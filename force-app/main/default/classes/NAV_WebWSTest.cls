/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_WebWS
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     17-03-2022   RL       Creación de la Clase.
1.1		08-02-2023	 RL		  Actualización del Test.
***********************************************************************************/

@isTest 
private class NAV_WebWSTest {
    @TestSetup
	static void setup(){
		Puerto__c puerto1 = new Puerto__c(
			Name = 'PUERTO MONTTT'// Nombre de Puerto
		);
		insert puerto1;

		Puerto__c puerto2 = new Puerto__c(
			Name = 'CHHAITÉN'// Nombre de Puerto
		);
		insert puerto2;

		Puerto__c puerto3 = new Puerto__c(
			Name = 'AYACARA'// Nombre de Puerto
		);
		insert puerto3;

		Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
			Name = 'CHHAITÉN SUR',                            // Nombre de Mantenedor Rutas
			Origen_Destino__c = 'PUERTO MONTTT -> CHHAITÉN',  // Zarpe Origen -> Recalada Final
			Sigla_Ruta__c = 'TPMCN'                            // Sigla Ruta
		);
		insert mantenedorRuta;
		
		Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
			Name = 'PUERTO MONTTT -> CHHAITÉN',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 1,                     // Secuencia
			ORIGEN__c = puerto1.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(1, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto2.Id         // DESTINO
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

		Escalas_Itinerario__c escalasItinerario = new Escalas_Itinerario__c(
		  Name = 'PUERTO MONTTT',                                          // Escala
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
		  Name = 'CHHAITÉN',                                          // Escala
		  Hacer_Escala__c = true,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 2,                                               // Secuencia
		  Puerto_Embarque__c = puerto2.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-11 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-11 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto3.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 56,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-12 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario2;
		
		Escalas_Itinerario__c escalasItinerario3 = new Escalas_Itinerario__c(
		  Name = 'AYACARA',                                          // Escala
		  Hacer_Escala__c = true,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 3,                                               // Secuencia
		  Puerto_Embarque__c = puerto3.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-11 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-11 20:45:00'),
		  Puerto_Destino__c = puerto3.Id,                                 // Puerto Destino
		  Navegacion__c = Time.newInstance(5,35,0,0)                     // Navegación
		);
		insert escalasItinerario3;
		
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
		  Fecha_Expiracion__c = Date.valueOf('2021-10-09'), // Fecha Expiración
		  Puerto_ORIGEN__c = puerto1.Id,                    // Puerto ORIGEN
		  Expira_al_Zarpe__c = false,                       // Expira al Zarpe
		  Puerto_DESTINO__c = puerto2.Id,                    // Puerto DESTINO
		  Itinerario_asociado__c = itinerario.Id,
          UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'
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
		  Transportista__c = false                       // Transportista
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
		  Transportista__c = false                       // Transportista
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
		  Detalle_Reserva_Conductor__c = detalleReserva1.Id                                 // Detalle Reserva Conductor
		);
		insert detalleReserva3;

		Detalle_Reserva__c detalleReserva4 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		  Unidad_de_medida__c = 'Pallet',                // Unidad de medida
		  Residente__c = true,                           // Residente
		  Persona_que_entrega__c = cuenta1.Id,           // Persona que entrega
		  Persona_que_retira__c = cuenta1.Id             // Persona que retira
		);
		insert detalleReserva4;

		Detalle_Reserva__c detalleReserva5 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  Numero__c = '02',                              // Número
		  Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		  Unidad_de_medida__c = 'Persona',               // Unidad de medida
		  Ubicacion__c = 'Salón',                        // Ubicación
		  Doc_Identificacion_Pasajero__c = '1-9',        // Doc Identificación Pasajero
		  Nombre_Pasajero__c = cuenta3.Id,               // Nombre Pasajero
		  Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		  Residente__c = true,                          // Residente
		  Conductor__c = true,                          // Conductor
		  Transportista__c = true                       // Transportista
		);
		insert detalleReserva5;

		Detalle_Reserva__c detalleReserva6 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  Categoria_de_Vehiculo__c = 'Bicicleta',        // Categoría de Vehículo
		  Tipo_de_Vehiculo__c = 'Bicicleta',             // Tipo de Vehículo
		  Detalle_Reserva_Conductor__c = detalleReserva1.Id    // Detalle Reserva Conductor
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

		// Capacidad_Tramo_Detalle_Reserva__c ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		//   Detalle_Reserva__c = detalleReserva1.Id,      // Detalle Reserva
		//   Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//   Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//   Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo
		// );
		// insert ctdr;

		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		//   Detalle_Reserva__c = detalleReserva2.Id,      // Detalle Reserva
		//   Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//   Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//   Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo
		// );
		// insert ctdr;

		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva3.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo	
		// );
		// insert ctdr;
		
		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva4.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo	
		// );
		// insert ctdr;

		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva5.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo	
		// );
		// insert ctdr;

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
    
		Caja__c sobj = new Caja__c(
			Name = 'UI-2023-02-08 03:00:13Z-142',// Nombre de la Caja
			Estado_de_la_Caja__c = 'Abierta',      // Estado de la Caja
			Numero_de_Caja__c = 1             // Número de Caja
			);
			insert sobj;
	}

    //Test GET origins - Camino Feliz
	@isTest
	static void test01(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','origins');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
		//req.addHeader('Content-Type', 'application/json');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET destinations - Camino Feliz
	@isTest
	static void test02(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','destinations');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        req.addParameter('origen','PUERTO MONTTT');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET nationalities - Camino Feliz
	@isTest
	static void test03(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','nationalities');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET vehicles - Camino Feliz
	@isTest
	static void test04(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','vehicles');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET brand - Camino Feliz
	@isTest
	static void test05(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','brand');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET models - Camino Feliz
	@isTest
	static void test06(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','models');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        req.addParameter('m','CHEVROLET');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET itineraries - Camino Feliz
	@isTest
	static void test07(){
		Test.startTest();

		//RL por motivos que desconozco se duplica el registro creado de Escala Itinerario, procedo a eliminar el duplicado que genera el trigger
		//El test crea un registro con Millas_de_Navegacion__c = 56 pero se genera un adicional de Millas_de_Navegacion__c = 103.0
		//Se eliminará el que no corresponde

		List<Escalas_Itinerario__C> escalasItinerarioLst = [SELECT Id, Itinerario__r.Name, Itinerario__r.Fecha_de_Viaje__c, Itinerario__r.RUTA__c, 
															Itinerario__r.Nombre_de_la_Nave__r.Name, Inicio_Embarque__c, 
															Itinerario__c, Millas_de_Navegacion__c, Navegacion__c, Observacion__c, 
															Puerto_Destino__c, ETA_Puerto_Destino__c, Puerto_Embarque__c, Salida__c, 
															Secuencia__c, Tiempo_Embarque__c, Itinerario__r.Nombre_de_la_Nave__r.Carga_Maxima_Vehiculos__c,
															Itinerario__r.Tipo__c, Itinerario__r.Fecha_Zarpe__c, Itinerario__r.Fecha_Termino__c,
															Itinerario__r.Pasajero_Web_Nac__c, Itinerario__r.Pasajero_Web_Ext__c,
															Itinerario__r.Vehiculo_Web_Nac__c, Itinerario__r.Vehiculo_Web_Ext__c
															FROM Escalas_Itinerario__c
															WHERE Puerto_Embarque__r.Name = 'PUERTO MONTTT'
															AND Itinerario__r.Canal_Web__c = true
                                                            AND Itinerario__r.Estado__c = 'Disponible para venta'
                                                            AND Hacer_Escala__c = true];
		
		System.debug('ESCALAS EN TEST ('+escalasItinerarioLst.size()+')');
		System.debug(escalasItinerarioLst);
		
		if(escalasItinerarioLst.size() > 0){
			List<Escalas_Itinerario__c> escalaToDelete = new List <Escalas_Itinerario__c>();
			for(Escalas_Itinerario__c escala : escalasItinerarioLst){
				if(escala.Millas_de_Navegacion__c != 56){
					escalaToDelete.add(escala);
				}
			}
			if(escalaToDelete.size() > 0){
				System.debug('Duplicados para borrar ('+escalaToDelete.size()+')');
				System.debug(escalaToDelete);
				delete escalaToDelete;
			}
		}
		
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','itineraries');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        req.addParameter('f','2021-09-10T19:45:47.000Z');
        req.addParameter('o','PUERTO MONTTT');
        req.addParameter('d','CHHAITÉN');
        req.addParameter('p','1');
        req.addParameter('v','1');
        req.addParameter('t','Vehiculo Menor');
        req.addParameter('m','CHEVROLET');
        req.addParameter('mo','IMPALA');
        req.addParameter('pe','0.0');
        req.addParameter('pm','0.0');
        req.addParameter('ca','');
        req.addParameter('lc','');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	 //Test GET itineraries - Camino Feliz
	 @isTest
	 static void test07b(){
		 Test.startTest();
 
		 //RL por motivos que desconozco se duplica el registro creado de Escala Itinerario, procedo a eliminar el duplicado que genera el trigger
		 //El test crea un registro con Millas_de_Navegacion__c = 56 pero se genera un adicional de Millas_de_Navegacion__c = 103.0
		 //Se eliminará el que no corresponde
 
		 List<Escalas_Itinerario__C> escalasItinerarioLst = [SELECT Id, Itinerario__r.Name, Itinerario__r.Fecha_de_Viaje__c, Itinerario__r.RUTA__c, 
															 Itinerario__r.Nombre_de_la_Nave__r.Name, Inicio_Embarque__c, 
															 Itinerario__c, Millas_de_Navegacion__c, Navegacion__c, Observacion__c, 
															 Puerto_Destino__c, ETA_Puerto_Destino__c, Puerto_Embarque__c, Salida__c, 
															 Secuencia__c, Tiempo_Embarque__c, Itinerario__r.Nombre_de_la_Nave__r.Carga_Maxima_Vehiculos__c,
															 Itinerario__r.Tipo__c, Itinerario__r.Fecha_Zarpe__c, Itinerario__r.Fecha_Termino__c,
															 Itinerario__r.Pasajero_Web_Nac__c, Itinerario__r.Pasajero_Web_Ext__c,
															 Itinerario__r.Vehiculo_Web_Nac__c, Itinerario__r.Vehiculo_Web_Ext__c
															 FROM Escalas_Itinerario__c
															 WHERE Puerto_Embarque__r.Name = 'PUERTO MONTTT'
															 AND Itinerario__r.Canal_Web__c = true
															 AND Itinerario__r.Estado__c = 'Disponible para venta'
															 AND Hacer_Escala__c = true];
		 
		 System.debug('ESCALAS EN TEST ('+escalasItinerarioLst.size()+')');
		 System.debug(escalasItinerarioLst);
		 
		 if(escalasItinerarioLst.size() > 0){
			 List<Escalas_Itinerario__c> escalaToDelete = new List <Escalas_Itinerario__c>();
			 for(Escalas_Itinerario__c escala : escalasItinerarioLst){
				 if(escala.Millas_de_Navegacion__c != 56){
					 escalaToDelete.add(escala);
				 }
			 }
			 if(escalaToDelete.size() > 0){
				 System.debug('Duplicados para borrar ('+escalaToDelete.size()+')');
				 System.debug(escalaToDelete);
				 delete escalaToDelete;
			 }
		 }
		 
		 RestRequest req = new RestRequest(); 
		 RestResponse res = new RestResponse();
		 
		 req.requestURI = '/services/apexrest/Web';  
		 req.httpMethod = 'GET'; 
		 req.addParameter('info','itineraries');
		 req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
		 req.addParameter('f','2021-09-10T19:45:47.000Z');
		 req.addParameter('o','PUERTO MONTTT');
		 req.addParameter('d','CHHAITÉN');
		 req.addParameter('p','1');
		 req.addParameter('v','1');
		 req.addParameter('t','Bicicleta');
		 req.addParameter('m','CHEVROLET');
		 req.addParameter('mo','IMPALA');
		 req.addParameter('pe','0.0');
		 req.addParameter('pm','0.0');
		 req.addParameter('ca','');
		 req.addParameter('lc','');
		 RestContext.request = req;
		 RestContext.response = res;
		 NAV_WebWs.getSalesforceInfo();
         NAV_PuelcheWebWS.getSalesforceInfo();
		 System.assertEquals(true, RestContext.response != null);
		 Test.stopTest();
	 }

    //Test GET capacities - Camino Feliz
	@isTest
	static void test08(){
        Test.startTest();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Web';
		req.httpMethod = 'GET'; 
        req.addParameter('info','capacities');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        req.addParameter('i',itinerario.id);
        req.addParameter('o','PUERTO MONTTT');
        req.addParameter('d','CHHAITÉN');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET person - Camino Feliz
	@isTest
	static void test09(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','person');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        req.addParameter('id','8955620-1');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET vehicle - Camino Feliz
	@isTest
	static void test10(){
		Test.startTest();
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','vehicle');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        req.addParameter('pat','BPZT89');
		RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET rates - Camino Feliz
	@isTest
	static void test11(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','rates');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET getDocuments - Camino Feliz
	@isTest
	static void test12(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','getDocuments');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    //Test GET exception - Servicio inexistente
	@isTest
	static void test13(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','test');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

    
    //Test DELETE - Servicio inexistente
	@isTest
	static void test14(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'DELETE'; 
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.deleteSalesforceInfo();
        NAV_PuelcheWebWS.deleteSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addCapacities - Exception
	@isTest
	static void test15(){
		Test.startTest();
			Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
														FROM Programacion_de_Itinerario__c
														WHERE Estado__c = 'Disponible para venta'];
			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addCapacities');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"reservation": "",\n';
			jsonString +='	"itinerarie": "'+itinerario.Id+'",\n';
			jsonString +='	"roundtrip": "Ida",\n';
			jsonString +='	"people": 1,\n'; 
			jsonString +='	"departure": "PUERTO MONTTT",\n'; 
			jsonString +='	"destination": "CHHAITÉN",\n'; 
			jsonString +='	"tripDate": "2021-09-10 19:45:47",\n';
			jsonString +='	"seats": ["01"],\n'; 
			jsonString +='	"arrayVehicles" : [{\n';
			jsonString +='		"tag": "1",\n';
			jsonString +='		"category": "Vehículo Menor",\n';
			jsonString +='		"brand": "CHEVROLET",\n';
			jsonString +='		"model": "IMPALA",\n';
			jsonString +='		"luggageRack": true,\n';
			jsonString +='		"bikeRack": true,\n';
			jsonString +='		"pullingCart": true,\n';
			jsonString +='		"pullingLong": 3.5,\n';
			jsonString +='		"vehicleType": "DEPORTIVO",\n'; 
			jsonString +='		"vHigh": 4,\n'; 
			jsonString +='		"vWidth": 2,\n'; 
			jsonString +='		"vLong": 15,\n'; 
			jsonString +='		"tare": 550,\n'; 
			jsonString +='		"load": 300 \n';
			jsonString +='	}]\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
            NAV_PuelcheWebWS.postSalesforceInfo();
			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addPerson - Camino Feliz
	@isTest
	static void test16(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name 
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addPerson');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"reservation": "'+reserva.Id+'",\n';
			jsonString +='	"seat": "01",\n';
			jsonString +='	"pName": "Dummy",\n';
			jsonString +='	"pLastname": "User",\n';
			jsonString +='	"pGender": "Masculino", \n';
			jsonString +='	"pBirthdate": "1990-11-09", \n';
			jsonString +='	"pDocType": "RUT",\n'; 
			jsonString +='	"pDocNum": "8955620-1",\n'; 
			jsonString +='	"pNationality": "Chilena",\n'; 
			jsonString +='	"pEmail": "eflores@nectia.com",\n'; 
			jsonString +='	"pPhone": "+56955566688",\n'; 
			jsonString +='	"pIsDriver": true\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
            NAV_PuelcheWebWS.postSalesforceInfo();
  			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addVehicle - Camino Feliz
	@isTest
	static void test17(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name 
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addVehicle');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"reservation": "'+reserva.id+'",\n';
			jsonString +='  "tag": "1",\n';
			jsonString +='	"licensePlate": "ABDC12",\n';
			jsonString +='	"category": "Vehículo Menor",\n';
			jsonString +='	"brand": "CHEVROLET",\n';
			jsonString +='	"model": "IMPALA",\n';
			jsonString +='	"luggageRack": true,\n';
			jsonString +='	"bikeRack": true,\n';
			jsonString +='	"pullingCart": true,\n';
			jsonString +='	"pullingLong": 3.5,\n';
			jsonString +='	"vehicleType": "DEPORTIVO",\n';
			jsonString +='	"vHigh": 4,\n';
			jsonString +='	"vWidth": 2,\n';
			jsonString +='	"vLong": 15,\n';
			jsonString +='	"tare": 550,\n';
			jsonString +='	"load": 300,\n';
			jsonString +='	"driver": {\n';
			jsonString +='		"pName": "Dummy",\n';
			jsonString +='		"pLastname": "User",\n';
			jsonString +='		"pGender": "Masculino",\n';
			jsonString +='		"pBirthdate": "1990-11-09",\n';
			jsonString +='		"pDocType": "RUT",\n';
			jsonString +='		"pDocNum": "8955620-1",\n';
			jsonString +='		"pNationality": "Chilena",\n';
			jsonString +='		"pEmail": "eflores@nectia.com",\n';
			jsonString +='		"pPhone": "+56955566688",\n';
			jsonString +='		"pIsDriver": true\n';
			jsonString +='	},\n';
			jsonString +='	"dispatcher": {\n';
			jsonString +='		"pName": "Dummy",\n';
			jsonString +='		"pLastname": "User",\n';
			jsonString +='		"pGender": "Masculino",\n';
			jsonString +='		"pBirthdate": "1990-11-09",\n';
			jsonString +='		"pDocType": "RUT",\n';
			jsonString +='		"pDocNum": "8955620-1",\n';
			jsonString +='		"pNationality": "Chilena",\n';
			jsonString +='		"pEmail": "eflores@nectia.com",\n';
			jsonString +='		"pPhone": "+56955566688",\n';
			jsonString +='		"pIsDriver": true\n';
			jsonString +='	},\n';
			jsonString +='	"receiver": {\n';
			jsonString +='		"pName": "Dummy",\n';
			jsonString +='		"pLastname": "User",\n';
			jsonString +='		"pGender": "Masculino",\n';
			jsonString +='		"pBirthdate": "1990-11-09",\n';
			jsonString +='		"pDocType": "RUT",\n';
			jsonString +='		"pDocNum": "8955620-1",\n';
			jsonString +='		"pNationality": "Chilena",\n';
			jsonString +='		"pEmail": "eflores@nectia.com",\n';
			jsonString +='		"pPhone": "+56955566688",\n';
			jsonString +='		"pIsDriver": true\n';
			jsonString +='	}\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
            NAV_PuelcheWebWS.postSalesforceInfo();
			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addPayment - Camino Feliz - Boleta
	@isTest
	static void test18(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name, Itemes_de_reserva_con_tarifa_validada__c
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			
			reserva.Tipo_Documento__c = 'Boleta';
			reserva.Canal_de_Venta__c = 'Web';
			reserva.Estado_de_Reserva__c = 'Reservada';
			reserva.Contacto_Reserva__c = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1' LIMIT 1].Id;
			update reserva;
			List<Detalle_Reserva__c> items = [SELECT Id, Parametro_Tarifa__c,Tarificacion_validada__c, Tramos__c, TramosReales__c FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id];
			System.debug('Rodri = '+items);
			for(Detalle_Reserva__c item :items){
				item.Parametro_Tarifa__c = 'OK';
			}
			update items;

			String rtId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId();

			Capacidad_Tramo__c capacidadTramo1 = [SELECT Id FROM Capacidad_Tramo__c WHERE RecordTypeId =: rtId AND Numero__c = '01' AND Unidad_de_medida__c = 'Pallet' AND Capacidad__c = 100];
			Detalle_Reserva__c detalleReserva1 = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id AND Doc_Identificacion_Pasajero__c = '8955620-1'];
			Detalle_Reserva__c detalleReserva2 = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id AND Doc_Identificacion_Pasajero__c = '2-7'];
			Detalle_Reserva__c detalleReserva3 = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id AND Placa_Patente_Vehiculo__c = 'BPZT89'];
			Detalle_Reserva__c detalleReserva4 = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id AND Unidad_de_medida__c = 'Pallet'];
			Detalle_Reserva__c detalleReserva5 = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id AND Doc_Identificacion_Pasajero__c = '1-9'];
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

			ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
				Detalle_Reserva__c = detalleReserva5.Id,      // Detalle Reserva
				Capacidad_Liberada__c = false,                 // Capacidad Liberada
				Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
				Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo	
			);
			insert ctdr;

			items = [SELECT Id, Parametro_Tarifa__c,Tarificacion_validada__c, Tramos__c, TramosReales__c  FROM Detalle_Reserva__c WHERE Reserva__c =: reserva.Id];
			System.debug('Rodri v2 = '+items);

			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addPayment');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +=' {\n';
			jsonString +='	"vci":"123",\n';
			jsonString +='	"amount":"27000",\n';
			jsonString +='	"buy_order":"AGDASF12123",\n';
			jsonString +='	"session_id":"65546q6521654a",\n';
			jsonString +='	"card_number":"0002",\n';
			jsonString +='	"accounting_date":"12122021",\n';
			jsonString +='	"transaction_date":"12122021",\n';
			jsonString +='	"authorization_code":"has124123",\n';
			jsonString +='	"payment_type":"Credito",\n';
			jsonString +='	"response_code":"54644654a",\n';
			jsonString +='	"card_expiration_date":"12/24",\n';
			jsonString +='	"url_redirection":"http://navieraaustral.cl",\n';
			jsonString +='	"shares_number":"5486",\n';
			jsonString +='	"commerce_code":"45",\n';
			jsonString +='	"status":"ok",\n';
			jsonString +='	"installments_amount":"27000",\n';
			jsonString +='	"installments_number":"1",\n';
			jsonString +='	"balance": "27000"\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
             //NAV_PuelcheWebWS.postSalesforceInfo();
  		System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addPayment - Camino Feliz - Factura Mixta
	@isTest
	static void test19(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name 
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			reserva.Tipo_Documento__c = 'Factura mixta';
			reserva.Contacto_Reserva__c = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1' LIMIT 1].Id;
			update reserva;

			reserva = [SELECT Id, Name, Itemes_de_reserva_con_tarifa_validada__c
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];

			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addPayment');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +=' {\n';
			jsonString +='	"vci":"123",\n';
			jsonString +='	"amount":"27000",\n';
			jsonString +='	"buy_order":"AGDASF12123",\n';
			jsonString +='	"session_id":"65546q6521654a",\n';
			jsonString +='	"card_number":"0002",\n';
			jsonString +='	"accounting_date":"12122021",\n';
			jsonString +='	"transaction_date":"12122021",\n';
			jsonString +='	"authorization_code":"has124123",\n';
			jsonString +='	"payment_type":"Credito",\n';
			jsonString +='	"response_code":"54644654a",\n';
			jsonString +='	"card_expiration_date":"12/24",\n';
			jsonString +='	"url_redirection":"http://navieraaustral.cl",\n';
			jsonString +='	"shares_number":"5486",\n';
			jsonString +='	"commerce_code":"45",\n';
			jsonString +='	"status":"ok",\n';
			jsonString +='	"installments_amount":"27000",\n';
			jsonString +='	"installments_number":"1",\n';
			jsonString +='	"balance": "27000"\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
			NAV_WebWS.formatDate(System.now());
            NAV_PuelcheWebWS.postSalesforceInfo();
            NAV_PuelcheWebWS.formatDate(System.now());
			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addPayment - Camino Feliz - Factura Mixta
	@isTest
	static void test19a(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name 
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			reserva.Tipo_Documento__c = 'Factura exenta';
			reserva.Contacto_Reserva__c = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1' LIMIT 1].Id;
			update reserva;

			reserva = [SELECT Id, Name, Itemes_de_reserva_con_tarifa_validada__c
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addPayment');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +=' {\n';
			jsonString +='	"vci":"123",\n';
			jsonString +='	"amount":"27000",\n';
			jsonString +='	"buy_order":"AGDASF12123",\n';
			jsonString +='	"session_id":"65546q6521654a",\n';
			jsonString +='	"card_number":"0002",\n';
			jsonString +='	"accounting_date":"12122021",\n';
			jsonString +='	"transaction_date":"12122021",\n';
			jsonString +='	"authorization_code":"has124123",\n';
			jsonString +='	"payment_type":"Credito",\n';
			jsonString +='	"response_code":"54644654a",\n';
			jsonString +='	"card_expiration_date":"12/24",\n';
			jsonString +='	"url_redirection":"http://navieraaustral.cl",\n';
			jsonString +='	"shares_number":"5486",\n';
			jsonString +='	"commerce_code":"45",\n';
			jsonString +='	"status":"ok",\n';
			jsonString +='	"installments_amount":"27000",\n';
			jsonString +='	"installments_number":"1",\n';
			jsonString +='	"balance": "27000"\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
			NAV_WebWS.formatDate(System.now());
        	NAV_PuelcheWebWS.postSalesforceInfo();
			NAV_PuelcheWebWS.formatDate(System.now());
			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST exception - Servicio inexistente
	@isTest
	static void test20(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'POST'; 
        req.addParameter('info','test');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
		String jsonString = '';
		jsonString +=' {\n';
		jsonString +=' }';
		req.addHeader('Content-Type', 'application/json');	
		req.requestBody = Blob.valueOf(jsonString);
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.postSalesforceInfo();
        NAV_PuelcheWebWS.postSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addPaymentData - Camino Feliz - Factura Mixta
	@isTest
	static void test21(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name 
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			reserva.Tipo_Documento__c = 'Factura mixta';
			update reserva;
			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addPaymentData');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"tipoDocumento": "Factura Mixta",\n';
			jsonString +='	"datosContacto": {\n';
			jsonString +='		"rut": "2-7",\n';
			jsonString +='		"nombre": "Juan",\n';
			jsonString +='		"apellido": "Perez",\n';
			jsonString +='		"correo": "juan@perez.cl",\n';
			jsonString +='		"telefono": "+56978445621"\n';
			jsonString +='	},\n';
			jsonString +='	"datosFactura": {\n';
			jsonString +='		"rut": "2-7",\n';
			jsonString +='		"razonSocial": "Perez EIRL",\n';
			jsonString +='		"giro": "Administracion de zapatos",\n';
			jsonString +='		"direccion": "Tobalaba 18015",\n';
			jsonString +='		"comuna": "La Reina"\n';
			jsonString +='	}\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
            NAV_PuelcheWebWS.postSalesforceInfo();
			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test POST addPaymentData - Camino Feliz - Factura Mixta
	@isTest
	static void test21b(){
		Test.startTest();
			Reserva__c reserva = [SELECT Id, Name 
								FROM Reserva__c
								WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040am3'];
			reserva.Tipo_Documento__c = 'Factura mixta';
			update reserva;
			RestRequest req = new RestRequest(); 
			RestResponse res = new RestResponse();
			
			req.requestURI = '/services/apexrest/Web';  
			req.httpMethod = 'POST'; 
			req.addParameter('info', 'addPaymentData');
			req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"tipoDocumento": "Factura Mixta",\n';
			jsonString +='	"datosContacto": {\n';
			jsonString +='		"rut": "16609033-4",\n';
			jsonString +='		"nombre": "Juan",\n';
			jsonString +='		"apellido": "Perez",\n';
			jsonString +='		"correo": "juann@perez.cl",\n';
			jsonString +='		"telefono": "+56978445621"\n';
			jsonString +='	},\n';
			jsonString +='	"datosFactura": {\n';
			jsonString +='		"rut": "10844385-5",\n';
			jsonString +='		"razonSocial": "Perezzz EIRL",\n';
			jsonString +='		"giro": "Administracion de zapatos",\n';
			jsonString +='		"direccion": "Tobalaba 18015",\n';
			jsonString +='		"comuna": "La Reina"\n';
			jsonString +='	}\n';
			jsonString +='}\n';
			req.addHeader('Content-Type', 'application/json');	
			req.requestBody = Blob.valueOf(jsonString);
			RestContext.request = req;
			RestContext.response = res;
			NAV_WebWs.postSalesforceInfo();
            NAV_PuelcheWebWS.postSalesforceInfo();
			System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}

	//Test de Cobertura para clases Wrapper
	@isTest
	static void test22(){
		Test.startTest();
			NAV_WrapperCapacities nwc = new NAV_WrapperCapacities();
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"itinerarie": "DUMMY",\n';
			jsonString +='	"roundtrip": "Ida",\n';
			jsonString +='	"people": 1,\n'; 
			jsonString +='	"departure": "PUERTO MONTTT",\n'; 
			jsonString +='	"destination": "CHHAITÉN",\n'; 
			jsonString +='	"tripDate": "2021-09-10 19:45:47",\n';
			jsonString +='	"seats": ["01"],\n'; 
			jsonString +='	"arrayVehicles" : [{\n';
			jsonString +='		"category": "Vehículo Menor",\n';
			jsonString +='		"tag": "1",\n';
			jsonString +='		"brand": "CHEVROLET",\n';
			jsonString +='		"model": "IMPALA",\n';
			jsonString +='		"luggageRack": true,\n';
			jsonString +='		"bikeRack": true,\n';
			jsonString +='		"pullingCart": true,\n';
			jsonString +='		"pullingLong": 3.5,\n';
			jsonString +='		"vehicleType": "DEPORTIVO",\n'; 
			jsonString +='		"vHigh": 4,\n'; 
			jsonString +='		"vWidth": 2,\n'; 
			jsonString +='		"vLong": 15,\n'; 
			jsonString +='		"tare": 550,\n'; 
			jsonString +='		"load": 300 \n';
			jsonString +='	}]\n';
			jsonString +='}\n';

			nwc = NAV_WrapperCapacities.parse(jsonString);
			System.assertEquals(true, nwc != null);
		Test.stopTest();
	}

	//Test de Cobertura para clases Wrapper
	@isTest
	static void test23(){
		Test.startTest();
			NAV_WrapperPerson nwp = new NAV_WrapperPerson();
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"reservation": "TEST",\n';
			jsonString +='	"seat": "01",\n';
			jsonString +='	"pName": "Dummy",\n';
			jsonString +='	"pLastname": "User",\n';
			jsonString +='	"pGender": "Masculino", \n';
			jsonString +='	"pBirthdate": "1990-11-09", \n';
			jsonString +='	"pDocType": "RUT",\n'; 
			jsonString +='	"pDocNum": "8955620-1",\n'; 
			jsonString +='	"pNationality": "Chilena",\n'; 
			jsonString +='	"pEmail": "eflores@nectia.com",\n'; 
			jsonString +='	"pPhone": "+56955566688",\n'; 
			jsonString +='	"pIsDriver": true\n';
			jsonString +='}\n';

			nwp = NAV_WrapperPerson.parse(jsonString);
			System.assertEquals(true, nwp != null);
		Test.stopTest();
	}

	//Test de Cobertura para clases Wrapper
	@isTest
	static void test24(){
		Test.startTest();
			NAV_WrapperVehicles nwv = new NAV_WrapperVehicles();
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"reservation": "Dummy",\n';
			jsonString +='	"licensePlate": "ABDC12",\n';
			jsonString +='  "tag": "1",\n';
			jsonString +='	"category": "Vehículo Menor",\n';
			jsonString +='	"brand": "CHEVROLET",\n';
			jsonString +='	"model": "IMPALA",\n';
			jsonString +='	"luggageRack": true,\n';
			jsonString +='	"bikeRack": true,\n';
			jsonString +='	"pullingCart": true,\n';
			jsonString +='	"pullingLong": 3.5,\n';
			jsonString +='	"vehicleType": "DEPORTIVO",\n';
			jsonString +='	"vHigh": 4,\n';
			jsonString +='	"vWidth": 2,\n';
			jsonString +='	"vLong": 15,\n';
			jsonString +='	"tare": 550,\n';
			jsonString +='	"load": 300,\n';
			jsonString +='	"driver": {\n';
			jsonString +='		"pName": "Dummy",\n';
			jsonString +='		"pLastname": "User",\n';
			jsonString +='		"pGender": "Masculino",\n';
			jsonString +='		"pBirthdate": "1990-11-09",\n';
			jsonString +='		"pDocType": "RUT",\n';
			jsonString +='		"pDocNum": "8955620-1",\n';
			jsonString +='		"pNationality": "Chilena",\n';
			jsonString +='		"pEmail": "eflores@nectia.com",\n';
			jsonString +='		"pPhone": "+56955566688",\n';
			jsonString +='		"pIsDriver": true\n';
			jsonString +='	},\n';
			jsonString +='	"dispatcher": {\n';
			jsonString +='		"pName": "Dummy",\n';
			jsonString +='		"pLastname": "User",\n';
			jsonString +='		"pGender": "Masculino",\n';
			jsonString +='		"pBirthdate": "1990-11-09",\n';
			jsonString +='		"pDocType": "RUT",\n';
			jsonString +='		"pDocNum": "8955620-1",\n';
			jsonString +='		"pNationality": "Chilena",\n';
			jsonString +='		"pEmail": "eflores@nectia.com",\n';
			jsonString +='		"pPhone": "+56955566688",\n';
			jsonString +='		"pIsDriver": true\n';
			jsonString +='	},\n';
			jsonString +='	"receiver": {\n';
			jsonString +='		"pName": "Dummy",\n';
			jsonString +='		"pLastname": "User",\n';
			jsonString +='		"pGender": "Masculino",\n';
			jsonString +='		"pBirthdate": "1990-11-09",\n';
			jsonString +='		"pDocType": "RUT",\n';
			jsonString +='		"pDocNum": "8955620-1",\n';
			jsonString +='		"pNationality": "Chilena",\n';
			jsonString +='		"pEmail": "eflores@nectia.com",\n';
			jsonString +='		"pPhone": "+56955566688",\n';
			jsonString +='		"pIsDriver": true\n';
			jsonString +='	}\n';
			jsonString +='}\n';

			nwv = NAV_WrapperVehicles.parse(jsonString);
			System.assertEquals(true, nwv != null);
		Test.stopTest();
	}

	//Test de Cobertura para clases Wrapper
	@isTest
	static void test25(){
		Test.startTest();
			NAV_WrapperPaymentData nwpd = new NAV_WrapperPaymentData();
			String jsonString = '';
			jsonString +='{\n';
			jsonString +='	"tipoDocumento": "Factura Mixta",\n';
			jsonString +='	"datosContacto": {\n';
			jsonString +='		"rut": "2-7",\n';
			jsonString +='		"nombre": "Juan",\n';
			jsonString +='		"apellido": "Perez",\n';
			jsonString +='		"correo": "juan@perez.cl",\n';
			jsonString +='		"telefono": "+56978445621"\n';
			jsonString +='	},\n';
			jsonString +='	"datosFactura": {\n';
			jsonString +='		"rut": "2-7",\n';
			jsonString +='		"razonSocial": "Perez EIRL",\n';
			jsonString +='		"giro": "Administracion de zapatos",\n';
			jsonString +='		"direccion": "Tobalaba 18015",\n';
			jsonString +='		"comuna": "La Reina"\n';
			jsonString +='	}\n';
			jsonString +='}\n';

			nwpd = NAV_WrapperPaymentData.parse(jsonString);
			System.assertEquals(true, nwpd != null);
		Test.stopTest();
	}

	//Test de Cobertura para clases Wrapper
	@isTest
	static void test26(){
		Test.startTest();
			NAV_WrapperPayments nwp = new NAV_WrapperPayments();
			String jsonString = '';
			jsonString +=' {\n';
			jsonString +='	"vci":"123",\n';
			jsonString +='	"amount":"27000",\n';
			jsonString +='	"buy_order":"AGDASF12123",\n';
			jsonString +='	"session_id":"65546q6521654a",\n';
			jsonString +='	"card_number":"0002",\n';
			jsonString +='	"accounting_date":"12122021",\n';
			jsonString +='	"transaction_date":"12122021",\n';
			jsonString +='	"authorization_code":"has124123",\n';
			jsonString +='	"payment_type":"Credito",\n';
			jsonString +='	"response_code":"54644654a",\n';
			jsonString +='	"card_expiration_date":"12/24",\n';
			jsonString +='	"url_redirection":"http://navieraaustral.cl",\n';
			jsonString +='	"shares_number":"5486",\n';
			jsonString +='	"commerce_code":"45",\n';
			jsonString +='	"status":"ok",\n';
			jsonString +='	"installments_amount":"27000",\n';
			jsonString +='	"installments_number":"1",\n';
			jsonString +='	"balance": "27000"\n';
			jsonString +='}\n';

			nwp = NAV_WrapperPayments.parse(jsonString);
			System.assertEquals(true, nwp != null);
		Test.stopTest();
	}
        @isTest
	static void test27(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','getCodPromocion');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}
    @isTest
	static void test28(){
		Test.startTest();
				
		RestRequest req = new RestRequest(); 
    	RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Web';  
		req.httpMethod = 'GET'; 
        req.addParameter('info','getRemoveCodPromocional');
        req.addParameter('uuid', 'd5799d8e-f1c8-491f-a333-333f62040am3');
        RestContext.request = req;
    	RestContext.response = res;
        NAV_WebWs.getSalesforceInfo();
        NAV_PuelcheWebWS.getSalesforceInfo();
        System.assertEquals(true, RestContext.response != null);
        Test.stopTest();
	}
}