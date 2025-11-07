@isTest
public with sharing class NAV_ConfirmacionReserva_Test {
    // Método para configurar datos de prueba comunes
    @TestSetup
    static void setupTestData() {
 
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
                Procesado__c = False,
                Contacto_Reserva__c = cuenta.Id,
                Itinerario_asociado__c = itinerario.Id
            ));
        }
        insert reservas;
    }
    
    // Test para el método execute del Schedulable
    @isTest
    static void testSchedulableExecute() {
        Test.startTest();
        NAV_ConfirmacionReserva scheduler = new NAV_ConfirmacionReserva();
        scheduler.execute(null);  
        Test.stopTest();
        
        // Verificar que las reservas se marcaron como procesadas
        List<Reserva__c> processedReservations = [
            SELECT Id FROM Reserva__c 
            WHERE Procesado__c = true
        ];
        System.assert(processedReservations.size() >= 3, 'Debería haber al menos 3 reservas procesadas');
    }
    
    // // Test para processUnprocessedReservations con reservas pendientes
    // @isTest
    // static void testProcessUnprocessedReservationsWithPending() {
    //     // Configurar mock para la llamada al WS
    //     Test.setMock(HttpCalloutMock.class, new NAV_ConfirmacionReserva_Mock());
        
    //     Test.startTest();
    //     NAV_ConfirmacionReserva.processUnprocessedReservations();
    //     Test.stopTest();
        
    //     // Verificaciones
    //     List<Reserva__c> updatedReservations = [
    //         SELECT Id, Procesado__c 
    //         FROM Reserva__c 
    //         WHERE Procesado__c = true
    //     ];
    //     System.assert(!updatedReservations.isEmpty(), 'Debería haber reservas marcadas como procesadas');

    //     // Ahora debería agregar un listado con las rerservas que hay que marcar
    // }
    
    // // Test para processUnprocessedReservations sin reservas pendientes
    // @isTest
    // static void testProcessUnprocessedReservationsWithoutPending() {
    //     // Marcar todas las reservas como procesadas primero
    //     List<Reserva__c> allReservations = [SELECT Id FROM Reserva__c];
    //     for(Reserva__c res : allReservations) {
    //         res.Procesado__c = true;
    //     }
    //     update allReservations;
        
    //     Test.startTest();
    //     NAV_ConfirmacionReserva.processUnprocessedReservations();
    //     Test.stopTest();
        
    //     // Verificar que no se procesaron reservas nuevas
    //     Integer processedCount = [SELECT COUNT() FROM Reserva__c WHERE Procesado__c = true];
    //     System.assertEquals(allReservations.size(), processedCount, 'No debería haber nuevas reservas procesadas');
    // }
    
}