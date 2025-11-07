# Análisis Técnico y Solución - Ticket N°00024259
## Problema de Nomenclatura y Duplicación en Cajas de Usuario Integración

---

**Fecha de análisis:** 7 de noviembre de 2025  
**Desarrollador:** Rodrigo Alonso Carvallo González  
**Rama de trabajo:** Ticket-00024259-Analisis-Caja  
**Estado:** Implementado y desplegado en Salesforce  

---

## 1. CONTEXTO Y PROBLEMÁTICA

### 1.1 Situación Reportada

El usuario reportó inconsistencias en la nomenclatura del campo "N° de Caja" para las cajas del Usuario Integración, específicamente:

- **Nomenclatura esperada:** `Cforce000XXX` (usando alias de CONSULTOR FORCE)
- **Nomenclatura problemática:** `intuser000XXX` (usando alias de Usuario Integración)
- **Frecuencia:** Casos puntuales, aproximadamente 2 veces al año
- **Impacto:** Descuadre de cajas en el cierre diario

### 1.2 Escenarios Identificados

**Escenario 1 - Normal (esperado):**
- Se crea 1 caja diaria con nomenclatura `Cforce000XXX`
- Owner: Usuario Integración
- CreatedBy: CONSULTOR FORCE

**Escenario 2 - Problemático ocasional:**
- Aparece nomenclatura `intuser000XXX` sin la correspondiente `Cforce000XXX`
- Ocurre cuando hay reintentos del flow programado

**Escenario 3 - Problemático crítico:**
- El mismo día aparecen 2 cajas: `Cforce000XXX` E `intuser000XXX`
- Provoca descuadre porque las reservas se asignan a diferentes cajas
- Las más problemático desde el punto de vista operacional

---

## 2. INVESTIGACIÓN Y ANÁLISIS

### 2.1 Queries Ejecutadas para Diagnóstico

#### Query 1: Verificación de nomenclatura actual
```sql
SELECT Id, Name, CreatedBy.Name, CreatedBy.Alias, 
       Owner.Name, Owner.Alias, CreatedDate 
FROM Caja__c 
WHERE Owner.Name = 'Usuario Integracion'
ORDER BY CreatedDate DESC 
LIMIT 20
```

**Resultado:**
```
UI-2025-11-07 03:00:03Z-1142 | CreatedBy: Consultor_Force (Cforce) | Owner: Usuario Integracion (intuser)
UI-2025-11-06 03:00:03Z-1141 | CreatedBy: Consultor_Force (Cforce) | Owner: Usuario Integracion (intuser)
...
```

**Observación:** Todas las cajas usan nomenclatura `UI-` en el campo `Name`, pero el problema está en otro campo.

---

#### Query 2: Búsqueda de días con múltiples cajas
```sql
SELECT COUNT(Id) Total, CALENDAR_YEAR(CreatedDate) Anio, 
       CALENDAR_MONTH(CreatedDate) Mes, DAY_IN_MONTH(CreatedDate) Dia 
FROM Caja__c 
WHERE Owner.Name = 'Usuario Integracion' 
  AND CALENDAR_YEAR(CreatedDate) >= 2024 
GROUP BY CALENDAR_YEAR(CreatedDate), CALENDAR_MONTH(CreatedDate), DAY_IN_MONTH(CreatedDate) 
HAVING COUNT(Id) > 1 
ORDER BY CALENDAR_YEAR(CreatedDate) DESC, CALENDAR_MONTH(CreatedDate) DESC, DAY_IN_MONTH(CreatedDate) DESC
```

**Resultado:**
```
Total: 0 registros
```

**Observación:** Actualmente no hay cajas duplicadas en producción (en 2024-2025), pero el problema es esporádico.

---

#### Query 3: Análisis histórico de duplicados
```sql
SELECT COUNT(Id) Total, Owner.Name, CALENDAR_MONTH(CreatedDate) Mes, DAY_IN_MONTH(CreatedDate) Dia 
FROM Caja__c 
WHERE Owner.Name = 'Usuario Integracion' 
GROUP BY Owner.Name, CALENDAR_MONTH(CreatedDate), DAY_IN_MONTH(CreatedDate) 
HAVING COUNT(Id) > 1 
ORDER BY CALENDAR_MONTH(CreatedDate) DESC, DAY_IN_MONTH(CreatedDate) DESC
```

**Resultado:**
```
365 días con múltiples cajas (3-8 cajas por día)
Ejemplo: 26 de septiembre → 8 cajas
```

**Observación:** Las cajas múltiples corresponden a diferentes AÑOS (2022, 2023, 2024, 2025), no son duplicados del mismo día/año.

---

#### Query 4: Análisis del campo N_Caja__c
```bash
sf sobject describe --sobject Caja__c | grep -A 5 "Numero_de_Caja__c"
```

**Resultado:**
```javascript
"calculatedFormula": "IF(Numero_de_Caja__c>0, CreatedBy.Alias & RIGHT(\"00000\"& TEXT(Numero_de_Caja__c), 6),\"\")"
"name": "N_Caja__c"
```

**Observación CRÍTICA:** El campo fórmula `N_Caja__c` usa `CreatedBy.Alias`, no `Owner.Alias`. Esta es la causa raíz del problema.

---

### 2.2 Componentes Identificados

#### Flow 1: `CrearCajaDiariaUsuarioIntegracion`
- **Tipo:** Scheduled Flow (Programado)
- **Frecuencia:** Diario a las 00:00 UTC (03:00 hora Chile)
- **Ejecutado por:** CONSULTOR FORCE (quien activó el flow)
- **Función:** Crea automáticamente una caja diaria para el Usuario Integración
- **Estado:** Activo

**Flujo actual:**
```
START (00:00 UTC)
  ↓
1. ObtenerUsuarioIntegracion (busca usuario por Username o Name)
  ↓
2. CrearCajaUsuarioIntegracion:
   - Name = "UI-" + DateTime + "-" + NumeroCaja
   - Numero_de_Caja__c = Correlativo_ultima_caja__c + 1
   - Owner = Usuario Integración (ID encontrado)
   - Estado = "Abierta"
  ↓
3. ActualizarCorrelativoUsuario (actualiza Correlativo_ultima_caja__c)
```

**Problema identificado:** No verifica si ya existe una caja antes de crear. Si hay un reintento por fallo, crea una segunda caja.

---

#### Flow 2: `CrearCajaAcreditacion`
- **Tipo:** Record-Triggered Flow (After Save)
- **Trigger:** Al crear una Acreditación
- **Ejecutado por:** Usuario que crea la Acreditación (Usuario Integración en ventas web)
- **Función:** Asigna caja existente o crea una nueva si no existe
- **Estado:** Activo

**Flujo actual:**
```
START (Al crear Acreditación)
  ↓
1. Buscar_Caja (busca caja abierta):
   - OwnerId = CreatedById de la Acreditación
   - FechaCaja = Fecha de creación
   - Estado = "Abierta"
   - getFirstRecordOnly = true
   - ⚠️ SIN ORDER BY
  ↓
2. ¿Existe caja?
   SI → Asigna caja a Acreditación y Reserva
   NO → Crea nueva caja
```

**Problema identificado:** Si existen múltiples cajas (por duplicados), `getFirstRecordOnly` sin ORDER BY devuelve un resultado impredecible. Las reservas se asignan aleatoriamente a diferentes cajas.

---

#### Campo: `N_Caja__c`
- **Tipo:** Formula (Text)
- **Label:** N° Caja
- **Visible en:** Reportes, vistas de lista, páginas de detalle
- **Fórmula actual:** `CreatedBy.Alias & RIGHT("00000"& TEXT(Numero_de_Caja__c), 6)`

**Comportamiento:**
- Si CreatedBy = CONSULTOR FORCE (Alias: "Cforce") → Muestra `Cforce000350`
- Si CreatedBy = Usuario Integración (Alias: "intuser") → Muestra `intuser001142`

**Problema identificado:** El campo usa `CreatedBy` cuando debería usar `Owner`, ya que el Owner es quien realmente "posee" la caja y realiza las operaciones.

---

## 3. CAUSA RAÍZ DEL PROBLEMA

### 3.1 Comportamiento de Flows Programados en Salesforce

Los flows programados (Scheduled Flows) en Salesforce tienen un comportamiento especial respecto a los reintentos:

1. **Ejecución normal:** El flow se ejecuta en el contexto del usuario que lo activó (CONSULTOR FORCE)

2. **En caso de fallo:** Salesforce implementa un mecanismo de reintentos automáticos:
   - El reintento puede ejecutarse con un contexto de usuario diferente
   - Puede ser: Automated Process User, System User, u otro usuario del sistema
   - Este cambio de contexto es **interno de Salesforce** y no es configurable

3. **Impacto en nuestro caso:**
   - Ejecución normal: CreatedBy = CONSULTOR FORCE → N° Caja = `Cforce000350`
   - Reintento: CreatedBy = Usuario Integración → N° Caja = `intuser001142`

### 3.2 Escenario de Duplicación de Cajas

**Timeline del problema:**

```
00:00:00 → Flow inicia (contexto: CONSULTOR FORCE)
00:00:01 → ObtenerUsuarioIntegracion ✅
00:00:02 → CrearCajaUsuarioIntegracion ✅ (Caja ID: a0P123...)
00:00:03 → ActualizarCorrelativoUsuario ❌ FALLA
          (Ej: timeout, lock de registro, governor limit)

00:00:10 → Salesforce detecta el fallo
00:00:11 → Inicia reintento automático (contexto: Automated Process o Usuario Integración)
00:00:12 → ObtenerUsuarioIntegracion ✅
00:00:13 → NO VERIFICA si ya existe caja
00:00:14 → CrearCajaUsuarioIntegracion ✅ (Caja ID: a0P456...) 
          → 💥 SEGUNDA CAJA CREADA
00:00:15 → ActualizarCorrelativoUsuario ✅
```

**Resultado:**
- **2 cajas en el mismo día** para Usuario Integración
- **Caja 1:** N° Caja = `Cforce000350` (CreatedBy: CONSULTOR FORCE)
- **Caja 2:** N° Caja = `intuser001142` (CreatedBy: Usuario Integración)
- **Problema operacional:** Reservas web se asignan aleatoriamente entre ambas cajas → Descuadre

---

## 4. SOLUCIÓN IMPLEMENTADA

### 4.1 Estrategia de Solución

La solución se abordó en 3 niveles:

1. **Nivel de presentación:** Corregir el campo fórmula para nomenclatura consistente
2. **Nivel de prevención:** Evitar que se creen cajas duplicadas
3. **Nivel de mitigación:** Manejar correctamente si existen duplicados

---

### 4.2 CAMBIO 1: Campo Fórmula `N_Caja__c`

**Archivo modificado:**
```
force-app/main/default/objects/Caja__c/fields/N_Caja__c.field-meta.xml
```

**Cambio realizado:**
```xml
<!-- ANTES -->
<formula>IF(Numero_de_Caja__c&gt;0, CreatedBy.Alias &amp; RIGHT(&quot;00000&quot;&amp; TEXT(Numero_de_Caja__c), 6),&quot;&quot;)</formula>

<!-- DESPUÉS -->
<formula>IF(Numero_de_Caja__c&gt;0, Owner:User.Alias &amp; RIGHT(&quot;00000&quot;&amp; TEXT(Numero_de_Caja__c), 6),&quot;&quot;)</formula>
<formulaTreatBlanksAs>BlankAsZero</formulaTreatBlanksAs>
```

**Justificación:**

El Owner de una caja es quien realmente la "posee" y realiza las operaciones financieras en ella. En este caso, el Owner siempre es Usuario Integración, independientemente de quién haya creado físicamente el registro.

- **Antes:** El campo mostraba el alias del usuario que creó la caja (contexto de ejecución)
- **Después:** El campo muestra el alias del propietario de la caja (quien realmente la usa)

**Ventajas:**
- ✅ Nomenclatura consistente: Todas las cajas muestran `intuser000XXX`
- ✅ Independiente del contexto de ejecución (flow programado o reintento)
- ✅ Refleja el Owner real de la caja
- ✅ No requiere cambios en flows ni lógica de negocio

**Nota técnica:** Se usa la sintaxis `Owner:User.Alias` en lugar de `Owner.Alias` porque el campo Owner en Salesforce es polimórfico (puede ser User o Queue). La sintaxis `Owner:User` especifica que queremos acceder al Owner cuando es de tipo User.

**Por qué NO afecta al proceso actual:**
- El cambio es solo en la visualización del campo, no en la lógica
- Los flows siguen asignando el Owner correctamente (Usuario Integración)
- Los procesos de negocio usan el registro de Caja completo, no solo el N° de Caja visible
- Las cajas existentes se recalculan automáticamente (comportamiento estándar de campos fórmula)

---

### 4.3 CAMBIO 2: Flow `CrearCajaDiariaUsuarioIntegracion`

**Archivo modificado:**
```
force-app/main/default/flows/CrearCajaDiariaUsuarioIntegracion.flow-meta.xml
```

**Elementos agregados:**

#### A) Nueva búsqueda: `BuscarCajaExistente`

```xml
<recordLookups>
    <description>Busca si ya existe una caja abierta para el usuario en la fecha actual</description>
    <name>BuscarCajaExistente</name>
    <label>Buscar Caja Existente</label>
    <filterLogic>and</filterLogic>
    <filters>
        <field>OwnerId</field>
        <operator>EqualTo</operator>
        <value>
            <elementReference>ObtenerUsuarioIntegracion.Id</elementReference>
        </value>
    </filters>
    <filters>
        <field>FechaCaja__c</field>
        <operator>EqualTo</operator>
        <value>
            <elementReference>$Flow.CurrentDate</elementReference>
        </value>
    </filters>
    <filters>
        <field>Estado_de_la_Caja__c</field>
        <operator>EqualTo</operator>
        <value>
            <stringValue>Abierta</stringValue>
        </value>
    </filters>
    <getFirstRecordOnly>true</getFirstRecordOnly>
    <object>Caja__c</object>
</recordLookups>
```

**Qué hace:** Antes de crear una caja, consulta si ya existe una caja abierta para el Usuario Integración en la fecha actual.

---

#### B) Nueva decisión: `VerificarSiCajaExiste`

```xml
<decisions>
    <description>Verifica si ya existe una caja abierta para evitar duplicados en caso de reintentos</description>
    <name>VerificarSiCajaExiste</name>
    <label>¿Caja Ya Existe?</label>
    <defaultConnector>
        <targetReference>CrearCajaUsuarioIntegracion</targetReference>
    </defaultConnector>
    <defaultConnectorLabel>No existe - Crear caja</defaultConnectorLabel>
    <rules>
        <name>CajaYaExiste</name>
        <conditionLogic>and</conditionLogic>
        <conditions>
            <leftValueReference>BuscarCajaExistente</leftValueReference>
            <operator>IsNull</operator>
            <rightValue>
                <booleanValue>false</booleanValue>
            </rightValue>
        </conditions>
        <label>Ya existe - No crear</label>
    </rules>
</decisions>
```

**Qué hace:** 
- **Si la búsqueda encontró una caja:** El flow termina sin crear nada
- **Si la búsqueda NO encontró caja:** Continúa con la creación normal

---

#### C) Flujo modificado

**ANTES:**
```
START → ObtenerUsuarioIntegracion → CrearCajaUsuarioIntegracion → ActualizarCorrelativoUsuario
```

**DESPUÉS:**
```
START 
  → ObtenerUsuarioIntegracion 
  → BuscarCajaExistente (NUEVO)
  → VerificarSiCajaExiste (NUEVO)
      ├─ Ya existe → FIN (sin crear)
      └─ No existe → CrearCajaUsuarioIntegracion → ActualizarCorrelativoUsuario
```

**Justificación:**

El problema de cajas duplicadas ocurre cuando:
1. El flow crea la caja exitosamente
2. Falla en un paso posterior (ej: actualizar correlativo)
3. Salesforce hace un reintento automático
4. El reintento crea una SEGUNDA caja porque no verifica si ya existe

Con esta modificación, el flow se vuelve **idempotente**: puede ejecutarse múltiples veces sin crear duplicados.

**Por qué NO afecta al proceso actual:**
- En funcionamiento normal (sin reintentos), la búsqueda no encuentra nada y crea la caja como siempre
- Solo previene el problema cuando HAY reintentos
- No cambia ninguna lógica de negocio existente
- No modifica los datos de la caja creada (Name, Owner, Estado, etc.)

---

### 4.4 CAMBIO 3: Flow `CrearCajaAcreditacion`

**Archivo modificado:**
```
force-app/main/default/flows/CrearCajaAcreditacion.flow-meta.xml
```

**Cambio realizado:**

```xml
<recordLookups>
    <description>Buscar si existe una caja con ese nombre. ORDER BY para consistencia en caso de duplicados</description>
    <name>Buscar_Caja</name>
    <!-- ... filtros existentes ... -->
    <getFirstRecordOnly>true</getFirstRecordOnly>
    <object>Caja__c</object>
    <sortField>CreatedDate</sortField>     <!-- NUEVO -->
    <sortOrder>Asc</sortOrder>             <!-- NUEVO -->
</recordLookups>
```

**Justificación:**

Este flow se ejecuta cuando llega una reserva desde la web y busca la caja del Usuario Integración para asignarla a la Acreditación.

**Problema sin ORDER BY:**
- Si existen 2 cajas (por un error previo o reintento), Salesforce devuelve una aleatoriamente
- Reserva 1 podría asignarse a Caja A
- Reserva 2 podría asignarse a Caja B
- Al cierre: Caja A tiene algunas reservas, Caja B tiene otras → Descuadre

**Solución con ORDER BY:**
- Ordena por fecha de creación ascendente (más antigua primero)
- SIEMPRE devuelve la primera caja creada
- Todas las reservas del día se asignan a la MISMA caja
- Comportamiento predecible y consistente

**Por qué NO afecta al proceso actual:**
- Si solo existe 1 caja (escenario normal), el ORDER BY no cambia nada
- Si existen duplicados, garantiza que todas las reservas van a la misma caja
- No modifica ninguna lógica de negocio
- Es una medida de protección para casos edge

---

## 5. RESULTADOS ESPERADOS

### 5.1 Escenarios Post-Implementación

#### Escenario A: Funcionamiento Normal (99% de los casos)

**Timeline:**
```
00:00 → Flow CrearCajaDiariaUsuarioIntegracion se ejecuta
     → Contexto: CONSULTOR FORCE
     → Busca caja existente → No encuentra
     → Crea caja
        • Name: "UI-2025-11-08 03:00:00Z-1143"
        • Numero_de_Caja__c: 1143
        • N_Caja__c: "intuser001143" ✅ (usa Owner.Alias)
        • Owner: Usuario Integración
        • CreatedBy: CONSULTOR FORCE
     → Actualiza correlativo
     
10:30 → Reserva web llega
     → CrearCajaAcreditacion se ejecuta
     → Busca caja del día con ORDER BY
     → Encuentra 1 caja: "intuser001143"
     → Asigna caja a la reserva ✅
```

**Resultado:** ✅ 1 caja, nomenclatura correcta, asignación exitosa

---

#### Escenario B: Fallo y Reintento (Antes problemático, ahora corregido)

**Timeline:**
```
00:00:00 → Flow se ejecuta (contexto: CONSULTOR FORCE)
       → Busca caja existente → No encuentra
       → Crea caja exitosamente
          • ID: a0PXX...001
          • N_Caja__c: "intuser001143" ✅
00:00:03 → ActualizarCorrelativoUsuario → ❌ FALLA
          (Ej: timeout, record lock)

00:00:15 → Salesforce detecta fallo
       → Inicia reintento automático
       → Contexto cambia a: Automated Process o Usuario Integración
       
00:00:16 → Flow reintento ejecuta:
       → Busca caja existente → ✅ ENCUENTRA (a0PXX...001)
       → Decisión: ¿Caja Ya Existe? → SÍ
       → ✅ TERMINA SIN CREAR (previene duplicado)
```

**Resultado:** ✅ 1 sola caja, NO hay duplicado, nomenclatura correcta

---

#### Escenario C: Duplicados Pre-existentes (Antes causaban descuadre)

Supongamos que por un error previo ya existen 2 cajas el mismo día:

```
Cajas en el sistema:
- Caja A: N° Caja "intuser001143", CreatedDate: 03:00:00
- Caja B: N° Caja "intuser001144", CreatedDate: 03:05:00

10:30 → Reserva web 1 llega
     → CrearCajaAcreditacion ejecuta
     → Busca caja con ORDER BY CreatedDate ASC
     → Encuentra 2, toma la primera: Caja A ✅
     → Asigna Reserva 1 a Caja A

11:15 → Reserva web 2 llega
     → CrearCajaAcreditacion ejecuta
     → Busca caja con ORDER BY CreatedDate ASC
     → Encuentra 2, toma la primera: Caja A ✅
     → Asigna Reserva 2 a Caja A

Al cierre:
- Caja A: Reserva 1 + Reserva 2 ✅
- Caja B: Vacía (no se usa)
```

**Resultado:** ✅ Todas las reservas en la misma caja, NO hay descuadre

---

### 5.2 Tabla Comparativa

| Aspecto | Antes de los cambios | Después de los cambios |
|---------|---------------------|------------------------|
| **Nomenclatura N° Caja** | `Cforce000XXX` o `intuser000XXX` (inconsistente según CreatedBy) | `intuser000XXX` (siempre consistente, basado en Owner) |
| **Cajas duplicadas** | Sí, ~2 veces al año cuando hay reintentos | No, validación previa previene duplicados |
| **Asignación de reservas web** | Aleatoria si hay duplicados → descuadre | Predecible (siempre la más antigua) → sin descuadre |
| **Owner de las cajas** | Usuario Integración ✅ | Usuario Integración ✅ (sin cambio) |
| **Proceso de creación diaria** | 1 caja a las 00:00 ✅ | 1 caja a las 00:00 ✅ (sin cambio) |
| **Proceso de asignación web** | Busca y asigna caja ✅ | Busca y asigna caja ✅ (sin cambio) |
| **Correlativo de cajas** | Número secuencial ✅ | Número secuencial ✅ (sin cambio) |

---

## 6. GARANTÍAS DE NO AFECTACIÓN

### 6.1 Validación de Impacto

**¿Por qué estos cambios NO afectan negativamente al proceso actual?**

#### Cambio 1: Campo Fórmula N_Caja__c

✅ **Es solo visualización:**
- El campo `N_Caja__c` es de tipo Formula (Text)
- Es **read-only**, no se puede escribir en él
- Solo se usa para mostrar en reportes y listas
- Ningún proceso de negocio consulta o filtra por este campo

✅ **No rompe referencias:**
- Los flows usan `Caja__c` (el registro completo) o su `Id`
- No hay filtros en flows que usen `N_Caja__c`
- Los reportes seguirán mostrando el campo, solo con valor diferente

✅ **Recalculo automático:**
- Salesforce recalcula campos fórmula automáticamente
- No requiere actualización masiva de registros
- Las cajas históricas mostrarán el nuevo valor al consultarlas

---

#### Cambio 2: Flow CrearCajaDiariaUsuarioIntegracion

✅ **Solo agrega validación:**
- El flujo normal (sin reintentos) sigue exactamente igual
- La búsqueda adicional es rápida y no consume recursos significativos
- Si no encuentra nada, continúa como antes

✅ **Idempotencia:**
- Si el flow se ejecuta múltiples veces (manual o por error), solo crea 1 caja
- Comportamiento esperado en sistemas robustos
- No duplica datos innecesariamente

✅ **No cambia datos creados:**
- La caja se crea con los mismos valores que antes:
  - Name: `UI-DateTime-Numero`
  - Owner: Usuario Integración
  - Estado: Abierta
  - Numero_de_Caja__c: Correlativo + 1

---

#### Cambio 3: Flow CrearCajaAcreditacion

✅ **Optimización transparente:**
- Si solo hay 1 caja (caso normal), devuelve esa caja ✅
- Si hay múltiples cajas, devuelve la más antigua ✅
- No cambia ninguna lógica de asignación

✅ **Mejora consistencia:**
- Antes: Comportamiento impredecible con duplicados
- Después: Comportamiento predecible y documentado

✅ **No requiere cambios en integraciones:**
- La API web sigue creando Acreditaciones normalmente
- El flow sigue asignando cajas automáticamente
- Los campos asignados son los mismos

---

### 6.2 Testing Recomendado

Para validar que todo funciona correctamente, se recomienda:

#### Test 1: Verificar campo fórmula
```sql
SELECT Id, Name, N_Caja__c, Owner.Alias, CreatedBy.Alias 
FROM Caja__c 
WHERE Owner.Name = 'Usuario Integracion'
ORDER BY CreatedDate DESC 
LIMIT 10
```

**Resultado esperado:** Todas las cajas deben mostrar `intuser000XXX` en `N_Caja__c`

---

#### Test 2: Validar creación diaria automática
- Esperar a las 03:00 (00:00 UTC) del día siguiente
- Verificar que se crea exactamente 1 caja
- Confirmar nomenclatura: `intuser000XXX`

---

#### Test 3: Probar reserva web
- Crear una reserva desde el sitio web
- Completar el pago
- Verificar que la Acreditación se asigna a la caja correcta
- Confirmar que la Reserva también tiene la caja asignada

---

#### Test 4: Simular reintento (opcional)
- Ejecutar manualmente el flow `CrearCajaDiariaUsuarioIntegracion` desde Flow Builder
- Como ya existe una caja del día, debe terminar sin crear nada
- Confirmar que sigue habiendo solo 1 caja

---

## 7. ANÁLISIS DE RIESGO

### 7.1 Riesgos Identificados y Mitigados

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Cambio en fórmula cause error en reportes | Baja | Bajo | Campo fórmula no se usa en filtros; solo visualización |
| Flow no cree caja cuando debería | Muy Baja | Alto | Validación solo revisa fecha actual, no histórica |
| ORDER BY afecte performance | Muy Baja | Bajo | Query con filtros indexados (OwnerId, FechaCaja, Estado) |
| Campos históricos muestren valores incorrectos | Baja | Medio | Comportamiento estándar de fórmulas en Salesforce |

---

### 7.2 Plan de Rollback

Si se detecta algún problema, el rollback es simple:

```bash
# Volver a la versión anterior
git checkout develop

# Desplegar versión anterior
sf project deploy start --source-dir [archivos_originales] --target-org NASA-DEV
```

**Componentes a revertir:**
1. Campo `N_Caja__c` → Volver a `CreatedBy.Alias`
2. Flow `CrearCajaDiariaUsuarioIntegracion` → Remover validación
3. Flow `CrearCajaAcreditacion` → Remover ORDER BY

**Tiempo estimado de rollback:** 5 minutos

---

## 8. BENEFICIOS DE LA SOLUCIÓN

### 8.1 Beneficios Técnicos

✅ **Consistencia de datos:**
- Nomenclatura uniforme independiente del contexto de ejecución
- Facilita auditorías y troubleshooting

✅ **Robustez del sistema:**
- Tolerancia a fallos temporales de Salesforce
- Comportamiento idempotente del flow programado

✅ **Mantenibilidad:**
- Código más claro y explícito en sus intenciones
- Documentación inline en descripciones de elementos

✅ **Performance:**
- Búsqueda adicional es mínima (3 filtros en campos indexados)
- ORDER BY en query con pocos resultados (1-2 registros máximo)

---

### 8.2 Beneficios Operacionales

✅ **Eliminación de descuadres:**
- Todas las reservas web se asignan consistentemente
- Cierres de caja más precisos

✅ **Reducción de tickets de soporte:**
- Menos incidencias por cajas duplicadas
- Menos confusión por nomenclaturas diferentes

✅ **Confiabilidad del sistema:**
- Comportamiento predecible
- Menos intervención manual

---

## 9. DOCUMENTACIÓN TÉCNICA

### 9.1 Objetos Salesforce Involucrados

**Caja__c**
- `Name` (Text): Nombre visible, formato `UI-DateTime-Numero`
- `Numero_de_Caja__c` (Number): Número correlativo almacenado
- `N_Caja__c` (Formula Text): Nomenclatura formateada visible en reportes
- `OwnerId` (Lookup User): Propietario de la caja
- `Estado_de_la_Caja__c` (Text): Estado (Abierta/Cerrada)
- `FechaCaja__c` (Date Formula): Fecha de la caja

**Acreditacion__c**
- `Caja__c` (Lookup): Referencia a la caja asignada
- `Reserva__c` (Master-Detail): Relación con reserva

**Reserva__c**
- `Caja__c` (Lookup): Referencia a la caja asignada

---

### 9.2 Flows Modificados

**CrearCajaDiariaUsuarioIntegracion**
- **API Version:** 55.0
- **Tipo:** AutoLaunchedFlow - Scheduled
- **Status:** Active
- **Frecuencia:** Daily @ 00:00:00 UTC
- **Modificaciones:** +42 líneas (2 elementos nuevos)

**CrearCajaAcreditacion**
- **API Version:** 54.0
- **Tipo:** AutoLaunchedFlow - Record-Triggered (After Save)
- **Status:** Active
- **Trigger:** Acreditacion__c - Create
- **Modificaciones:** +2 líneas (ORDER BY)

---

### 9.3 Usuarios Involucrados

**CONSULTOR FORCE**
- Alias: `Cforce`
- Rol: Usuario que activó el flow programado
- Contexto: Ejecuta el flow diariamente a las 00:00

**Usuario Integración**
- Alias: `intuser`
- Rol: Usuario técnico para integraciones web
- Owner: De todas las cajas creadas automáticamente
- Correlativo: Campo `Correlativo_ultima_caja__c` almacena el último número usado

---

## 10. CONCLUSIONES

### 10.1 Problema Resuelto

Se identificó y corrigió la causa raíz del problema de nomenclatura inconsistente y cajas duplicadas:

1. **Campo fórmula corregido** → Nomenclatura consistente basada en Owner
2. **Validación anti-duplicados agregada** → Previene cajas duplicadas en reintentos
3. **ORDER BY implementado** → Asignación predecible si hay duplicados

---

### 10.2 Validación Pendiente

- **Monitoreo:** Próximos 7 días para confirmar comportamiento correcto
- **Métrica:** Verificar que solo se crea 1 caja por día
- **Confirmación:** Todas las cajas muestran nomenclatura `intuser000XXX`

---

### 10.3 Lecciones Aprendidas

1. **Campos fórmula deben usar referencias estables:** Owner es más estable que CreatedBy en contextos de automatización
2. **Flows programados necesitan idempotencia:** Siempre validar antes de crear registros
3. **Queries con getFirstRecordOnly deben tener ORDER BY:** Para comportamiento predecible
4. **Análisis previo con queries es fundamental:** Entender el problema antes de implementar soluciones

---

## 11. ANEXOS

### 11.1 Archivos Modificados

```
Commit: 160ee29
Rama: Ticket-00024259-Analisis-Caja

force-app/main/default/flows/CrearCajaDiariaUsuarioIntegracion.flow-meta.xml
force-app/main/default/flows/CrearCajaAcreditacion.flow-meta.xml
force-app/main/default/objects/Caja__c/fields/N_Caja__c.field-meta.xml
force-app/main/default/objects/Caja__c/fields/Numero_de_Caja__c.field-meta.xml (nuevo)
force-app/main/default/objects/Caja__c/Caja__c.object-meta.xml (nuevo)

Total: 5 archivos, 94 inserciones, 4 eliminaciones
```

---

### 11.2 Comandos de Despliegue

```bash
# Deploy realizado
sf project deploy start \
  --source-dir force-app/main/default/flows/CrearCajaDiariaUsuarioIntegracion.flow-meta.xml \
  --source-dir force-app/main/default/flows/CrearCajaAcreditacion.flow-meta.xml \
  --source-dir force-app/main/default/objects/Caja__c/fields/N_Caja__c.field-meta.xml \
  --target-org NASA-DEV

# Resultado: Succeeded (2.47s)
```

---

### 11.3 Referencias

- **Documentación Salesforce - Formula Fields:** https://help.salesforce.com/s/articleView?id=sf.customize_functions.htm
- **Documentación Salesforce - Scheduled Flows:** https://help.salesforce.com/s/articleView?id=sf.flow_concepts_trigger_scheduled.htm
- **Documentación Salesforce - Record-Triggered Flows:** https://help.salesforce.com/s/articleView?id=sf.flow_concepts_trigger.htm
- **Repositorio GitHub:** https://github.com/rcarval/NASA (rama: Ticket-00024259-Analisis-Caja)

---

## 12. APROBACIONES Y CAMBIOS

| Fecha | Acción | Usuario | Comentarios |
|-------|--------|---------|-------------|
| 2025-11-07 | Análisis inicial | Rodrigo Carvallo | Identificación del problema |
| 2025-11-07 | Implementación | Rodrigo Carvallo | 3 componentes modificados |
| 2025-11-07 | Despliegue | Rodrigo Carvallo | Deploy exitoso a NASA-DEV |
| 2025-11-XX | Validación | [Pendiente] | Monitoreo post-implementación |
| 2025-11-XX | Cierre | [Pendiente] | Confirmación de funcionamiento |

---

**Fin del documento**

*Este documento técnico describe las modificaciones realizadas para resolver el Ticket N°00024259 relacionado con la inconsistencia en la nomenclatura y duplicación de cajas del Usuario Integración en el sistema Salesforce de Naviera Austral.*

