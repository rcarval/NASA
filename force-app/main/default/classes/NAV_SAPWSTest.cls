@IsTest
public class NAV_SAPWSTest {
    @TestSetup
    static void setup(){
		Puerto__c puerto1 = new Puerto__c(
			Name = 'DUMMY MONTT', // Nombre de Puerto.
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
            Codigo_Subvencionada_SAP__c = 'RUT',
            Codigo_Comercial_SAP__c = 'RUT'
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

        List<Parametro_Tasa_Embarque__c> pte = new List<Parametro_Tasa_Embarque__c>{
            new Parametro_Tasa_Embarque__c(
                Puerto__c = puerto1.Id,
                Concepto__c = 'Tasa Pasajero',
                Aplicar__c = 'Al Embarque y Desembarque',
                Residente__c = true,
                Vigencia_desde__c = Date.valueOf('2021-04-01'),
                Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                Valor__c = 9.000,
                Ruta_Comercial__c = true,
                Ruta_Subvencionada__c = true,
                Impuesto__c = 'Valor Exento',
                Porcentaje_Impuesto__c = 0
            ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2021-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                    Valor__c = 18.000,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = true,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Vehículos',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2021-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                    Valor__c = 28.000,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = true,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Vehículos',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = true,
                    Vigencia_desde__c = Date.valueOf('2021-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                    Valor__c = 14.000,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = true,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = true,
                    Vigencia_desde__c = Date.valueOf('2022-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2023-03-31'),
                    Valor__c = 9.200,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2022-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2023-03-31'),
                    Valor__c = 18.400,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = true,
                    Vigencia_desde__c = Date.valueOf('2020-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2023-03-31'),
                    Valor__c = 8.900,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto1.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2020-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2021-03-31'),
                    Valor__c = 17.800,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                )
                };
                    insert pte;

        List<Parametro_Tasa_Embarque__c> pteDesembarque = new List<Parametro_Tasa_Embarque__c>{
            new Parametro_Tasa_Embarque__c(
                Puerto__c = puerto2.Id,
                Concepto__c = 'Tasa Pasajero',
                Aplicar__c = 'Al Embarque y Desembarque',
                Residente__c = true,
                Vigencia_desde__c = Date.valueOf('2021-04-01'),
                Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                Valor__c = 9.000,
                Ruta_Comercial__c = true,
                Ruta_Subvencionada__c = true,
                Impuesto__c = 'Valor Exento',
                Porcentaje_Impuesto__c = 0
            ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2021-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                    Valor__c = 18.000,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = true,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Vehículos',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2021-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                    Valor__c = 28.000,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = true,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Vehículos',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = true,
                    Vigencia_desde__c = Date.valueOf('2021-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2022-03-31'),
                    Valor__c = 14.000,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = true,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = true,
                    Vigencia_desde__c = Date.valueOf('2022-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2023-03-31'),
                    Valor__c = 9.200,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2022-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2023-03-31'),
                    Valor__c = 18.400,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = true,
                    Vigencia_desde__c = Date.valueOf('2020-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2023-03-31'),
                    Valor__c = 8.900,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametro_Tasa_Embarque__c(
                    Puerto__c = puerto2.Id,
                    Concepto__c = 'Tasa Pasajero',
                    Aplicar__c = 'Al Embarque y Desembarque',
                    Residente__c = false,
                    Vigencia_desde__c = Date.valueOf('2020-04-01'),
                    Vigencia_hasta__c = Date.valueOf('2021-03-31'),
                    Valor__c = 17.800,
                    Ruta_Comercial__c = true,
                    Ruta_Subvencionada__c = false,
                    Impuesto__c = 'Valor Exento',
                    Porcentaje_Impuesto__c = 0
                )
                };
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

// Con coma (inicializador de lista) y 1 solo insert
        List<Capacidad_Nave__c> capacidadNave = new List<Capacidad_Nave__c>{
            new Capacidad_Nave__c(
                Nave__c = nave.Id,
                Categoria__c = 'General',
                Numero__c = '01',
                Ubicacion__c = 'Salón',
                Capacidad__c = 1,
                Cupo_Venta_Local__c = false,
                Unidad_de_medida__c = 'Persona',
                RecordTypeId = Schema.SObjectType.Capacidad_Nave__c
                .getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
            ),
                new Capacidad_Nave__c(
                    Nave__c = nave.Id,
                    Categoria__c = 'General',
                    Numero__c = '02',
                    Ubicacion__c = 'Salón',
                    Capacidad__c = 1,
                    Cupo_Venta_Local__c = false,
                    Unidad_de_medida__c = 'Persona',
                    RecordTypeId = Schema.SObjectType.Capacidad_Nave__c
                    .getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
                ),
                new Capacidad_Nave__c(
                    Nave__c = nave.Id,
                    Categoria__c = 'General',
                    Numero__c = '03',
                    Ubicacion__c = 'Salón',
                    Capacidad__c = 1,
                    Cupo_Venta_Local__c = false,
                    Unidad_de_medida__c = 'Persona',
                    RecordTypeId = Schema.SObjectType.Capacidad_Nave__c
                    .getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()
                ),
                new Capacidad_Nave__c(
                    Nave__c = nave.Id,
                    Ubicacion__c = 'Bajo cubierta',
                    Capacidad__c = 5,
                    Cupo_Venta_Local__c = false,
                    Unidad_de_medida__c = 'Pallet',
                    RecordTypeId = Schema.SObjectType.Capacidad_Nave__c
                    .getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()
                ),
                new Capacidad_Nave__c(
                    Nave__c = nave.Id,
                    Ubicacion__c = 'Cubierta',
                    Numero__c = '1',
                    Cupo_Venta_Local__c = false,
                    Unidad_de_medida__c = 'm',
                    Capacidad__c = 280.0,
                    Alto__c = 5.1,
                    Ancho__c = 3.1,
                    RecordTypeId = Schema.SObjectType.Capacidad_Nave__c
                    .getRecordTypeInfosByName().get('Capacidad Nave Pista').getRecordTypeId()
                )
                };
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
		  UUID__c = 'd5799d8e-f1c8-491f-a333-333f62040ed4',
 		  Tickets_enviados__c = true
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

        List<Parametros_Tarifarios_Pasajeros__c> parametroTarifa = new List<Parametros_Tarifarios_Pasajeros__c>{
            new Parametros_Tarifarios_Pasajeros__c(
                Valor__c = 12770,
                Contrato_Tarifa__c = tarifa.Id,
                Tipo_Transporte__c = 'Pasajero',
                Ruta_Subsidiada__c = true,
                Especificacion__c = 'General',
                Ruta_Comercial__c = false,
                Nacional__c = true,
                Puerto_ORIGEN__c = puerto1.Id,
                Extranjero__c = true,
                Puerto_DESTINO__c = puerto2.Id,
                Residente__c = true,
                Discapacidad__c = false,
                Estudiante__c = false,
                Conductor__c = false,
                Impuesto__c = 'Valor Exento',
                Transportista__c = false,
                Porcentaje_Impuesto__c = 0,
                Edad_desde__c = 0,
                Oferta__c = 10000,
                Edad_hasta__c = 59,
                Vigencia_Oferta_desde__c = Date.valueOf('2021-10-10'),
                Vigencia_Oferta_hasta__c = Date.valueOf('2021-10-11')
            ),
                new Parametros_Tarifarios_Pasajeros__c(
                    Valor__c = 17820,
                    Contrato_Tarifa__c = tarifa.Id,
                    Tipo_Transporte__c = 'Pasajero',
                    Ruta_Subsidiada__c = true,
                    Especificacion__c = 'General',
                    Ruta_Comercial__c = false,
                    Nacional__c = true,
                    Puerto_ORIGEN__c = puerto1.Id,
                    Extranjero__c = true,
                    Puerto_DESTINO__c = puerto2.Id,
                    Residente__c = false,
                    Discapacidad__c = false,
                    Estudiante__c = false,
                    Conductor__c = false,
                    Impuesto__c = 'Valor Exento',
                    Transportista__c = false,
                    Porcentaje_Impuesto__c = 0
                ),
                new Parametros_Tarifarios_Pasajeros__c(
                    Valor__c = 97950,
                    Contrato_Tarifa__c = tarifa.Id,
                    Tipo_Transporte__c = 'Vehículo',
                    Ruta_Subsidiada__c = true,
                    Especificacion__c = 'Vehículo Menor',
                    Ruta_Comercial__c = false,
                    Nacional__c = true,
                    Puerto_ORIGEN__c = puerto1.Id,
                    Extranjero__c = true,
                    Puerto_DESTINO__c = puerto2.Id,
                    Residente__c = true,
                    Discapacidad__c = false,
                    Estudiante__c = false,
                    Conductor__c = false,
                    Impuesto__c = 'Valor Bruto',
                    Transportista__c = false,
                    Porcentaje_Impuesto__c = 19
                ),
                new Parametros_Tarifarios_Pasajeros__c(
                    Valor__c = 22050,
                    Contrato_Tarifa__c = tarifa.Id,
                    Tipo_Transporte__c = 'Vehículo',
                    Ruta_Subsidiada__c = true,
                    Especificacion__c = 'Metro Lineal',
                    Ruta_Comercial__c = false,
                    Nacional__c = true,
                    Puerto_ORIGEN__c = puerto1.Id,
                    Extranjero__c = true,
                    Puerto_DESTINO__c = puerto2.Id,
                    Residente__c = true,
                    Discapacidad__c = false,
                    Estudiante__c = false,
                    Conductor__c = false,
                    Impuesto__c = 'Valor Bruto',
                    Transportista__c = false,
                    Porcentaje_Impuesto__c = 19
                ),
                new Parametros_Tarifarios_Pasajeros__c(
                    Valor__c = 25250,
                    Contrato_Tarifa__c = tarifa.Id,
                    Tipo_Transporte__c = 'Carga',
                    Ruta_Subsidiada__c = true,
                    Especificacion__c = 'Pallets',
                    Ruta_Comercial__c = false,
                    Nacional__c = true,
                    Puerto_ORIGEN__c = puerto1.Id,
                    Extranjero__c = true,
                    Puerto_DESTINO__c = puerto2.Id,
                    Residente__c = true,
                    Discapacidad__c = false,
                    Estudiante__c = false,
                    Conductor__c = false,
                    Impuesto__c = 'Valor Bruto',
                    Transportista__c = false,
                    Porcentaje_Impuesto__c = 19
                ),
                new Parametros_Tarifarios_Pasajeros__c(
                    Valor__c = 15000,
                    Contrato_Tarifa__c = tarifa.Id,
                    Tipo_Transporte__c = 'Vehículo',
                    Ruta_Subsidiada__c = true,
                    Especificacion__c = 'Bicicletas',
                    Ruta_Comercial__c = false,
                    Nacional__c = true,
                    Puerto_ORIGEN__c = puerto1.Id,
                    Extranjero__c = true,
                    Puerto_DESTINO__c = puerto2.Id,
                    Discapacidad__c = false,
                    Estudiante__c = false,
                    Conductor__c = false,
                    Tipo_de_Vehiculo__c = 'Bicicleta',
                    Transportista__c = false,
                    Impuesto__c = 'Valor Neto',
                    Porcentaje_Impuesto__c = 19
                )
                };
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

        List<Capacidad_Tramo_Detalle_Reserva__c> ctdr = new List<Capacidad_Tramo_Detalle_Reserva__c>{
            new Capacidad_Tramo_Detalle_Reserva__c(
                Detalle_Reserva__c = detalleReserva1.Id,
                Capacidad_Liberada__c = false,
                Capacidad_Comprometida_en_Reserva__c = 0.5,
                Capacidad_Tramo__c = capacidadTramo1.Id
            ),
                new Capacidad_Tramo_Detalle_Reserva__c(
                    Detalle_Reserva__c = detalleReserva2.Id,
                    Capacidad_Liberada__c = false,
                    Capacidad_Comprometida_en_Reserva__c = 0.5,
                    Capacidad_Tramo__c = capacidadTramo1.Id
                ),
                new Capacidad_Tramo_Detalle_Reserva__c(
                    Detalle_Reserva__c = detalleReserva3.Id,
                    Capacidad_Liberada__c = false,
                    Capacidad_Comprometida_en_Reserva__c = 0.5,
                    Capacidad_Tramo__c = capacidadTramo1.Id
                ),
                new Capacidad_Tramo_Detalle_Reserva__c(
                    Detalle_Reserva__c = detalleReserva4.Id,
                    Capacidad_Liberada__c = false,
                    Capacidad_Comprometida_en_Reserva__c = 0.5,
                    Capacidad_Tramo__c = capacidadTramo1.Id
                )
                };
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
		// System.debug('TEST Items con Tarifas '+reserva.Itemes_reservas_con_tarifas__c);
		// System.debug('TEST Total Items '+reserva.Contador_de_Itemes_reservas__c);
		// System.debug('TEST Tarifa Validada '+reserva.Itemes_de_reserva_con_tarifa_validada__c);
		Caja__c caja = new Caja__c(
			Name = 'C-2022-05-02 15:12:41Z-13',// Nombre de la Caja
			Estado_de_la_Caja__c = 'Abierta',    // Estado de la Caja
			Numero_de_Caja__c = 13            // Número de Caja
		);
		insert caja;

		Acreditacion__c acreditacion = new Acreditacion__c(
			Reserva__c = reserva.Id,
            Destinatario_Documentos__c = cuenta1.Id,
            DatosConfirmados__c = true,
			Caja__c = caja.Id
		);
		insert acreditacion;

		//Decimal porAcreditar = 5000;
		Decimal porAcreditar = [SELECT Por_acreditar__c FROM Acreditacion__c WHERE Id =: acreditacion.Id].Por_acreditar__c;

        
			 system.debug('CD CREAR CAJA Line 810 '+ caja.Id);
		Forma_de_pago__c formaPago = new Forma_de_pago__c(
            Acreditacion__c = acreditacion.Id,												   
            Caja__c = caja.Id,
            Monto__c = porAcreditar,
            RecordTypeId = Schema.SObjectType.Forma_de_pago__c.getRecordTypeInfosByName().get('Efectivo').getRecordTypeId(),
            Tipo_de_pago__c = 'Efectivo'
        );
		insert formaPago;   

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
		  Caja__c = caja.Id,
		  Condicion_de_Venta__c = 'Al_Dia',
		  RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
		);
		insert documento;

        List<Detalle_Documentos__c> detalleDocumento = new List<Detalle_Documentos__c>{
            new Detalle_Documentos__c(
                Documento__c = documento.Id,
                Descripcion__c = 'Test',
                Cantidad__c = 1,
                Valor_Unitario_Neto__c = 1.000,
                Tax_Id__c = '[1,2]',
                Descuento__c = 0
            ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'PASAJERO / TASA',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'PASAJERO',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'BICICLETA',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'PALLET',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'TASA / MTRS',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'TRANSBORDO',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[9]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'USO DE ZONA PRE EMBARQUE',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[9]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'VEHICULOTASA / MTRS',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[9]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento.Id,
                    Descripcion__c = 'VEHICULO / ML',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[9]',
                    Descuento__c = 0
                )
                };
                    insert detalleDocumento;
		

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
		  Caja__c = caja.Id,
		  Condicion_de_Venta__c = 'Al_Dia',
		  RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
		);
		insert documento2;


        List<Detalle_Documentos__c> detalleDocumento2 = new List<Detalle_Documentos__c>{
            new Detalle_Documentos__c(
                Documento__c = documento2.Id,
                Descripcion__c = 'Test',
                Cantidad__c = 1,
                Valor_Unitario_Neto__c = 1.000,
                Tax_Id__c = '[1,2]',
                Descuento__c = 0
            ),
                new Detalle_Documentos__c(
                    Documento__c = documento2.Id,
                    Descripcion__c = 'VEHICULO / MTRS / TASA',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento2.Id,
                    Descripcion__c = 'VEHICULO / ML / TASA',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                ),
                new Detalle_Documentos__c(
                    Documento__c = documento2.Id,
                    Descripcion__c = 'VEHICULO / MTRS',
                    Cantidad__c = 1,
                    Valor_Unitario_Neto__c = 1.000,
                    Tax_Id__c = '[1,2]',
                    Descuento__c = 0
                )
                };
                    insert detalleDocumento2;

        ServicioSAP__c soc = new ServicioSAP__c();
        soc.Sociedad__c = '1540';
        soc.Endpoint__c = 'https://fioqas.cpt.cl/sap/bc/srt/rfc/sap/zws_fi_nasa/400/zws_fi_nasa_service/zws_fi_nasa_binding';
        soc.Usuario__c = 'zws1';
        soc.Clave__c = 'zcptws2017';
        soc.Nombre_Certificado__c = 'cert_2021';
        insert soc;

    }
    @IsTest
    private static void testSAPprocessIntegration() {
        List<Id> iAcreditaciones = new List<Id>();
        List<Acreditacion__c> acreds = [SELECT Id FROM Acreditacion__c  Limit 1];
        for(Acreditacion__c ac : acreds){
            iAcreditaciones.add(ac.Id);
        }
        Test.startTest();
        NAV_SAPWS.processIntegration(iAcreditaciones);
		NAV_SAPWS.xmlTestData();
         NAV_SAPWS.xmlTestOutput();
        Test.stopTest();
    } 
    @IsTest
    private static void testSAPprocessIntegration2() {
        List<Id> iAcreditaciones = new List<Id>();
        List<Acreditacion__c> acreds = [SELECT Id FROM Acreditacion__c  Limit 1];
        for(Acreditacion__c ac : acreds){
            iAcreditaciones.add(ac.Id);
        }
				Documento__c docPrincipal = [SELECT Id ,Fecha_Envio_SAP__c,Listo_para_SAP__c
								   FROM Documento__c 
								   WHERE RecordTypeId =: Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId() 
								   AND Acreditacion__c =:  acreds[0].Id];
		
            // 2) Cambias valores
            //docPrincipal.Fecha_Envio_SAP__c = Datetime.valueOf('2025-09-10 20:45:00');
            docPrincipal.Listo_para_SAP__c  = 1;
            
            // 3) Update
            update docPrincipal;	
        Test.startTest();
        NAV_SAPWS.processIntegration(iAcreditaciones);
		NAV_SAPWS.xmlTestData();
         NAV_SAPWS.xmlTestOutput();
        Test.stopTest();
    } 

    @IsTest
    private static void testSAPAnulacion() {
        List<Id> iAcreditaciones = new List<Id>();
        List<Id> iReservas = new List<Id>();
        List<Acreditacion__c> acreds = [SELECT Id, Reserva__c FROM Acreditacion__c Limit 1];
		Id ultimaAcreditacion = null;
        for(Acreditacion__c ac : acreds){
            iAcreditaciones.add(ac.Id);
			ultimaAcreditacion = ac.Id;
			iReservas.add(ac.Reserva__c);
        }
		List<Reserva__c> reservs = [SELECT Id, Estado_de_Reserva__c FROM Reserva__c WHERE Id IN: iReservas];
		for(Reserva__c rv : reservs){
			rv.Estado_de_Reserva__c = 'Anulada';
		}
		update reservs;
		
       
		Caja__c caja = [SELECT Id FROM Caja__c LIMIT 1];
        
		Id idDocumentoPrincipal = [SELECT Id 
								   FROM Documento__c 
								   WHERE RecordTypeId =: Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId() 
								   LIMIT 1].Id;

		Documento__c documento = new Documento__c(
		  Acreditacion__c = ultimaAcreditacion,                                                                                                                                         // Reserva
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
		  Caja__c = caja.Id,
		  Condicion_de_Venta__c = 'Al_Dia',
		  Documento_principal__c = idDocumentoPrincipal,
		  Motivo_Devolucion__c = 'No viaja',
		  Tipo_de_Nota_de_Credito__c = '1',
		  Tipo_de_Devolucion__c = 'Forma de Pago Nueva Venta',
		  Tipo_de_Documento__c = '2',
		  RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Nota de Crédito').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
		);
		insert documento;

		Detalle_Documentos__c detalleDocumento = new Detalle_Documentos__c(
		  Documento__c = documento.Id,		 // Documento
		  Descripcion__c = 'Test',           // Descripción
		  Cantidad__c = 1,                   // Cantidad
		  Valor_Unitario_Neto__c = 1.000,    // Valor Unitario Neto
		  Tax_Id__c = '[1,2]',               // Tax Id
		  Descuento__c = 0                   // % Descuento
		);
		insert detalleDocumento;
 		Test.startTest();
        NAV_SAPAnulacionWS.processIntegrationAnulada(iAcreditaciones);
        Test.stopTest();
    }
    @IsTest
    private static void testSAPAnulacion2() {
        List<Id> iAcreditaciones = new List<Id>();
        List<Id> iReservas = new List<Id>();
        List<Acreditacion__c> acreds = [SELECT Id, Reserva__c FROM Acreditacion__c  Limit 1 ];
		Id ultimaAcreditacion = null;
        for(Acreditacion__c ac : acreds){
            iAcreditaciones.add(ac.Id);
			ultimaAcreditacion = ac.Id;
			iReservas.add(ac.Reserva__c);
        }
		List<Reserva__c> reservs = [SELECT Id, Estado_de_Reserva__c FROM Reserva__c WHERE Id IN: iReservas];
		for(Reserva__c rv : reservs){
			rv.Estado_de_Reserva__c = 'Anulada';
		}
		update reservs;
		
        
		Caja__c caja = [SELECT Id FROM Caja__c LIMIT 1];

		Id idDocumentoPrincipal2 = [SELECT Id 
								   FROM Documento__c 
								   WHERE RecordTypeId =: Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId() 
								   LIMIT 1].Id;

		Documento__c documento2 = new Documento__c(
		  Acreditacion__c = ultimaAcreditacion,                                                                                                                                         // Reserva
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
		  Caja__c = caja.Id,
		  Condicion_de_Venta__c = 'Al_Dia',
		  Documento_principal__c = idDocumentoPrincipal2,
		  Motivo_Devolucion__c = 'No viaja',
		  Tipo_de_Nota_de_Credito__c = '1',
		  Tipo_de_Devolucion__c = 'Forma de Pago Nueva Venta',
		  Tipo_de_Documento__c = '17',
		  RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Anulación Venta (No Tributario)').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
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
		Test.startTest();
        NAV_SAPAnulacionWS.processIntegrationAnulada(iAcreditaciones);

        Test.stopTest();																						  
    }
        @IsTest
    private static void testSAPAnulacion3() {
        List<Id> iAcreditaciones = new List<Id>();
        List<Id> iReservas = new List<Id>();
        List<Acreditacion__c> acreds = [SELECT Id, Reserva__c FROM Acreditacion__c  Limit 1];
		Id ultimaAcreditacion = null;
        for(Acreditacion__c ac : acreds){
            iAcreditaciones.add(ac.Id);
			ultimaAcreditacion = ac.Id;
			iReservas.add(ac.Reserva__c);
        }
		List<Reserva__c> reservs = [SELECT Id, Estado_de_Reserva__c FROM Reserva__c WHERE Id IN: iReservas];
		for(Reserva__c rv : reservs){
			rv.Estado_de_Reserva__c = 'Anulada';
		}
		update reservs;
		
        
		Caja__c caja = [SELECT Id FROM Caja__c LIMIT 1];

		Id idDocumentoPrincipal2 = [SELECT Id 
								   FROM Documento__c 
								   WHERE RecordTypeId =: Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId() 
								   LIMIT 1].Id;

		Documento__c documento2 = new Documento__c(
		  Acreditacion__c = ultimaAcreditacion,                                                                                                                                         // Reserva
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
		  Caja__c = caja.Id,
		  Condicion_de_Venta__c = 'Al_Dia',
		  Documento_principal__c = idDocumentoPrincipal2,
		  Motivo_Devolucion__c = 'No viaja',
		  Tipo_de_Nota_de_Credito__c = '1',
		  Tipo_de_Devolucion__c = 'Forma de Pago Nueva Venta',
		  Tipo_de_Documento__c = '17',
		  RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Anulación Venta (No Tributario)').getRecordTypeId()                                                                                                                                 // Enviar Documento a Cliente
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
		Test.startTest();

        NAV_SAPCompletoWS.processIntegration(iAcreditaciones);
        Test.stopTest();																						  
    } 

}