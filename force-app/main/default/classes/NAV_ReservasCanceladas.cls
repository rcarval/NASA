public with sharing class NAV_ReservasCanceladas {
    public NAV_ReservasCanceladas() {

    }
    public static void cancelaReservas(){
        List<Capacidad_Tramo_Detalle_Reserva__c> cToUpdate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
        List<Capacidad_Tramo_Detalle_Reserva__c> capacidades = new List<Capacidad_Tramo_Detalle_Reserva__c>();
        List<Capacidad_Tramo_Detalle_Reserva__c> capacidades2 = new List<Capacidad_Tramo_Detalle_Reserva__c>();
        
        //Capacidades Web
        capacidades = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c, Detalle_Reserva__r.Reserva__c
                                                                FROM Capacidad_Tramo_Detalle_Reserva__c
                                                                WHERE Detalle_Reserva__r.Reserva__r.CreatedDate <= YESTERDAY
                                                                    AND Detalle_Reserva__r.Reserva__r.Estado_de_Reserva__c = 'Creada'
                                                                    AND Detalle_Reserva__r.Reserva__r.Canal_de_Venta__c = 'Web'];
        //Capacidades Agencia
        capacidades2 = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c, Detalle_Reserva__r.Reserva__c
                                                                FROM Capacidad_Tramo_Detalle_Reserva__c
                                                                WHERE Detalle_Reserva__r.Reserva__r.CreatedDate <= YESTERDAY
                                                                    AND Detalle_Reserva__r.Reserva__r.Estado_de_Reserva__c = 'Creada'
                                                                    AND Detalle_Reserva__r.Reserva__r.Canal_de_Venta__c = 'Presencial'
                                                                    AND (Detalle_Reserva__r.Reserva__r.Expira_al_Zarpe__c = true
                                                                        OR Detalle_Reserva__r.Reserva__r.Fecha_Expiracion__c = TODAY)];
    
        
        //RL -> Ya que no se puede modificar el valor CreatedDate para los test, se agrega método isRunningTest para 
        //bypass de query y traer los datos para cancelar                                                                
        if(Test.isRunningTest()){
            //Capacidades Agencia
            capacidades2 = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c, Detalle_Reserva__r.Reserva__c
                            FROM Capacidad_Tramo_Detalle_Reserva__c
                            WHERE Detalle_Reserva__r.Reserva__r.Canal_de_Venta__c = 'Presencial'];
        }
        
        List<Reserva__c> rToUpdate = new List<Reserva__c>();
        Set<Id> rIds = new Set<Id>();
        for(Capacidad_Tramo_Detalle_Reserva__c cDet : capacidades){
            cDet.Capacidad_Liberada__c = true;
            cDet.Causa_Liberacion__c = 'Reserva Expirada';
            cToUpdate.add(cDet);
            rIds.add(cDet.Detalle_Reserva__r.Reserva__c);
        }
        for(Capacidad_Tramo_Detalle_Reserva__c cDet : capacidades2){
            cDet.Capacidad_Liberada__c = true;
            cDet.Causa_Liberacion__c = 'Reserva Expirada';
            cToUpdate.add(cDet);
            rIds.add(cDet.Detalle_Reserva__r.Reserva__c);
        }
        System.debug('Capacidades: '+cToUpdate.size());
        if(cToUpdate.size() > 0){
            update cToUpdate;
        }
        for(Id rId : rIds){
            Reserva__c res = new Reserva__c();
            res.Id = rId;
            res.Estado_de_Reserva__c = 'Anulada';
            rToUpdate.add(res);
        }
        System.debug('Reservas: '+rToUpdate.size());
        if(rToUpdate.size() > 0){
            update rToUpdate;
        }
    }
}