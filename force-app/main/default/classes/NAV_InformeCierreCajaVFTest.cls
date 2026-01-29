/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EF)
Proyecto: Naviera Austral
Descripción: Clase Test para cubrir el informe y envío del Cierre de Caja
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     09-01-2023   EF       Creación de la Clase.
***********************************************************************************/

@isTest 
private class NAV_InformeCierreCajaVFTest {
	@isTest
	static void testCaja()
    {
        Test.startTest();
        User u = crearUsuario();
        System.runAs(u)
        {
            Puerto__c puerto1 = new Puerto__c(
                Name = 'DUMMY MONTT', // Nombre de Puerto
                Muelle_SAP__c = 'PMONTT'
            );
            insert puerto1;

            Puerto__c puerto2 = new Puerto__c(
                Name = 'DUMMY CHAITÉN', // Nombre de Puerto
                Muelle_SAP__c = 'PMONTT'
            );
            insert puerto2;

            Puerto__c puerto3 = new Puerto__c(
                Name = '--', // Nombre de Puerto
                Muelle_SAP__c = 'PMONTT'
            );
            insert puerto3;

            Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
                Name = 'DUMMY CHAITÉN SUR',                            // Nombre de Mantenedor Rutas
                Origen_Destino__c = 'DUMMY MONTT -> DUMMY CHAITÉN',  // Zarpe Origen -> Recalada Final
                Sigla_Ruta__c = 'PMCN',                            // Sigla Ruta
                Ruta_SAP__c = 'RUT'
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
              Puerto__c = puerto1.Id,						  // Puerto
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
              Puerto__c = puerto1.Id,						  // Puerto
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
              Puerto__c = puerto2.Id,						  // Puerto
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
              Puerto__c = puerto2.Id,						  // Puerto
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
              Razon_Social__c = 'cuejk',
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
              Razon_Social__c = 'cuejk2',
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
              Razon_Social__c = 'cuejk3',
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
              Carga_Maxima_Vehiculos__c = 550,   // Carga Máxima Vehículos
              CEBE__c = 'GASS'
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
                Nave__c = nave.Id,          	  // Nave
                Categoria__c = 'General',         // Categoría
                Numero__c = '03',                 // Número
                Ubicacion__c = 'Salón',           // Ubicación
                Capacidad__c = 1,             	  // Capacidad
                Cupo_Venta_Local__c = false,      // Cupo Venta Local
                Unidad_de_medida__c = 'Persona',  // Unidad de medida
                RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
            );
            insert capacidadNave;
    
            capacidadNave = new Capacidad_Nave__c(
                Nave__c = nave.Id,         		 // Nave
                Ubicacion__c = 'Bajo cubierta',  // Ubicación
                Capacidad__c = 5,            // Capacidad
                Cupo_Venta_Local__c = false,     // Cupo Venta Local
                Unidad_de_medida__c = 'Pallet',  // Unidad de medida
                RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()
            );
            insert capacidadNave;
    
            capacidadNave = new Capacidad_Nave__c(
                Nave__c = nave.Id,         		 // Nave
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
              Nombre_Ruta__c = mantenedorRuta.Id,				                       // Nombre Ruta
              Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
              Tipo__c = 'SUBV',                                            // Tipo
              Nombre_de_la_Nave__c = nave.Id,		                       // Nombre de la Nave
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
              UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4'
            );
            insert reserva;
    
            Detalle_Reserva__c detalleReserva1 = new Detalle_Reserva__c(
              RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
              Reserva__c = reserva.Id,						 // Reserva
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
              Reserva__c = reserva.Id,						 // Reserva
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
              Reserva__c = reserva.Id,						 // Reserva
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
              Reserva__c = reserva.Id,						 // Reserva
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
              Valor__c = 12770,									      // Valor
              Contrato_Tarifa__c = tarifa.Id,				          // Contrato Tarifa
              Tipo_Transporte__c = 'Pasajero',                        // Tipo Transporte
              Ruta_Subsidiada__c = true,                              // Ruta Subsidiada
              Especificacion__c = 'General',                          // Especificación
              Ruta_Comercial__c = false,                              // Ruta Comercial
              Nacional__c = true,                                     // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	                      // Puerto ORIGEN
              Extranjero__c = true,                                   // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		                  // Puerto DESTINO
              Residente__c = true,                                    // Residente
              Discapacidad__c = false,                                // Discapacidad
              Estudiante__c = false,                                  // Estudiante
              Conductor__c = false,                                   // Conductor
              Impuesto__c = 'Valor Exento',                           // Impuesto
              Transportista__c = false,                               // Transportista
              Porcentaje_Impuesto__c = 0,                             // Porcentaje Impuesto
              Edad_desde__c = 0,	                                  // Edad desde
              Oferta__c = 10000,		                              // Oferta
              Edad_hasta__c = 59,	                                  // Edad hasta
              Vigencia_Oferta_desde__c = Date.valueOf('2021-10-10'),  // Vigencia Oferta desde
              Vigencia_Oferta_hasta__c = Date.valueOf('2021-10-11')   // Vigencia Oferta hasta
            );
            insert parametroTarifa;
    
            parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
              Valor__c = 17820,		                   // Valor
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Pasajero',         // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'General',           // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'Vehículo Menor',    // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'Metro Lineal',      // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Carga',            // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'Pallets',           // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
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
              Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
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
              Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
              Ubicacion__c = 'Cubierta',       				     // Ubicación
              Numero__c = '01',                           		 // Número
              Cupo_Venta_Local__c = false,               		 // Cupo Venta Local
              Capacidad__c = 100,                          		 // Capacidad
              Canal_Web__c = true,                       		 // Canal Web
              Unidad_de_medida__c = 'Persona'            		 // Unidad de medida
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
            reserva.Contacto_Reserva__c = cuenta1.id;
            update reserva;
            reserva = [SELECT Id, Itemes_reservas_con_tarifas__c, Contador_de_Itemes_reservas__c, Itemes_de_reserva_con_tarifa_validada__c FROM Reserva__c WHERE Id =: reserva.Id];
    
            Acreditacion__c acreditacion = new Acreditacion__c(
                Reserva__c = reserva.Id,
                DatosConfirmados__c = true,
                Destinatario_Documentos__c = cuenta1.Id
            );
            insert acreditacion;

			Decimal porAcreditar = [SELECT Por_acreditar__c FROM Acreditacion__c WHERE Id =: acreditacion.Id].Por_acreditar__c;
        	
            //Al momento de crear esta caja, por detras corre un FLOW (Crear Caja Acreditación), que crea otra caja con otro ID
            Caja__c caja = new Caja__c(
                Name = 'C-2100-11-08 15:54:41Z-13',// Nombre de la Caja
                Estado_de_la_Caja__c = 'Abierta',    // Estado de la Caja
                Numero_de_Caja__c = 13            // Número de Caja
            );
            insert caja;
            
            //para este test, se tomara el ID de la caja que creo el FLOW
            Caja__c cajavar = [select id from Caja__c where Name <> 'C-2100-11-08 15:54:41Z-13'];
            
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
              Correo_Cliente__c = 'rlopez@nectia.com',                                                                                                                                  // Correo Cliente
              Persona_Natural__c = true,                                                                                                                                                // Persona Natural
              Enviar_Documento_a_Cliente__c = false,
              Fecha_Zarpe__c = Date.valueOf('2021-10-01'),
              Nave__c = 'Nave',
              Folio_referencia__c = '123456789',
              Fecha_Documento_Referencia__c = Date.valueOf('2021-10-01'),
              Referencia__c = 'Test',
              Caja__c = cajavar.Id,
              Condicion_de_Venta__c = 'Al_Dia',
              RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
            );
            insert documento;
            
            Documento__c documento2 = new Documento__c(
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
              Correo_Cliente__c = 'rlopez@nectia.com',                                                                                                                                  // Correo Cliente
              Persona_Natural__c = true,                                                                                                                                                // Persona Natural
              Enviar_Documento_a_Cliente__c = false,
              Fecha_Zarpe__c = Date.valueOf('2021-10-01'),
              Nave__c = 'Nave',
              Folio_referencia__c = '123456789',
              Fecha_Documento_Referencia__c = Date.valueOf('2021-10-01'),
              Referencia__c = 'Test',
              Caja__c = cajavar.Id,
              Condicion_de_Venta__c = 'Al_Dia',
              RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Afecta').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
            );
            insert documento2;
            
            Detalle_Documentos__c detalleDocumento2 = new Detalle_Documentos__c(
              Documento__c = documento2.Id,		 // Documento
              Descripcion__c = 'Test',           // Descripción
              Cantidad__c = 1,                   // Cantidad
              Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
              Tax_Id__c = '[1,2]',               // Tax Id
              Descuento__c = 0                   // % Descuento
            );
            insert detalleDocumento2;
    
            Detalle_Documentos__c detalleDocumento = new Detalle_Documentos__c(
              Documento__c = documento.Id,		 // Documento
              Descripcion__c = 'Test',           // Descripción
              Cantidad__c = 1,                   // Cantidad
              Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
              Tax_Id__c = '[1,2]',               // Tax Id
              Descuento__c = 0                   // % Descuento
            );
            insert detalleDocumento;
            
            Forma_de_Pago__c formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Efectivo').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Efectivo';
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Cheque al día').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Cheque';
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Tarjeta crédito').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Tarjeta crédito';
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Transferencia bancaria').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Transferencia';
            insert formaPago;
            
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Depósito cheque').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Cheque';
            insert formaPago;
                    
            caja.TotalDocVtaValidamenteEmitidos__c = 1;
            caja.Estado_de_la_Caja__c = 'Cerrada';
           // caja.DocumentosPendientesBsale__c =0;
            caja.Observacion_Caja__c = 'Prueba caja.';
            update caja;
            system.debug('CD caja '+ caja);
            List<Id> cajaIds = new List<Id>();
            cajaIds.add(cajavar.id);
        
            Pagereference pagina = new PageReference('/apex/NAV_InformeCierreCajaPDF');
            pagina.getParameters().put('id',cajavar.id);
            
            Test.setCurrentPage(pagina);
            
            ApexPages.StandardController standardController = new ApexPages.StandardController(cajavar);
            NAV_InformeCierreCajaVFController controller = new NAV_InformeCierreCajaVFController(standardController);
            
            NAV_InformeCierreCajaVFController.enviarInformeCaja(cajaIds);
            
            } //fin run as

        Test.stopTest();
    }
    public static User crearUsuario(){
           
        Profile p = [SELECT Id, Name FROM Profile WHERE Name in ('Administrador del sistema', 'System Administrator')];//Administrador del sistema
        User sobj = new User(
          FirstName = 'Samuel Bravo',                                                                                    // Nombre
          Alias = 'sbrav',                                                                                                 // Alias
          Email = 'sbravo@nectia.com',                                                                                     // Email
          Username = 'sbravo@nectia.com.sbx2029',                                                                          // Nombre de usuario
          IsActive = true,                                                                                                 // Activo
          CommunityNickname = 'Usuar3444343',  // Apodo
          UserPermissionsMarketingUser = false,                                                                            // Usuario de marketing
          UserPermissionsOfflineUser = false,                                                                              // Usuario de Offline
          UserPermissionsInteractionUser = false,                                                                          // Usuario de Flow                                                     
          ForecastEnabled = false,                                                                                         // Permitir realización de pronósticos
          MobilePhone = '5692261111',                                                                                       // Móvil
          profileId = p.Id,
          EmailEncodingKey='UTF-8', 
            LastName='Testing', 
            LanguageLocaleKey='en_US', 
          LocaleSidKey='en_US', 
          TimeZoneSidKey='America/New_York'
        );
        insert sobj;
        return sobj;
    }
    
    	@isTest
	static void testCajaPuelche()
    {
        Test.startTest();
        User u = crearUsuario();
        System.runAs(u)
        {
            Puerto__c puerto1 = new Puerto__c(
                Name = 'DUMMY MONTT', // Nombre de Puerto
                Muelle_SAP__c = 'PMONTT'
            );
            insert puerto1;

            Puerto__c puerto2 = new Puerto__c(
                Name = 'DUMMY CHAITÉN', // Nombre de Puerto
                Muelle_SAP__c = 'PMONTT'
            );
            insert puerto2;

            Puerto__c puerto3 = new Puerto__c(
                Name = '--', // Nombre de Puerto
                Muelle_SAP__c = 'PMONTT'
            );
            insert puerto3;

            Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
                Name = 'DUMMY CHAITÉN SUR',                            // Nombre de Mantenedor Rutas
                Origen_Destino__c = 'DUMMY MONTT -> DUMMY CHAITÉN',  // Zarpe Origen -> Recalada Final
                Sigla_Ruta__c = 'PMCN',                            // Sigla Ruta
                Ruta_SAP__c = 'RUT',
                Empresa_Puelche__c = true
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
              Puerto__c = puerto1.Id,						  // Puerto
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
              Puerto__c = puerto1.Id,						  // Puerto
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
              Puerto__c = puerto2.Id,						  // Puerto
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
              Puerto__c = puerto2.Id,						  // Puerto
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
              Razon_Social__c = 'cuejk',
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
              Razon_Social__c = 'cuejk2',
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
              Razon_Social__c = 'cuejk3',
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
              Carga_Maxima_Vehiculos__c = 550,   // Carga Máxima Vehículos
              CEBE__c = 'GASS'
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
                Nave__c = nave.Id,          	  // Nave
                Categoria__c = 'General',         // Categoría
                Numero__c = '03',                 // Número
                Ubicacion__c = 'Salón',           // Ubicación
                Capacidad__c = 1,             	  // Capacidad
                Cupo_Venta_Local__c = false,      // Cupo Venta Local
                Unidad_de_medida__c = 'Persona',  // Unidad de medida
                RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
            );
            insert capacidadNave;
    
            capacidadNave = new Capacidad_Nave__c(
                Nave__c = nave.Id,         		 // Nave
                Ubicacion__c = 'Bajo cubierta',  // Ubicación
                Capacidad__c = 5,            // Capacidad
                Cupo_Venta_Local__c = false,     // Cupo Venta Local
                Unidad_de_medida__c = 'Pallet',  // Unidad de medida
                RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()
            );
            insert capacidadNave;
    
            capacidadNave = new Capacidad_Nave__c(
                Nave__c = nave.Id,         		 // Nave
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
              Nombre_Ruta__c = mantenedorRuta.Id,				                       // Nombre Ruta
              Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
              Tipo__c = 'SUBV',                                            // Tipo
              Nombre_de_la_Nave__c = nave.Id,		                       // Nombre de la Nave
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
              UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4'
              
            );
            insert reserva;
   
            Detalle_Reserva__c detalleReserva1 = new Detalle_Reserva__c(
              RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
              Reserva__c = reserva.Id,						 // Reserva
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
              Reserva__c = reserva.Id,						 // Reserva
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
              Reserva__c = reserva.Id,						 // Reserva
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
              Reserva__c = reserva.Id,						 // Reserva
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
              Valor__c = 12770,									      // Valor
              Contrato_Tarifa__c = tarifa.Id,				          // Contrato Tarifa
              Tipo_Transporte__c = 'Pasajero',                        // Tipo Transporte
              Ruta_Subsidiada__c = true,                              // Ruta Subsidiada
              Especificacion__c = 'General',                          // Especificación
              Ruta_Comercial__c = false,                              // Ruta Comercial
              Nacional__c = true,                                     // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	                      // Puerto ORIGEN
              Extranjero__c = true,                                   // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		                  // Puerto DESTINO
              Residente__c = true,                                    // Residente
              Discapacidad__c = false,                                // Discapacidad
              Estudiante__c = false,                                  // Estudiante
              Conductor__c = false,                                   // Conductor
              Impuesto__c = 'Valor Exento',                           // Impuesto
              Transportista__c = false,                               // Transportista
              Porcentaje_Impuesto__c = 0,                             // Porcentaje Impuesto
              Edad_desde__c = 0,	                                  // Edad desde
              Oferta__c = 10000,		                              // Oferta
              Edad_hasta__c = 59,	                                  // Edad hasta
              Vigencia_Oferta_desde__c = Date.valueOf('2021-10-10'),  // Vigencia Oferta desde
              Vigencia_Oferta_hasta__c = Date.valueOf('2021-10-11')   // Vigencia Oferta hasta
            );
            insert parametroTarifa;
    
            parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
              Valor__c = 17820,		                   // Valor
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Pasajero',         // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'General',           // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'Vehículo Menor',    // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'Metro Lineal',      // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
              Tipo_Transporte__c = 'Carga',            // Tipo Transporte
              Ruta_Subsidiada__c = true,               // Ruta Subsidiada
              Especificacion__c = 'Pallets',           // Especificación
              Ruta_Comercial__c = false,               // Ruta Comercial
              Nacional__c = true,                      // Nacional
              Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
              Extranjero__c = true,                    // Extranjero
              Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
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
              Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
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
              Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
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
              Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
              Ubicacion__c = 'Cubierta',       				     // Ubicación
              Numero__c = '01',                           		 // Número
              Cupo_Venta_Local__c = false,               		 // Cupo Venta Local
              Capacidad__c = 100,                          		 // Capacidad
              Canal_Web__c = true,                       		 // Canal Web
              Unidad_de_medida__c = 'Persona'            		 // Unidad de medida
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
            reserva.Contacto_Reserva__c = cuenta1.id;
            update reserva;
            reserva = [SELECT Id, Itemes_reservas_con_tarifas__c, Contador_de_Itemes_reservas__c, Itemes_de_reserva_con_tarifa_validada__c FROM Reserva__c WHERE Id =: reserva.Id];
    
            Acreditacion__c acreditacion = new Acreditacion__c(
                Reserva__c = reserva.Id,
                DatosConfirmados__c = true,
                Destinatario_Documentos__c = cuenta1.Id
            );
            insert acreditacion;

			Decimal porAcreditar = [SELECT Por_acreditar__c FROM Acreditacion__c WHERE Id =: acreditacion.Id].Por_acreditar__c;
        	
            //Al momento de crear esta caja, por detras corre un FLOW (Crear Caja Acreditación), que crea otra caja con otro ID
            Caja__c caja = new Caja__c(
                Name = 'C-2100-11-08 15:54:41Z-13',// Nombre de la Caja
                Estado_de_la_Caja__c = 'Abierta',    // Estado de la Caja
                Numero_de_Caja__c = 13            // Número de Caja
            );
            insert caja;
            
            //para este test, se tomara el ID de la caja que creo el FLOW
            Caja__c cajavar = [select id from Caja__c where Name <> 'C-2100-11-08 15:54:41Z-13'];
            
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
              Correo_Cliente__c = 'rlopez@nectia.com',                                                                                                                                  // Correo Cliente
              Persona_Natural__c = true,                                                                                                                                                // Persona Natural
              Enviar_Documento_a_Cliente__c = false,
              Fecha_Zarpe__c = Date.valueOf('2021-10-01'),
              Nave__c = 'Nave',
              Folio_referencia__c = '123456789',
              Fecha_Documento_Referencia__c = Date.valueOf('2021-10-01'),
              Referencia__c = 'Test',
              Caja__c = cajavar.Id,
              Condicion_de_Venta__c = 'Al_Dia',
              RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId() ,
               Empresa_Puelche__c = true// Enviar Documento a Cliente
            );
            insert documento;
            
            Documento__c documento2 = new Documento__c(
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
              Correo_Cliente__c = 'rlopez@nectia.com',                                                                                                                                  // Correo Cliente
              Persona_Natural__c = true,                                                                                                                                                // Persona Natural
              Enviar_Documento_a_Cliente__c = false,
              Fecha_Zarpe__c = Date.valueOf('2021-10-01'),
              Nave__c = 'Nave',
              Folio_referencia__c = '123456789',
              Fecha_Documento_Referencia__c = Date.valueOf('2021-10-01'),
              Referencia__c = 'Test',
              Caja__c = cajavar.Id,
              Condicion_de_Venta__c = 'Al_Dia',
              RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Exenta').getRecordTypeId(),     
              Empresa_Puelche__c = true// Enviar Documento a Cliente
            );
            insert documento2;
            
            Detalle_Documentos__c detalleDocumento2 = new Detalle_Documentos__c(
              Documento__c = documento2.Id,		 // Documento
              Descripcion__c = 'Test',           // Descripción
              Cantidad__c = 1,                   // Cantidad
              Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
              Tax_Id__c = '[1,2]',               // Tax Id
              Descuento__c = 0                   // % Descuento
            );
            insert detalleDocumento2;
    
            Detalle_Documentos__c detalleDocumento = new Detalle_Documentos__c(
              Documento__c = documento.Id,		 // Documento
              Descripcion__c = 'Test',           // Descripción
              Cantidad__c = 1,                   // Cantidad
              Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
              Tax_Id__c = '[1,2]',               // Tax Id
              Descuento__c = 0                   // % Descuento
            );
            insert detalleDocumento;
            
            Forma_de_Pago__c formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Efectivo').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Efectivo';
                //formaPago.Empresa_Puelche__c = true;
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Cheque al día').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Cheque';
                //formaPago.Empresa_Puelche__c = true;
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Tarjeta crédito').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Tarjeta crédito';
                //formaPago.Empresa_Puelche__c = true;
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Depósito cheque').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Cheque';
            insert formaPago;
            
            formaPago = new Forma_de_Pago__c();
                formaPago.Acreditacion__c = acreditacion.Id;
                formaPago.Caja__c = cajavar.Id;
                formaPago.Monto__c = porAcreditar / 6;
                formaPago.RecordTypeId = Schema.SObjectType.Forma_de_Pago__c.getRecordTypeInfosByName().get('Transferencia bancaria').getRecordTypeId();
                formaPago.Tipo_de_pago__c = 'Transferencia';
                //formaPago.Empresa_Puelche__c = true;
            insert formaPago;
                    
            caja.TotalDocVtaValidamenteEmitidos__c = 1;
            caja.Estado_de_la_Caja__c = 'Cerrada';
           // caja.DocumentosPendientesBsale__c =0;
            caja.Observacion_Caja__c = 'Prueba caja.';
            update caja;
            system.debug('CD caja '+ caja);
            List<Id> cajaIds = new List<Id>();
            cajaIds.add(cajavar.id);
        
            Pagereference pagina = new PageReference('/apex/NAV_InformeCierreCajaPDF');
            pagina.getParameters().put('id',cajavar.id);
            
            Test.setCurrentPage(pagina);
            
            ApexPages.StandardController standardController = new ApexPages.StandardController(cajavar);
            NAV_InformeCierreCajaVFController controller = new NAV_InformeCierreCajaVFController(standardController);
            
            NAV_InformeCierreCajaVFController.enviarInformeCaja(cajaIds);
            //NAV_InformeCierreCajaVFController.enviarCorreo(cajavar.id);
            } //fin run as

        Test.stopTest();
    }
       
    
}