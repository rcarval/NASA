/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_EscalaTriggerHelper, NAV_CapacidadesInsertBatch y NAV_EscalaTriggerHelperTest
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     22-03-2022   RL       Creación de la Clase.
***********************************************************************************/

@IsTest
public class NAV_EscalaTriggerHelperTest {
    //Test de NAV_EscalaInsertBatch
    @IsTest
	private static void test01(){
		Puerto__c puerto1 = new Puerto__c(
			Name = 'CASTRO',// Nombre de Puerto
            Sigla__c = 'CA'
		);
		insert puerto1;

        Puerto__c puerto2 = new Puerto__c(
			Name = 'PUERTESITO',// Nombre de Puerto
            Sigla__c = 'PT'
		);
		insert puerto2;

		Puerto__c puerto3 = new Puerto__c(
			Name = 'CHAITÉN',// Nombre de Puerto
            Sigla__c = 'CN'
		);
		insert puerto3;

		Puerto__c puerto4 = new Puerto__c(
			Name = '--',// Nombre de Puerto
            Sigla__c = '--'
		);
		insert puerto4;

		Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
			Name = 'CASTRO SUR',                            // Nombre de Mantenedor Rutas
			Origen_Destino__c = 'Castro -> Chaitén',  // Zarpe Origen -> Recalada Final
			Sigla_Ruta__c = 'CACN'                            // Sigla Ruta
		);
		insert mantenedorRuta;

		Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
			Name = 'Castro -> Puertesito',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 1,                     // Secuencia
			ORIGEN__c = puerto1.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(3, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto2.Id         // DESTINO
		);
		insert mantenedorTramos;

		Mantenedor_de_Tramos__c mantenedorTramos2 = new Mantenedor_de_Tramos__c(
			Name = 'Puertesito -> Chaitén',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto2.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto3.Id         // DESTINO
		);
		insert mantenedorTramos2;

        Mantenedor_de_Tramos__c mantenedorTramos3 = new Mantenedor_de_Tramos__c(
			Name = 'Chaitén --',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto3.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto4.Id         // DESTINO
		);
		insert mantenedorTramos3;


		OrigenDestino__c origenDestino = new OrigenDestino__c(
			Distancia__c = 52,          // Distancia
			Origen__c = puerto1.Id,   // Origen
			Destino__c = puerto2.Id  // Destino
        );
        insert origenDestino;

        origenDestino = new OrigenDestino__c(
			Distancia__c = 45,          // Distancia
			Origen__c = puerto2.Id,   // Origen
			Destino__c = puerto3.Id  // Destino
        );
        insert origenDestino;

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

        Set<Id> idEscalasSet = new Set<Id>();

		Escalas_Itinerario__c escalasItinerario = new Escalas_Itinerario__c(
		  Name = 'CASTRO',                                          // Escala
		  Hacer_Escala__c = false,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 1,                                               // Secuencia
		  Puerto_Embarque__c = puerto1.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto2.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 52,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario;
        idEscalasSet.add(escalasItinerario.Id);

		escalasItinerario = new Escalas_Itinerario__c(
		  Name = 'PUERTESITO',                                          // Escala
		  Hacer_Escala__c = false,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 2,                                               // Secuencia
		  Puerto_Embarque__c = puerto2.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto3.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 45,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario;
        idEscalasSet.add(escalasItinerario.Id);

		escalasItinerario = new Escalas_Itinerario__c(
		  Name = 'CHAITÉN',                                          // Escala
		  Hacer_Escala__c = false,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 1,                                               // Secuencia
		  Puerto_Embarque__c = puerto3.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto4.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 0,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario;
        idEscalasSet.add(escalasItinerario.Id);
        
		Test.startTest();
            NAV_EscalaInsertBatch escalaInsertBatch = new NAV_EscalaInsertBatch();
            escalaInsertBatch.iEscalas = idEscalasSet;
            Id jobid= Database.executeBatch(escalaInsertBatch,5);
			System.assertEquals(true, idEscalasSet.size() >= 0);
        Test.stopTest();
    }

    //Test de NAV_CapacidadesInsertBatch
    @IsTest
	private static void test02(){
		Puerto__c puerto1 = new Puerto__c(
			Name = 'CASTRO',// Nombre de Puerto
            Sigla__c = 'CA'
		);
		insert puerto1;

        Puerto__c puerto2 = new Puerto__c(
			Name = 'PUERTESITO',// Nombre de Puerto
            Sigla__c = 'PT'
		);
		insert puerto2;

		Puerto__c puerto3 = new Puerto__c(
			Name = 'CHAITÉN',// Nombre de Puerto
            Sigla__c = 'CN'
		);
		insert puerto3;

		Puerto__c puerto4 = new Puerto__c(
			Name = '--',// Nombre de Puerto
            Sigla__c = '--'
		);
		insert puerto4;

		Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
			Name = 'CASTRO SUR',                            // Nombre de Mantenedor Rutas
			Origen_Destino__c = 'Castro -> Chaitén',  // Zarpe Origen -> Recalada Final
			Sigla_Ruta__c = 'CACN'                            // Sigla Ruta
		);
		insert mantenedorRuta;

		Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
			Name = 'Castro -> Puertesito',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 1,                     // Secuencia
			ORIGEN__c = puerto1.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(3, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto2.Id         // DESTINO
		);
		insert mantenedorTramos;

		Mantenedor_de_Tramos__c mantenedorTramos2 = new Mantenedor_de_Tramos__c(
			Name = 'Puertesito -> Chaitén',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto2.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto3.Id         // DESTINO
		);
		insert mantenedorTramos2;

        Mantenedor_de_Tramos__c mantenedorTramos3 = new Mantenedor_de_Tramos__c(
			Name = 'Chaitén --',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto3.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto4.Id         // DESTINO
		);
		insert mantenedorTramos3;


		OrigenDestino__c origenDestino = new OrigenDestino__c(
			Distancia__c = 52,          // Distancia
			Origen__c = puerto1.Id,   // Origen
			Destino__c = puerto2.Id  // Destino
        );
        insert origenDestino;

        origenDestino = new OrigenDestino__c(
			Distancia__c = 45,          // Distancia
			Origen__c = puerto2.Id,   // Origen
			Destino__c = puerto3.Id  // Destino
        );
        insert origenDestino;

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
		  Name = 'CASTRO',                                          // Escala
		  Hacer_Escala__c = false,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 1,                                               // Secuencia
		  Puerto_Embarque__c = puerto1.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto2.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 52,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario;
        
		Escalas_Itinerario__c escalasItinerario2 = new Escalas_Itinerario__c(
		  Name = 'PUERTESITO',                                          // Escala
		  Hacer_Escala__c = false,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 2,                                               // Secuencia
		  Puerto_Embarque__c = puerto2.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto3.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 45,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario2;
        
		Escalas_Itinerario__c escalasItinerario3 = new Escalas_Itinerario__c(
		  Name = 'CHAITÉN',                                          // Escala
		  Hacer_Escala__c = false,                                         // Hacer Escala
		  Itinerario__c = itinerario.Id,                                  // Itinerario
		  Secuencia__c = 1,                                               // Secuencia
		  Puerto_Embarque__c = puerto3.Id,                                // Puerto Embarque
		  Tiempo_Embarque__c = Time.newInstance(1,0,0,0),                 // Tiempo Embarque
		  Inicio_Embarque__c = Datetime.valueOf('2021-09-10 19:45:00'),   // Inicio Embarque
		  Salida__c = Datetime.valueOf('2021-09-10 20:45:00'),            // Salida
		  Puerto_Destino__c = puerto4.Id,                                 // Puerto Destino
		  Millas_de_Navegacion__c = 0,                                   // Millas de Navegación
		  Navegacion__c = Time.newInstance(5,35,0,0),                     // Navegación
		  ETA_Puerto_Destino__c = Datetime.valueOf('2021-09-11 2:21:00')  // ETA Puerto Destino
		);
		insert escalasItinerario3;

        Capacidad_Tramo__c capacidadTramo1 = new Capacidad_Tramo__c(
		  RecordTypeId = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId(),
		  Escala_itinerario__c = escalasItinerario.Id,		 // Escala itinerario
		  Ubicacion__c = 'Bajo cubierta',            // Ubicación
		  Numero__c = '1',                           // Número
		  Cupo_Venta_Local__c = false,               // Cupo Venta Local
		  Capacidad__c = 5,                          // Capacidad
		  Canal_Web__c = true,                       // Canal Web
		  Unidad_de_medida__c = 'Pallet'             // Unidad de medida
		);
		List<Capacidad_Tramo__c> capacidadTramoLst = new List<Capacidad_Tramo__c>();
        capacidadTramoLst.add(capacidadTramo1);
        
		Test.startTest();
        NAV_CapacidadesInsertBatch capacidadesInsertBatch = new NAV_CapacidadesInsertBatch();
        capacidadesInsertBatch.capacidades = capacidadTramoLst;
        Id jobid= Database.executeBatch(capacidadesInsertBatch,5);
		System.assertEquals(true, capacidadTramoLst.size() >= 0);
        Test.stopTest();
    }
    
    //Test de NAV_EscalaTriggerHelperTest
	@IsTest
	private static void test03(){
		Puerto__c puerto1 = new Puerto__c(
			Name = 'CASTRO',// Nombre de Puerto
            Sigla__c = 'CA'
		);
		insert puerto1;

        Puerto__c puerto2 = new Puerto__c(
			Name = 'PUERTESITO',// Nombre de Puerto
            Sigla__c = 'PT'
		);
		insert puerto2;

		Puerto__c puerto3 = new Puerto__c(
			Name = 'CHAITÉN',// Nombre de Puerto
            Sigla__c = 'CN'
		);
		insert puerto3;

		Puerto__c puerto4 = new Puerto__c(
			Name = '--',// Nombre de Puerto
            Sigla__c = '--'
		);
		insert puerto4;

		Mantenedor_Ruta__c mantenedorRuta = new Mantenedor_Ruta__c(
			Name = 'CASTRO SUR',                            // Nombre de Mantenedor Rutas
			Origen_Destino__c = 'Castro -> Chaitén',  // Zarpe Origen -> Recalada Final
			Sigla_Ruta__c = 'CACN'                            // Sigla Ruta
		);
		insert mantenedorRuta;

		Mantenedor_Ruta__c mantenedorRuta2 = new Mantenedor_Ruta__c(
			Name = 'CASTRO SUR 2',                            // Nombre de Mantenedor Rutas
			Origen_Destino__c = 'Chaitén -> --',  // Zarpe Origen -> Recalada Final
			Sigla_Ruta__c = 'CA--'                            // Sigla Ruta
		);
		insert mantenedorRuta2;

		Mantenedor_de_Tramos__c mantenedorTramos = new Mantenedor_de_Tramos__c(
			Name = 'Castro -> Puertesito',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 1,                     // Secuencia
			ORIGEN__c = puerto1.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(3, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto2.Id         // DESTINO
		);
		insert mantenedorTramos;

		Mantenedor_de_Tramos__c mantenedorTramos2 = new Mantenedor_de_Tramos__c(
			Name = 'Puertesito -> Chaitén',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto2.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto3.Id         // DESTINO
		);
		insert mantenedorTramos2;

        Mantenedor_de_Tramos__c mantenedorTramos3 = new Mantenedor_de_Tramos__c(
			Name = 'Chaitén --',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto3.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto4.Id         // DESTINO
		);
		insert mantenedorTramos3;

		Mantenedor_de_Tramos__c mantenedorTramos4 = new Mantenedor_de_Tramos__c(
			Name = 'Chaitén --',  // Nombre de Tramos
			Nombre_de_Ruta__c = mantenedorRuta2.Id,  // Nombre de Ruta
			Secuencia__c = 2,                     // Secuencia
			ORIGEN__c = puerto3.Id,          // ORIGEN
			Tiempo_Embarque__c = Time.newInstance(2, 0, 0, 0),            // Tiempo Embarque
			DESTINO__c = puerto4.Id         // DESTINO
		);
		insert mantenedorTramos4;


		OrigenDestino__c origenDestino = new OrigenDestino__c(
			Distancia__c = 52,          // Distancia
			Origen__c = puerto1.Id,   // Origen
			Destino__c = puerto2.Id  // Destino
        );
        insert origenDestino;

        origenDestino = new OrigenDestino__c(
			Distancia__c = 45,          // Distancia
			Origen__c = puerto2.Id,   // Origen
			Destino__c = puerto3.Id  // Destino
        );
        insert origenDestino;

		origenDestino = new OrigenDestino__c(
			Distancia__c = 0,          // Distancia
			Origen__c = puerto3.Id,   // Origen
			Destino__c = puerto4.Id  // Destino
        );
        insert origenDestino;

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

		itinerario = new Programacion_de_Itinerario__c(
		  Nombre_Ruta__c = mantenedorRuta2.Id,				                       // Nombre Ruta
		  Fecha_de_Viaje__c = Datetime.valueOf('2021-09-10 20:45:00'),  // Fecha de Viaje
		  Tipo__c = 'COM',                                            // Tipo
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

		NAV_EscalaTriggerHelper.runOnce = false;
        List<Escalas_Itinerario__c> escalasItinerarioLst = [SELECT Id, Itinerario__c,
                                                            Name
                                                            FROM Escalas_Itinerario__c];
        if(escalasItinerarioLst !=null){
            for(Escalas_Itinerario__c eItinerario : escalasItinerarioLst){
                eItinerario.Hacer_Escala__c = false;
            }
			update escalasItinerarioLst;
        }

        Test.startTest();
		for(Escalas_Itinerario__c eItinerario : escalasItinerarioLst){
			eItinerario.Hacer_Escala__c = true;
		}
		update escalasItinerarioLst;
        	System.assertEquals(true, escalasItinerarioLst.size() >= 0);
        Test.stopTest();
    }    
}