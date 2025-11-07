/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para Trigger de manejo de itinerarios
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     23-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
public with sharing class NAV_ItinerarioTriggerHandler {
    private NAV_ItinerarioTriggerHelper helper { get; set; }
    public Boolean isExecuting = false;
    public Integer BatchSize = 0;
    public Decimal ValidExecution = 1;
    public Boolean isAdmin { get; set; }
    public NAV_ItinerarioTriggerHandler (Boolean isExecuting, Integer size){
        isExecuting = isExecuting;
        BatchSize = size;
        helper = new NAV_ItinerarioTriggerHelper();
        isAdmin = false;
        Id ProfileId = UserInfo.getProfileId();
        String profileName = [SELECT Name FROM Profile WHERE Id =: ProfileId].Name;
        if(profileName == 'Administrador del sistema'){
            isAdmin = true;
        }
    }
    /** START Itinerario After Insert **/
    public void OnAfterInsert_Itinerario(Programacion_de_Itinerario__c[] newData){
        if(!NAV_ItinerarioTriggerHelper.runOnce){
            helper.creaItinerarios(newData);
        }
    }
    /** END Itinerario After Insert **/
}