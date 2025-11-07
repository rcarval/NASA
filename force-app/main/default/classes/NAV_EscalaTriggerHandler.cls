/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para Trigger de manejo de escalas
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     25-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
public with sharing class NAV_EscalaTriggerHandler {
    private NAV_EscalaTriggerHelper helper { get; set; }
    public Boolean isExecuting = false;
    public Integer BatchSize = 0;
    public Decimal ValidExecution = 1;
    public Boolean isAdmin { get; set; }
    public NAV_EscalaTriggerHandler (Boolean isExecuting, Integer size){
        isExecuting = isExecuting;
        BatchSize = size;
        helper = new NAV_EscalaTriggerHelper();
        isAdmin = false;
        Id ProfileId = UserInfo.getProfileId();
        String profileName = [SELECT Name FROM Profile WHERE Id =: ProfileId].Name;
        if(profileName == 'Administrador del sistema'){
            isAdmin = true;
        }
    }
    /** START Escala After Insert **/
    public void OnAfterInsert_Escala(Escalas_Itinerario__c[] newData){
        System.debug('Entrando a After Insert');
        //if(!NAV_EscalaTriggerHelper.runOnce){
            helper.creaEscalas(newData);
            NAV_EscalaTriggerHelper.runOnce = true;
        //}
    }
    /** END Escala After Insert **/
    /** START Escala Before Update **/
    public void OnAfterUpdate_Escala(Escalas_Itinerario__c[] newData, Map<Id,Escalas_Itinerario__c> oldMap){
        System.debug('Entrando a After Update');
        if(!NAV_EscalaTriggerHelper.runOnce){
            helper.validaModificaciones(newData, oldMap);
            NAV_EscalaTriggerHelper.runOnce = true;
        }
    }
    /** END Escala Before Update **/
}