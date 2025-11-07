/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Trigger de Programacion de itinerarios
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     23-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
trigger NAV_ProgramacionItinerariosTrigger on Programacion_de_Itinerario__c (after insert) {
    if(System.isFuture() || System.isBatch()) return;
    // BEFORE INSERT
    System.debug('Entrando en trigger de itinerarios');
    if ( Trigger.isInsert && Trigger.isAfter) {
        //Clase Apex que controla lo que suceda en este Trigger
        NAV_ItinerarioTriggerHandler  handler = new NAV_ItinerarioTriggerHandler(Trigger.isExecuting, Trigger.size);
        handler.OnAfterInsert_Itinerario(Trigger.new);
    }
}