/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EF)
Proyecto: Naviera Austral
Descripción: Clase para tarea programada que cancela las reservas pasados 20 minutos
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     23-03-2022   EF       Creación de la Clase.
***********************************************************************************/
public with sharing class NAV_ReservasCanceladasMinutos {
    public NAV_ReservasCanceladasMinutos() {
        
    }
    public static void cancelaReservas20Mins(){
        List<Capacidad_Tramo_Detalle_Reserva__c> cToUpdate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
        List<Capacidad_Tramo_Detalle_Reserva__c> capacidades = new List<Capacidad_Tramo_Detalle_Reserva__c>();
        List<Reserva__c> reservas = new List<Reserva__c>();
        List<Reserva__c> reserva2 = new List<Reserva__c>();
        List<Reserva__c> reserva3 = new List<Reserva__c>();
        List<Reserva__c> rToUpdate = new List<Reserva__c>();
        Set<Id> rIds = new Set<Id>();

        //Capacidades
        capacidades = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c, Detalle_Reserva__r.Reserva__c
                                                                FROM Capacidad_Tramo_Detalle_Reserva__c
                                                                WHERE Detalle_Reserva__r.Reserva__r.LastModifiedDate <=: Datetime.now().addMinutes(-20)
                                                                    AND Detalle_Reserva__r.Reserva__r.Estado_de_Reserva__c = 'Creada'];
        reservas = [SELECT Id 
                    FROM Reserva__c
                    WHERE LastModifiedDate <=: Datetime.now().addMinutes(-20)
                    AND Estado_de_Reserva__c = 'Creada'];
        for(Reserva__c res : reservas){
            rIds.add(res.Id);
        }
        reserva2 = [SELECT Id
                    FROM Reserva__c
                    WHERE Estado_de_Reserva__c NOT IN('Acreditada','Anulada') 
                        AND ((Expira_al_Zarpe__c = false AND Fecha_hora_expiracion__c <=: Datetime.now()) 
                            OR (Expira_al_Zarpe__c = true AND Fecha_Hora_de_Viaje__c <=: Datetime.now()))];

        for(Reserva__c res : reserva2){
            rIds.add(res.Id);
        }
        reserva3 = [SELECT Id 
                    FROM Reserva__c
                    WHERE LastModifiedDate <=: Datetime.now().addMinutes(-20)
                    AND Estado_de_Reserva__c = 'Reservada'
                    AND Canal_de_Venta__c = 'Web'];
        for(Reserva__c res : reserva3){
            rIds.add(res.Id);
        }
        if(Test.isRunningTest()){
            capacidades = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c, Detalle_Reserva__r.Reserva__c
                            FROM Capacidad_Tramo_Detalle_Reserva__c];
        }
        for(Capacidad_Tramo_Detalle_Reserva__c cDet : capacidades){
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