public  class NAV_ComprobarIdClientesBsaleController {
    public String currentRecordId {get;set;}
    public String URLretorno{get;set;}
    public NAV_Integraciones_WS integracionesWS{get;set;}
    public NAV_Integraciones_SOQL consultasSOQL{get;set;}
    public Account datosCuenta{get;set;}

    public NAV_ComprobarIdClientesBsaleController(ApexPages.StandardController controller) {
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
	public void comprobarClienteBSale(){
		//Caso contrario va al servicio de POST en BSale 
        if(String.isNotBlank(datosCuenta.Id_Cliente_BSale__c)){
            System.debug('Reviso información del cliente en BSale');
            NAV_Integraciones_WS.consumirWSGetClientes(currentRecordId);
        }
	}

    //Retorno registro POST-Consumo de WS de BSale según el ID encontrado
	public PageReference redirect(){
        PageReference acctPage = new PageReference(URLretorno);
        acctPage.setRedirect(true);
        return acctPage;
    }
}