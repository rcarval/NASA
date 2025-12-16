# Análisis y Solución: Duplicación de Business Partners en SAP

## Información del Ticket
**Problema:** Duplicación de Business Partners (BP) en SAP cuando se realizan compras ida y vuelta desde la página web.

**Fecha de análisis:** 2025-01-XX

---

## 1. Contexto del Problema

### 1.1 Descripción del Problema
Desde SAP se reporta que se están duplicando los Business Partners (BP), específicamente en su creación por integración con Salesforce cuando se realizan compras ida y vuelta desde la página web.

**Escenarios reportados:**
- **Escenario 1:** Un día no se crea la caja con nomenclatura CFORCE, pero aparece USERINT que coincide con un reintento.
- **Escenario 2:** El mismo día aparece creado CFORCE y USERINT.
- **Escenario 3 (Normal):** Todos los días se crea CFORCE y owner Userint.

**Causa raíz identificada:**
Cuando se compra ida y vuelta por la web, se generan 2 reservas correlativas en Salesforce con el mismo UUID. Estas se envían casi simultáneamente hacia SAP, y al recibir dos llamadas para crear el mismo cliente (mismo RUT) que no existe previamente, SAP lo crea dos veces.

### 1.2 Historia del Delay de 1 Minuto
Anteriormente existía un flujo que comparaba campos resumen (`Numero_Documentos__c` vs `Numero_Documentos_Listos_para_SAP__c`) para determinar cuándo enviar a SAP. Esto estaba generando duplicidades en algunos casos específicos a SAP.

**Solución implementada:** Se agregó un delay de 1 minuto antes del envío a SAP, lo que resolvió las duplicidades en casos normales, pero generó el problema actual con procesos ida-vuelta.

---

## 2. Análisis Técnico del Flujo Actual

### 2.1 Proceso de Creación desde la Web

#### 2.1.1 API REST Custom
- **Clase:** `NAV_WebWS`
- **Anotación:** `@RestResource(urlMapping='/Web/*')`
- **Métodos:** `@HttpPost` y `@HttpGet`
- **Endpoint:** `/services/apexrest/Web/*`
- **Tipo:** API REST custom de Salesforce (NO es la API estándar)

#### 2.1.2 Creación de Reservas Ida y Vuelta
1. La página web realiza **2 llamadas POST separadas** al mismo endpoint.
2. Cada llamada incluye:
   - El mismo `uuid` (parámetro de la URL: `req.params.get('uuid')`)
   - Diferente `roundtrip` en el body JSON: `'Ida'` o `'Vuelta'`
3. En `NAV_WebWS.cls` (líneas 88, 119): cada reserva recibe el mismo `UUID__c = uuid`
4. **Resultado:** Se crean 2 reservas con el mismo UUID pero diferentes `Sentido_Viaje__c` ('Ida' y 'Vuelta')

#### 2.1.3 Creación de Acreditaciones
- En `NAV_WebWS.cls` (líneas 708-712): Se buscan todas las reservas con ese UUID
- Líneas 739-764: Se crea una `Acreditacion__c` por cada reserva encontrada
- Línea 766: Se insertan ambas acreditaciones simultáneamente
- **Ambas comparten el mismo `Destinatario_Documentos__c` (mismo RUT)**

### 2.2 Flujo de Envío a SAP

#### 2.2.1 Flujo: `Valida_Envio_Automatico_de_Documentos_a_SAP`
**Propósito:** Activa el envío automático cuando todos los documentos están listos.

**Condiciones de activación:**
- `Numero_Documentos__c` > 0
- `Numero_Documentos_Listos_para_SAP__c` > 0
- `Numero_Documentos_Listos_para_SAP__c` cambió
- `Numero_Documentos__c` = `Numero_Documentos_Listos_para_SAP__c`
- `Por_acreditar__c` = 0
- `Total_a_acreditar__c` > 0
- `Envio_Documentos_Automatico__c` = false

**Acción:** Activa `Envio_Documentos_Automatico__c = true`

#### 2.2.2 Flujo: `IntegracionSAP`
**Propósito:** Envía la acreditación a SAP después de un delay.

**Condiciones de activación:**
- `Envio_Documentos_Automatico__c` = true
- `Envio_Documentos_Automatico__c` cambió

**Acción:** 
- Programa el envío para **1 minuto después** (scheduled path)
- Después de 1 minuto, llama a `NAV_SAPWS.processIntegration()`
- Desmarca `Envio_Documentos_Automatico__c = false`

#### 2.2.3 Clase: `NAV_SAPWS`
**Método:** `callAcreditacion(String iAcreditacion)`
- Construye el XML con los datos de la acreditación
- Incluye el RUT del cliente en el campo `<RUT>` del XML (línea 404)
- Llama a `callService()` que hace el HTTP POST a SAP
- Actualiza `Fecha_Envio_SAP__c` cuando se envía

### 2.3 Problema Identificado

**Condición de carrera:**
1. Se crean 2 acreditaciones simultáneamente (ida y vuelta)
2. Ambas generan documentos independientemente
3. Cuando ambas cumplen las condiciones, se activan casi simultáneamente
4. Ambas se programan para ejecutarse 1 minuto después
5. Ambas envían el mismo RUT a SAP casi simultáneamente
6. SAP recibe dos llamadas para crear el mismo BP y lo crea dos veces

**El delay de 1 minuto resuelve duplicidades en casos normales, pero NO resuelve la condición de carrera cuando hay múltiples acreditaciones relacionadas (ida/vuelta) que se activan casi simultáneamente.**

---

## 3. Solución Propuesta: Deduplicación de Envíos SAP

### 3.1 Objetivo
Evitar que dos acreditaciones relacionadas (ida/vuelta) con el mismo RUT se envíen a SAP casi simultáneamente, causando duplicación de Business Partners.

### 3.2 Estrategia
1. **Coordinación:** Antes de activar el envío automático, verificar si existe otra acreditación relacionada ya siendo procesada.
2. **Activación diferida:** Si existe una relacionada procesándose, NO activar el envío todavía.
3. **Activación posterior:** Cuando la primera acreditación termine de enviarse, activar automáticamente la segunda.

---

## 4. Componentes a Modificar

### 4.1 Flujo: `Valida_Envio_Automatico_de_Documentos_a_SAP` (MODIFICAR)

#### 4.1.1 Cambios Específicos

**A. Agregar elemento Get Records**

**Ubicación:** Después de la decisión `Documentos_Listos` y ANTES de `Autoriza_Envio_Documentos`

**Configuración:**
- **Nombre:** `Buscar_Acreditacion_Relacionada_Procesando`
- **Objeto:** `Acreditacion__c`
- **Filtros (AND):**
  1. `Destinatario_Documentos__c` = `$Record.Destinatario_Documentos__c` (mismo RUT)
  2. `Id` ≠ `$Record.Id` (diferente acreditación)
  3. `Envio_Documentos_Automatico__c` = `true` O `Fecha_Envio_SAP__c` ≠ `null`
  4. `Reserva_relacionada__c` = `$Record.Reserva__c` O `Reserva__c` = `$Record.Reserva_relacionada__c` (relacionadas por ida/vuelta)
- **Guardar en:** Variable de colección `AcreditacionesRelacionadasProcesando`

**Justificación:** Busca si hay otra acreditación relacionada (mismo RUT, relacionada por ida/vuelta) que ya esté siendo procesada o ya haya sido enviada.

**B. Agregar Decisión**

**Ubicación:** Después del Get Records

**Configuración:**
- **Nombre:** `Existe_Acreditacion_Relacionada_Procesando`
- **Regla:**
  - Si `AcreditacionesRelacionadasProcesando` no está vacía → `Sí, existe`
  - Si está vacía → `No existe`
- **Conectores:**
  - `Sí, existe` → No hacer nada (terminar el flujo sin activar)
  - `No existe` → Continuar a `Autoriza_Envio_Documentos`

**Justificación:** Si existe otra acreditación relacionada ya procesándose, NO activar el envío automático todavía. Esto evita la condición de carrera sin cambiar el delay de 1 minuto.

#### 4.1.2 Flujo Modificado

```
Start (Record After Save)
  ↓
Documentos_Listos (Decisión)
  ↓ (Sí, documentos listos)
Buscar_Acreditacion_Relacionada_Procesando (Get Records) [NUEVO]
  ↓
Existe_Acreditacion_Relacionada_Procesando (Decisión) [NUEVO]
  ├─ Sí, existe → End (no activar)
  └─ No existe → Autoriza_Envio_Documentos (Update)
```

---

### 4.2 Flujo: `Activar_Envio_Relacionado_SAP` (NUEVO)

#### 4.2.1 Propósito
Activar el envío de acreditaciones relacionadas cuando la primera termine de enviarse a SAP.

#### 4.2.2 Estructura del Flujo

**A. Start Element (Record-Triggered Flow)**
- **Objeto:** `Acreditacion__c`
- **Trigger:** `Record After Save`
- **Filtros (AND):**
  1. `Fecha_Envio_SAP__c` cambió
  2. `Fecha_Envio_SAP__c` ≠ `null`
  3. `Destinatario_Documentos__c` ≠ `null`

**Justificación:** Se activa cuando una acreditación termina de enviarse a SAP (cuando `Fecha_Envio_SAP__c` se actualiza).

**B. Get Records**
- **Nombre:** `Buscar_Acreditaciones_Relacionadas_Pendientes`
- **Objeto:** `Acreditacion__c`
- **Filtros (AND):**
  1. `Destinatario_Documentos__c` = `$Record.Destinatario_Documentos__c` (mismo RUT)
  2. `Id` ≠ `$Record.Id` (diferente acreditación)
  3. `Envio_Documentos_Automatico__c` = `false` (aún no activada)
  4. `Numero_Documentos__c` = `Numero_Documentos_Listos_para_SAP__c` (documentos listos)
  5. `Numero_Documentos_Listos_para_SAP__c` > `0`
  6. `Por_acreditar__c` = `0`
  7. `Total_a_acreditar__c` > `0`
  8. `Reserva_relacionada__c` = `$Record.Reserva__c` O `Reserva__c` = `$Record.Reserva_relacionada__c` (relacionadas)
- **Guardar en:** Variable de colección `AcreditacionesPendientes`

**Justificación:** Busca acreditaciones relacionadas que estén listas para enviar pero que aún no han sido activadas.

**C. Loop sobre `AcreditacionesPendientes`**
- Para cada acreditación pendiente, actualizar:
  - `Envio_Documentos_Automatico__c` = `true`

**Justificación:** Activa el envío automático de las acreditaciones relacionadas pendientes, lo que disparará el flujo `IntegracionSAP` para cada una.

#### 4.2.3 Flujo Completo

```
Start (Record After Save - Fecha_Envio_SAP__c cambió)
  ↓
Buscar_Acreditaciones_Relacionadas_Pendientes (Get Records)
  ↓
Loop sobre AcreditacionesPendientes
  ↓
  Update: Envio_Documentos_Automatico__c = true
  ↓
End
```

---

## 5. Flujo Completo de Ejecución

### 5.1 Escenario: Compra Ida y Vuelta

**Paso 1: Creación de Reservas**
- Se crean 2 reservas con el mismo UUID (diferentes `Sentido_Viaje__c`)
- Llamadas POST separadas desde la web con el mismo `uuid` pero diferente `roundtrip`

**Paso 2: Creación de Acreditaciones**
- Se crean 2 acreditaciones simultáneamente (línea 766 de `NAV_WebWS.cls`)
- Ambas con el mismo `Destinatario_Documentos__c` (mismo RUT)
- Una tiene `Reserva_relacionada__c` apuntando a la otra

**Paso 3: Generación de Documentos**
- Se generan documentos para ambas acreditaciones de forma independiente
- Cuando `Numero_Documentos_Listos_para_SAP__c` = `Numero_Documentos__c`, se dispara `Valida_Envio_Automatico_de_Documentos_a_SAP`

**Paso 4: Validación de Envío (Primera Acreditación - Ida)**
- Flujo `Valida_Envio_Automatico_de_Documentos_a_SAP` se ejecuta
- Verifica si hay acreditación relacionada procesándose → **NO hay**
- Activa `Envio_Documentos_Automatico__c = true`

**Paso 5: Validación de Envío (Segunda Acreditación - Vuelta)**
- Flujo `Valida_Envio_Automatico_de_Documentos_a_SAP` se ejecuta
- Verifica si hay acreditación relacionada procesándose → **SÍ (la primera)**
- **NO activa el envío automático todavía**

**Paso 6: Envío de Primera Acreditación**
- Flujo `IntegracionSAP` se dispara para la primera acreditación
- Programa envío para 1 minuto después
- Después de 1 minuto, envía a SAP
- Actualiza `Fecha_Envio_SAP__c`

**Paso 7: Activación de Segunda Acreditación**
- Flujo `Activar_Envio_Relacionado_SAP` se dispara (por cambio en `Fecha_Envio_SAP__c`)
- Detecta que `Fecha_Envio_SAP__c` cambió
- Busca acreditaciones relacionadas pendientes
- Encuentra la segunda acreditación (vuelta)
- Activa `Envio_Documentos_Automatico__c = true` en la segunda

**Paso 8: Envío de Segunda Acreditación**
- Flujo `IntegracionSAP` se dispara para la segunda acreditación
- Programa envío para 1 minuto después
- Después de 1 minuto, envía a SAP
- **El BP ya existe en SAP, no se duplica**

---

## 6. Filtros y Condiciones Detalladas

### 6.1 Filtros en `Valida_Envio_Automatico_de_Documentos_a_SAP` (Get Records)

**Query lógica:**
```sql
WHERE Destinatario_Documentos__c = :$Record.Destinatario_Documentos__c
  AND Id != :$Record.Id
  AND (Envio_Documentos_Automatico__c = true OR Fecha_Envio_SAP__c != null)
  AND (
    Reserva_relacionada__c = :$Record.Reserva__c 
    OR Reserva__c = :$Record.Reserva_relacionada__c
  )
```

**Justificación de cada filtro:**
- `Destinatario_Documentos__c = $Record.Destinatario_Documentos__c`: Mismo RUT (mismo cliente)
- `Id != $Record.Id`: Excluir la acreditación actual
- `Envio_Documentos_Automatico__c = true OR Fecha_Envio_SAP__c != null`: Ya está siendo procesada o ya se envió
- `Reserva_relacionada__c = $Record.Reserva__c OR Reserva__c = $Record.Reserva_relacionada__c`: Están relacionadas por ida/vuelta

### 6.2 Filtros en `Activar_Envio_Relacionado_SAP` (Get Records)

**Query lógica:**
```sql
WHERE Destinatario_Documentos__c = :$Record.Destinatario_Documentos__c
  AND Id != :$Record.Id
  AND Envio_Documentos_Automatico__c = false
  AND Numero_Documentos__c = Numero_Documentos_Listos_para_SAP__c
  AND Numero_Documentos_Listos_para_SAP__c > 0
  AND Por_acreditar__c = 0
  AND Total_a_acreditar__c > 0
  AND (
    Reserva_relacionada__c = :$Record.Reserva__c 
    OR Reserva__c = :$Record.Reserva_relacionada__c
  )
```

**Justificación de cada filtro:**
- `Destinatario_Documentos__c = $Record.Destinatario_Documentos__c`: Mismo RUT
- `Id != $Record.Id`: Excluir la acreditación actual
- `Envio_Documentos_Automatico__c = false`: Aún no activada
- `Numero_Documentos__c = Numero_Documentos_Listos_para_SAP__c`: Documentos listos
- `Numero_Documentos_Listos_para_SAP__c > 0`: Tiene documentos
- `Por_acreditar__c = 0`: Sin pendientes
- `Total_a_acreditar__c > 0`: Tiene monto a acreditar
- `Reserva_relacionada__c = $Record.Reserva__c OR Reserva__c = $Record.Reserva_relacionada__c`: Están relacionadas

---

## 7. Ventajas de la Solución

1. **Mantiene el delay de 1 minuto:** No modifica la solución que resolvió las duplicidades anteriores
2. **No requiere campos nuevos:** Usa campos existentes en el objeto `Acreditacion__c`
3. **Usa relaciones existentes:** Aprovecha `Reserva_relacionada__c` y `Destinatario_Documentos__c`
4. **Coordinación automática:** Las acreditaciones relacionadas se coordinan automáticamente
5. **No afecta otros casos:** Solo afecta acreditaciones relacionadas (ida/vuelta)

---

## 8. Consideraciones Importantes

### 8.1 Casos Edge

1. **Si ambas acreditaciones quedan listas exactamente al mismo tiempo:**
   - La primera en ser evaluada por el flujo activará el envío
   - La segunda detectará que la primera está procesándose y esperará
   - Cuando la primera termine, se activará automáticamente la segunda

2. **Si la primera acreditación falla al enviarse:**
   - La segunda NO se activará automáticamente
   - Requerirá intervención manual o lógica adicional para manejar errores

3. **Si hay más de 2 acreditaciones relacionadas:**
   - Solo se activará una a la vez
   - Cada una esperará a que la anterior termine

### 8.2 Limitaciones

- El flujo nuevo solo se activa cuando `Fecha_Envio_SAP__c` cambia y no es null
- Si hay errores en el envío, las acreditaciones relacionadas pueden quedar bloqueadas
- Requiere que el campo `Reserva_relacionada__c` esté correctamente poblado

---

## 9. Resumen de Cambios

| Componente | Tipo | Acción |
|------------|------|--------|
| `Valida_Envio_Automatico_de_Documentos_a_SAP` | Flow (Modificar) | Agregar Get Records y Decisión antes de activar envío |
| `Activar_Envio_Relacionado_SAP` | Flow (Nuevo) | Crear flujo que active acreditaciones relacionadas pendientes |

---

## 10. Próximos Pasos

1. **Revisar y aprobar** esta solución
2. **Implementar** los cambios en el flujo `Valida_Envio_Automatico_de_Documentos_a_SAP`
3. **Crear** el nuevo flujo `Activar_Envio_Relacionado_SAP`
4. **Probar** en ambiente de desarrollo con casos ida/vuelta
5. **Validar** que no se afecten otros procesos
6. **Desplegar** a producción

---

## 11. Referencias Técnicas

### 11.1 Archivos Relevantes
- `force-app/main/default/classes/NAV_WebWS.cls` - API REST para creación desde web
- `force-app/main/default/classes/NAV_SAPWS.cls` - Integración con SAP
- `force-app/main/default/flows/Valida_Envio_Automatico_de_Documentos_a_SAP.flow-meta.xml` - Flujo de validación
- `force-app/main/default/flows/IntegracionSAP.flow-meta.xml` - Flujo de integración SAP

### 11.2 Campos Utilizados
- `Acreditacion__c.Destinatario_Documentos__c` - Lookup a Account (RUT del cliente)
- `Acreditacion__c.Reserva__c` - Lookup a Reserva
- `Acreditacion__c.Reserva_relacionada__c` - Lookup a Reserva (para ida/vuelta)
- `Acreditacion__c.Envio_Documentos_Automatico__c` - Checkbox
- `Acreditacion__c.Fecha_Envio_SAP__c` - DateTime
- `Acreditacion__c.Numero_Documentos__c` - Number
- `Acreditacion__c.Numero_Documentos_Listos_para_SAP__c` - Number
- `Acreditacion__c.Por_acreditar__c` - Number
- `Acreditacion__c.Total_a_acreditar__c` - Number
- `Reserva__c.UUID__c` - Text (identificador único compartido)

---

**Documento generado:** 2025-01-XX
**Autor:** Análisis técnico - Duplicación BP SAP
**Versión:** 1.0


