/**
 * @description       : Clase de test para validar tareas programadas de reservas
 * @author            : Esteban Flores
 * @group             : Seidor
 * @last modified on  : 06-16-2022
 * @last modified by  : Esteban Flores
 * @project           : Naviera
**/
@istest
public class NAV_ReservasSheduledTest {
    
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

	@isTest
    static void test() {
        Test.startTest();
            NAV_ReservasScheduled m = new NAV_ReservasScheduled();
            String sch = '0 1 0 * * ?';
            String jobID = system.schedule('Test Scheduled', sch, m);
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                                FROM CronTrigger
                                WHERE id = :jobID];
            System.assertEquals(sch, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
	
	@isTest
    static void test2() {

        Test.startTest();
            NAV_ReservasScheduled20 m = new NAV_ReservasScheduled20();
            String sch = '0 1 0 * * ?';
            String jobID = system.schedule('Test Scheduled', sch, m);
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                                FROM CronTrigger
                                WHERE id = :jobID];
            System.assertEquals(sch, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
}