trigger ReservaTrigger on Reserva__c (after insert, after update, after delete) {

    // Manejador de lógica central
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            NAV_ReservaTriggerHandler.actualizarCantidadCodigos(Trigger.new, null);
        }
        else if(Trigger.isUpdate){
            NAV_ReservaTriggerHandler.actualizarCantidadCodigos(Trigger.new, Trigger.old);
        }
        else if(Trigger.isDelete){
            NAV_ReservaTriggerHandler.actualizarCantidadCodigos(null, Trigger.old);
        }
    }
}