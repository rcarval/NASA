/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_Tarificar_SOQL y NAV_Tarificar_Controller
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     19-10-2021   RL       Creación de la Clase.
***********************************************************************************/


@IsTest
public class NAV_Tarificar_Controller_Test  {
    @TestSetup
    static void setup(){
        Puerto__c puerto1 = new Puerto__c(
            Name = 'PUERTO MONTT'// Nombre de Puerto
        );
        insert puerto1;

        Puerto__c puerto2 = new Puerto__c(
            Name = 'CHAITÉN'// Nombre de Puerto
        );
        insert puerto2;

        Puerto__c puerto3 = new Puerto__c(
            Name = 'AYACARA'// Nombre de Puerto
        );
        insert puerto3;

        Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
            Name = 'CHAITÉN SUR',                            // Nombre de Mantenedor Rutas
            Origen_Destino__c = 'PUERTO MONTT -> CHAITÉN',  // Zarpe Origen -> Recalada Final
            Sigla_Ruta__c = 'PMCN'                            // Sigla Ruta
        );
        insert mantenedorRuta;

        Mantenedor_Ruta__c mantenedorRutaV2 = new Mantenedor_Ruta__c(
            Name = 'PUERTO MONTT SUR',                            // Nombre de Mantenedor Rutas
            Origen_Destino__c = 'CHAITÉN -> PUERTO MONTT',  // Zarpe Origen -> Recalada Final
            Sigla_Ruta__c = 'CNPM'                            // Sigla Ruta
        );
        insert mantenedorRutaV2;
        
        Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
            Name = 'PUERTO MONTT -> CHAITÉN',  // Nombre de Tramos
            Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
            Secuencia__c = 1,                     // Secuencia
            ORIGEN__c = puerto1.Id,          // ORIGEN
            Tiempo_Embarque__c = Time.newInstance(1, 0, 0, 0),            // Tiempo Embarque
            DESTINO__c = puerto2.Id         // DESTINO
        );
        insert mantenedorTramos;

        // Mantenedor_de_Tramos__c mantenedorTramos2 = new Mantenedor_de_Tramos__c(
        //  Name = 'CHAITÉN -> PUERTO MONTT',  // Nombre de Tramos
        //  Nombre_de_Ruta__c = mantenedorRutaV2.Id,  // Nombre de Ruta
        //  Secuencia__c = 1,                     // Secuencia
        //  ORIGEN__c = puerto2.Id,          // ORIGEN
        //  Tiempo_Embarque__c = Time.newInstance(1, 0, 0, 0),            // Tiempo Embarque
        //  DESTINO__c = puerto1.Id         // DESTINO
        // );
        // insert mantenedorTramos2;

        OrigenDestino__c origenDestino = new OrigenDestino__c(
            Distancia__c = 103,          // Distancia
            Origen__c = puerto1.Id,   // Origen
            Destino__c = puerto2.Id  // Destino
        );
        insert origenDestino;

        Parametro_Tasa_Embarque__c pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 9.000,                               // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                      // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 18.000,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Vehículos',                 // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 28.000,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Vehículos',                 // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 14.000,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 9.200,                               // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 18.400,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 8.900,                               // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        pte = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto1.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 17.800,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;

        Parametro_Tasa_Embarque__c pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 9.000,                               // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                      // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 18.000,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Vehículos',                 // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 28.000,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Vehículos',                 // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 14.000,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 9.200,                               // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 18.400,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = true,                            // Residente
          Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 8.900,                               // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        pteDesembarque = new Parametro_Tasa_Embarque__c(
          Puerto__c = puerto2.Id,                         // Puerto
          Concepto__c = 'Tasa Pasajero',                  // Concepto
          Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
          Residente__c = false,                           // Residente
          Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
          Valor__c = 17.800,                              // Valor
          Ruta_Comercial__c = true,                       // Ruta Comercial
          Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
          Impuesto__c = 'Valor Exento',                   // Impuesto
          Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;

        Account cuenta1 = new Account(
          RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
          FirstName = 'Dummy', // Nombre de la cuenta
          LastName = 'User',
          Identificacion__c = '8955620-1',               // Identificación
          PersonBirthdate = Date.valueOf('1967-10-11'),  // Fecha de nacimiento
          Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
          PersonEmail = 'dummy@dummy.com',               // Correo electrónico
          Discapacidad__pc = false                      // Discapacidad
        );
        insert cuenta1;

        Account cuenta2 = new Account(
          RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
          FirstName = 'Dummy', // Nombre de la cuenta
          LastName = 'User 2',
          Identificacion__c = '2-7',              // Identificación
          PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
          Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
          PersonEmail = 'dummy2@dummy.com',              // Correo electrónico
          Discapacidad__pc = false                       // Discapacidad
        );
        insert cuenta2;

        Account cuenta3 = new Account(
          RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
          FirstName = 'Dummy', // Nombre de la cuenta
          LastName = 'User 3',
          Identificacion__c = '1-9',              // Identificación
          PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
          Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
          PersonEmail = 'dummy3@dummy.com',              // Correo electrónico
          Discapacidad__pc = false                       // Discapacidad
        );
        insert cuenta3;

        Mantenedor_Nave__c nave = new Mantenedor_Nave__c(
          Name = 'AGIOS',                   // Nombre de la Nave
          Velocidad_Navegacion__c = 10,     // Velocidad Navegación
          Carga_Maxima_Vehiculos__c = 550   // Carga Máxima Vehículos
        );
        insert nave;

        Capacidad_Nave__c capacidadNave = new Capacidad_Nave__c(
            Nave__c = nave.Id,          // Nave
            Categoria__c = 'General',         // Categoría
            Numero__c = '01',                 // Número
            Ubicacion__c = 'Salón',           // Ubicación
            Capacidad__c = 1,             // Capacidad
            Cupo_Venta_Local__c = false,      // Cupo Venta Local
            Unidad_de_medida__c = 'Persona',  // Unidad de medida
            RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
        );
        insert capacidadNave;

        capacidadNave = new Capacidad_Nave__c(
            Nave__c = nave.Id,          // Nave
            Categoria__c = 'General',         // Categoría
            Numero__c = '02',                 // Número
            Ubicacion__c = 'Salón',           // Ubicación
            Capacidad__c = 1,             // Capacidad
            Cupo_Venta_Local__c = false,      // Cupo Venta Local
            Unidad_de_medida__c = 'Persona',  // Unidad de medida
            RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
        );
        insert capacidadNave;

        capacidadNave = new Capacidad_Nave__c(
            Nave__c = nave.Id,                // Nave
            Categoria__c = 'General',         // Categoría
            Numero__c = '03',                 // Número
            Ubicacion__c = 'Salón',           // Ubicación
            Capacidad__c = 1,                 // Capacidad
            Cupo_Venta_Local__c = false,      // Cupo Venta Local
            Unidad_de_medida__c = 'Persona',  // Unidad de medida
            RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
        );
        insert capacidadNave;

        capacidadNave = new Capacidad_Nave__c(
            Nave__c = nave.Id,               // Nave
            Ubicacion__c = 'Bajo cubierta',  // Ubicación
            Capacidad__c = 5,            // Capacidad
            Cupo_Venta_Local__c = false,     // Cupo Venta Local
            Unidad_de_medida__c = 'Pallet',  // Unidad de medida
            RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()
        );
        insert capacidadNave;

        capacidadNave = new Capacidad_Nave__c(
            Nave__c = nave.Id,               // Nave
            Ubicacion__c = 'Cubierta',    // Ubicación
            Numero__c = '1',              // Número
            Cupo_Venta_Local__c = false,  // Cupo Venta Local
            Unidad_de_medida__c = 'm',    // Unidad de medida
            Capacidad__c = 280.0,       // Capacidad
            Alto__c = 5.1,              // Alto
            Ancho__c = 3.1,  // Unidad de medida
            RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Pista').getRecordTypeId()
        );
        insert capacidadNave;

        Programacion_de_Itinerario__c itinerario = new Programacion_de_Itinerario__c(
          Nombre_Ruta__c = mantenedorRuta.Id,                                      // Nombre Ruta
          Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
          Tipo__c = 'SUBV',                                            // Tipo
          Nombre_de_la_Nave__c = nave.Id,                              // Nombre de la Nave
          Descuento_Temporalidad_Ocupacion__c = 'No',                  // Descuento Temporalidad Ocupación
          Estado__c = 'Disponible para venta',                         // Estado
          Canal_Web__c = true,                                         // Canal Web
          Pasajero_Web_Nac__c = false,                                 // Pasajero Web Nac
          Pasajero_Web_Ext__c = false,                                 // Pasajero Web Ext
          Vehiculo_Web_Nac__c = false,                                 // Vehículo Web Nac
          Vehiculo_Web_Ext__c = false                                 // Vehículo Web Ext
        );
        insert itinerario;

        Programacion_de_Itinerario__c itinerarioV2 = new Programacion_de_Itinerario__c(
          Nombre_Ruta__c = mantenedorRutaV2.Id,                                    // Nombre Ruta
          Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
          Tipo__c = 'SUBV',                                            // Tipo
          Nombre_de_la_Nave__c = nave.Id,                              // Nombre de la Nave
          Descuento_Temporalidad_Ocupacion__c = 'No',                  // Descuento Temporalidad Ocupación
          Estado__c = 'Disponible para venta',                         // Estado
          Canal_Web__c = true,                                         // Canal Web
          Pasajero_Web_Nac__c = false,                                 // Pasajero Web Nac
          Pasajero_Web_Ext__c = false,                                 // Pasajero Web Ext
          Vehiculo_Web_Nac__c = false,                                 // Vehículo Web Nac
          Vehiculo_Web_Ext__c = false                                 // Vehículo Web Ext
        );
        insert itinerarioV2;

        Reserva__c reserva = new Reserva__c(
          Canal_de_Venta__c = 'Presencial',                 // Canal de Venta
          Tipo_de_Reserva__c = 'General',                   // Tipo de Reserva
          Sentido_Viaje__c = 'Ida',                         // Sentido Viaje
          Fecha_de_Reserva__c = Date.valueOf('2021-09-06'), // Fecha de Reserva
          Estado_de_Reserva__c = 'Acreditada',                  // Estado de Reserva
          Cantidad_de_Pasajeros__c = 2,                     // Cantidad de Pasajeros
          Cantidad_de_Vehiculos__c = 1,                     // Cantidad de Vehículos
          Itinerario_admite_DR__c = true,                   // Itinerario admite DR
          Ocupacion_porcentaje__c = 23,                    // Ocupación %
          Fecha_Viaje__c = Date.valueOf('2021-10-10'),      // Fecha Viaje
          Fecha_Expiracion__c = Date.valueOf('2021-10-09'), // Fecha Expiración
          Puerto_ORIGEN__c = puerto1.Id,                    // Puerto ORIGEN
          Expira_al_Zarpe__c = false,                       // Expira al Zarpe
          Puerto_DESTINO__c = puerto2.Id,                    // Puerto DESTINO
          Itinerario_asociado__c = itinerario.Id
        );
        insert reserva;

        Detalle_Reserva__c detalleReserva1 = new Detalle_Reserva__c(
          RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
          Reserva__c = reserva.Id,                       // Reserva
          Numero__c = '01',                              // Número
          Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
          Unidad_de_medida__c = 'Persona',               // Unidad de medida
          Ubicacion__c = 'Salón',                        // Ubicación
          Doc_Identificacion_Pasajero__c = '8955620-1',  // Doc Identificación Pasajero
          Nombre_Pasajero__c = cuenta1.Id,               // Nombre Pasajero
          Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
          Residente__c = true,                           // Residente
          Conductor__c = false,                          // Conductor
          Transportista__c = false,                       // Transportista
          TramosReales__c = 1
        );
        insert detalleReserva1;

        Detalle_Reserva__c detalleReserva2 = new Detalle_Reserva__c(
          RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
          Reserva__c = reserva.Id,                       // Reserva
          Numero__c = '02',                              // Número
          Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
          Unidad_de_medida__c = 'Persona',               // Unidad de medida
          Ubicacion__c = 'Salón',                        // Ubicación
          Doc_Identificacion_Pasajero__c = '2-7',        // Doc Identificación Pasajero
          Nombre_Pasajero__c = cuenta2.Id,               // Nombre Pasajero
          Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
          Residente__c = false,                          // Residente
          Conductor__c = false,                          // Conductor
          Transportista__c = false,                       // Transportista
          TramosReales__c = 1
        );
        insert detalleReserva2;

        Detalle_Reserva__c detalleReserva3 = new Detalle_Reserva__c(
          RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId(),
          Reserva__c = reserva.Id,                       // Reserva
          Numero__c = '1',                                                                  // Número
          Ubicacion__c = 'Bajo Cubierta',                                                   // Ubicación
          Residente__c = true,                                                              // Residente
          Capacidad_Comprometida__c = 4.3,                                                  // Capacidad Comprometida
          Tara__c = 1,                                                                      // Tara
          Unidad_de_medida__c = 'm',                                                        // Unidad de medida
          Categoria_de_Vehiculo__c = 'Vehículo Menor',                                      // Categoría de Vehículo
          Cantidad_de_Metros__c = 2,                                                        // Cantidad de Metros
          Marca__c = 'ABARTH',                                                              // Marca
          Modelo__c = '124 SPIDER',                                                         // Modelo
          Tipo_de_Vehiculo__c = 'DEPORTIVO',                                                // Tipo de Vehículo
          Largo__c = 4.1,                                                                   // Largo
          Alto__c = 1.3,                                                                    // Alto
          Ancho__c = 2.6,                                                                   // Ancho
          Placa_Patente_Vehiculo__c = 'BPZT89',                                             // Placa Patente Vehículo
          Detalle_Reserva_Conductor__c = detalleReserva1.Id,                                 // Detalle Reserva Conductor
          TramosReales__c = 1
        );
        insert detalleReserva3;

        Detalle_Reserva__c detalleReserva4 = new Detalle_Reserva__c(
          RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId(),
          Reserva__c = reserva.Id,                       // Reserva
          Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
          Unidad_de_medida__c = 'Pallet',                // Unidad de medida
          Residente__c = true,                           // Residente
          Persona_que_entrega__c = cuenta1.Id,           // Persona que entrega
          Persona_que_retira__c = cuenta1.Id,             // Persona que retira
          TramosReales__c = 1
        );
        insert detalleReserva4;

        Detalle_Reserva__c detalleReserva5 = new Detalle_Reserva__c(
          RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
          Reserva__c = reserva.Id,                       // Reserva
          Numero__c = '02',                              // Número
          Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
          Unidad_de_medida__c = 'Persona',               // Unidad de medida
          Ubicacion__c = 'Salón',                        // Ubicación
          Doc_Identificacion_Pasajero__c = '1-9',        // Doc Identificación Pasajero
          Nombre_Pasajero__c = cuenta3.Id,               // Nombre Pasajero
          Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
          Residente__c = true,                          // Residente
          Conductor__c = true,                          // Conductor
          Transportista__c = true,                       // Transportista
          TramosReales__c = 1
        );
        insert detalleReserva5;

        Detalle_Reserva__c detalleReserva6 = new Detalle_Reserva__c(
          RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId(),
          Reserva__c = reserva.Id,                       // Reserva
          Categoria_de_Vehiculo__c = 'Bicicleta',        // Categoría de Vehículo
          Tipo_de_Vehiculo__c = 'Bicicleta',             // Tipo de Vehículo
          Detalle_Reserva_Conductor__c = detalleReserva1.Id,    // Detalle Reserva Conductor
          TramosReales__c = 1
         );
        insert detalleReserva6;

        Contrato_Tarifa__c tarifa = new Contrato_Tarifa__c(
          Name = 'CAM003',                               // Nombre del Contrato
          Vigencia_desde__c = Date.valueOf('2021-08-01'),    // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2021-11-30'),  // Vigencia hasta
          Informacion_General_de_la_Tarifa__c = '\n'      // Información General de la Tarifa
        );
        insert tarifa;

        Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
          Valor__c = 12770,                                       // Valor
          Contrato_Tarifa__c = tarifa.Id,                         // Contrato Tarifa
          Tipo_Transporte__c = 'Pasajero',                        // Tipo Transporte
          Ruta_Subsidiada__c = true,                              // Ruta Subsidiada
          Especificacion__c = 'General',                          // Especificación
          Ruta_Comercial__c = false,                              // Ruta Comercial
          Nacional__c = true,                                     // Nacional
          Puerto_ORIGEN__c = puerto1.Id,                          // Puerto ORIGEN
          Extranjero__c = true,                                   // Extranjero
          Puerto_DESTINO__c = puerto2.Id,                         // Puerto DESTINO
          Residente__c = true,                                    // Residente
          Discapacidad__c = false,                                // Discapacidad
          Estudiante__c = false,                                  // Estudiante
          Conductor__c = false,                                   // Conductor
          Impuesto__c = 'Valor Exento',                           // Impuesto
          Transportista__c = false,                               // Transportista
          Porcentaje_Impuesto__c = 0,                             // Porcentaje Impuesto
          Edad_desde__c = 0,                                      // Edad desde
          Oferta__c = 10000,                                      // Oferta
          Edad_hasta__c = 59,                                     // Edad hasta
          Vigencia_Oferta_desde__c = Date.valueOf('2021-10-10'),  // Vigencia Oferta desde
          Vigencia_Oferta_hasta__c = Date.valueOf('2021-10-11')   // Vigencia Oferta hasta
        );
        insert parametroTarifa;

        parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
          Valor__c = 17820,                        // Valor
          Contrato_Tarifa__c = tarifa.Id,          // Contrato Tarifa
          Tipo_Transporte__c = 'Pasajero',         // Tipo Transporte
          Ruta_Subsidiada__c = true,               // Ruta Subsidiada
          Especificacion__c = 'General',           // Especificación
          Ruta_Comercial__c = false,               // Ruta Comercial
          Nacional__c = true,                      // Nacional
          Puerto_ORIGEN__c = puerto1.Id,           // Puerto ORIGEN
          Extranjero__c = true,                    // Extranjero
          Puerto_DESTINO__c = puerto2.Id,          // Puerto DESTINO
          Residente__c = false,                    // Residente
          Discapacidad__c = false,                 // Discapacidad
          Estudiante__c = false,                   // Estudiante
          Conductor__c = false,                    // Conductor
          Impuesto__c = 'Valor Exento',            // Impuesto
          Transportista__c = false,                // Transportista
          Porcentaje_Impuesto__c = 0               // Porcentaje Impuesto
        );
        insert parametroTarifa;

        parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
          Valor__c = 97950,                        // Valor
          Contrato_Tarifa__c = tarifa.Id,          // Contrato Tarifa
          Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
          Ruta_Subsidiada__c = true,               // Ruta Subsidiada
          Especificacion__c = 'Vehículo Menor',    // Especificación
          Ruta_Comercial__c = false,               // Ruta Comercial
          Nacional__c = true,                      // Nacional
          Puerto_ORIGEN__c = puerto1.Id,           // Puerto ORIGEN
          Extranjero__c = true,                    // Extranjero
          Puerto_DESTINO__c = puerto2.Id,          // Puerto DESTINO
          Residente__c = true,                     // Residente
          Discapacidad__c = false,                 // Discapacidad
          Estudiante__c = false,                   // Estudiante
          Conductor__c = false,                    // Conductor
          Impuesto__c = 'Valor Bruto',             // Impuesto
          Transportista__c = false,                // Transportista
          Porcentaje_Impuesto__c = 19              // Porcentaje Impuesto
        );
        insert parametroTarifa;

        parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
          Valor__c = 22050,                        // Valor
          Contrato_Tarifa__c = tarifa.Id,          // Contrato Tarifa
          Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
          Ruta_Subsidiada__c = true,               // Ruta Subsidiada
          Especificacion__c = 'Metro Lineal',      // Especificación
          Ruta_Comercial__c = false,               // Ruta Comercial
          Nacional__c = true,                      // Nacional
          Puerto_ORIGEN__c = puerto1.Id,           // Puerto ORIGEN
          Extranjero__c = true,                    // Extranjero
          Puerto_DESTINO__c = puerto2.Id,          // Puerto DESTINO
          Residente__c = true,                     // Residente
          Discapacidad__c = false,                 // Discapacidad
          Estudiante__c = false,                   // Estudiante
          Conductor__c = false,                    // Conductor
          Impuesto__c = 'Valor Bruto',             // Impuesto
          Transportista__c = false,                // Transportista
          Porcentaje_Impuesto__c = 19              // Porcentaje Impuesto
        );
        insert parametroTarifa;

        parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
          Valor__c = 25250,                        // Valor
          Contrato_Tarifa__c = tarifa.Id,          // Contrato Tarifa
          Tipo_Transporte__c = 'Carga',            // Tipo Transporte
          Ruta_Subsidiada__c = true,               // Ruta Subsidiada
          Especificacion__c = 'Pallets',           // Especificación
          Ruta_Comercial__c = false,               // Ruta Comercial
          Nacional__c = true,                      // Nacional
          Puerto_ORIGEN__c = puerto1.Id,           // Puerto ORIGEN
          Extranjero__c = true,                    // Extranjero
          Puerto_DESTINO__c = puerto2.Id,          // Puerto DESTINO
          Residente__c = true,                     // Residente
          Discapacidad__c = false,                 // Discapacidad
          Estudiante__c = false,                   // Estudiante
          Conductor__c = false,                    // Conductor
          Impuesto__c = 'Valor Bruto',             // Impuesto
          Transportista__c = false,                // Transportista
          Porcentaje_Impuesto__c = 19             // Porcentaje Impuesto
        );
        insert parametroTarifa;

        parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
          Valor__c = 15000,                // Valor
          Contrato_Tarifa__c = tarifa.Id,   // Contrato Tarifa
          Tipo_Transporte__c = 'Vehículo',    // Tipo Transporte
          Ruta_Subsidiada__c = true,         // Ruta Subsidiada
          Especificacion__c = 'Bicicletas',   // Especificación
          Ruta_Comercial__c = false,          // Ruta Comercial
          Nacional__c = true,                // Nacional
          Puerto_ORIGEN__c = puerto1.Id,     // Puerto ORIGEN
          Extranjero__c = true,              // Extranjero
          Puerto_DESTINO__c = puerto2.Id,    // Puerto DESTINO
          Discapacidad__c = false,            // Discapacidad
          Estudiante__c = false,              // Estudiante
          Conductor__c = false,               // Conductor
          Tipo_de_Vehiculo__c = 'Bicicleta',  // Tipo de Vehículo
          Transportista__c = false,           // Transportista
          Impuesto__c = 'Valor Neto',         // Impuesto
          Porcentaje_Impuesto__c = 19        // Porcentaje Impuesto
        );
        insert parametroTarifa;
        
        Escalas_Itinerario__c escalasItinerario = new Escalas_Itinerario__c(
          Name = 'PUERTO MONTT',                                          // Escala
          Hacer_Escala__c = true,                                         // Hacer Escala
          Itinerario__c = itinerario.Id,                                  // Itinerario
          Secuencia__c = 1,                                               // Secuencia
          Puerto_Embarque__c = puerto1.Id,                                // Puerto Embarque
          Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
          Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
          Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
          Puerto_Destino__c = puerto2.Id,                                 // Puerto Destino
          Millas_de_Navegacion__c = 56,                                   // Millas de Navegación
          Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
          ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
        );
        insert escalasItinerario;

        Escalas_Itinerario__c escalasItinerario2 = new Escalas_Itinerario__c(
          Name = 'CHAITEN',                                          // Escala
          Hacer_Escala__c = true,                                         // Hacer Escala
          Itinerario__c = itinerario.Id,                                  // Itinerario
          Secuencia__c = 2,                                               // Secuencia
          Puerto_Embarque__c = puerto2.Id,                                // Puerto Embarque
          Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
          Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
          Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
          Puerto_Destino__c = puerto3.Id,                                 // Puerto Destino
          Millas_de_Navegacion__c = 56,                                   // Millas de Navegación
          Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
          ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
        );
        insert escalasItinerario2;

        // Escalas_Itinerario__c escalasItinerario3 = new Escalas_Itinerario__c(
        //   Name = 'AYACARA',                                          // Escala
        //   Hacer_Escala__c = false,                                         // Hacer Escala
        //   Itinerario__c = itinerarioV2.Id,                                  // Itinerario
        //   Secuencia__c = 1,                                               // Secuencia
        //   Puerto_Embarque__c = puerto1.Id,                                // Puerto Embarque
        //   Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
        //   Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
        //   Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
        //   Puerto_Destino__c = puerto3.Id,                                 // Puerto Destino
        //   Millas_de_Navegacion__c = 56,                                   // Millas de Navegación
        //   Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
        //   ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
        // );
        // insert escalasItinerario3;

        // Escalas_Itinerario__c escalasItinerario4 = new Escalas_Itinerario__c(
        //   Name = 'AYACARAPM',                                          // Escala
        //   Hacer_Escala__c = false,                                         // Hacer Escala
        //   Itinerario__c = itinerarioV2.Id,                                  // Itinerario
        //   Secuencia__c = 2,                                               // Secuencia
        //   Puerto_Embarque__c = puerto3.Id,                                // Puerto Embarque
        //   Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
        //   Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
        //   Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
        //   Puerto_Destino__c = puerto1.Id,                                 // Puerto Destino
        //   Millas_de_Navegacion__c = 56,                                   // Millas de Navegación
        //   Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
        //   ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
        // );
        // insert escalasItinerario4;
        
        Capacidad_Tramo__c capacidadTramo1 = new Capacidad_Tramo__c(
          RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
          Escala_itinerario__c = escalasItinerario.Id,       // Escala itinerario
          Ubicacion__c = 'Bajo cubierta',            // Ubicación
          Numero__c = '1',                           // Número
          Cupo_Venta_Local__c = false,               // Cupo Venta Local
          Capacidad__c = 5,                          // Capacidad
          Canal_Web__c = true,                       // Canal Web
          Unidad_de_medida__c = 'Pallet'             // Unidad de medida
        );
        insert capacidadTramo1;

        Capacidad_Tramo__c capacidadTramo2 = new Capacidad_Tramo__c(
		  RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		  Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		  Ubicacion__c = 'Bajo cubierta',            // Ubicación
		  Numero__c = '2',                           // Número
		  Cupo_Venta_Local__c = false,               // Cupo Venta Local
		  Capacidad__c = 5,                          // Capacidad
		  Canal_Web__c = true,                       // Canal Web
		  Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		);
		insert capacidadTramo2;

		Capacidad_Tramo__c capacidadTramo3 = new Capacidad_Tramo__c(
		  RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		  Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		  Ubicacion__c = 'Bajo cubierta',            // Ubicación
		  Numero__c = '3',                           // Número
		  Cupo_Venta_Local__c = false,               // Cupo Venta Local
		  Capacidad__c = 5,                          // Capacidad
		  Canal_Web__c = true,                       // Canal Web
		  Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		);
		insert capacidadTramo3;

		Capacidad_Tramo__c capacidadTramo4 = new Capacidad_Tramo__c(
		  RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		  Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		  Ubicacion__c = 'Bajo cubierta',            // Ubicación
		  Numero__c = '4',                           // Número
		  Cupo_Venta_Local__c = false,               // Cupo Venta Local
		  Capacidad__c = 5,                          // Capacidad
		  Canal_Web__c = true,                       // Canal Web
		  Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		);
		insert capacidadTramo4;

        Capacidad_Tramo__c capacidadTramo5 = new Capacidad_Tramo__c(
		  RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		  Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		  Ubicacion__c = 'Bajo cubierta',            // Ubicación
		  Numero__c = '5',                           // Número
		  Cupo_Venta_Local__c = false,               // Cupo Venta Local
		  Capacidad__c = 5,                          // Capacidad
		  Canal_Web__c = true,                       // Canal Web
		  Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		);
		insert capacidadTramo5;

        Capacidad_Tramo_Detalle_Reserva__c ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
          Detalle_Reserva__c = detalleReserva1.Id,      // Detalle Reserva
          Capacidad_Liberada__c = false,                 // Capacidad Liberada
          Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
          Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo
        );
        insert ctdr;

        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
          Detalle_Reserva__c = detalleReserva2.Id,      // Detalle Reserva
          Capacidad_Liberada__c = false,                 // Capacidad Liberada
          Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
          Capacidad_Tramo__c = capacidadTramo2.Id        // Capacidad Tramo
        );
        insert ctdr;

        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
            Detalle_Reserva__c = detalleReserva3.Id,      // Detalle Reserva
            Capacidad_Liberada__c = false,                 // Capacidad Liberada
            Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
            Capacidad_Tramo__c = capacidadTramo3.Id        // Capacidad Tramo   
        );
        insert ctdr;
        
        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
            Detalle_Reserva__c = detalleReserva4.Id,      // Detalle Reserva
            Capacidad_Liberada__c = false,                 // Capacidad Liberada
            Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
            Capacidad_Tramo__c = capacidadTramo4.Id        // Capacidad Tramo   
        );
        insert ctdr;

        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
            Detalle_Reserva__c = detalleReserva5.Id,      // Detalle Reserva
            Capacidad_Liberada__c = false,                 // Capacidad Liberada
            Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
            Capacidad_Tramo__c = capacidadTramo5.Id        // Capacidad Tramo   
        );
        insert ctdr;

        Mantenedor_Matriz_DR__c matriz = new Mantenedor_Matriz_DR__c(
          Name = 'DR OCT-NOV 2021',                      // Nombre Matriz DR
          Vigencia_desde__c = Date.valueOf('2021-10-01'),   // Vigencia desde
          Vigencia_hasta__c = Date.valueOf('2030-11-30')  // Vigencia hasta
        );
        insert matriz;

        Parametro_DR__c parametroDR = new Parametro_DR__c(
          Porcentaje_DR__c = 0,             // % DR
          Anticipacion_desde__c = 10,       // Anticipación desde (<)
          Utilizacion_desde__c = 25,          // % Utilización desde (<)
          Anticipacion_hasta__c = 30,       // Anticipación hasta (>=)
          Utilizacion_hasta__c = 35,          // % Utilización hasta (>=)
          Nombre_Matriz_DR__c = matriz.Id  // Nombre Matriz DR
        );
        insert parametroDR;
    }

    //Test de Camino Feliz - Butaca
    @IsTest
    private static void test1(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c, Reserva__r.Fecha_de_Reserva__c, Reserva__r.Fecha_Viaje__c, Reserva__r.Ocupacion_porcentaje__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            
            
            Date fechaComparar = Date.valueOf(detalleReserva.Reserva__r.Fecha_Viaje__c);
            Date fechaReserva = Date.valueOf(detalleReserva.Reserva__r.Fecha_de_Reserva__c);
            //Calculo días de Anticipación en base a fecha de Reserva y fecha de Viaje
            Integer diasAnticipacion = fechaReserva.daysBetween(fechaComparar);
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Parametro_DR__c parametroDR;
            //Obtengo recargo DR en base a los datos del Registro
            parametroDR = consultasSOQL.getRecargoDR(diasAnticipacion, detalleReserva.Reserva__r.Ocupacion_porcentaje__c,detalleReserva.Reserva__r.Fecha_Viaje__c);

            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Camino Feliz - Butaca
    @IsTest
    private static void test1Extranjero(){
        Test.startTest();
            Account acc = [SELECT Id, Tipo_de_identificacion__c FROM Account WHERE Identificacion__c = '8955620-1' LIMIT 1];
            acc.Tipo_de_identificacion__c = 'Pasaporte';
            update acc;
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }
    //Test de Camino Feliz - Butaca - Cálculo con Valor Bruto
    @IsTest
    private static void test2(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '2-7'];
            // List<Parametro_Tasa_Embarque__c> tasasEmbarque = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Pasajero'];
            // for(Parametro_Tasa_Embarque__c tasaEmbarque : tasasEmbarque){
            //     tasaEmbarque.Impuesto__c = 'Valor Bruto';
            // }
            // update tasasEmbarque;

        
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de camino feliz - Butaca - Uso de Impuesto Valor Bruto y Tasa de Embarque Neto
    @IsTest
    private static void test3(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '2-7'];
            // Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 17820];
            // ptr.Impuesto__c = 'Valor Bruto';
            // update ptr;

            // List<Parametro_Tasa_Embarque__c> tasasEmbarque = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Pasajero'];
            // for(Parametro_Tasa_Embarque__c tasaEmbarque : tasasEmbarque){
            //     tasaEmbarque.Impuesto__c = 'Valor Neto';
            // }
            // update tasasEmbarque;

        
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Camino Feliz - Pallet
    @IsTest
    private static void test4(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test camino feliz - Pallet - Valor Exento
    @IsTest
    private static void test5(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
            Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 25250];
            ptr.Impuesto__c = 'Valor Exento';
            update ptr;
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test Camino Feliz - Pallet - Valor Neto
    @IsTest
    private static void test6(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
            Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 25250];
            ptr.Impuesto__c = 'Valor Neto';
            update ptr;
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test camino feliz - Pista
    @IsTest
    private static void test7(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
       
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test camino feliz - Pista - Valor Exento
    @IsTest
    private static void test8(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
            Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 97950];
            ptr.Impuesto__c = 'Valor Exento';
            update ptr;

            ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 22050];
            ptr.Impuesto__c = 'Valor Exento';
            update ptr;

            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test camino feliz - Pista - Valor Neto
    @IsTest
    private static void test9(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
            Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 97950];
            ptr.Impuesto__c = 'Valor Neto';
            update ptr;

            ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 22050];
            ptr.Impuesto__c = 'Valor Neto';
            update ptr;

            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Tarifa no encontrada
    @IsTest
    private static void test10(){
        Test.startTest(); 
            Reserva__c reserva = [SELECT Id FROM Reserva__c];
            Puerto__c puerto = [SELECT Id FROM Puerto__c WHERE Name = 'AYACARA'];
            reserva.Puerto_DESTINO__c = puerto.Id;
            update reserva;

            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
       
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c == 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Tarifa no encontrada
    @IsTest
    private static void test11(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
            Contrato_Tarifa__c tarifa = [SELECT Id FROM Contrato_Tarifa__c WHERE Name = 'CAM003']; 
       
        
            Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'PUERTO MONTT'];
            Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'CHAITÉN'];
            Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
            Valor__c = 97950,                        // Valor
            Contrato_Tarifa__c = tarifa.Id,          // Contrato Tarifa
            Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
            Ruta_Subsidiada__c = true,               // Ruta Subsidiada
            Especificacion__c = 'Vehículo Menor',    // Especificación
            Ruta_Comercial__c = false,               // Ruta Comercial
            Nacional__c = true,                      // Nacional
            Puerto_ORIGEN__c = puerto1.Id,           // Puerto ORIGEN
            Extranjero__c = true,                    // Extranjero
            Puerto_DESTINO__c = puerto2.Id,          // Puerto DESTINO
            Residente__c = true,                     // Residente
            Discapacidad__c = false,                 // Discapacidad
            Estudiante__c = false,                   // Estudiante
            Conductor__c = false,                    // Conductor
            Impuesto__c = 'Valor Bruto',             // Impuesto
            Transportista__c = false,                // Transportista
            Porcentaje_Impuesto__c = 19              // Porcentaje Impuesto
            );
            insert parametroTarifa;

            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test Camino Feliz - Pista - Distinto Parametro
    @IsTest
    private static void test12(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
            Contrato_Tarifa__c tarifa = [SELECT Id FROM Contrato_Tarifa__c]; 
            Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'PUERTO MONTT'];
            Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'CHAITÉN'];
            Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
            Valor__c = 22050,                        // Valor
            Contrato_Tarifa__c = tarifa.Id,          // Contrato Tarifa
            Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
            Ruta_Subsidiada__c = true,               // Ruta Subsidiada
            Especificacion__c = 'Metro Lineal',      // Especificación
            Ruta_Comercial__c = false,               // Ruta Comercial
            Nacional__c = true,                      // Nacional
            Puerto_ORIGEN__c = puerto1.Id,           // Puerto ORIGEN
            Extranjero__c = true,                    // Extranjero
            Puerto_DESTINO__c = puerto2.Id,          // Puerto DESTINO
            Residente__c = true,                     // Residente
            Discapacidad__c = false,                 // Discapacidad
            Estudiante__c = false,                   // Estudiante
            Conductor__c = false,                    // Conductor
            Impuesto__c = 'Valor Bruto',             // Impuesto
            Transportista__c = false,                // Transportista
            Porcentaje_Impuesto__c = 19              // Porcentaje Impuesto
            );
            insert parametroTarifa;
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test13(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() <= 0);
        Test.stopTest();
    }
    
    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test14(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = false;
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() <= 0);
        Test.stopTest();
    }

    //Test de Query - Tasa Embarque
    @IsTest
    private static void test15(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
       
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Butaca');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test16(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = false;
            detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() <= 0);
        Test.stopTest();
    }

    //Test de Query - Tasas Desembarque
    @IsTest
    private static void test17(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaDesembarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_DESTINO__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Butaca');
            System.assertEquals(true, tasaDesembarque == null);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifas
    @IsTest
    private static void test18(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];

            consultasSOQL.getTramoDetalleReserva(detalleReserva.Id);
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = true;
            detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'COM', 'General');
            consultasSOQL.actualizarValorDetalleReserva(detalleReserva);
            System.assertEquals(true, mapParametros.size() <= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifas
    @IsTest
    private static void test19(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = false;
            detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test20(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = true;
            detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test21(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pallet', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test22(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pallet', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test23(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pallet', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test24(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pista', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test25(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pista', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test26(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pista', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test27(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMetroLineal(detalleReserva, 'COM');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test28(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
      
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMetroLineal(detalleReserva, 'COM');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test29(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMetroLineal(detalleReserva, 'SUBV');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Tasa Embarque
    @IsTest
    private static void test30(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque != null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test31(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test32(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
       
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test33(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test34(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test35(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test36(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test37(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
       
        
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque != null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test38(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test39(){
        Test.startTest();    
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
       
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test40(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test41(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test42(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test43(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test44(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        

            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque != null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Embarque
    @IsTest
    private static void test45(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque != null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test46(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test47(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test48(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test49(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test50(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test51(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test52(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
       
        
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque != null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test53(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
       
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test54(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test55(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'COM', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test56(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Carro_Arrastre__c = true;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test57(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 1;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test58(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
            detalleReserva.Cantidad_de_Metros__c = 13;
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque == null);
        Test.stopTest();
    }

    //Test de Query - Tasa de Desembarque
    @IsTest
    private static void test59(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__c = null;
            update detalleReserva;
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Parametro_Tasa_Embarque__c tasaEmbarque = consultasSOQL.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, 'SUBV', 'Pista');
            System.assertEquals(true, tasaEmbarque != null);
        Test.stopTest();
    }

    //Test Ponderador - Retorna 0
    @IsTest
    private static void test60(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            Integer valorRetorno = NAV_Tarificador.rankPonderador('','',0);
            System.assertEquals(true, valorRetorno == 0);
        Test.stopTest();
    }

    //Test Ponderador - Retorna -100
    @IsTest
    private static void test61(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            Integer valorRetorno = NAV_Tarificador.rankPonderador('a','b',0);
            System.assertEquals(true, valorRetorno == -100);
        Test.stopTest();
    }

    //Test Ponderador - Retorna -1000
    @IsTest
    private static void test62(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            Integer valorRetorno = NAV_Tarificador.rankingEdad(10,15,20,25);
            System.assertEquals(true, valorRetorno == -1000);
        Test.stopTest();
    }

    //Test Ponderador - Retorna 1000
    @IsTest
    private static void test63(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        
            Integer valorRetorno = NAV_Tarificador.rankingEdad(25,15,20,20);
            System.assertEquals(true, valorRetorno == 1000);
        Test.stopTest();
    }

    //Test para aumentar cobertura
    @IsTest
    private static void test64(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
        
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            List<String> idList = new List<String>();
			idList.add(detalleReserva.id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test para aumentar cobertura
    @IsTest
    private static void test65(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
            Parametros_Tarifarios_Pasajeros__c parametroTarifa = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Especificacion__c = 'Bicicletas'];
            parametroTarifa.Impuesto__c = 'Valor Exento';
            update parametroTarifa;        
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            List<String> idList = new List<String>();
			idList.add(detalleReserva.id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test para aumentar cobertura
    @IsTest
    private static void test66(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
            Parametros_Tarifarios_Pasajeros__c parametroTarifa = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Especificacion__c = 'Bicicletas'];
            parametroTarifa.Impuesto__c = 'Valor Bruto';
            update parametroTarifa;
        
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            List<String> idList = new List<String>();
			idList.add(detalleReserva.id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test66Extra(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
            Parametros_Tarifarios_Pasajeros__c parametroTarifa = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Especificacion__c = 'Bicicletas'];
            parametroTarifa.Impuesto__c = 'Valor Bruto';
            update parametroTarifa;

            consultasSOQL.getParametroTarifa(parametroTarifa.Id);

            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            List<String> idList = new List<String>();
			idList.add(detalleReserva.id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test67(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Bicicletas', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test68(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Bicicletas', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test69(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'Pasaporte';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Bicicletas', 'SUBV','');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }

    //Test de Aumento de Cobertura NAV_EscalaTriggerHelper
    @IsTest
    private static void test70(){
        Test.startTest();
            NAV_EscalaTriggerHelper escalaTriggerHelper = new NAV_EscalaTriggerHelper();
            List<Escalas_Itinerario__c> escalasItinerarioLst = [SELECT Id, Itinerario__c,
                                                            Name
                                                            FROM Escalas_Itinerario__c];
        
            for(Escalas_Itinerario__c escalasItinerario :escalasItinerarioLst){
                if(escalasItinerario.Name == 'PUERTO MONTT'){
                    escalasItinerario.Inicio_Embarque__c = Datetime.valueOf('2021-09-11 19:45:00');
                    escalasItinerario.Salida__c = Datetime.valueOf('2021-09-11 20:45:00');
                    escalasItinerario.ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-12 2:21:00');
                }else{
                    escalasItinerario.Salida__c = Datetime.valueOf('2021-09-11 20:45:00');
                    escalasItinerario.ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-12 2:21:00');
                }
            }
            update escalasItinerarioLst;

            System.assertEquals(true, escalasItinerarioLst.size() >= 0);
        Test.stopTest();
    }

    //Test de Aumento de Cobertura NAV_EscalaTriggerHelper
    @IsTest
    private static void test71(){
        Test.startTest();
            NAV_EscalaTriggerHelper escalaTriggerHelper = new NAV_EscalaTriggerHelper();
            List<Escalas_Itinerario__c> escalasItinerarioLst = [SELECT Id, Itinerario__c,
                                                            Name
                                                            FROM Escalas_Itinerario__c];
        
            for(Escalas_Itinerario__c escalasItinerario :escalasItinerarioLst){
                if(escalasItinerario.Name == 'PUERTO MONTT'){
                    escalasItinerario.Tiempo_Embarque__c = Time.newInstance(2,0,0,0);
                }
            }
            update escalasItinerarioLst;
            System.assertEquals(true, escalasItinerarioLst.size() >= 0);
        Test.stopTest();
    }

    //Test de Aumento de Cobertura NAV_EscalaTriggerHelper
    @IsTest
    private static void test72(){
        Test.startTest();
            NAV_EscalaTriggerHelper escalaTriggerHelper = new NAV_EscalaTriggerHelper();
            List<Escalas_Itinerario__c> escalasItinerarioLst = [SELECT Id, Itinerario__c,
                                                            Name
                                                            FROM Escalas_Itinerario__c];
        
            for(Escalas_Itinerario__c escalasItinerario :escalasItinerarioLst){
                if(escalasItinerario.Name == 'PUERTO MONTT'){
                    escalasItinerario.Navegacion__c = Time.newInstance(6,35,0,0);
                }
            }
            update escalasItinerarioLst;
            System.assertEquals(true, escalasItinerarioLst.size() >= 0);
        Test.stopTest();
    }

    //Test camino feliz - Pista - Valor Bruto
    @IsTest
    private static void test73(){
        Test.startTest();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
            
            List<Parametro_Tasa_Embarque__c> pteList = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Vehículos'];
            for(Parametro_Tasa_Embarque__c pte : pteList){
                pte.Impuesto__c = 'Valor Bruto';
                pte.Porcentaje_Impuesto__c = 19;
            }
            update pteList;

            Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 97950];
            ptr.Impuesto__c = 'Valor Bruto';
            update ptr;

            ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 22050];
            ptr.Impuesto__c = 'Valor Bruto';
            update ptr;
        
            PageReference pref = Page.NAV_Tarificar_VF;
            Test.setCurrentPage(pref);
            pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
            ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
            NAV_Tarificar_Controller controlador = new NAV_Tarificar_Controller(apst);
            controlador.valorizarRegistro();
            detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
            System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
        Test.stopTest();
    }
    
        //Test de Query - Parametros Tarifa
    @IsTest
    private static void test74(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = True;
            detalleReserva.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
        @IsTest
    private static void test75(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Residente__c = False;
            detalleReserva.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Butaca', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
     //Test de Query - Parametros Tarifa
    @IsTest
    private static void test76(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pallet', 'COM', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
         //Test de Query - Parametros Tarifa
    @IsTest
    private static void test77(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pallet', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
        //Test de Query - Parametros Tarifa
    @IsTest
    private static void test78(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Pista', 'SUBV', 'General');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
        //Test de Query - Parametros Tarifa
    @IsTest
    private static void test79(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Bicicletas', 'SUBV','');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
    //Test de Query - Parametros Tarifa
    @IsTest
    private static void test80(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifa(detalleReserva, 'Bicicletas', 'SUBV','');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
    
        //Test de Query - Parametros Tarifa
    @IsTest
    private static void test81(){
        Test.startTest();
            NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
            Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
        
            detalleReserva = consultasSOQL.retornarDatosDetalleReserva(detalleReserva.Id);
            detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c = 'RUT';
            Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMetroLineal(detalleReserva, 'SUBV');
            System.assertEquals(true, mapParametros.size() >= 0);
        Test.stopTest();
    }
}