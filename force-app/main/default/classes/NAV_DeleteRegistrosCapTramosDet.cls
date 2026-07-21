global class NAV_DeleteRegistrosCapTramosDet implements Database.Batchable<sObject>{
    
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
          query = 'SELECT Id FROM Capacidad_Tramo_Detalle_Reserva__c WHERE CreatedDate <= :fechaLimite AND Detalle_Reserva__r.Reserva__r.Fecha_Hora_de_Viaje__c <= :fechaLimite'; 
        // Consultar los registros de TramoDetalle que necesitan ser eliminados
        //String query = 'SELECT Id FROM Capacidad_Tramo_Detalle_Reserva__c WHERE CreatedDate <= :fechaLimite ';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Capacidad_Tramo_Detalle_Reserva__c> scope) {    
        // Eliminar los registros de ReservaTramoDetalle
        system.debug('scope ' +scope);
        delete scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        // Puede agregar cualquier lógica de finalización aquí si es necesario
    }
}