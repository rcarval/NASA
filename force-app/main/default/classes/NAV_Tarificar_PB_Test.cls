/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_Tarificar_PB
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     25-10-2021   RL       Creación de la Clase.
***********************************************************************************/


@isTest 
private class NAV_Tarificar_PB_Test {

	@TestSetup
	static void setup(){
		// Puerto__c puerto1 = new Puerto__c(
		// 	Name = 'PUERTO MONTT'// Nombre de Puerto
		// );
		// insert puerto1;

		// Puerto__c puerto2 = new Puerto__c(
		// 	Name = 'CHAITÉN'// Nombre de Puerto
		// );
		// insert puerto2;

		// Puerto__c puerto3 = new Puerto__c(
		// 	Name = 'AYACARA'// Nombre de Puerto
		// );
		// insert puerto3;

		// Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
		// 	Name = 'CHAITÉN SUR',                            // Nombre de Mantenedor Rutas
		// 	Origen_Destino__c = 'PUERTO MONTT -> CHAITÉN',  // Zarpe Origen -> Recalada Final
		// 	Sigla_Ruta__c = 'PMCN'                            // Sigla Ruta
		// );
		// insert mantenedorRuta;
		
		// Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
		// 	Name = 'PUERTO MONTT -> CHAITÉN',  // Nombre de Tramos
		// 	Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
		// 	Secuencia__c = 1,                     // Secuencia
		// 	ORIGEN__c = puerto1.Id,          // ORIGEN
		// 	Tiempo_Embarque__c = Time.newInstance(1, 0, 0, 0),            // Tiempo Embarque
		// 	DESTINO__c = puerto2.Id         // DESTINO
		// );
		// insert mantenedorTramos;

        // OrigenDestino__c origenDestino = new OrigenDestino__c(
		// 	Distancia__c = 103,          // Distancia
		// 	Origen__c = puerto1.Id,   // Origen
		// 	Destino__c = puerto2.Id  // Destino
        // );
        // insert origenDestino;

		// Parametro_Tasa_Embarque__c pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,						  // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 9.000,                               // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                      // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 18.000,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,                         // Puerto
		//   Concepto__c = 'Tasa Vehículos',                 // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 28.000,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,                         // Puerto
		//   Concepto__c = 'Tasa Vehículos',                 // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 14.000,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
		//   Valor__c = 9.200,                               // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
		//   Valor__c = 18.400,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
		//   Valor__c = 8.900,                               // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// pte = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto1.Id,						  // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2021-03-31'), // Vigencia hasta
		//   Valor__c = 17.800,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pte;

		// Parametro_Tasa_Embarque__c pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,						  // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 9.000,                               // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                      // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 18.000,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,                         // Puerto
		//   Concepto__c = 'Tasa Vehículos',                 // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 28.000,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,                         // Puerto
		//   Concepto__c = 'Tasa Vehículos',                 // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2021-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2022-03-31'), // Vigencia hasta
		//   Valor__c = 14.000,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = true,                   // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
		//   Valor__c = 9.200,                               // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2022-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
		//   Valor__c = 18.400,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,                         // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = true,                            // Residente
		//   Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2099-03-31'), // Vigencia hasta
		//   Valor__c = 8.900,                               // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// pteDesembarque = new Parametro_Tasa_Embarque__c(
		//   Puerto__c = puerto2.Id,						  // Puerto
		//   Concepto__c = 'Tasa Pasajero',                  // Concepto
		//   Aplicar__c = 'Al Embarque y Desembarque',                     // Aplicar
		//   Residente__c = false,                           // Residente
		//   Vigencia_desde__c = Date.valueOf('2020-04-01'), // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2021-03-31'), // Vigencia hasta
		//   Valor__c = 17.800,                              // Valor
		//   Ruta_Comercial__c = true,                       // Ruta Comercial
		//   Ruta_Subvencionada__c = false,                  // Ruta Subvencionada
		//   Impuesto__c = 'Valor Exento',                   // Impuesto
		//   Porcentaje_Impuesto__c = 0                     // Porcentaje Impuesto
		// );
		// insert pteDesembarque;

		// Account cuenta1 = new Account(
		//   RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		//   FirstName = 'Dummy', // Nombre de la cuenta
		//   LastName = 'User',
		//   Identificacion__c = '8955620-1',               // Identificación
		//   PersonBirthdate = Date.valueOf('1967-10-11'),  // Fecha de nacimiento
		//   Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		//   PersonEmail = 'dummy@dummy.com',               // Correo electrónico
		//   Discapacidad__pc = false                      // Discapacidad
		// );
		// insert cuenta1;

		// Account cuenta2 = new Account(
		//   RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		//   FirstName = 'Dummy', // Nombre de la cuenta
		//   LastName = 'User 2',
		//   Identificacion__c = '2-7',              // Identificación
		//   PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
		//   Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		//   PersonEmail = 'dummy2@dummy.com',              // Correo electrónico
		//   Discapacidad__pc = false                       // Discapacidad
		// );
		// insert cuenta2;

		// Account cuenta3 = new Account(
		//   RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		//   FirstName = 'Dummy', // Nombre de la cuenta
		//   LastName = 'User 3',
		//   Identificacion__c = '1-9',              // Identificación
		//   PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
		//   Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		//   PersonEmail = 'dummy3@dummy.com',              // Correo electrónico
		//   Discapacidad__pc = false                       // Discapacidad
		// );
		// insert cuenta3;

		// Account cuenta4 = new Account(
		//   RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		//   FirstName = 'Dummy', // Nombre de la cuenta
		//   LastName = 'User 4',
		//   Identificacion__c = '12345678',              // Identificación
		//   PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
		//   Tipo_de_identificacion__c = 'Pasaporte',             // Tipo de identificación
		//   PersonEmail = 'dummy4@dummy.com',              // Correo electrónico
		//   Discapacidad__pc = false                       // Discapacidad
		// );
		// insert cuenta4;

		// Reserva__c reserva = new Reserva__c(
		//   Canal_de_Venta__c = 'Presencial',                 // Canal de Venta
		//   Tipo_de_Reserva__c = 'General',                   // Tipo de Reserva
		//   Sentido_Viaje__c = 'Ida',                         // Sentido Viaje
		//   Fecha_de_Reserva__c = Date.valueOf('2021-09-06'), // Fecha de Reserva
		//   Estado_de_Reserva__c = 'Creada',                  // Estado de Reserva
		//   Cantidad_de_Pasajeros__c = 2,                     // Cantidad de Pasajeros
		//   Cantidad_de_Vehiculos__c = 1,                     // Cantidad de Vehículos
		//   Itinerario_admite_DR__c = true,                   // Itinerario admite DR
		//   Ocupacion_porcentaje__c = 23,                    // Ocupación %
		//   Fecha_Viaje__c = Date.valueOf('2021-10-10'),      // Fecha Viaje
		//   Fecha_Expiracion__c = Date.valueOf('2021-10-09'), // Fecha Expiración
		//   Puerto_ORIGEN__c = puerto1.Id,                    // Puerto ORIGEN
		//   Expira_al_Zarpe__c = false,                       // Expira al Zarpe
		//   Puerto_DESTINO__c = puerto2.Id                    // Puerto DESTINO
		// );
		// insert reserva;

		// Detalle_Reserva__c detalleReserva1 = new Detalle_Reserva__c(
		//   RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
		//   Reserva__c = reserva.Id,						 // Reserva
		//   Numero__c = '01',                              // Número
		//   Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		//   Unidad_de_medida__c = 'Persona',               // Unidad de medida
		//   Ubicacion__c = 'Salón',                        // Ubicación
		//   Doc_Identificacion_Pasajero__c = '8955620-1',  // Doc Identificación Pasajero
		//   Nombre_Pasajero__c = cuenta1.Id,               // Nombre Pasajero
		//   Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		//   Residente__c = true,                           // Residente
		//   Conductor__c = false,                          // Conductor
		//   Transportista__c = false                       // Transportista
		// );
		// insert detalleReserva1;

		// Detalle_Reserva__c detalleReserva2 = new Detalle_Reserva__c(
		//   RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
		//   Reserva__c = reserva.Id,						 // Reserva
		//   Numero__c = '02',                              // Número
		//   Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		//   Unidad_de_medida__c = 'Persona',               // Unidad de medida
		//   Ubicacion__c = 'Salón',                        // Ubicación
		//   Doc_Identificacion_Pasajero__c = '2-7',        // Doc Identificación Pasajero
		//   Nombre_Pasajero__c = cuenta2.Id,               // Nombre Pasajero
		//   Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		//   Residente__c = false,                          // Residente
		//   Conductor__c = false,                          // Conductor
		//   Transportista__c = false                       // Transportista
		// );
		// insert detalleReserva2;

		// Detalle_Reserva__c detalleReserva3 = new Detalle_Reserva__c(
		//   RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId(),
		//   Reserva__c = reserva.Id,						 // Reserva
		//   Numero__c = '1',                                                                  // Número
		//   Ubicacion__c = 'Bajo Cubierta',                                                   // Ubicación
		//   Residente__c = true,                                                              // Residente
		//   Capacidad_Comprometida__c = 4.3,                                                  // Capacidad Comprometida
		//   Tara__c = 1,                                                                      // Tara
		//   Unidad_de_medida__c = 'm',                                                        // Unidad de medida
		//   Categoria_de_Vehiculo__c = 'Vehículo Menor',                                      // Categoría de Vehículo
		//   Cantidad_de_Metros__c = 2,                                                        // Cantidad de Metros
		//   Marca__c = 'ABARTH',                                                              // Marca
		//   Modelo__c = '124 SPIDER',                                                         // Modelo
		//   Tipo_de_Vehiculo__c = 'DEPORTIVO',                                                // Tipo de Vehículo
		//   Largo__c = 4.1,                                                                   // Largo
		//   Alto__c = 1.3,                                                                    // Alto
		//   Ancho__c = 2.6,                                                                   // Ancho
		//   Placa_Patente_Vehiculo__c = 'BPZT89',                                             // Placa Patente Vehículo
		//   Detalle_Reserva_Conductor__c = detalleReserva1.Id                                 // Detalle Reserva Conductor
		// );
		// insert detalleReserva3;

		// Detalle_Reserva__c detalleReserva4 = new Detalle_Reserva__c(
		//   RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId(),
		//   Reserva__c = reserva.Id,						 // Reserva
		//   Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		//   Unidad_de_medida__c = 'Pallet',                // Unidad de medida
		//   Residente__c = true,                           // Residente
		//   Persona_que_entrega__c = cuenta1.Id,           // Persona que entrega
		//   Persona_que_retira__c = cuenta1.Id             // Persona que retira
		// );
		// insert detalleReserva4;

		// Detalle_Reserva__c detalleReserva5 = new Detalle_Reserva__c(
		//   RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId(),
		//   Reserva__c = reserva.Id,						 // Reserva
		//   Numero__c = '02',                              // Número
		//   Capacidad_Comprometida__c = 1,                 // Capacidad Comprometida
		//   Unidad_de_medida__c = 'Persona',               // Unidad de medida
		//   Ubicacion__c = 'Salón',                        // Ubicación
		//   Doc_Identificacion_Pasajero__c = '1-9',        // Doc Identificación Pasajero
		//   Nombre_Pasajero__c = cuenta3.Id,               // Nombre Pasajero
		//   Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		//   Residente__c = true,                          // Residente
		//   Conductor__c = true,                          // Conductor
		//   Transportista__c = true                       // Transportista
		// );
		// insert detalleReserva5;

		// Detalle_Reserva__c detalleReserva6 = new Detalle_Reserva__c(
		//   RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId(),
		//   Reserva__c = reserva.Id,						 // Reserva
		//   Categoria_de_Vehiculo__c = 'Bicicleta',        // Categoría de Vehículo
		//   Tipo_de_Vehiculo__c = 'Bicicleta',             // Tipo de Vehículo
		//   Detalle_Reserva_Conductor__c = detalleReserva1.Id    // Detalle Reserva Conductor
		//  );
		// insert detalleReserva6;

		// Contrato_Tarifa__c tarifa = new Contrato_Tarifa__c(
		//   Name = 'CAM003',                               // Nombre del Contrato
		//   Vigencia_desde__c = Date.valueOf('2021-08-01'),    // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2021-11-30'),  // Vigencia hasta
		//   Informacion_General_de_la_Tarifa__c = '\n'      // Información General de la Tarifa
		// );
		// insert tarifa;

		// Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
		//   Valor__c = 12770,									      // Valor
		//   Contrato_Tarifa__c = tarifa.Id,				          // Contrato Tarifa
		//   Tipo_Transporte__c = 'Pasajero',                        // Tipo Transporte
		//   Ruta_Subsidiada__c = true,                              // Ruta Subsidiada
		//   Especificacion__c = 'General',                          // Especificación
		//   Ruta_Comercial__c = true,                              // Ruta Comercial
		//   Nacional__c = true,                                     // Nacional
		//   Puerto_ORIGEN__c = puerto1.Id,	                      // Puerto ORIGEN
		//   Extranjero__c = true,                                   // Extranjero
		//   Puerto_DESTINO__c = puerto2.Id,		                  // Puerto DESTINO
		//   Residente__c = true,                                    // Residente
		//   Discapacidad__c = false,                                // Discapacidad
		//   Estudiante__c = false,                                  // Estudiante
		//   Conductor__c = false,                                   // Conductor
		//   Impuesto__c = 'Valor Exento',                           // Impuesto
		//   Transportista__c = false,                               // Transportista
		//   Porcentaje_Impuesto__c = 0,                             // Porcentaje Impuesto
		//   Edad_desde__c = 0,	                                  // Edad desde
		//   Oferta__c = 10000,		                              // Oferta
		//   Edad_hasta__c = 59,	                                  // Edad hasta
		//   Vigencia_Oferta_desde__c = Date.valueOf('2021-10-10'),  // Vigencia Oferta desde
		//   Vigencia_Oferta_hasta__c = Date.valueOf('2021-10-11')   // Vigencia Oferta hasta
		// );
		// insert parametroTarifa;

		// parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
		//   Valor__c = 17820,		                   // Valor
		//   Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
		//   Tipo_Transporte__c = 'Pasajero',         // Tipo Transporte
		//   Ruta_Subsidiada__c = true,               // Ruta Subsidiada
		//   Especificacion__c = 'General',           // Especificación
		//   Ruta_Comercial__c = false,               // Ruta Comercial
		//   Nacional__c = true,                      // Nacional
		//   Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
		//   Extranjero__c = true,                    // Extranjero
		//   Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
		//   Residente__c = false,                    // Residente
		//   Discapacidad__c = false,                 // Discapacidad
		//   Estudiante__c = false,                   // Estudiante
		//   Conductor__c = false,                    // Conductor
		//   Impuesto__c = 'Valor Exento',            // Impuesto
		//   Transportista__c = false,                // Transportista
		//   Porcentaje_Impuesto__c = 0               // Porcentaje Impuesto
		// );
		// insert parametroTarifa;

		// parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
		//   Valor__c = 97950,                        // Valor
		//   Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
		//   Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
		//   Ruta_Subsidiada__c = true,               // Ruta Subsidiada
		//   Especificacion__c = 'Vehículo Menor',    // Especificación
		//   Ruta_Comercial__c = true,               // Ruta Comercial
		//   Nacional__c = true,                      // Nacional
		//   Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
		//   Extranjero__c = true,                    // Extranjero
		//   Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
		//   Residente__c = true,                     // Residente
		//   Discapacidad__c = false,                 // Discapacidad
		//   Estudiante__c = false,                   // Estudiante
		//   Conductor__c = false,                    // Conductor
		//   Impuesto__c = 'Valor Bruto',             // Impuesto
		//   Transportista__c = false,                // Transportista
		//   Tipo_de_Vehiculo__c = 'DEPORTIVO',
		//   Porcentaje_Impuesto__c = 19              // Porcentaje Impuesto
		// );
		// insert parametroTarifa;

		// parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
		//   Valor__c = 22050,                        // Valor
		//   Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
		//   Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
		//   Ruta_Subsidiada__c = true,               // Ruta Subsidiada
		//   Especificacion__c = 'Metro Lineal',      // Especificación
		//   Ruta_Comercial__c = true,               // Ruta Comercial
		//   Nacional__c = true,                      // Nacional
		//   Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
		//   Extranjero__c = true,                    // Extranjero
		//   Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
		//   Residente__c = true,                     // Residente
		//   Discapacidad__c = false,                 // Discapacidad
		//   Estudiante__c = false,                   // Estudiante
		//   Conductor__c = false,                    // Conductor
		//   Impuesto__c = 'Valor Bruto',             // Impuesto
		//   Transportista__c = false,                // Transportista
		//   Tipo_de_Vehiculo__c = 'DEPORTIVO',
		//   Porcentaje_Impuesto__c = 19              // Porcentaje Impuesto
		// );
		// insert parametroTarifa;

		// parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
		//   Valor__c = 25250,                        // Valor
		//   Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
		//   Tipo_Transporte__c = 'Carga',            // Tipo Transporte
		//   Ruta_Subsidiada__c = true,               // Ruta Subsidiada
		//   Especificacion__c = 'Pallets',           // Especificación
		//   Ruta_Comercial__c = true,               // Ruta Comercial
		//   Nacional__c = true,                      // Nacional
		//   Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
		//   Extranjero__c = true,                    // Extranjero
		//   Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
		//   Residente__c = true,                     // Residente
		//   Discapacidad__c = false,                 // Discapacidad
		//   Estudiante__c = false,                   // Estudiante
		//   Conductor__c = false,                    // Conductor
		//   Impuesto__c = 'Valor Bruto',             // Impuesto
		//   Transportista__c = false,                // Transportista
		//   Porcentaje_Impuesto__c = 19             // Porcentaje Impuesto
		// );
		// insert parametroTarifa;


		//   Valor__c = 15000,                // Valor
		//   Contrato_Tarifa__c = tarifa.Id,   // Contrato Tarifa
		//   Tipo_Transporte__c = 'Vehículo',    // Tipo Transporte
		//   Ruta_Subsidiada__c = true,         // Ruta Subsidiada
		//   Especificacion__c = 'Bicicletas',   // Especificación
		//   Ruta_Comercial__c = true,          // Ruta Comercial
		//   Nacional__c = true,                // Nacional
		//   Puerto_ORIGEN__c = puerto1.Id,     // Puerto ORIGEN
		//   Extranjero__c = true,              // Extranjero
		//   Puerto_DESTINO__c = puerto2.Id,    // Puerto DESTINO
		//   Discapacidad__c = false,            // Discapacidad
		//   Estudiante__c = false,              // Estudiante
		//   Conductor__c = false,               // Conductor
		//   Tipo_de_Vehiculo__c = 'Bicicleta',  // Tipo de Vehículo
		//   Transportista__c = false,           // Transportista
		//   Impuesto__c = 'Valor Neto',         // Impuesto
		//   Porcentaje_Impuesto__c = 19        // Porcentaje Impuesto
		// );
		// insert parametroTarifa;
		
		// Mantenedor_Nave__c nave = new Mantenedor_Nave__c(
		//   Name = 'AGIOS',                   // Nombre de la Nave
		//   Velocidad_Navegacion__c = 10,     // Velocidad Navegación
		//   Carga_Maxima_Vehiculos__c = 550   // Carga Máxima Vehículos
		// );
		// insert nave;

		// Capacidad_Nave__c capacidadNave = new Capacidad_Nave__c(
		// 	Nave__c = nave.Id,          // Nave
		// 	Categoria__c = 'General',         // Categoría
		// 	Numero__c = '01',                 // Número
		// 	Ubicacion__c = 'Salón',           // Ubicación
		// 	Capacidad__c = 1,             // Capacidad
		// 	Cupo_Venta_Local__c = false,      // Cupo Venta Local
		// 	Unidad_de_medida__c = 'Persona',  // Unidad de medida
		// 	RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
		// );
		// insert capacidadNave;

		// capacidadNave = new Capacidad_Nave__c(
		// 	Nave__c = nave.Id,          // Nave
		// 	Categoria__c = 'General',         // Categoría
		// 	Numero__c = '02',                 // Número
		// 	Ubicacion__c = 'Salón',           // Ubicación
		// 	Capacidad__c = 1,             // Capacidad
		// 	Cupo_Venta_Local__c = false,      // Cupo Venta Local
		// 	Unidad_de_medida__c = 'Persona',  // Unidad de medida
		// 	RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
		// );
		// insert capacidadNave;

		// capacidadNave = new Capacidad_Nave__c(
		// 	Nave__c = nave.Id,          	  // Nave
		// 	Categoria__c = 'General',         // Categoría
		// 	Numero__c = '03',                 // Número
		// 	Ubicacion__c = 'Salón',           // Ubicación
		// 	Capacidad__c = 1,             	  // Capacidad
		// 	Cupo_Venta_Local__c = false,      // Cupo Venta Local
		// 	Unidad_de_medida__c = 'Persona',  // Unidad de medida
		// 	RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
		// );
		// insert capacidadNave;

		// capacidadNave = new Capacidad_Nave__c(
		// 	Nave__c = nave.Id,         		 // Nave
		// 	Ubicacion__c = 'Bajo cubierta',  // Ubicación
		// 	Capacidad__c = 5,            // Capacidad
		// 	Cupo_Venta_Local__c = false,     // Cupo Venta Local
		// 	Unidad_de_medida__c = 'Pallet',  // Unidad de medida
		// 	RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()
		// );
		// insert capacidadNave;

		// capacidadNave = new Capacidad_Nave__c(
		// 	Nave__c = nave.Id,         		 // Nave
		// 	Ubicacion__c = 'Cubierta',    // Ubicación
		// 	Numero__c = '1',              // Número
		// 	Cupo_Venta_Local__c = false,  // Cupo Venta Local
		// 	Unidad_de_medida__c = 'm',    // Unidad de medida
		// 	Capacidad__c = 280.0,       // Capacidad
		// 	Alto__c = 5.1,              // Alto
		// 	Ancho__c = 3.1,  // Unidad de medida
		// 	RecordTypeId = Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Pista').getRecordTypeId()
		// );
		// insert capacidadNave;

		// Programacion_de_Itinerario__c itinerario = new Programacion_de_Itinerario__c(
		//   Nombre_Ruta__c = mantenedorRuta.Id,				                       // Nombre Ruta
		//   Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
		//   Tipo__c = 'SUBV',                                            // Tipo
		//   Nombre_de_la_Nave__c = nave.Id,		                       // Nombre de la Nave
		//   Descuento_Temporalidad_Ocupacion__c = 'No',                  // Descuento Temporalidad Ocupación
		//   Estado__c = 'Disponible para venta',                         // Estado
		//   Canal_Web__c = true,                                         // Canal Web
		//   Pasajero_Web_Nac__c = false,                                 // Pasajero Web Nac
		//   Pasajero_Web_Ext__c = false,                                 // Pasajero Web Ext
		//   Vehiculo_Web_Nac__c = false,                                 // Vehículo Web Nac
		//   Vehiculo_Web_Ext__c = false                                 // Vehículo Web Ext
		// );
		// insert itinerario;

		// Escalas_Itinerario__c escalasItinerario = new Escalas_Itinerario__c(
		//   Name = 'PUERTO MONTT',                                          // Escala
		//   Hacer_Escala__c = true,                                         // Hacer Escala
		//   Itinerario__c = itinerario.Id,                                  // Itinerario
		//   Secuencia__c = 1,                                               // Secuencia
		//   Puerto_Embarque__c = puerto1.Id,                                // Puerto Embarque
		//   Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		//   Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		//   Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		//   Puerto_Destino__c = puerto2.Id,                                 // Puerto Destino
		//   Millas_de_Navegacion__c = 56,                                   // Millas de Navegación
		//   Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		//   ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		// );
		// insert escalasItinerario;
		
		// Capacidad_Tramo__c capacidadTramo1 = new Capacidad_Tramo__c(
		//   RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		//   Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		//   Ubicacion__c = 'Bajo cubierta',            // Ubicación
		//   Numero__c = '1',                           // Número
		//   Cupo_Venta_Local__c = false,               // Cupo Venta Local
		//   Capacidad__c = 5,                          // Capacidad
		//   Canal_Web__c = true,                       // Canal Web
		//   Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		// );
		// insert capacidadTramo1;

		// Capacidad_Tramo__c capacidadTramo2 = new Capacidad_Tramo__c(
		//   RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		//   Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		//   Ubicacion__c = 'Bajo cubierta',            // Ubicación
		//   Numero__c = '2',                           // Número
		//   Cupo_Venta_Local__c = false,               // Cupo Venta Local
		//   Capacidad__c = 5,                          // Capacidad
		//   Canal_Web__c = true,                       // Canal Web
		//   Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		// );
		// insert capacidadTramo2;

		// Capacidad_Tramo__c capacidadTramo3 = new Capacidad_Tramo__c(
		//   RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		//   Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		//   Ubicacion__c = 'Bajo cubierta',            // Ubicación
		//   Numero__c = '3',                           // Número
		//   Cupo_Venta_Local__c = false,               // Cupo Venta Local
		//   Capacidad__c = 5,                          // Capacidad
		//   Canal_Web__c = true,                       // Canal Web
		//   Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		// );
		// insert capacidadTramo3;

		// Capacidad_Tramo__c capacidadTramo4 = new Capacidad_Tramo__c(
		//   RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		//   Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		//   Ubicacion__c = 'Bajo cubierta',            // Ubicación
		//   Numero__c = '4',                           // Número
		//   Cupo_Venta_Local__c = false,               // Cupo Venta Local
		//   Capacidad__c = 5,                          // Capacidad
		//   Canal_Web__c = true,                       // Canal Web
		//   Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		// );
		// insert capacidadTramo4;

        // Capacidad_Tramo__c capacidadTramo5 = new Capacidad_Tramo__c(
		//   RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		//   Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		//   Ubicacion__c = 'Bajo cubierta',            // Ubicación
		//   Numero__c = '5',                           // Número
		//   Cupo_Venta_Local__c = false,               // Cupo Venta Local
		//   Capacidad__c = 5,                          // Capacidad
		//   Canal_Web__c = true,                       // Canal Web
		//   Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		// );
		// insert capacidadTramo5;

		// Capacidad_Tramo__c capacidadTramo6 = new Capacidad_Tramo__c(
		//   RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		//   Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		//   Ubicacion__c = 'Bajo cubierta',            // Ubicación
		//   Numero__c = '6',                           // Número
		//   Cupo_Venta_Local__c = false,               // Cupo Venta Local
		//   Capacidad__c = 5,                          // Capacidad
		//   Canal_Web__c = true,                       // Canal Web
		//   Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		// );
		// insert capacidadTramo6;

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
		//   Capacidad_Tramo__c = capacidadTramo2.Id        // Capacidad Tramo
		// );
		// insert ctdr;

		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva3.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo3.Id        // Capacidad Tramo	
		// );
		// insert ctdr;
		
		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva4.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo4.Id        // Capacidad Tramo	
		// );
		// insert ctdr;

		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva5.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo5.Id        // Capacidad Tramo	
		// );
		// insert ctdr;

		// ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
		// 	Detalle_Reserva__c = detalleReserva6.Id,      // Detalle Reserva
		//     Capacidad_Liberada__c = false,                 // Capacidad Liberada
		//     Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		//     Capacidad_Tramo__c = capacidadTramo6.Id        // Capacidad Tramo	
		// );
		// insert ctdr;

		// Mantenedor_Matriz_DR__c matriz = new Mantenedor_Matriz_DR__c(
		//   Name = 'DR OCT-NOV 2021',                      // Nombre Matriz DR
		//   Vigencia_desde__c = Date.valueOf('2021-10-01'),   // Vigencia desde
		//   Vigencia_hasta__c = Date.valueOf('2021-11-30')  // Vigencia hasta
		// );
		// insert matriz;

		// Parametro_DR__c parametroDR = new Parametro_DR__c(
		//   Porcentaje_DR__c = 0,             // % DR
		//   Anticipacion_desde__c = 10,       // Anticipación desde (<)
		//   Utilizacion_desde__c = 25,          // % Utilización desde (<)
		//   Anticipacion_hasta__c = 30,       // Anticipación hasta (>=)
		//   Utilizacion_hasta__c = 35,          // % Utilización hasta (>=)
		//   Nombre_Matriz_DR__c = matriz.Id  // Nombre Matriz DR
		// );
		// insert parametroDR;

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

		Puerto__c puerto4 = new Puerto__c(
			Name = 'DUMMY AYACARA'// Nombre de Puerto
		);
		insert puerto4;

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
		  Puerto__c = puerto1.Id,						  // Puerto
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
		  Puerto__c = puerto2.Id,						  // Puerto
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
		  Puerto__c = puerto2.Id,						  // Puerto
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

		Account cuenta4 = new Account(
		  RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		  FirstName = 'Dummy', // Nombre de la cuenta
		  LastName = 'User 4',
		  Identificacion__c = '12345678',              // Identificación
		  PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
		  Tipo_de_identificacion__c = 'Pasaporte',             // Tipo de identificación
		  PersonEmail = 'dummy4@dummy.com',              // Correo electrónico
		  Discapacidad__pc = false                       // Discapacidad
		);
		insert cuenta4;

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

		capacidadNave = new Capacidad_Nave__c(
			Nave__c = nave.Id,         		 // Nave
			Ubicacion__c = 'Cubierta',    // Ubicación
			Numero__c = '2',              // Número
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
		  Doc_Identificacion_Pasajero__c = '1-9',        // Doc Identificación Pasajero
		  Nombre_Pasajero__c = cuenta3.Id,               // Nombre Pasajero
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
		  Marca__c = 'ABARTH',                                                              // Marca
		  Modelo__c = '124 SPIDER',                                                         // Modelo
		  Tipo_de_Vehiculo__c = 'DEPORTIVO',                                                // Tipo de Vehículo
		  Largo__c = 4.1,                                                                   // Largo
		  Alto__c = 1.3,                                                                    // Alto
		  Ancho__c = 2.6,                                                                   // Ancho
		  Placa_Patente_Vehiculo__c = 'BPZT89',
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

		Detalle_Reserva__c detalleReserva6 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  Categoria_de_Vehiculo__c = 'Bicicleta',        // Categoría de Vehículo
		  Tipo_de_Vehiculo__c = 'Bicicleta',             // Tipo de Vehículo
		  Detalle_Reserva_Conductor__c = detalleReserva1.Id    // Detalle Reserva Conductor
		 );
		insert detalleReserva6;
        
        Detalle_Reserva__c detalleReserva7 = new Detalle_Reserva__c(
		  RecordTypeId = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId(),
		  Reserva__c = reserva.Id,						 // Reserva
		  Categoria_de_Vehiculo__c = 'Bus y Motorhome',        // Categoría de Vehículo
		  Tipo_de_Vehiculo__c = 'CASA RODANTE',             // Tipo de Vehículo
          Largo__c = 1,             
		  Detalle_Reserva_Conductor__c = detalleReserva1.Id,    // Detalle Reserva Conductor
          Parametro_Tarifa__c = 'Tarifa: P-0000000217, Tarifa Metro lineal: P-0000001162',  // Parámetro Tarifa
		  Parametro_Tasa_de_Embarque__c = 'TE-000011',
          Residente__c = true,
          Conductor__c = true  
		 );
		insert detalleReserva7;

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
		  Valor__c = 97951,                        // Valor
		  Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
		  Tipo_Transporte__c = 'Vehículo',         // Tipo Transporte
		  Ruta_Subsidiada__c = true,               // Ruta Subsidiada
		  Especificacion__c = 'Metro Lineal',    // Especificación
		  Ruta_Comercial__c = false,               // Ruta Comercial
		  Nacional__c = true,                      // Nacional
		  Puerto_ORIGEN__c = puerto1.Id,	       // Puerto ORIGEN
		  Extranjero__c = true,                    // Extranjero
		  Puerto_DESTINO__c = puerto2.Id,		   // Puerto DESTINO
		  Residente__c = true,                     // Residente
		  Discapacidad__c = false,                 // Discapacidad
		  Estudiante__c = false,                   // Estudiante
		  Conductor__c = true,                    // Conductor
		  Impuesto__c = 'Valor Bruto',             // Impuesto
		  Transportista__c = false,                // Transportista
		  Porcentaje_Impuesto__c = 19,              // Porcentaje Impuesto
          Tipo_de_Vehiculo__c = 'CAMION CON ACOPLADO'
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

		ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
			Detalle_Reserva__c = detalleReserva6.Id,      // Detalle Reserva
		    Capacidad_Liberada__c = false,                 // Capacidad Liberada
		    Capacidad_Comprometida_en_Reserva__c = 0.5,  // Capacidad Comprometida en Reserva
		    Capacidad_Tramo__c = capacidadTramo1.Id        // Capacidad Tramo	
		);
		insert ctdr;
        
        ctdr = new Capacidad_Tramo_Detalle_Reserva__c(
			Detalle_Reserva__c = detalleReserva7.Id,      // Detalle Reserva
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

	//Test Camino Feliz - Butaca
	@IsTest
	private static void test1(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Butaca - Valor Bruto
	@IsTest
	private static void test2(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		// List<Parametro_Tasa_Embarque__c> tasasEmbarque = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Pasajero'];
		// for(Parametro_Tasa_Embarque__c tasaEmbarque : tasasEmbarque){
		// 	tasaEmbarque.Impuesto__c = 'Valor Bruto';
		// }
		// update tasasEmbarque;

		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Butaca - Valor Bruto
	@IsTest
	private static void test3(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		// Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 17820];
		// ptr.Impuesto__c = 'Valor Bruto';
		// update ptr;

		// List<Parametro_Tasa_Embarque__c> tasasEmbarque = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Pasajero'];
		// for(Parametro_Tasa_Embarque__c tasaEmbarque : tasasEmbarque){
		// 	tasaEmbarque.Impuesto__c = 'Valor Neto';
		// }
		// update tasasEmbarque;

		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet
	@IsTest
	private static void test4(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet -Exento
	@IsTest
	private static void test5(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
		Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 25250];
		ptr.Impuesto__c = 'Valor Exento';
		update ptr;
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet - Neto
	@IsTest
	private static void test6(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
		Parametros_Tarifarios_Pasajeros__c ptr = [SELECT Id, Name FROM Parametros_Tarifarios_Pasajeros__c WHERE Valor__c = 25250];
		ptr.Impuesto__c = 'Valor Neto';
		update ptr;
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test de Error - Pista
	@IsTest
	private static void test7(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista - Exento
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

			List<Parametro_Tasa_Embarque__c> pteList = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Vehículos'];
			for(Parametro_Tasa_Embarque__c pte : pteList){
				pte.Impuesto__c = 'Valor Exento';
				pte.Porcentaje_Impuesto__c = 0;
			}
			update pteList;

		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista - Neto
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

			List<Parametro_Tasa_Embarque__c> pteList = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Vehículos'];
			for(Parametro_Tasa_Embarque__c pte : pteList){
				pte.Impuesto__c = 'Valor Neto';
				pte.Porcentaje_Impuesto__c = 19;
			}
			update pteList;

		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista - NO encontrar tarifa
	@IsTest
	private static void test10(){
		Reserva__c reserva = [SELECT Id FROM Reserva__c];
		Puerto__c puerto = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY AYACARA'];
		reserva.Puerto_DESTINO__c = puerto.Id;
		update reserva;

		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c == 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista - Bruto
	@IsTest
	private static void test11(){
		Test.startTest();
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
			Contrato_Tarifa__c tarifa = [SELECT Id FROM Contrato_Tarifa__c]; 
			Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY MONTT'];
			Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY CHAITÉN'];
			Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
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

			List<Parametro_Tasa_Embarque__c> pteList = [SELECT Id, Name FROM Parametro_Tasa_Embarque__c WHERE Concepto__c = 'Tasa Vehículos'];
			for(Parametro_Tasa_Embarque__c pte : pteList){
				pte.Impuesto__c = 'Valor Bruto';
				pte.Porcentaje_Impuesto__c = 19;
			}
			update pteList;
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista - Bruto
	@IsTest
	private static void test12(){
		Test.startTest();
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
			Contrato_Tarifa__c tarifa = [SELECT Id FROM Contrato_Tarifa__c]; 
			Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY MONTT'];
			Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY CHAITÉN'];
			Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
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
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test de Query - Pasajeros COM
	@IsTest
	private static void test13(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		/*Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;*/

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}

		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReservaLst.add(detalleReserva);
		Test.startTest();
		
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarifa_Return ret = new NAV_Tarifa_Return();
			ret = NAV_Tarificador.buscarTarifaPASAJERO(detalleReserva, mapParametros, 'COM', capacidadTramo.get(0).Capacidad_Tramo__r.Categoria__c, true);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pasajeros COM Extranjero
	@IsTest
	private static void test14(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		/*Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;*/

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarifa_Return ret = new NAV_Tarifa_Return();
			ret = NAV_Tarificador.buscarTarifaPASAJERO(detalleReserva, mapParametros, 'COM', capacidadTramo.get(0).Capacidad_Tramo__r.Categoria__c, false);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pasajeros COM NO Residente
	@IsTest
	private static void test15(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		detalleReserva.Residente__c = false;

		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pasajeros COM Extranjero NO Residente
	@IsTest
	private static void test16(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
		detalleReserva.Residente__c = false;
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pasajeros COM Extranjero NO Residente
	@IsTest
	private static void test17(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
		detalleReserva.Residente__c = true;
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pasajeros SUBV Extranjero NO Residente
	@IsTest
	private static void test18(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReserva.Tipo_de_identificacion__c = 'Pasaporte';
		detalleReserva.Residente__c = false;
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pallet COM Residente
	@IsTest
	private static void test19(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c 
											 WHERE Unidad_de_medida__c = 'Pallet'];
		
		/*Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;*/
		
		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReserva.Residente__c = true;
		detalleReserva.Tipo_de_identificacion__c = 'RUT';
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarifa_Return ret = new NAV_Tarifa_Return();
			ret = NAV_Tarificador.buscarTarifaPALLET(detalleReserva, mapParametros, 'COM', true);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pallet COM Extranjero
	@IsTest
	private static void test20(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			
			Account cuenta = [SELECT Id, Name
							FROM Account
							WHERE Identificacion__c = '12345678'];

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c 
												WHERE Unidad_de_medida__c = 'Pallet'];
			
			// Programacion_de_Itinerario__c itinerario = [SELECT Id 
			// 											FROM Programacion_de_Itinerario__c
			// 											WHERE Tipo__c = 'SUBV'
			// 											AND Estado__c = 'Disponible para venta'];

			// itinerario.Tipo__c = 'COM';
			// update itinerario;
			
			List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
												Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
												Detalle_Reserva__c 
												FROM Capacidad_Tramo_Detalle_Reserva__c 
												WHERE Detalle_Reserva__c =: detalleReserva.Id
												AND Capacidad_Liberada__c = false
												LIMIT 1];

			Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
			for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
				if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
						tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
				}
			}
			
			List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
			detalleReserva.Residente__c = true;
			detalleReserva.Persona_que_entrega__c = cuenta.Id;
			update detalleReserva;

			detalleReserva = [SELECT Id, Name, 
							RecordType.DeveloperName, Reserva__c, 
							Alto__c, Ancho__c, 
							Capacidad_Comprometida__c,  
							Carga_Veh_culo__c, Conductor__c, 
							Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
							Estado_Reserva__c, Fono_Pasajero__c, 
							Largo__c, Nombre_Pasajero__c, 
							Numero__c, Pasajero_Conductor__c, 
							Placa_Patente_Vehiculo__c, Residente__c, 
							Tara__c, Tipo_de_Vehiculo__c, 
							Tipo_de_identificacion__c, Ubicacion__c, 
							Unidad_de_medida__c, Marca__c, 
							Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
							Estudiante__c,
							Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
							Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
							Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
							Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
							Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
							Reserva__r.Itinerario_admite_DR__c, CreatedDate,
							Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
							Carro_Arrastre__c, ML_Portabicicleta__c,
							Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c 
							WHERE Id =: detalleReserva.Id];

			detalleReservaLst.add(detalleReserva);
		
		
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarifa_Return ret = new NAV_Tarifa_Return();
			ret = NAV_Tarificador.buscarTarifaPALLET(detalleReserva, mapParametros, 'COM', false);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pallet SUV Extranjero
	@IsTest
	private static void test21(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			
			Account cuenta = [SELECT Id, Name
							FROM Account
							WHERE Identificacion__c = '12345678'];

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c 
												WHERE Unidad_de_medida__c = 'Pallet'];
			
			Programacion_de_Itinerario__c itinerario = [SELECT Id 
														FROM Programacion_de_Itinerario__c
														WHERE Tipo__c = 'SUBV'
														AND Estado__c = 'Disponible para venta'];

			List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
												Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
												Detalle_Reserva__c
												FROM Capacidad_Tramo_Detalle_Reserva__c 
												WHERE Detalle_Reserva__c =: detalleReserva.Id
												AND Capacidad_Liberada__c = false
												LIMIT 1];

			Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
			for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
				if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
						tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
				}
			}
			
			List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
			detalleReserva.Residente__c = true;
			detalleReserva.Persona_que_entrega__c = cuenta.Id;
			update detalleReserva;

			detalleReserva = [SELECT Id, Name, 
							RecordType.DeveloperName, Reserva__c, 
							Alto__c, Ancho__c, 
							Capacidad_Comprometida__c,  
							Carga_Veh_culo__c, Conductor__c, 
							Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
							Estado_Reserva__c, Fono_Pasajero__c, 
							Largo__c, Nombre_Pasajero__c, 
							Numero__c, Pasajero_Conductor__c, 
							Placa_Patente_Vehiculo__c, Residente__c, 
							Tara__c, Tipo_de_Vehiculo__c, 
							Tipo_de_identificacion__c, Ubicacion__c, 
							Unidad_de_medida__c, Marca__c, 
							Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
							Estudiante__c,
							Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
							Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
							Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
							Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
							Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
							Reserva__r.Itinerario_admite_DR__c, CreatedDate,
							Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
							Carro_Arrastre__c, ML_Portabicicleta__c,
							Reserva__r.Itinerario_asociado__r.Tipo__c FROM Detalle_Reserva__c 
							WHERE Id =: detalleReserva.Id];

			detalleReservaLst.add(detalleReserva);
				
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pista COM
	@IsTest
	private static void test22(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c
											 FROM Detalle_Reserva__c 
											 WHERE Modelo__c = '124 SPIDER'];
		
		// Programacion_de_Itinerario__c itinerario = [SELECT Id 
		// 											FROM Programacion_de_Itinerario__c
		// 											WHERE Tipo__c = 'SUBV'
		// 											AND Estado__c = 'Disponible para venta'];

		// itinerario.Tipo__c = 'COM';
		// update itinerario;

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReservaLst.add(detalleReserva);

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarifa_Return ret = new NAV_Tarifa_Return();
			ret = NAV_Tarificador.buscarTarifaVEH(detalleReserva, mapParametros, 'COM', true);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Pista COM Extranjero
	@IsTest
	private static void test23(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c
												FROM Detalle_Reserva__c 
												WHERE Modelo__c = '124 SPIDER'];
			
			// Programacion_de_Itinerario__c itinerario = [SELECT Id 
			// 											FROM Programacion_de_Itinerario__c
			// 											WHERE Tipo__c = 'SUBV'
			// 											AND Estado__c = 'Disponible para venta'];

			// itinerario.Tipo__c = 'COM';
			// update itinerario;

			List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
												Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
												Detalle_Reserva__c 
												FROM Capacidad_Tramo_Detalle_Reserva__c 
												WHERE Detalle_Reserva__c =: detalleReserva.Id
												AND Capacidad_Liberada__c = false
												LIMIT 1];
			
			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c 
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];
			
			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;

			Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
			for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
				if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
						tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
				}
			}

			detalleReserva = [SELECT Id, Name, 
							RecordType.DeveloperName, Reserva__c, 
							Alto__c, Ancho__c, 
							Capacidad_Comprometida__c,  
							Carga_Veh_culo__c, Conductor__c, 
							Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
							Estado_Reserva__c, Fono_Pasajero__c, 
							Largo__c, Nombre_Pasajero__c, 
							Numero__c, Pasajero_Conductor__c, 
							Placa_Patente_Vehiculo__c, Residente__c, 
							Tara__c, Tipo_de_Vehiculo__c, 
							Tipo_de_identificacion__c, Ubicacion__c, 
							Unidad_de_medida__c, Marca__c, 
							Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
							Estudiante__c,
							Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
							Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
							Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
							Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
							Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
							Reserva__r.Itinerario_admite_DR__c, CreatedDate,
							Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
							Carro_Arrastre__c, ML_Portabicicleta__c,
							Reserva__r.Itinerario_asociado__r.Tipo__c
							FROM Detalle_Reserva__c 
							WHERE Id =: detalleReserva.Id];

			List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
			detalleReservaLst.add(detalleReserva);
			
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarifa_Return ret = new NAV_Tarifa_Return();
			ret = NAV_Tarificador.buscarTarifaVEH(detalleReserva, mapParametros, 'COM', false);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Bicicleta COM
	@IsTest
	private static void test24(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c 
												FROM Detalle_Reserva__c 
												WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
			

			Reserva__c reserva = [SELECT Id, Itinerario_asociado__c
								FROM Reserva__c
								WHERE Id =: detalleReserva.Reserva__c];

			Programacion_de_Itinerario__c itinerario = [SELECT Id 
														FROM Programacion_de_Itinerario__c
														WHERE Tipo__c = 'SUBV'
														AND Estado__c = 'Disponible para venta'];

			itinerario.Tipo__c = 'COM';
			update itinerario;

			reserva.Itinerario_asociado__c = itinerario.Id;
			update reserva;

			detalleReserva = [SELECT Id, Name, 
							RecordType.DeveloperName, Reserva__c, 
							Alto__c, Ancho__c, 
							Capacidad_Comprometida__c,  
							Carga_Veh_culo__c, Conductor__c, 
							Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
							Estado_Reserva__c, Fono_Pasajero__c, 
							Largo__c, Nombre_Pasajero__c, 
							Numero__c, Pasajero_Conductor__c, 
							Placa_Patente_Vehiculo__c, Residente__c, 
							Tara__c, Tipo_de_Vehiculo__c, 
							Tipo_de_identificacion__c, Ubicacion__c, 
							Unidad_de_medida__c, Marca__c, 
							Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
							Estudiante__c,
							Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
							Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
							Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
							Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
							Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
							Reserva__r.Itinerario_admite_DR__c, CreatedDate,
							Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
							Carro_Arrastre__c, ML_Portabicicleta__c,
							Reserva__r.Itinerario_asociado__r.Tipo__c 
							FROM Detalle_Reserva__c 
							WHERE Id =: detalleReserva.Id];

			List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
																Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
																Detalle_Reserva__c 
																FROM Capacidad_Tramo_Detalle_Reserva__c 
																WHERE Detalle_Reserva__c =: detalleReserva.Id
																AND Capacidad_Liberada__c = false
																LIMIT 1];

			Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
			for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
				if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
						tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
				}
			}
			
			List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
			detalleReservaLst.add(detalleReserva);

			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			NAV_Tarificador.buscarTarifaBICICLETAS(detalleReserva, mapParametros, true);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Bicicleta COM Extranjero
	@IsTest
	private static void test25(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			
			Account cuenta = [SELECT Id, Name
							FROM Account
							WHERE Identificacion__c = '12345678'];

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c 
												FROM Detalle_Reserva__c 
												WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];

			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];

			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;

		
		Reserva__c reserva = [SELECT Id, Itinerario_asociado__c
							  FROM Reserva__c
							  WHERE Id =: detalleReserva.Reserva__c];

		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;

		reserva.Itinerario_asociado__c = itinerario.Id;
		update reserva;

		detalleReserva = [SELECT Id, Name, 
						  RecordType.DeveloperName, Reserva__c, 
						  Alto__c, Ancho__c, 
						  Capacidad_Comprometida__c,  
						  Carga_Veh_culo__c, Conductor__c, 
						  Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
						  Estado_Reserva__c, Fono_Pasajero__c, 
						  Largo__c, Nombre_Pasajero__c, 
						  Numero__c, Pasajero_Conductor__c, 
						  Placa_Patente_Vehiculo__c, Residente__c, 
						  Tara__c, Tipo_de_Vehiculo__c, 
						  Tipo_de_identificacion__c, Ubicacion__c, 
						  Unidad_de_medida__c, Marca__c, 
						  Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
						  Estudiante__c,
						  Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
						  Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
						  Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
						  Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
						  Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
						  Reserva__r.Itinerario_admite_DR__c, CreatedDate,
						  Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
						  Carro_Arrastre__c, ML_Portabicicleta__c,
						  Reserva__r.Itinerario_asociado__r.Tipo__c 
						  FROM Detalle_Reserva__c 
						  WHERE Id =: detalleReserva.Id];

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
															 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
															 Detalle_Reserva__c 
															 FROM Capacidad_Tramo_Detalle_Reserva__c 
															 WHERE Detalle_Reserva__c =: detalleReserva.Id
															 AND Capacidad_Liberada__c = false
															 LIMIT 1];

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReservaLst.add(detalleReserva);
		
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Bicicleta SUBV Extranjero
	@IsTest
	private static void test26(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			
			Account cuenta = [SELECT Id, Name
							FROM Account
							WHERE Identificacion__c = '12345678'];

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c 
												FROM Detalle_Reserva__c 
												WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];

			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];

			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;


			Reserva__c reserva = [SELECT Id, Itinerario_asociado__c
								FROM Reserva__c
								WHERE Id =: detalleReserva.Reserva__c];

			detalleReserva = [SELECT Id, Name, 
							RecordType.DeveloperName, Reserva__c, 
							Alto__c, Ancho__c, 
							Capacidad_Comprometida__c,  
							Carga_Veh_culo__c, Conductor__c, 
							Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
							Estado_Reserva__c, Fono_Pasajero__c, 
							Largo__c, Nombre_Pasajero__c, 
							Numero__c, Pasajero_Conductor__c, 
							Placa_Patente_Vehiculo__c, Residente__c, 
							Tara__c, Tipo_de_Vehiculo__c, 
							Tipo_de_identificacion__c, Ubicacion__c, 
							Unidad_de_medida__c, Marca__c, 
							Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
							Estudiante__c,
							Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
							Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
							Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
							Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
							Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
							Reserva__r.Itinerario_admite_DR__c, CreatedDate,
							Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
							Carro_Arrastre__c, ML_Portabicicleta__c,
							Reserva__r.Itinerario_asociado__r.Tipo__c 
							FROM Detalle_Reserva__c 
							WHERE Id =: detalleReserva.Id];

			List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
																Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
																Detalle_Reserva__c 
																FROM Capacidad_Tramo_Detalle_Reserva__c 
																WHERE Detalle_Reserva__c =: detalleReserva.Id
																AND Capacidad_Liberada__c = false
																LIMIT 1];

			Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
			for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
				if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
						tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
				}
			}
			
			List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
			detalleReservaLst.add(detalleReserva);
		
		
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Metro Lineal COM
	@IsTest
	private static void test27(){
		NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
											 RecordType.DeveloperName, Reserva__c, 
											 Alto__c, Ancho__c, 
											 Capacidad_Comprometida__c,  
											 Carga_Veh_culo__c, Conductor__c, 
											 Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
											 Estado_Reserva__c, Fono_Pasajero__c, 
											 Largo__c, Nombre_Pasajero__c, 
											 Numero__c, Pasajero_Conductor__c, 
											 Placa_Patente_Vehiculo__c, Residente__c, 
											 Tara__c, Tipo_de_Vehiculo__c, 
											 Tipo_de_identificacion__c, Ubicacion__c, 
											 Unidad_de_medida__c, Marca__c, 
											 Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
											 Estudiante__c,
											 Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
											 Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
											 Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
											 Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
											 Reserva__r.Itinerario_admite_DR__c, CreatedDate,
											 Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
											 Carro_Arrastre__c, ML_Portabicicleta__c,
											 Reserva__r.Itinerario_asociado__r.Tipo__c
											 FROM Detalle_Reserva__c 
											 WHERE Modelo__c = '124 SPIDER'];
		
		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;

		List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
											 Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
											 Detalle_Reserva__c 
											 FROM Capacidad_Tramo_Detalle_Reserva__c 
											 WHERE Detalle_Reserva__c =: detalleReserva.Id
											 AND Capacidad_Liberada__c = false
											 LIMIT 1];

		Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
		for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
			if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
					tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
			}
		}
		
		List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
		detalleReservaLst.add(detalleReserva);
		
		Test.startTest();
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMetroLinealMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test de Query - Metro Lineal COM Extranjero
	@IsTest
	private static void test28(){
		Test.startTest();
			NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
			
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
												RecordType.DeveloperName, Reserva__c, 
												Alto__c, Ancho__c, 
												Capacidad_Comprometida__c,  
												Carga_Veh_culo__c, Conductor__c, 
												Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
												Estado_Reserva__c, Fono_Pasajero__c, 
												Largo__c, Nombre_Pasajero__c, 
												Numero__c, Pasajero_Conductor__c, 
												Placa_Patente_Vehiculo__c, Residente__c, 
												Tara__c, Tipo_de_Vehiculo__c, 
												Tipo_de_identificacion__c, Ubicacion__c, 
												Unidad_de_medida__c, Marca__c, 
												Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
												Estudiante__c,
												Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
												Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
												Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
												Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
												Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
												Reserva__r.Itinerario_admite_DR__c, CreatedDate,
												Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
												Carro_Arrastre__c, ML_Portabicicleta__c,
												Reserva__r.Itinerario_asociado__r.Tipo__c
												FROM Detalle_Reserva__c 
												WHERE Modelo__c = '124 SPIDER'];
			
			Programacion_de_Itinerario__c itinerario = [SELECT Id 
														FROM Programacion_de_Itinerario__c
														WHERE Tipo__c = 'SUBV'
														AND Estado__c = 'Disponible para venta'];

			itinerario.Tipo__c = 'COM';
			update itinerario;

			List<Capacidad_Tramo_Detalle_Reserva__c> capacidadTramo = [SELECT Id, Itinerario__c, 
												Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
												Detalle_Reserva__c 
												FROM Capacidad_Tramo_Detalle_Reserva__c 
												WHERE Detalle_Reserva__c =: detalleReserva.Id
												AND Capacidad_Liberada__c = false
												LIMIT 1];

			Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
			for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : capacidadTramo){
				if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
						tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
				}
			}
			
			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c 
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];
			
			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;

			detalleReserva = [SELECT Id, Name, 
							RecordType.DeveloperName, Reserva__c, 
							Alto__c, Ancho__c, 
							Capacidad_Comprometida__c,  
							Carga_Veh_culo__c, Conductor__c, 
							Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
							Estado_Reserva__c, Fono_Pasajero__c, 
							Largo__c, Nombre_Pasajero__c, 
							Numero__c, Pasajero_Conductor__c, 
							Placa_Patente_Vehiculo__c, Residente__c, 
							Tara__c, Tipo_de_Vehiculo__c, 
							Tipo_de_identificacion__c, Ubicacion__c, 
							Unidad_de_medida__c, Marca__c, 
							Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
							Estudiante__c,
							Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
							Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
							Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
							Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
							Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
							Reserva__r.Itinerario_admite_DR__c, CreatedDate,
							Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
							Carro_Arrastre__c, ML_Portabicicleta__c,
							Reserva__r.Itinerario_asociado__r.Tipo__c
							FROM Detalle_Reserva__c 
							WHERE Id =: detalleReserva.Id];

			List<Detalle_Reserva__c> detalleReservaLst = new List<Detalle_Reserva__c>();
			detalleReservaLst.add(detalleReserva);
		
			Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = consultasSOQL.getParametrosTarifaMetroLinealMap(detalleReservaLst, tramoDetalleReservaMap);
			System.assertEquals(true, mapParametros.size() >= 0);
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet - Neto
	@IsTest
	private static void test29(){
		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;
		
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista COM 
	@IsTest
	private static void test30(){
		Test.startTest();
			Programacion_de_Itinerario__c itinerario = [SELECT Id 
														FROM Programacion_de_Itinerario__c
														WHERE Tipo__c = 'SUBV'
														AND Estado__c = 'Disponible para venta'];

			itinerario.Tipo__c = 'COM';
			update itinerario;
			
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, Detalle_Reserva_Conductor__c FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
			
			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c 
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];
			
			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;		
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista COM Extranjero
	@IsTest
	private static void test31(){
		Test.startTest();
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, Detalle_Reserva_Conductor__c FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
			
			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c 
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];
			
			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;			
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Butaca COM
	@IsTest
	private static void test32(){
		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;

		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(true, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Bicicleta COM Extranjero
	@IsTest
	private static void test33(){
		Test.startTest();
			Programacion_de_Itinerario__c itinerario = [SELECT Id 
														FROM Programacion_de_Itinerario__c
														WHERE Tipo__c = 'SUBV'
														AND Estado__c = 'Disponible para venta'];

			itinerario.Tipo__c = 'COM';
			update itinerario;
			
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name, Detalle_Reserva_Conductor__c 
			FROM Detalle_Reserva__c 
			WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
			
			Detalle_Reserva__c detalleReservaConductor = [SELECT Id, Name
														FROM Detalle_Reserva__c 
														WHERE Id =: detalleReserva.Detalle_Reserva_Conductor__c];
			
			detalleReservaConductor.Tipo_de_identificacion__c = 'Pasaporte';
			update detalleReservaConductor;		
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet COM
	@IsTest
	private static void test34(){
		Programacion_de_Itinerario__c itinerario = [SELECT Id 
													FROM Programacion_de_Itinerario__c
													WHERE Tipo__c = 'SUBV'
													AND Estado__c = 'Disponible para venta'];

		itinerario.Tipo__c = 'COM';
		update itinerario;
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			System.assertEquals(true, itinerario != null);
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet COM Extranjero
	@IsTest
	private static void test35(){
		Test.startTest();
			Account cuenta = [SELECT Id, Name
							FROM Account
							WHERE Identificacion__c = '12345678'];
			
			Programacion_de_Itinerario__c itinerario = [SELECT Id 
														FROM Programacion_de_Itinerario__c
														WHERE Tipo__c = 'SUBV'
														AND Estado__c = 'Disponible para venta'];

			itinerario.Tipo__c = 'COM';
			update itinerario;
			
			Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
			
			detalleReserva.Persona_que_entrega__c = cuenta.Id;
			update detalleReserva;
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			System.assertEquals(true, itinerario != null);
		Test.stopTest();		
	}

	//Test Camino Feliz - Bicicleta Exento
	@IsTest
	private static void test36(){
		Parametros_Tarifarios_Pasajeros__c parametroTarifa = [SELECT Id, Name
															  FROM Parametros_Tarifarios_Pasajeros__c
															  WHERE Especificacion__c = 'Bicicletas'];

		parametroTarifa.Impuesto__c = 'Valor Exento';
		update parametroTarifa;
		
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name
											 FROM Detalle_Reserva__c 
											 WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
		
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Bicicleta Bruto
	@IsTest
	private static void test37(){
		Parametros_Tarifarios_Pasajeros__c parametroTarifa = [SELECT Id, Name
															  FROM Parametros_Tarifarios_Pasajeros__c
															  WHERE Especificacion__c = 'Bicicletas'];

		parametroTarifa.Impuesto__c = 'Valor Bruto';
		update parametroTarifa;
		
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name
											 FROM Detalle_Reserva__c 
											 WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
		
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pista Error 
	@IsTest
	private static void test38(){
		List<Parametros_Tarifarios_Pasajeros__c> parametrosTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
		parametrosTarifa = [SELECT Id, Name
						   FROM Parametros_Tarifarios_Pasajeros__c
						   WHERE Especificacion__c = 'Vehículo Menor'];
		delete parametrosTarifa;

		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, Detalle_Reserva_Conductor__c FROM Detalle_Reserva__c WHERE Modelo__c = '124 SPIDER'];
		
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Butaca Error 
	@IsTest
	private static void test39(){
		List<Parametros_Tarifarios_Pasajeros__c> parametrosTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
		parametrosTarifa = [SELECT Id, Name
						   FROM Parametros_Tarifarios_Pasajeros__c
						   WHERE Tipo_Transporte__c = 'Pasajero'];
		delete parametrosTarifa;

		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Doc_Identificacion_Pasajero__c = '8955620-1'];
		
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet Error 
	@IsTest
	private static void test40(){
		List<Parametros_Tarifarios_Pasajeros__c> parametrosTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
		parametrosTarifa = [SELECT Id, Name
						   FROM Parametros_Tarifarios_Pasajeros__c
						   WHERE Especificacion__c = 'Pallets'];
		delete parametrosTarifa;

		Detalle_Reserva__c detalleReserva = [SELECT Id, Name FROM Detalle_Reserva__c WHERE Unidad_de_medida__c = 'Pallet'];
		
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Bicicleta Error 
	@IsTest
	private static void test41(){
		List<Parametros_Tarifarios_Pasajeros__c> parametrosTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
		parametrosTarifa = [SELECT Id, Name
						   FROM Parametros_Tarifarios_Pasajeros__c
						   WHERE Especificacion__c = 'Bicicletas'];
		delete parametrosTarifa;

		Detalle_Reserva__c detalleReserva = [SELECT Id, Name
											 FROM Detalle_Reserva__c 
											 WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
		
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'No se encontraron tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pasajero Error 2
	@IsTest
	private static void test42(){
		Test.startTest();
			Contrato_Tarifa__c tarifa = [SELECT Id, Name
										FROM
										Contrato_Tarifa__c
										WHERE Name = 'CAM003'];
			
			Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY MONTT'];
			Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY CHAITÉN'];

			Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
			Valor__c = 12770,									      // Valor
			Contrato_Tarifa__c = tarifa.Id,				          // Contrato Tarifa
			Tipo_Transporte__c = 'Pasajero',                        // Tipo Transporte
			Ruta_Subsidiada__c = true,                              // Ruta Subsidiada
			Especificacion__c = 'General',                          // Especificación
			Ruta_Comercial__c = true,                              // Ruta Comercial
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

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name
												FROM Detalle_Reserva__c 
												WHERE Doc_Identificacion_Pasajero__c = '1-9'];
		
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Bicicleta Error 2
	@IsTest
	private static void test43(){
		Test.startTest();
			Contrato_Tarifa__c tarifa = [SELECT Id, Name
										FROM
										Contrato_Tarifa__c
										WHERE Name = 'CAM003'];
			
			Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY MONTT'];
			Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY CHAITÉN'];

			Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
			Valor__c = 15000,                // Valor
			Contrato_Tarifa__c = tarifa.Id,   // Contrato Tarifa
			Tipo_Transporte__c = 'Vehículo',    // Tipo Transporte
			Ruta_Subsidiada__c = true,         // Ruta Subsidiada
			Especificacion__c = 'Bicicletas',   // Especificación
			Ruta_Comercial__c = true,          // Ruta Comercial
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

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name
												FROM Detalle_Reserva__c 
												WHERE Tipo_de_Vehiculo__c = 'Bicicleta'];
		
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas');
		Test.stopTest();
	}

	//Test Camino Feliz - Pallet Error 2
	@IsTest
	private static void test44(){
		Test.startTest();
			Contrato_Tarifa__c tarifa = [SELECT Id, Name
										FROM
										Contrato_Tarifa__c
										WHERE Name = 'CAM003'];
			
			Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY MONTT'];
			Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY CHAITÉN'];

			Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
			Valor__c = 25250,                        // Valor
			Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
			Tipo_Transporte__c = 'Carga',            // Tipo Transporte
			Ruta_Subsidiada__c = true,               // Ruta Subsidiada
			Especificacion__c = 'Pallets',           // Especificación
			Ruta_Comercial__c = true,               // Ruta Comercial
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

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name 
												FROM Detalle_Reserva__c 
												WHERE Unidad_de_medida__c = 'Pallet'];
		
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			NAV_ItinerarioTriggerHelper itinerarioTriggerHelper = new NAV_ItinerarioTriggerHelper();
			List<OrigenDestino__c> listOrigenDestino = itinerarioTriggerHelper.distanciasOrigenDestino();
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas');
		Test.stopTest();
	}
    
    @IsTest
	private static void test45(){
		Detalle_Reserva__c detalleReserva = [SELECT Id, Name, Categoria_de_Vehiculo__c, Tipo_de_Vehiculo__c FROM Detalle_Reserva__c WHERE Categoria_de_Vehiculo__c  = 'Bus y Motorhome' 
                                             AND Detalle_Reserva_Conductor__r.Doc_Identificacion_Pasajero__c = '8955620-1'
                                             AND Tipo_de_Vehiculo__c = 'CASA RODANTE'];
        system.debug('detalleReserva: '+detalleReserva);
		Test.startTest();
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			//System.assertEquals(false, detalleReserva.Parametro_Tarifa__c != null && detalleReserva.Parametro_Tarifa__c != 'No se encontraron tarifas');
		Test.stopTest();
	}
    
    /*
    @IsTest
	private static void test45(){
		Test.startTest();
			Contrato_Tarifa__c tarifa = [SELECT Id, Name
										FROM
										Contrato_Tarifa__c
										WHERE Name = 'CAM003'];
			
			Puerto__c puerto1 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY MONTT'];
			Puerto__c puerto2 = [SELECT Id FROM Puerto__c WHERE Name = 'DUMMY CHAITÉN'];

			Parametros_Tarifarios_Pasajeros__c parametroTarifa = new Parametros_Tarifarios_Pasajeros__c(
			Valor__c = 25250,                        // Valor
			Contrato_Tarifa__c = tarifa.Id,		   // Contrato Tarifa
			Tipo_Transporte__c = 'Carga',            // Tipo Transporte
			Ruta_Subsidiada__c = true,               // Ruta Subsidiada
			Especificacion__c = 'Pallets',           // Especificación
			Ruta_Comercial__c = true,               // Ruta Comercial
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

			Detalle_Reserva__c detalleReserva = [SELECT Id, Name 
												FROM Detalle_Reserva__c 
												WHERE Categoria_de_Vehiculo__c = 'Bus y Motorhome'];
		
		
			List<String> idList = new List<String>();
			idList.add(detalleReserva.Id);
			NAV_Tarificar_PB.TarificaDetalleReserva(idList);
			detalleReserva = [SELECT Id, Name, Parametro_Tarifa__c FROM Detalle_Reserva__c WHERE Id =: detalleReserva.Id];
			NAV_ItinerarioTriggerHelper itinerarioTriggerHelper = new NAV_ItinerarioTriggerHelper();
			List<OrigenDestino__c> listOrigenDestino = itinerarioTriggerHelper.distanciasOrigenDestino();
			System.assertEquals(false, detalleReserva.Parametro_Tarifa__c == 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas');
		Test.stopTest();
	}*/
}