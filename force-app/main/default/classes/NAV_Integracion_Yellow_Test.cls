@IsTest
private class NAV_Integracion_Yellow_Test {
    
    // Clase mock para respuestas HTTP
    private class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setBody('{"success":true}');
            return res;
        }
    }

    @TestSetup
    static void setupTestData() {
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
        Mantenedor_Nave__c nave = new Mantenedor_Nave__c(
            Name = 'AGIOS',                   // Nombre de la Nave
            Velocidad_Navegacion__c = 10,     // Velocidad Navegación
            Carga_Maxima_Vehiculos__c = 550   // Carga Máxima Vehículos
        );
        insert nave;
        
        Mantenedor_Ruta__c ruta = new Mantenedor_Ruta__c(
			Name = 'DUMMY CHAITÉN SUR',                            // Nombre de Mantenedor Rutas
			Origen_Destino__c = 'DUMMY MONTT -> DUMMY CHAITÉN',  // Zarpe Origen -> Recalada Final
			Sigla_Ruta__c = 'PMCN'                            // Sigla Ruta
        );
        insert ruta;

        Programacion_de_Itinerario__c itinerario = new Programacion_de_Itinerario__c(
            Nombre_Ruta__c = ruta.Id,
            Nombre_de_la_Nave__c = nave.Id,
            Fecha_Reprogramacion__c = DateTime.now().addDays(1)
        );
        insert itinerario;

Escalas_Itinerario__c Escala = new Escalas_Itinerario__c(
  Name = 'PUERTO MONTT',                                            // Hacer Escala
  Itinerario__c = itinerario.Id,                                      // Itinerario
  Secuencia__c = 1,                                               // Secuencia
  Puerto_Embarque__c = puerto1.Id,                                 // Puerto Embarque
  Tiempo_Embarque__c = DateTime.now().addHours(1).time(),                                  // Tiempo Embarque
  Inicio_Embarque__c = DateTime.now().addDays(1),      // Inicio Embarque
  Salida__c = DateTime.now().addDays(1),               // Salida
  Puerto_Destino__c = puerto2.Id,                                  // Puerto Destino
  Millas_de_Navegacion__c = 50,                                 // Millas de Navegación
  Navegacion__c = DateTime.now().addHours(5).time(),                                        // Navegación
  i_Navegacion__c = DateTime.now().addHours(5).time(),                                      // i Navegación
  ETA_Puerto_Destino__c = DateTime.now().addDays(2) // ETA Puerto Destino
);
insert Escala;
        
        Account cuenta = new Account(
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
            FirstName = 'Dummy', // Nombre de la cuenta
            LastName = 'User 2',
            Razon_Social__c = 'cuejk2',
            Identificacion__c = '2-7',              // Identificación
            PersonBirthdate = Date.valueOf('1988-10-11'),  // Fecha de nacimiento
            Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
            PersonEmail = 'dummy2@dummy.com',              // Correo electrónico
            Discapacidad__pc = false ,
            Phone = '+56999999999'
        );
        insert cuenta;
        
        List<Reserva__c> reservas = new List<Reserva__c>();
        for(Integer i = 0; i < 55; i++) {
            reservas.add(new Reserva__c(
                Contacto_Reserva__c = cuenta.Id,
                Itinerario_asociado__c = itinerario.Id,
                Estado_de_Reserva__c = 'Acreditada',
				Puerto_ORIGEN__C =puerto1.Id,
                Fecha_Hora_de_Viaje__c = DateTime.now().addDays(1)
            ));
        }
        insert reservas;
    }

    @IsTest
    static void testIntegracionCompleta() {
        // Obtener itinerario de prueba
        Programacion_de_Itinerario__c itinerario = [SELECT Id FROM Programacion_de_Itinerario__c LIMIT 1];
        
        List<Reserva__c> reservas = [SELECT Id FROM Reserva__c LIMIT 50];
        
        // Configurar mock HTTP
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());  
        Test.startTest();
        
        // Ejecutar método invocable
        NAV_Integracion_Yellow_Inv.FlowInputs input = new NAV_Integracion_Yellow_Inv.FlowInputs();
        input.IdItinerario = itinerario.Id;
        input.estadoItinerario = 'Reprogramado';
        
        NAV_Integracion_Yellow_Inv.integrarYellow(new List<NAV_Integracion_Yellow_Inv.FlowInputs>{input});
        
        Id jobId1 = System.enqueueJob(new NAV_CalloutYellow_Queueable('Reprogramado', reservas));
        
        Test.stopTest();
    }
    
    @IsTest
    static void testQueueableExecution() {
        // Obtener reservas con campos necesarios
        List<Reserva__c> reservas = [
            SELECT Name, Contacto_Reserva__r.Name, Telefono_Contacto__c, Correo_Contacto__c,Itinerario_asociado__c,Fecha_Hora_de_Viaje__c,
                          Ruta__c, Nave__c, Itinerario_asociado__r.Nombre_Ruta__r.Name, Itinerario_asociado__r.Fecha_Reprogramacion__c,Puerto_ORIGEN__r.Name 
            FROM Reserva__c 
            LIMIT 50
        ];
        
        // Configurar mock HTTP
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        Test.startTest();
        Id jobId = System.enqueueJob(new NAV_CalloutYellow_Queueable('Reprogramado', reservas));
        Test.stopTest();
        
        // Verificar ejecución
        System.assertNotEquals(null, jobId, 'El job debe haberse encolado correctamente');
    }
}