global class NAV_DeleteRegistrosCapacidadTramos implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        DateTime fechaActual;
        DateTime fechaLimite;
        String query ='';
        // Obtener la fecha actual
        fechaActual = DateTime.now();
        System.debug('fechaActual: ' + fechaActual);
        // Calcular la fecha límite (3 meses atrás)
        fechaLimite = fechaActual.addMonths(-3);
        System.debug('fechaLimite: ' + fechaLimite);
        query = 'SELECT Id FROM Capacidad_Tramo__c WHERE CreatedDate < :fechaLimite AND Capacidad_Comprometida__c = 0' ;
        // Consultar los registros de Tramo que necesitan ser eliminados
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Capacidad_Tramo__c> scope) {    
        // Eliminar los registros de ReservaTramo
             delete scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        // Puede agregar cualquier lógica de finalización aquí si es necesario
    }
}