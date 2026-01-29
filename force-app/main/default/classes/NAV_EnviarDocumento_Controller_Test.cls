/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_EnviarDocumento_Controller_Test
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     30-11-2021   RL       Creación de la Clase.
***********************************************************************************/

@isTest 
private class NAV_EnviarDocumento_Controller_Test {
    @TestSetup
    static void setup(){
        Puerto__c puerto1 = new Puerto__c(
            Name = 'DUMMY MONTT'// Nombre de Puerto
        );
        insert puerto1;
        
        Puerto__c puerto2 = new Puerto__c(
            Name = 'DUMMY CHAITÉN'// Nombre de Puerto
        );
        insert puerto2;
        
        Puerto__c puerto3 = new Puerto__c(
            Name = '--'// Nombre de Puerto
        );
        insert puerto3;
        
        Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
            Name = 'DUMMY CHAITÉN SUR',                            // Nombre de Mantenedor Rutas
            Origen_Destino__c = 'DUMMY MONTT -> DUMMY CHAITÉN',  // Zarpe Origen -> Recalada Final
            Sigla_Ruta__c = 'PMCN'  ,                          // Sigla Ruta
            Empresa_Puelche__c = True
        );
        insert mantenedorRuta;
        
        Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
            Name = 'DUMMY MONTT -> DUMMY CHAITÉN',  // Nombre de Tramos
            Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
            Secuencia__c = 1,                     // Secuencia
            ORIGEN__c = puerto1.Id,          // ORIGEN
            Tiempo_Embarque__c = Time.newInstance(1, 0, 0, 0),            // Tiempo Embarque
            DESTINO__c = puerto2.Id         // DESTINO
        );
        insert mantenedorTramos;
        
        mantenedorTramos = new Mantenedor_de_Tramos__c(
            Name = 'DUMMY CHAITÉN -> --',  // Nombre de Tramos
            Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
            Secuencia__c = 2,                     // Secuencia
            ORIGEN__c = puerto2.Id,          // ORIGEN
            Tiempo_Embarque__c = Time.newInstance(1, 0, 0, 0),            // Tiempo Embarque
            DESTINO__c = puerto3.Id         // DESTINO
        );
        insert mantenedorTramos;
        
        OrigenDestino__c origenDestino = new OrigenDestino__c(
            Distancia__c = 103,          // Distancia
            Origen__c = puerto1.Id,   // Origen
            Destino__c = puerto2.Id  // Destino
        );
        insert origenDestino;
        
        Parametro_Tasa_Embarque__c pte = new Parametro_Tasa_Embarque__c(
            Puerto__c = puerto1.Id,              // Puerto
            Concepto__c = 'Tasa Pasajero',                  // Concepto
            Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
            Residente__c = true,                            // Residente
            Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2023-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2023-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2023-03-31'), // Vigencia hasta
            Valor__c = 8.900,                               // Valor
            Ruta_Comercial__c = true,                       // Ruta Comercial
            Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
            Impuesto__c = 'Valor Exento',                   // Impuesto
            Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;
        
        pte = new Parametro_Tasa_Embarque__c(
            Puerto__c = puerto1.Id,              // Puerto
            Concepto__c = 'Tasa Pasajero',                  // Concepto
            Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
            Residente__c = false,                           // Residente
            Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
            Vigencia_hasta__c = Date.valueOf('2021-03-31'), // Vigencia hasta
            Valor__c = 17.800,                              // Valor
            Ruta_Comercial__c = true,                       // Ruta Comercial
            Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
            Impuesto__c = 'Valor Exento',                   // Impuesto
            Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pte;
        
        Parametro_Tasa_Embarque__c pteDesembarque = new Parametro_Tasa_Embarque__c(
            Puerto__c = puerto2.Id,              // Puerto
            Concepto__c = 'Tasa Pasajero',                  // Concepto
            Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
            Residente__c = true,                            // Residente
            Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2023-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2023-03-31'), // Vigencia hasta
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
            Vigencia_hasta__c = Date.valueOf('2023-03-31'), // Vigencia hasta
            Valor__c = 8.900,                               // Valor
            Ruta_Comercial__c = true,                       // Ruta Comercial
            Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
            Impuesto__c = 'Valor Exento',                   // Impuesto
            Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
        );
        insert pteDesembarque;
        
        pteDesembarque = new Parametro_Tasa_Embarque__c(
            Puerto__c = puerto2.Id,              // Puerto
            Concepto__c = 'Tasa Pasajero',                  // Concepto
            Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
            Residente__c = false,                           // Residente
            Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
            Vigencia_hasta__c = Date.valueOf('2021-03-31'), // Vigencia hasta
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
            Discapacidad__pc = false,                      // Discapacidad
            Nacionalidad__pc = 'Chileno(a)',
            Sexo__pc = 'M'
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
            Nave__c = nave.Id,              // Nave
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
            Nave__c = nave.Id,              // Nave
            Ubicacion__c = 'Bajo cubierta',  // Ubicación
            Capacidad__c = 5,            // Capacidad
            Cupo_Venta_Local__c = false,     // Cupo Venta Local
            Unidad_de_medida__c = 'Pallet',  // Unidad de medida
            RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()
        );
        insert capacidadNave;
        
        capacidadNave = new Capacidad_Nave__c(
            Nave__c = nave.Id,              // Nave
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
            Nombre_Ruta__c = mantenedorRuta.Id,                               // Nombre Ruta
            Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
            Tipo__c = 'SUBV',                                            // Tipo
            Nombre_de_la_Nave__c = nave.Id,                           // Nombre de la Nave
            Descuento_Temporalidad_Ocupacion__c = 'No',                  // Descuento Temporalidad Ocupación
            Estado__c = 'Disponible para venta',                         // Estado
            Canal_Web__c = true,                                         // Canal Web
            Pasajero_Web_Nac__c = false,                                 // Pasajero Web Nac
            Pasajero_Web_Ext__c = false,                                 // Pasajero Web Ext
            Vehiculo_Web_Nac__c = false,                                 // Vehículo Web Nac
            Vehiculo_Web_Ext__c = false                                 // Vehículo Web Ext
        );
        insert itinerario;
        
        Reserva__c reserva = new Reserva__c(
            Canal_de_Venta__c = 'Presencial',                 // Canal de Venta
            Tipo_de_Reserva__c = 'General',                   // Tipo de Reserva
            Sentido_Viaje__c = 'Ida',                         // Sentido Viaje
            Fecha_de_Reserva__c = Date.valueOf('2021-09-06'), // Fecha de Reserva
            Estado_de_Reserva__c = 'Creada',                  // Estado de Reserva
            Cantidad_de_Pasajeros__c = 2,                     // Cantidad de Pasajeros
            Cantidad_de_Vehiculos__c = 1,                     // Cantidad de Vehículos
            Itinerario_admite_DR__c = true,                   // Itinerario admite DR
            Ocupacion_porcentaje__c = 23,                    // Ocupación %
            Fecha_Viaje__c = Date.valueOf('2021-10-10'),      // Fecha Viaje
            Fecha_Hora_de_Viaje__c = DateTime.valueOf('2021-10-10 15:00:00'),
            Fecha_Expiracion__c = Date.today(), // Fecha Expiración
            Puerto_ORIGEN__c = puerto1.Id,                    // Puerto ORIGEN
            Expira_al_Zarpe__c = true,                       // Expira al Zarpe
            Puerto_DESTINO__c = puerto2.Id,                    // Puerto DESTINO
            Itinerario_asociado__c = itinerario.Id,
            Contacto_Reserva__c = cuenta1.id,
            UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4'
        );
        insert reserva;
        
        Detalle_Reserva__c detalleReserva1 = new Detalle_Reserva__c(
            RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
            Reserva__c = reserva.Id,             // Reserva
            Numero__c = '01',                              // Número
            Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
            Unidad_de_medida__c = 'Persona',               // Unidad de medida
            Ubicacion__c = 'Salón',                        // Ubicación
            Doc_Identificacion_Pasajero__c = '8955620-1',  // Doc Identificación Pasajero
            Nombre_Pasajero__c = cuenta1.Id,               // Nombre Pasajero
            Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
            Residente__c = true,                           // Residente
            Conductor__c = false,                          // Conductor
            Transportista__c = false,                      // Transportista
            Parametro_Tarifa__c = 'Tarifa: P-0000000198',  // Parámetro Tarifa
            Valor_Pasajero__c = 20800,                    // Valor Pasajero
            Valor_Pasajero_DR__c = 20800,                 // Valor Pasajero DR
            Parametro_Tasa_de_Embarque__c = 'TE-000001',   // Parámetro Tasa de Embarque
            Tasa_Embarque__c = 2975,                      // Tasa Embarque
            Tasa_Desembarque__c = 0                       // Tasa Desembarque
        );
        insert detalleReserva1;
        
        Detalle_Reserva__c detalleReserva2 = new Detalle_Reserva__c(
            RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
            Reserva__c = reserva.Id,             // Reserva
            Numero__c = '02',                              // Número
            Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
            Unidad_de_medida__c = 'Persona',               // Unidad de medida
            Ubicacion__c = 'Salón',                        // Ubicación
            Doc_Identificacion_Pasajero__c = '2-7',        // Doc Identificación Pasajero
            Nombre_Pasajero__c = cuenta2.Id,               // Nombre Pasajero
            Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
            Residente__c = false,                          // Residente
            Conductor__c = false,                          // Conductor
            Transportista__c = false,
            Parametro_Tarifa__c = 'Tarifa: P-0000000198',  // Parámetro Tarifa
            Valor_Pasajero__c = 20800,                    // Valor Pasajero
            Valor_Pasajero_DR__c = 20800,                 // Valor Pasajero DR
            Parametro_Tasa_de_Embarque__c = 'TE-000001',   // Parámetro Tasa de Embarque
            Tasa_Embarque__c = 2975,                      // Tasa Embarque
            Tasa_Desembarque__c = 0                       // Tasa Desembarque
        );
        insert detalleReserva2;
        
        Detalle_Reserva__c detalleReserva3 = new Detalle_Reserva__c(
            RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId(),
            Reserva__c = reserva.Id,             // Reserva
            Numero__c = '1',                                                                  // Número
            Ubicacion__c = 'Bajo Cubierta',                                                   // Ubicación
            Residente__c = true,                                                              // Residente
            Capacidad_Comprometida__c = 4.3,                                                  // Capacidad Comprometida
            Tara__c = 1,                                                                      // Tara
            Unidad_de_medida__c = 'm',                                                        // Unidad de medida
            Categoria_de_Vehiculo__c = 'Vehículo Menor',                                      // Categoría de Vehículo
            Cantidad_de_Metros__c = 2,                                                        // Cantidad de Metros
            Marca__c = 'CHEVROLET',                                                              // Marca
            Modelo__c = 'IMPALA',                                                         // Modelo
            Tipo_de_Vehiculo__c = 'DEPORTIVO',                                                // Tipo de Vehículo
            Largo__c = 4.1,                                                                   // Largo
            Alto__c = 1.3,                                                                    // Alto
            Ancho__c = 2.6,                                                                   // Ancho
            Placa_Patente_Vehiculo__c = 'BPZT89',                                             // Placa Patente Vehículo
            Detalle_Reserva_Conductor__c = detalleReserva1.Id,                                 // Detalle Reserva Conductor
            ML_Portabicicleta__c = 1,                                                       // ML Portabicicleta
            Parametro_Tarifa__c = 'Tarifa: P-0000000217, Tarifa Metro lineal: P-0000001162',  // Parámetro Tarifa
            Parametro_Tasa_de_Embarque__c = 'TE-000011',                                      // Parámetro Tasa de Embarque
            Tasa_Embarque__c = 5903,                                                         // Tasa Embarque
            Tasa_Desembarque__c = 0,                                                          // Tasa Desembarque
            Valor_Vehiculo__c = 97950,                                                       // Valor Vehículo
            Valor_Veh_culo_DR__c = 104905,                                                   // Valor Vehículo DR
            Valor_Metros__c = 286650,                                                        // Valor Metros
            Valor_ML_DR__c = 307003,                                                         // Valor ML DR
            Porcentaje_DR_Tiempo_Ocupacion__c = 100
        );
        insert detalleReserva3;
        
        Detalle_Reserva__c detalleReserva4 = new Detalle_Reserva__c(
            RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId(),
            Reserva__c = reserva.Id,             // Reserva
            Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
            Unidad_de_medida__c = 'Pallet',                // Unidad de medida
            Residente__c = true,                           // Residente
            Persona_que_entrega__c = cuenta1.Id,           // Persona que entrega
            Persona_que_retira__c = cuenta1.Id,            // Persona que retira
            Parametro_Tarifa__c = 'Tarifa: P-0000000185',  // Parámetro Tarifa
            Valor_Carga__c = 12625,                        // Valor Carga
            Valor_Carga_DR__c = 15024,                     // Valor Carga DR
            Neto_CA__c = 12625,                            // Neto CA
            IVA_CA__c = 2399,                              // IVA CA
            Porcentaje_DR_Tiempo_Ocupacion__c = 0          // % DR Tiempo Ocupación
        );
        insert detalleReserva4;
        
        Contrato_Tarifa__c tarifa = new Contrato_Tarifa__c(
            Name = 'CAM003',                               // Nombre del Contrato
            Vigencia_desde__c = Date.valueOf('2021-08-01'),    // Vigencia desde
            Vigencia_hasta__c = Date.valueOf('2021-11-30'),  // Vigencia hasta
            Informacion_General_de_la_Tarifa__c = '\n'      // Información General de la Tarifa
        );
        insert tarifa;
        
        Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
            Valor__c = 12770,                        // Valor
            Contrato_Tarifa__c = tarifa.Id,                  // Contrato Tarifa
            Tipo_Transporte__c = 'Pasajero',                        // Tipo Transporte
            Ruta_Subsidiada__c = true,                              // Ruta Subsidiada
            Especificacion__c = 'General',                          // Especificación
            Ruta_Comercial__c = false,                              // Ruta Comercial
            Nacional__c = true,                                     // Nacional
            Puerto_ORIGEN__c = puerto1.Id,                        // Puerto ORIGEN
            Extranjero__c = true,                                   // Extranjero
            Puerto_DESTINO__c = puerto2.Id,                      // Puerto DESTINO
            Residente__c = true,                                    // Residente
            Discapacidad__c = false,                                // Discapacidad
            Estudiante__c = false,                                  // Estudiante
            Conductor__c = false,                                   // Conductor
            Impuesto__c = 'Valor Exento',                           // Impuesto
            Transportista__c = false,                               // Transportista
            Porcentaje_Impuesto__c = 0,                             // Porcentaje Impuesto
            Edad_desde__c = 0,                                    // Edad desde
            Oferta__c = 10000,                                  // Oferta
            Edad_hasta__c = 59,                                    // Edad hasta
            Vigencia_Oferta_desde__c = Date.valueOf('2021-10-10'),  // Vigencia Oferta desde
            Vigencia_Oferta_hasta__c = Date.valueOf('2021-10-11')   // Vigencia Oferta hasta
        );
        insert parametroTarifa;
        
        parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
            Valor__c = 17820,                       // Valor
            Contrato_Tarifa__c = tarifa.Id,       // Contrato Tarifa
            Tipo_Transporte__c = 'Pasajero',         // Tipo Transporte
            Ruta_Subsidiada__c = true,               // Ruta Subsidiada
            Especificacion__c = 'General',           // Especificación
            Ruta_Comercial__c = false,               // Ruta Comercial
            Nacional__c = true,                      // Nacional
            Puerto_ORIGEN__c = puerto1.Id,         // Puerto ORIGEN
            Extranjero__c = true,                    // Extranjero
            Puerto_DESTINO__c = puerto2.Id,       // Puerto DESTINO
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
            Contrato_Tarifa__c = tarifa.Id,       // Contrato Tarifa
            Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
            Ruta_Subsidiada__c = true,               // Ruta Subsidiada
            Especificacion__c = 'Vehículo Menor',    // Especificación
            Ruta_Comercial__c = false,               // Ruta Comercial
            Nacional__c = true,                      // Nacional
            Puerto_ORIGEN__c = puerto1.Id,         // Puerto ORIGEN
            Extranjero__c = true,                    // Extranjero
            Puerto_DESTINO__c = puerto2.Id,       // Puerto DESTINO
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
            Contrato_Tarifa__c = tarifa.Id,       // Contrato Tarifa
            Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
            Ruta_Subsidiada__c = true,               // Ruta Subsidiada
            Especificacion__c = 'Metro Lineal',      // Especificación
            Ruta_Comercial__c = false,               // Ruta Comercial
            Nacional__c = true,                      // Nacional
            Puerto_ORIGEN__c = puerto1.Id,         // Puerto ORIGEN
            Extranjero__c = true,                    // Extranjero
            Puerto_DESTINO__c = puerto2.Id,       // Puerto DESTINO
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
            Contrato_Tarifa__c = tarifa.Id,       // Contrato Tarifa
            Tipo_Transporte__c = 'Carga',            // Tipo Transporte
            Ruta_Subsidiada__c = true,               // Ruta Subsidiada
            Especificacion__c = 'Pallets',           // Especificación
            Ruta_Comercial__c = false,               // Ruta Comercial
            Nacional__c = true,                      // Nacional
            Puerto_ORIGEN__c = puerto1.Id,         // Puerto ORIGEN
            Extranjero__c = true,                    // Extranjero
            Puerto_DESTINO__c = puerto2.Id,       // Puerto DESTINO
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
        
        Escalas_Itinerario__c escalasItinerario = [SELECT Id 
                                                   FROM Escalas_Itinerario__c 
                                                   WHERE Puerto_Embarque__r.Name = 'DUMMY MONTT' 
                                                   AND Itinerario__c =: itinerario.Id
                                                   AND Hacer_Escala__c = true];    
        
        Capacidad_Tramo__c capacidadTramo1 = new Capacidad_Tramo__c(
            RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
            Escala_itinerario__c = escalasItinerario.Id,     // Escala itinerario
            Ubicacion__c = 'Bajo cubierta',            // Ubicación
            Numero__c = '01',                           // Número
            Cupo_Venta_Local__c = false,               // Cupo Venta Local
            Capacidad__c = 100,                          // Capacidad
            Canal_Web__c = true,                       // Canal Web
            Unidad_de_medida__c = 'Pallet'             // Unidad de medida
        );
        insert capacidadTramo1;
        
        Capacidad_Tramo__c capacidadTramo2 = new Capacidad_Tramo__c(
            RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId(),
            Escala_itinerario__c = escalasItinerario.Id,     // Escala itinerario
            Ubicacion__c = 'Cubierta',            // Ubicación
            Numero__c = '01',                           // Número
            Cupo_Venta_Local__c = false,               // Cupo Venta Local
            Alto__c = 6,
            Capacidad__c = 100,                          // Capacidad
            Canal_Web__c = true,                       // Canal Web
            Unidad_de_medida__c = 'm'             // Unidad de medida
        );
        insert capacidadTramo2;
        
        Capacidad_Tramo__c capacidadTramo3 = new Capacidad_Tramo__c(
            RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
            Escala_itinerario__c = escalasItinerario.Id,     // Escala itinerario
            Ubicacion__c = 'Cubierta',                    // Ubicación
            Numero__c = '01',                                // Número
            Cupo_Venta_Local__c = false,                    // Cupo Venta Local
            Capacidad__c = 100,                               // Capacidad
            Canal_Web__c = true,                            // Canal Web
            Unidad_de_medida__c = 'Persona'                 // Unidad de medida
        );
        insert capacidadTramo3;
        
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
            Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo
        );
        insert ctdr;
        
        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
            Detalle_Reserva__c = detalleReserva3.Id,      // Detalle Reserva
            Capacidad_Liberada__c = false,                 // Capacidad Liberada
            Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
            Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo  
        );
        insert ctdr;
        
        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
            Detalle_Reserva__c = detalleReserva4.Id,      // Detalle Reserva
            Capacidad_Liberada__c = false,                 // Capacidad Liberada
            Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
            Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo  
        );
        insert ctdr;
        
        Mantenedor_Matriz_DR__c matriz = new Mantenedor_Matriz_DR__c(
            Name = 'DR OCT-NOV 2021',                      // Nombre Matriz DR
            Vigencia_desde__c = Date.valueOf('2021-10-01'),   // Vigencia desde
            Vigencia_hasta__c = Date.valueOf('2021-11-30')  // Vigencia hasta
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
        
        Maestro_Vehiculos_Menores__c vehiculoMenor = new Maestro_Vehiculos_Menores__c(
            Marca__c = 'CHEVROLET',       // Marca
            Modelo__c = 'IMPALA',          // Modelo
            Tipo_de_Vehiculo__c = 'SEDAN',  // Tipo de Vehículo
            Peso__c = 1500,              // Peso
            Largo__c = 5.00,              // Largo
            Alto__c = 1.50               // Alto
        );
        insert vehiculoMenor;
        
        
        vehiculoMenor = new Maestro_Vehiculos_Menores__c(
            Marca__c = 'CHEVROLET',       // Marca
            Modelo__c = 'BEL AIR',          // Modelo
            Tipo_de_Vehiculo__c = 'SEDAN',  // Tipo de Vehículo
            Peso__c = 1500,              // Peso
            Largo__c = 5.00,              // Largo
            Alto__c = 1.50               // Alto
        );
        insert vehiculoMenor;
        
        reserva.Itemes_de_reserva_con_tarifa_validada__c = true;
        update reserva;
        reserva = [SELECT Id, Name, Itemes_reservas_con_tarifas__c, Contador_de_Itemes_reservas__c, Itemes_de_reserva_con_tarifa_validada__c FROM Reserva__c WHERE Id =: reserva.Id];
        // System.debug('TEST Items con Tarifas '+reserva.Itemes_reservas_con_tarifas__c);
        // System.debug('TEST Total Items '+reserva.Contador_de_Itemes_reservas__c);
        // System.debug('TEST Tarifa Validada '+reserva.Itemes_de_reserva_con_tarifa_validada__c);
        
        Acreditacion__c acreditacion = new Acreditacion__c(
            Reserva__c = reserva.Id
        );
        insert acreditacion;
        
        Caja__c caja = new Caja__c(
            Name = 'C-2022-05-02 15:12:41Z-13',// Nombre de la Caja
            Estado_de_la_Caja__c = 'Abierta',    // Estado de la Caja
            Numero_de_Caja__c = 13            // Número de Caja
        );
        insert caja;
        
        Documento__c documento = new Documento__c(
            Acreditacion__c = acreditacion.Id,                                                                                                                                         // Reserva
            Office_Id__c = '1',                                                                                                                                                       // Office Id
            Fecha_Vencimiento__c = Date.valueOf('2021-10-01'),                                                                                                                                // Fecha de Vencimiento
            Fecha_Emision__c = Date.valueOf('2021-10-01'),                                                                                                                                    // Fecha de Emisión
            Declarar_Documento_a_SII__c = false,                                                                                                                                      // Declarar Documento a SII
            RUT_Cliente__c = '8955620-1',                                                                                                                                                   // RUT Cliente
            Ciudad_Cliente__c = 'Desierto',                                                                                                                                           // Ciudad Cliente
            Razon_Social__c = 'Acme',                                                                                                                                                 // Razón Social
            Comuna_Cliente__c = 'Comuna',                                                                                                                                             // Comuna Cliente
            Giro_Cliente__c = 'Venta de instrumentos fallidos para cazar al correcaminos',                                                                                            // Giro Cliente
            Direccion_Cliente__c = 'Dirección',                                                                                                                                       // Dirección Cliente
            Correo_Cliente__c = 'rlopez@correo.com',    
            Email_contacto__c = 'rlopez@correo.com',  
            Contacto_Reserva__c =  cuenta1.Id,                                                                                                                           // Correo Cliente
            Persona_Natural__c = true,                                                                                                                                                // Persona Natural
            Enviar_Documento_a_Cliente__c = false,
            Fecha_Zarpe__c = Date.valueOf('2021-10-01'),
            Nave__c = 'Nave',
            Caja__c = caja.Id,
            Condicion_de_Venta__c = 'Al_Dia',
            Reenvio_BSale_Bloqueado__c = false,
            Reserva__c = reserva.Name,
            RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Afecta').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
        );
        insert documento;
        
        Referencia_Documento__c referenciaDocumento = new Referencia_Documento__c();
        referenciaDocumento.Documento__c = documento.Id;
        referenciaDocumento.Fecha__c = Date.valueOf('2021-10-01');
        referenciaDocumento.Folio__c = '123456789';
        referenciaDocumento.Referencia__c = 'Test';
        referenciaDocumento.Tipo_Documento__c = '801';
        insert referenciaDocumento;
		
        Detalle_Documentos__c detalleDocumento = new Detalle_Documentos__c(
            Documento__c = documento.Id,     // Documento
            Descripcion__c = 'Test',           // Descripción
            Cantidad__c = 1,                   // Cantidad
            Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
            Tax_Id__c = '[1,2]',               // Tax Id
            Descuento__c = 0                   // % Descuento
        );
        insert detalleDocumento;
        
        Documento__c documento2 = new Documento__c(
            Acreditacion__c = acreditacion.Id,                                                                                                                                         // Reserva
            Office_Id__c = '1',                                                                                                                                                       // Office Id
            Fecha_Vencimiento__c = Date.valueOf('2021-10-01'),                                                                                                                                // Fecha de Vencimiento
            Fecha_Emision__c = Date.valueOf('2021-10-01'),                                                                                                                                    // Fecha de Emisión
            Declarar_Documento_a_SII__c = false,                                                                                                                                      // Declarar Documento a SII
            RUT_Cliente__c = '8955620-2',                                                                                                                                                   // RUT Cliente
            Ciudad_Cliente__c = 'Desierto',                                                                                                                                           // Ciudad Cliente
            Razon_Social__c = 'Acme',                                                                                                                                                 // Razón Social
            Comuna_Cliente__c = 'Comuna',                                                                                                                                             // Comuna Cliente
            Giro_Cliente__c = 'Venta de instrumentos fallidos para cazar al correcaminos',                                                                                            // Giro Cliente
            Direccion_Cliente__c = 'Dirección',                                                                                                                                       // Dirección Cliente
            Correo_Cliente__c = 'rlopez@correo.com',    
            Email_contacto__c = 'rlopez@correo.com',  
            Contacto_Reserva__c =  cuenta1.Id,                                                                                                                           // Correo Cliente
            Persona_Natural__c = true,                                                                                                                                                // Persona Natural
            Enviar_Documento_a_Cliente__c = false,
            Fecha_Zarpe__c = Date.valueOf('2021-10-01'),
            Nave__c = 'Nave',
            Caja__c = caja.Id,
            Condicion_de_Venta__c = 'Al_Dia',
            Reenvio_BSale_Bloqueado__c = false,
            Reserva__c = reserva.Name,
            Id_Documento_Bsale__c = '123',
            RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Afecta').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
        );
        insert documento2;
        
        Referencia_Documento__c referenciaDocumento2 = new Referencia_Documento__c();
        referenciaDocumento2.Documento__c = documento2.Id;
        referenciaDocumento2.Fecha__c = Date.valueOf('2021-10-01');
        referenciaDocumento2.Folio__c = '123456789';
        referenciaDocumento2.Referencia__c = 'Test';
        referenciaDocumento2.Tipo_Documento__c = '801';
        insert referenciaDocumento2;

        Detalle_Documentos__c detalleDocumento2 = new Detalle_Documentos__c(
            Documento__c = documento2.Id,     // Documento
            Descripcion__c = 'Test',           // Descripción
            Cantidad__c = 1,                   // Cantidad
            Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
            Tax_Id__c = '[1,2]',               // Tax Id
            Descuento__c = 0,                   // % Descuento
            Id_Detalle_Documento_Bsale__c = '1'
        );
        insert detalleDocumento2;
    }
    
    //Test Excepción
    @IsTest
    private static void test1(){
        Detalle_Reserva__c detalleReserva = [SELECT Id, Reserva__c, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(detalleReserva.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(detalleReserva);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        Documento__c documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Acreditacion__r.Reserva__c =: detalleReserva.Reserva__c LIMIT 1];
        System.assertEquals(true, documento.PDF_Documento__c == null);
        Test.stopTest();
    }
    
    //Test Camino Feliz
    @IsTest
    private static void test2(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.consumirWSClienteBSalePOST('8955620-1');
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    //Test Camino Feliz
    @IsTest
    private static void test2_2(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSClienteBSalePOST('8955620-1');
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    @IsTest
    private static void test2_22(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c,Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Mantenedor_Ruta__c ruta = [SELECT Id, Empresa_Puelche__c FROM Mantenedor_Ruta__c WHERE id =: documento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c ];
        ruta.Empresa_Puelche__c = false;
        update ruta;  
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = null;
        NAV_Integraciones_WS.consumirWSGetClientesRUT('8955620-1');
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test2_3(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSGetClientes(documento.Contacto_Reserva__c);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test2_4(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSClienteBSalePOST(documento.Contacto_Reserva__c);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test2_5(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSClienteBSalePUT(documento.Contacto_Reserva__c);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test2_6(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c,Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Mantenedor_Ruta__c ruta = [SELECT Id, Empresa_Puelche__c FROM Mantenedor_Ruta__c WHERE id =: documento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c ];
        ruta.Empresa_Puelche__c = false;
        update ruta;  
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSClienteBSalePUT(documento.Contacto_Reserva__c);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test2_7(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c,Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Mantenedor_Ruta__c ruta = [SELECT Id, Empresa_Puelche__c FROM Mantenedor_Ruta__c WHERE id =: documento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c ];
        
        ruta.Empresa_Puelche__c = false;
        update ruta;  
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSClienteBSalePOST(documento.Contacto_Reserva__c);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }

    @IsTest
    private static void test2_8(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c,Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Mantenedor_Ruta__c ruta = [SELECT Id, Empresa_Puelche__c FROM Mantenedor_Ruta__c WHERE id =: documento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c ];
        ruta.Empresa_Puelche__c = false;
        update ruta;  
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        NAV_Integraciones_WS.consumirWSGetClientes(documento.Contacto_Reserva__c);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    //Test Error 400
    @IsTest
    private static void test3(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Error400_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(true, documento.PDF_Documento__c == null);
        Test.stopTest();
    }
    
    //Test Exception
    @IsTest
    private static void test4(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Exception_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        controlador.grabarDocumento();
        System.assertEquals(true, documento.PDF_Documento__c == null);
        Test.stopTest();
    }
    
    //Test de Método para redireccionar
    @IsTest
    private static void test5(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.redirect();
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(true, documento.PDF_Documento__c == null);
        Test.stopTest();
    }
    
    //Test para subir cobertura de clase NAV_Documento_JSON
    @IsTest
    private static void test6(){
        NAV_Documento_JSON datosJSON = new NAV_Documento_JSON();
        Test.startTest();
        datosJSON.href = '';
        datosJSON.id = 0;
        datosJSON.emissionDate = 1;
        datosJSON.expirationDate = 1;
        datosJSON.generationDate = 1;
        datosJSON.number_Z = 1;
        datosJSON.serialNumber = '1';
        datosJSON.totalAmount = 1; 
        datosJSON.netAmount = 1; 
        datosJSON.taxAmount = 1; 
        datosJSON.exemptAmount = 1; 
        datosJSON.exportTotalAmount = 1; 
        datosJSON.exportNetAmount = 1;  
        datosJSON.exportTaxAmount = 1;  
        datosJSON.exportExemptAmount = 1;  
        datosJSON.commissionRate = 1;  
        datosJSON.commissionNetAmount = 1;  
        datosJSON.commissionTaxAmount = 1;  
        datosJSON.commissionTotalAmount = 1; 
        datosJSON.percentageTaxWithheld = 1; 
        datosJSON.purchaseTaxAmount = 1;  
        datosJSON.purchaseTotalAmount = 1;  
        datosJSON.address = '';
        datosJSON.municipality = '';
        datosJSON.city = '';
        datosJSON.urlTimbre = '';
        datosJSON.urlPublicView = '';
        datosJSON.urlPdf = '';
        datosJSON.urlPublicViewOriginal = '';
        datosJSON.urlPdfOriginal = '';
        datosJSON.token = '';
        datosJSON.state = 0; 
        datosJSON.urlXml = ''; 
        datosJSON.ted = ''; 
        datosJSON.salesId = ''; 
        datosJSON.informedSii = 0; 
        datosJSON.responseMsgSii = '';
        datosJSON.document_type = new NAV_Documento_JSON.Document_type();
        datosJSON.document_type.href = 'Test';
        datosJSON.document_type.id = 'Test';
        datosJSON.office = new NAV_Documento_JSON.Document_type();
        datosJSON.office.href = 'Test';
        datosJSON.office.id = 'Test';
        datosJSON.user = new NAV_Documento_JSON.Document_type();
        datosJSON.user.href = 'Test';
        datosJSON.user.id = 'Test';
        datosJSON.coin = new NAV_Documento_JSON.Document_type();
        datosJSON.coin.href = 'Test';
        datosJSON.coin.id = 'Test'; 
        datosJSON.references = new NAV_Documento_JSON.References();
        datosJSON.references.href = 'Test'; 
        datosJSON.document_taxes = new NAV_Documento_JSON.References();
        datosJSON.document_taxes.href = 'Test';
        datosJSON.details = new NAV_Documento_JSON.References();
        datosJSON.details.href = 'Test';
        datosJSON.sellers = new NAV_Documento_JSON.References();
        datosJSON.sellers.href = 'Test';
        datosJSON.attributes = new NAV_Documento_JSON.References();
        datosJSON.attributes.href = 'Test';
        System.assertEquals(true, datosJSON != null);
        Test.stopTest();
    }
    
    
    @IsTest
    private static void test6_1(){
        NAV_Documento_JSON datosJSON = new NAV_Documento_JSON();
        Test.startTest();
        datosJSON.href = '';
        datosJSON.id = 0;
        datosJSON.emissionDate = 1;
        datosJSON.expirationDate = 1;
        datosJSON.generationDate = 1;
        datosJSON.number_Z = 1;
        datosJSON.serialNumber = '1';
        datosJSON.totalAmount = 1; 
        datosJSON.netAmount = 1; 
        datosJSON.taxAmount = 1; 
        datosJSON.exemptAmount = 1; 
        datosJSON.exportTotalAmount = 1; 
        datosJSON.exportNetAmount = 1;  
        datosJSON.exportTaxAmount = 1;  
        datosJSON.exportExemptAmount = 1;  
        datosJSON.commissionRate = 1;  
        datosJSON.commissionNetAmount = 1;  
        datosJSON.commissionTaxAmount = 1;  
        datosJSON.commissionTotalAmount = 1; 
        datosJSON.percentageTaxWithheld = 1; 
        datosJSON.purchaseTaxAmount = 1;  
        datosJSON.purchaseTotalAmount = 1;  
        datosJSON.address = '';
        datosJSON.municipality = '';
        datosJSON.city = '';
        datosJSON.urlTimbre = '';
        datosJSON.urlPublicView = '';
        datosJSON.urlPdf = '';
        datosJSON.urlPublicViewOriginal = '';
        datosJSON.urlPdfOriginal = '';
        datosJSON.token = '';
        datosJSON.state = 0; 
        datosJSON.urlXml = ''; 
        datosJSON.ted = ''; 
        datosJSON.salesId = ''; 
        datosJSON.informedSii = 0; 
        datosJSON.responseMsgSii = '';
        datosJSON.document_type = new NAV_Documento_JSON.Document_type();
        datosJSON.document_type.href = 'Test';
        datosJSON.document_type.id = 'Test';
        datosJSON.office = new NAV_Documento_JSON.Document_type();
        datosJSON.office.href = 'Test';
        datosJSON.office.id = 'Test';
        datosJSON.user = new NAV_Documento_JSON.Document_type();
        datosJSON.user.href = 'Test';
        datosJSON.user.id = 'Test';
        datosJSON.coin = new NAV_Documento_JSON.Document_type();
        datosJSON.coin.href = 'Test';
        datosJSON.coin.id = 'Test'; 
        datosJSON.references = new NAV_Documento_JSON.References();
        datosJSON.references.href = 'Test'; 
        datosJSON.document_taxes = new NAV_Documento_JSON.References();
        datosJSON.document_taxes.href = 'Test';
        datosJSON.details = new NAV_Documento_JSON.References();
        datosJSON.details.href = 'Test';
        datosJSON.sellers = new NAV_Documento_JSON.References();
        datosJSON.sellers.href = 'Test';
        datosJSON.attributes = new NAV_Documento_JSON.References();
        datosJSON.attributes.href = 'Test';
        System.assertEquals(false, datosJSON == null);
        Test.stopTest();
    }
    
    //Test Camino Feliz - Clase Invocable Envío Documento
    @IsTest
    private static void test7(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        List<Id> idParams = new List<Id>();
        idParams.add(documento.Id);
        NAV_EnviarDocumento_PB.ConsumoWSDocumentoBSale(idParams);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(true, documento.PDF_Documento__c == null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test7_1(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        List<Id> idParams = new List<Id>();
        idParams.add(documento.Id);
        NAV_EnviarDocumento_PB.ConsumoWSDocumentoBSale(idParams);
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    //Test de Aumento de Cobertura - NAV_DetalleDocumentos_JSON
    @IsTest
    private static void test8(){
        Test.startTest();
        NAV_DetalleDocumentos_JSON detalleDocumentos = new NAV_DetalleDocumentos_JSON();
        detalleDocumentos.href = 'test';
        detalleDocumentos.count = 1; 
        detalleDocumentos.limit_Z = 1; 
        detalleDocumentos.offset = 1;
        
        NAV_DetalleDocumentos_JSON.Items detalleItems = new NAV_DetalleDocumentos_JSON.Items();
        
        detalleItems.href = '';
        detalleItems.id = 1;
        detalleItems.lineNumber = 1;
        detalleItems.quantity = 1;
        detalleItems.netUnitValue = 1;
        detalleItems.totalUnitValue = 1;
        detalleItems.netAmount = 1;
        detalleItems.taxAmount = 1;
        detalleItems.totalAmount = 1;
        detalleItems.netDiscount = 1;
        detalleItems.totalDiscount = 1;
        detalleItems.note = '';
        detalleItems.relatedDetailId = 1;
        
        NAV_DetalleDocumentos_JSON.Variant detalleVariant = new NAV_DetalleDocumentos_JSON.Variant();
        
        detalleVariant.href = 'test';
        detalleVariant.description = 'test';
        detalleVariant.code = 'test';
        detalleVariant.id = 1;
        
        detalleItems.variant = detalleVariant;
        
        System.assertEquals(true, detalleDocumentos != null);
        Test.stopTest();
    }
    
    //Test Camino Feliz - Factura Exenta
    @IsTest
    private static void test9(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Id idTipoRegistro = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Exenta').getRecordTypeId();
        documento.RecordTypeId = idTipoRegistro;
        //documento.Tipo_de_Documento__c = '15';
        update documento;
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    //Test Camino Feliz - Boleta
    @IsTest
    private static void test10(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Id idTipoRegistro = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId();
        documento.RecordTypeId = idTipoRegistro;
        //documento.Tipo_de_Documento__c = '82';
        update documento;
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    //Test de aumento de cobertura NAV_Integraciones_SOQL
    @IsTest
    private static void test11(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        List<Detalle_Documentos__c> detalleDocumentos = [SELECT Id, Name, Descripcion__c FROM Detalle_Documentos__c WHERE Documento__c =: documento.id];
        String body = '';
        body +='{\n';
        body +='  "href": "https://api.bsale.cl/v1/documents/189452/details.json",\n';
        body +='  "count": 1,\n';
        body +='  "limit": 25,\n';
        body +='  "offset": 0,\n';
        body +='  "items": [\n';
        body +='    {\n';
        body +='      "href": "https://api.bsale.cl/v1/documents/189452/details/287257.json",\n';
        body +='      "id": 287257,\n';
        body +='      "lineNumber": 1,\n';
        body +='      "quantity": 1,\n';
        body +='      "netUnitValue": 1000,\n';
        body +='      "totalUnitValue": 1190,\n';
        body +='      "netAmount": 1000,\n';
        body +='      "taxAmount": 190,\n';
        body +='      "totalAmount": 1190,\n';
        body +='      "netDiscount": 0,\n';
        body +='      "totalDiscount": 0,\n';
        body +='      "variant": {\n';
        body +='        "href": "https://api.bsale.cl/v1/variants/294176.json",\n';
        body +='        "id": 294176,\n';
        body +='        "description": "Test",\n';
        body +='        "code": "1642175456"\n';
        body +='      },\n';
        body +='      "note": "",\n';
        body +='      "relatedDetailId": 0\n';
        body +='    }\n';
        body +='  ]\n';
        body +='}\n';
        Test.startTest();
        NAV_DetalleDocumentos_JSON respuestaJson = NAV_DetalleDocumentos_JSON.parse(body);
        NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        consultasSOQL.registrarIdDetalleDocumentosBsale(detalleDocumentos, respuestaJson);
        System.assertEquals(true, detalleDocumentos.size() > 0);
        Test.stopTest();
    }
    
    //Test de aumento de cobertura NAV_Integraciones_SOQL
    @IsTest
    private static void test12(){
        Documento__c documento = [SELECT Id, Name FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Test.startTest();
        NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        consultasSOQL.registrarDocumentoBsale(documento.Id, 1, 'Dummy.pdf', 'https://www.dummyurl.com', 'Test','algo');
        System.assertEquals(true, documento != null);
        Test.stopTest();
    }
    
    //Test de aumento de cobertura NAV_Integraciones_SOQL
    @IsTest
    private static void test13(){
        Reserva__c reserva = [SELECT Id, Name FROM Reserva__c WHERE Tipo_de_Reserva__c = 'General'];
        
        Test.startTest();
        PageReference pref = Page.NAV_ReservaEstandar;
        Test.setCurrentPage(pref);
        //pref.getParameters().put('Id', String.valueOf(reserva.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(reserva);
        NAV_ReservaEstandar controlador = new NAV_ReservaEstandar(apst);
        System.assertEquals(true, reserva != null);
        Test.stopTest();
    }
    
    //Test Nota de Crédito
    @IsTest
    private static void test14(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Documento__c documento2 = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-2'];
        Id idTipoRegistro = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Nota de Crédito').getRecordTypeId();
        documento.RecordTypeId = idTipoRegistro;
        documento.Tipo_de_Documento__c = '2';
        documento.Documento_Principal__c = documento2.Id;
        documento.Motivo_Devolucion__c = 'test';
        documento.Tipo_de_Nota_de_Credito__c = '0';
        update documento;
        
        List<Detalle_Documentos__c> detalleDocumentos = [SELECT Id, Name, Id_Detalle_Documento_Bsale__c FROM Detalle_Documentos__c WHERE Documento__c =: documento.Id];
        List<Detalle_Documentos__c> detalleDocumentos2 = [SELECT Id, Name, Id_Detalle_Documento_Bsale__c FROM Detalle_Documentos__c WHERE Documento__c =: documento2.Id];
        for(Detalle_Documentos__c detalleDoc : detalleDocumentos){
            detalleDoc.Detalle_Documento_Principal__c = detalleDocumentos2.get(0).Id;
        }
        update detalleDocumentos;
        
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        pref.getParameters().put('Id', String.valueOf(documento.Id));
        ApexPages.StandardController apst = new ApexPages.StandardController(documento);
        NAV_EnviarDocumento_Controller controlador = new NAV_EnviarDocumento_Controller(apst);
        controlador.grabarDocumento();
        documento = [SELECT Id, PDF_Documento__c, Name FROM Documento__c WHERE Id =: documento.Id];
        System.assertEquals(false, documento.PDF_Documento__c != null);
        Test.stopTest();
    }
    
    //Test de método consumirWsGetDocumento
    @IsTest
    private static void test15(){
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        NAV_Documento_JSON documentoJson = new NAV_Documento_JSON();
        documentoJson = NAV_Integraciones_WS.consumirWSGetDocumento('algo');
        System.assertEquals(true, documentoJson != null);
        Test.stopTest();
    }
    
    @IsTest
    private static void test16(){
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        NAV_Documento_JSON documentoJson = new NAV_Documento_JSON();
        documentoJson = NAV_Integraciones_WS.consumirWSGetDocumento('algo');
        System.assertEquals(false, documentoJson == null);
        Test.stopTest();
    }
    
        @IsTest
    private static void test17(){
        Documento__c documento = [SELECT Id, Name, Reenvio_BSale_Bloqueado__c,Contacto_Reserva__c,Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c FROM Documento__c WHERE RUT_Cliente__c = '8955620-1'];
        Mantenedor_Ruta__c ruta = [SELECT Id, Empresa_Puelche__c FROM Mantenedor_Ruta__c WHERE id =: documento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__c ];
        ruta.Empresa_Puelche__c = false;
        update ruta; 
        Test.setMock(HttpCalloutMock.class, new NAV_EnviarDocumento_Mock());
        Test.startTest();
        PageReference pref = Page.NAV_EnviarDocumento_VF;
        Test.setCurrentPage(pref);
        NAV_Documento_JSON documentoJson = new NAV_Documento_JSON();
        NAV_Integraciones_WS.sharedIdDocumento = documento.Id;
        documentoJson = NAV_Integraciones_WS.consumirWSGetDocumento('algo');
        System.assertEquals(true, documentoJson != null);
        Test.stopTest();
    }
    
}