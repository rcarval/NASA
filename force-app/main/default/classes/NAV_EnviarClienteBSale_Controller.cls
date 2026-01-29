/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Oscar Lobos (OL)
Proyecto: Naviera Austral
Descripción: Clase Controller para Visualforce NAV_EnviarClienteBSale_VF
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     10-02-2022   OL       Creación de la Clase.
1.1     10-03-2022   RL       Ajustes para completar funcionalidad.
***********************************************************************************/

public class NAV_EnviarClienteBSale_Controller {
    public String currentRecordId {get;set;}
    public String URLretorno{get;set;}
    public NAV_Integraciones_WS integracionesWS{get;set;}
    public NAV_ClienteBSale_JSON respuestaCliente{get;set;}
    public NAV_Integraciones_SOQL consultasSOQL{get;set;}
    public Account datosCuenta{get;set;}

    public NAV_EnviarClienteBSale_Controller(ApexPages.StandardController controller) {
        //Inicializa variable de Account
        datosCuenta = new Account();

        //Inicializa variables para consultas SOQL
        consultasSOQL = new NAV_Integraciones_SOQL();

        //Inicializa variables para clase integraciones
        integracionesWS = new NAV_Integraciones_WS();

        //Aca empezaria el try-catch

        //Asignacion de ID de la cuenta
        currentRecordId = ApexPages.currentPage().getParameters().get('id');
        
        //Asignacion URL base para funcion de Retorno
        String urlVal = ApexPages.currentPage().getHeaders().get('Referer');

        //Asignacion URLretorno con datos de ID y URL base
        URLretorno = urlVal+currentRecordId;

        //Obtengo los datos de la cuenta
        datosCuenta = consultasSOQL.getAccount(currentRecordId);

        
    }

    //Función que graba datos de la respuesta JSON recibida por BSale
	public void grabarDocumento(){
		// //Si campo ID de BSale viene vacío, registrar respuesta errónea.
        // //Si Id Cliente BSale en Salesforce es vacío y ID Bsale de JSON es distinto de vacío, asociar ID a cuenta.
        // //Si Id Cliente BSale en Salesforce NO es vacío y ID Bsale de JSON es distinto a vacío, guardar mensaje de actualización exitosa.
        // if(respuestaCliente != null && String.isNotBlank(respuestaCliente.error)){
        //     consultasSOQL.registrarRespuestaBSale(respuestaCliente.error, currentRecordId);
        // }else{
        //     if(respuestaCliente == null || String.isBlank(String.valueOf(respuestaCliente.id))){
        //         consultasSOQL.registrarRespuestaBSale('Se ha producido un error, contacte al Administrador', currentRecordId);
        //     }else{
        //         if(String.isBlank(datosCuenta.Id_Cliente_BSale__c) && String.isNotBlank(String.valueOf(respuestaCliente.id))){
        //             consultasSOQL.registrarIdClienteBSale(String.valueOf(respuestaCliente.Id), currentRecordId);
        //         }else{
        //             if(String.isNotBlank(datosCuenta.Id_Cliente_BSale__c) && String.isNotBlank(String.valueOf(respuestaCliente.id))){
        //                 consultasSOQL.registrarRespuestaBSale('Registro actualizado en BSale exitósamente', currentRecordId);
        //             }
        //         }
        //     }
        // }
        
        //Si la cuenta tiene Id_Cliente_BSale__c asignada va a al servicio de PUT de Cliente en BSale
        //Caso contrario va al servicio de POST en BSale 
        if(String.isNotBlank(datosCuenta.Id_Cliente_BSale__c)){
            System.debug('Actualizo datos del Cliente');
            //respuestaCliente = integracionesWs.consumirWSClienteBSalePUT(currentRecordId, datosCuenta);
            NAV_Integraciones_WS.consumirWSClienteBSalePUT(currentRecordId);
        }else{
            System.debug('Inserto datos del Cliente');
            //respuestaCliente = integracionesWs.consumirWSClienteBSalePOST(currentRecordId, datosCuenta);
            NAV_Integraciones_WS.consumirWSClienteBSalePOST(currentRecordId);
        }
	}

	//Retorno registro POST-Consumo de WS de BSale según el ID encontrado
	public PageReference redirect(){
        PageReference acctPage = new PageReference(URLretorno);
        acctPage.setRedirect(true);
        return acctPage;
    }
}