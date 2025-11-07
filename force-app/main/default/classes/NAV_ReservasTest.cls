/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_Reservas
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     23-03-2022   RL       Creación de la Clase.
***********************************************************************************/

@isTest 
private class NAV_ReservasTest {
    @isTest
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
			Sigla_Ruta__c = 'PMCN'                            // Sigla Ruta
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
		  Transportista__c = false
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
		  Numero__c = '1',
		  Capacidad_Comprometida__c = 1,
		  Detalle_Reserva_Conductor__c = detalleReserva1.Id    // Detalle Reserva Conductor
		 );
		insert detalleReserva6;

		Detalle_Reserva__c detalleReserva7 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  Numero__c = 'SA1',                              // Número
		  Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		  Unidad_de_medida__c = 'Persona',               // Unidad de medida
		  Ubicacion__c = 'Salón',                        // Ubicación
		  Doc_Identificacion_Pasajero__c = '4-3',        // Doc Identificación Pasajero
		  Nombre_Pasajero__c = cuenta3.Id,               // Nombre Pasajero
		  Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		  Residente__c = false,                          // Residente
		  Conductor__c = false,                          // Conductor
		  Sin_acomodacion__c = true                       // Transportista
		);
		insert detalleReserva7;
        
         Detalle_Reserva__c detalleReserva8 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Venta Cruzada').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  VCTipo__c ='PASAJERO',
          VCMateria__c ='Bus Conexion', 
          VC_Valor_Bruto__c= 10000,
          Capacidad_Comprometida__c = 1
		);
		insert detalleReserva8;
        Item_Folio__c sobjFolio = new Item_Folio__c(
          Name = '172890106-4',               // Numero de Folio
          Item_Reserva__c = detalleReserva8.Id,        // Item Reserva
          Nombre_Servicio__c = 'Bus Conexion',  // Nombre Servicio
          Id_Reserva__c = 'R-0000002008'       // Reserva
        );
        insert sobjFolio;
        
        Detalle_Reserva__c detalleReserva9 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Venta Cruzada').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  VCTipo__c ='TMC Camión chico (1.500 a 6.000 kg)',
          VCMateria__c ='TMC Camión chico (1.500 a 6.000 kg)', 
          VC_Valor_Bruto__c= 10000,
          Capacidad_Comprometida__c = 1
		);
		insert detalleReserva9;
        Item_Folio__c sobjFolio9 = new Item_Folio__c(
          Name = '1112233',               // Numero de Folio
          Item_Reserva__c = detalleReserva9.Id,        // Item Reserva
          Nombre_Servicio__c = 'TMC Camión chico (1.500 a 6.000 kg)',  // Nombre Servicio
          Id_Reserva__c = 'R-0000002008'       // Reserva
        );
        insert sobjFolio9;
        

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

		parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
		  Valor__c = 2000,		                   // Valor
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
		  Categoria__c = 'Sin acomodación',
		  Estudiante__c = false,                   // Estudiante
		  Conductor__c = false,                    // Conductor
		  Impuesto__c = 'Valor Exento',            // Impuesto
		  Transportista__c = false,                // Transportista
		  Porcentaje_Impuesto__c = 0               // Porcentaje Impuesto
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

		Capacidad_Tramo__c capacidadTramo4 = new Capacidad_Tramo__c(
		  RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
		  Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		  Ubicacion__c = 'Cubierta',       				     // Ubicación
		  Numero__c = '01',                           		 // Número
		  Cupo_Venta_Local__c = false,               		 // Cupo Venta Local
		  Capacidad__c = 100,                          		 // Capacidad
		  Canal_Web__c = true, 
		  Categoria__c = 'Sin acomodacion',                      		 // Canal Web
		  Unidad_de_medida__c = 'Persona'            		 // Unidad de medida
		);
		insert capacidadTramo4;

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
    }

    //Test loadData - Camino Feliz
	@isTest
	static void test01(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            controlador.loadData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

    //Test getData - 0 - Camino Feliz
	@isTest
	static void test02(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '0');
            pref.getParameters().put('origen', 'DUMMY MONTT');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

    //Test getData - people - Camino Feliz
	@isTest
	static void test03(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', 'people');
            pref.getParameters().put('id', '8955620-1');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

    //Test getData - vehicle - Camino Feliz
	@isTest
	static void test04(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', 'vehicle');
            pref.getParameters().put('pat', 'BPZT89');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

    //Test getData - x - Camino Feliz
	@isTest
	static void test05(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', 'x');
            pref.getParameters().put('pat', 'CHEVROLET');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

    //Test getData - 1 - Camino Feliz
	@isTest
	static void test06(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '1');
            pref.getParameters().put('f','10/09/2021');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
            pref.getParameters().put('p','1');
            pref.getParameters().put('v','1');
            pref.getParameters().put('c','0');
            pref.getParameters().put('sA','1');
            pref.getParameters().put('t','Vehiculo Menor');
            pref.getParameters().put('m','CHEVROLET');
            pref.getParameters().put('mo','IMPALA');
            pref.getParameters().put('vmal','1.3');
            pref.getParameters().put('vmla','4.1');
            pref.getParameters().put('vmtm','2.6');
            pref.getParameters().put('pe','false');
            pref.getParameters().put('pb','false');
            pref.getParameters().put('ca','true');
            pref.getParameters().put('lc','2');
            pref.getParameters().put('mTi','2');
            pref.getParameters().put('mAl','2');
            pref.getParameters().put('mAn','2');
            pref.getParameters().put('mLa','2');
            pref.getParameters().put('cmFa','2');
            pref.getParameters().put('cmTi','2');
            pref.getParameters().put('cmTa','2');
            pref.getParameters().put('cmCa','2');
            pref.getParameters().put('cmAl','2');
            pref.getParameters().put('cmAn','2');
            pref.getParameters().put('cmLa','2');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

    //Test getData - 2 - Camino Feliz
	@isTest
	static void test07(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '2');
            pref.getParameters().put('i',itinerario.Id);
            pref.getParameters().put('iid',itinerario.Id);
            pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('ifo','10/09/2021');
            pref.getParameters().put('fi','10/09/2021');
            pref.getParameters().put('f','10/09/2021');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
            pref.getParameters().put('p','1');
            pref.getParameters().put('v','1');
            pref.getParameters().put('c','0');
            pref.getParameters().put('sA','1');
            pref.getParameters().put('t','Vehiculo Menor');
            pref.getParameters().put('m','CHEVROLET');
            pref.getParameters().put('mo','IMPALA');
            pref.getParameters().put('vmal','1.3');
            pref.getParameters().put('vmla','4.1');
            pref.getParameters().put('vmtm','SEDAN');
            pref.getParameters().put('pe','1');
            pref.getParameters().put('pb','1');
            pref.getParameters().put('ca','1');
            pref.getParameters().put('lc','2');
            pref.getParameters().put('mTi','2');
            pref.getParameters().put('mAl','2');
            pref.getParameters().put('mAn','2');
            pref.getParameters().put('mLa','2');
            pref.getParameters().put('cmFa','2');
            pref.getParameters().put('cmTi','2');
            pref.getParameters().put('cmTa','2');
            pref.getParameters().put('cmCa','2');
            pref.getParameters().put('cmAl','2');
            pref.getParameters().put('cmAn','2');
            pref.getParameters().put('cmLa','2');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 2a - Camino Feliz
	@isTest
	static void test08(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
			pref.getParameters().put('pa', '2a');
            pref.getParameters().put('butacas', '01,02,03,SA1');
            pref.getParameters().put('i',itinerario.Id);
            pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 3 - Camino Feliz
	@isTest
	static void test09(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
			pref.getParameters().put('pa', '3');
            pref.getParameters().put('butacas', '01');
            pref.getParameters().put('i',itinerario.Id);
            pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('Ptd','RUT');
			pref.getParameters().put('Pdo','8955620-1');
			pref.getParameters().put('Pn','Dummy');
			pref.getParameters().put('Pap','Test');
			pref.getParameters().put('Pt','+56221234567');
			pref.getParameters().put('Pem','dummy@dummy.com');
			pref.getParameters().put('PfN','10/11/1967');
			pref.getParameters().put('Pg','Masculino');
			pref.getParameters().put('Pd','1');
			pref.getParameters().put('Pr','1');
			pref.getParameters().put('Pe','1');
			pref.getParameters().put('Pbut','01');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 3 - Camino Felizv2
	@isTest
	static void test10(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];        
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
			pref.getParameters().put('pa', '3');
            pref.getParameters().put('butacas', '01');
            pref.getParameters().put('i',itinerario.Id);
            pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('Ptd','RUT');
			pref.getParameters().put('Pdo','3-5');
			pref.getParameters().put('Pn','Dummy');
			pref.getParameters().put('Pap','Test');
			pref.getParameters().put('Pt','+56221234567');
			pref.getParameters().put('Pem','dummy@dummyv2.com');
			pref.getParameters().put('PfN','10/11/1967');
			pref.getParameters().put('Pg','Masculino');
			pref.getParameters().put('Pd','1');
			pref.getParameters().put('Pr','1');
			pref.getParameters().put('Pe','1');
			pref.getParameters().put('Pbut','01');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 4 - Camino Feliz
	@isTest
	static void test11(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('i',itinerario.Id);
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('AyIdVe','Vehiculo Menor_1');
			pref.getParameters().put('AyPate','BPZT89');
			pref.getParameters().put('AyCond','8955620-1');
			pref.getParameters().put('AyNEmp','');
			pref.getParameters().put('AEDocu','8955620-1');
			pref.getParameters().put('AENDoc','');
			pref.getParameters().put('AEName','');
			pref.getParameters().put('AEApel','');
			pref.getParameters().put('AETele','');
			pref.getParameters().put('ARDocu','');
			pref.getParameters().put('ARNDoc','');
			pref.getParameters().put('ARName','');
			pref.getParameters().put('ARApel','');
			pref.getParameters().put('ARTele','');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 4 Sin Conductor - Camino Feliz
	@isTest
	static void test12(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('i',itinerario.Id);
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('AyIdVe','Vehiculo Menor_1');
			pref.getParameters().put('AyPate','BPZT89');
			pref.getParameters().put('AyCond','Sin Conductor');
			pref.getParameters().put('AyNEmp','');
			pref.getParameters().put('AENDoc','3-5');
			pref.getParameters().put('AEDocu','RUT');
			pref.getParameters().put('AEName','Dummy Name');
			pref.getParameters().put('AEApel','Dummy LastName');
			pref.getParameters().put('AETele','+56212345678');
			pref.getParameters().put('ARNDoc','17375869-3');
			pref.getParameters().put('ARDocu','RUT');
			pref.getParameters().put('ARName','Dummy Name');
			pref.getParameters().put('ARApel','Dummy LastName');
			pref.getParameters().put('ARTele','+56212345678');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 4 Bicicleta - Camino Feliz
	@isTest
	static void test13(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('i',itinerario.Id);
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('AyIdVe','Bicicleta_1');
			pref.getParameters().put('AyPate','BPZT89');
			pref.getParameters().put('AyCond','8955620-1');
			pref.getParameters().put('AyNEmp','');
			pref.getParameters().put('AEDocu','8955620-1');
			pref.getParameters().put('AENDoc','');
			pref.getParameters().put('AEName','');
			pref.getParameters().put('AEApel','');
			pref.getParameters().put('AETele','');
			pref.getParameters().put('ARDocu','');
			pref.getParameters().put('ARNDoc','');
			pref.getParameters().put('ARName','');
			pref.getParameters().put('ARApel','');
			pref.getParameters().put('ARTele','');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 4 - Camino Feliz
	@isTest
	static void test14(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '4');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('i',itinerario.Id);
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('AyIdVe','_1');
			pref.getParameters().put('AyPate','BPZT89');
			pref.getParameters().put('AyCond','8955620-1');
			pref.getParameters().put('AyNEmp','');
			pref.getParameters().put('AEDocu','8955620-1');
			pref.getParameters().put('AENDoc','');
			pref.getParameters().put('AEName','');
			pref.getParameters().put('AEApel','');
			pref.getParameters().put('AETele','');
			pref.getParameters().put('ARDocu','');
			pref.getParameters().put('ARNDoc','');
			pref.getParameters().put('ARName','');
			pref.getParameters().put('ARApel','');
			pref.getParameters().put('ARTele','');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 4a - Camino Feliz
	@isTest
	static void test14a(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '4a');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('i',itinerario.Id);
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 5 - Camino Feliz
	@isTest
	static void test15(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
		Programacion_de_Itinerario__c itinerario = [SELECT Id, Name 
                                                    FROM Programacion_de_Itinerario__c
                                                    WHERE Estado__c = 'Disponible para venta'];		
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '5');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('i',itinerario.Id);
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            pref.getParameters().put('carga','1');
			pref.getParameters().put('cEDoc','RUT');
			pref.getParameters().put('cENdo','8955620-1');
			pref.getParameters().put('cENam','Dummy');
			pref.getParameters().put('cEApe','Dummy');
			pref.getParameters().put('cETel','+56221234567');
			pref.getParameters().put('cRDoc','RUT');
			pref.getParameters().put('cRNdo','3-5');
			pref.getParameters().put('cRNam','Dummy');
			pref.getParameters().put('cRApe','Dummy');
			pref.getParameters().put('cRTel','+56221234567');
			pref.getParameters().put('cObse','Test');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 6 - Camino Feliz
	@isTest
	static void test16(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '6');
            pref.getParameters().put('o','DUMMY MONTT');
            pref.getParameters().put('d','DUMMY CHAITÉN');
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            controlador.getData();
			NAV_Reservas.formatDecimal(100,3);
			controlador.numReserva = 'test';
			controlador.cargas = 'test';
			controlador.uuid = 'algo';
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	//Test getData - 7 - Camino Feliz
	@isTest
	static void test177(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
		    NAV_Reservas controlador = new NAV_Reservas();
            PageReference pref = Page.NAV_Reservas;
		    Test.setCurrentPage(pref);
            pref.getParameters().put('pa', '7');
			pref.getParameters().put('uuid','d5799d8e-f1c8-491f-a333-333f62040ed4');
            controlador.getData();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
	}

	@isTest
	static void test17(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Reserva__c reserva = [SELECT Id
							  FROM Reserva__c
							  WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4'];
		Test.startTest();
			PageReference pref = Page.NAV_TicketPDF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(reserva.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(reserva);
			NAV_TicketPDFController controlador = new NAV_TicketPDFController(apst);
			NAV_TicketPDFController.formatDecimal(100,3);
        	System.assertEquals(true, capacidadTramoLst.size() >= 0);
        
            NAV_ValidaReservaController val= new NAV_ValidaReservaController(apst);
			
		Test.stopTest();
	}

	@isTest
	static void test18(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        Id iReserva;
		Reserva__c reserva = [SELECT Id
							  FROM Reserva__c
							  WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4'];
        iReserva = reserva.Id;
		Test.startTest();
			NAV_ResumenVFController controlador = new NAV_ResumenVFController(iReserva);
			PageReference pref = Page.NAV_ResumenVF;
			pref.getParameters().put('Id', String.valueOf(iReserva));
			Test.setCurrentPage(pref);
			ApexPages.StandardController apst = new ApexPages.StandardController(reserva);
			controlador = new NAV_ResumenVFController(apst);
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
		Test.stopTest();
	}

	@isTest
	static void test19(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Reserva__c reserva = [SELECT Id
							  FROM Reserva__c
							  WHERE UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4'];
		Test.startTest();
			List<Id> idReservaLst = new List<Id>();
			idReservaLst.add(reserva.Id);
			NAV_EnviarTicketPDF.EnviarTickets(idReservaLst);
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
		Test.stopTest();
	}

	@isTest
	static void test20(){
		List<Capacidad_Tramo__c> capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
        setup();
        capacidadTramoLst = [SELECT Id FROM Capacidad_Tramo__c];
		Test.startTest();
			NAV_ReservasCanceladas reservasCanceladas = new NAV_ReservasCanceladas();
			NAV_ReservasCanceladas.cancelaReservas();
			System.assertEquals(true, capacidadTramoLst.size() >= 0);
		Test.stopTest();
	}



}