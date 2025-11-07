/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Trigger de Programacion de itinerarios
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     25-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
trigger NAV_EscalasItinerarioTrigger on Escalas_itinerario__c (after insert, after update) {
    if(System.isFuture() || System.isBatch()) return;
    //Clase Apex que controla lo que suceda en este Trigger
    NAV_EscalaTriggerHandler  handler = new NAV_EscalaTriggerHandler(Trigger.isExecuting, Trigger.size);
    System.debug('Entrando en trigger de escalas de itinerarios');
    // AFTER INSERT
    if ( Trigger.isInsert && Trigger.isAfter) {
        handler.OnAfterInsert_Escala(Trigger.new);
    // AFTER UPDATE
    }else if( Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate_Escala(Trigger.new, Trigger.oldMap);
    }
}