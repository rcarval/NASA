public class NAV_EnviarClienteBSale_Invocable  {
	public static NAV_Integraciones_WS integracionesWS{get;set;}
	public static NAV_Integraciones_SOQL consultasSOQL{get;set;}
	
	@InvocableMethod(label='Consumir WS Cliente BSale' description='Consumir WS Cliente BSale')
	public static void ConsumoWSClienteBSale(List<Id> inputParams) {
		try{
			Set<Id> listaIds = new Set<Id>();
			listaIds.addAll(inputParams);
			System.debug('IDs de entrada');
			System.debug(inputParams);
			for(Id currentRecordId : inputParams){
				//Inicializo Variable para consultas SOQL
				consultasSOQL = new NAV_Integraciones_SOQL();
		
				//Inicializo Variable para clase de Integraciones
				integracionesWS = new NAV_Integraciones_WS();
				
				//Obtengo los datos de la cuenta
				Account datosCuenta = consultasSOQL.getAccount(currentRecordId);

				//Si la cuenta tiene Id_Cliente_BSale__c asignada va a al servicio de PUT de Cliente en BSale
                //Caso contrario va al servicio de POST en BSale 
                if(String.isNotBlank(datosCuenta.Id_Cliente_BSale__c)){
                    System.debug('Actualizo datos del Cliente');
                    NAV_Integraciones_WS.consumirWSClienteBSalePUT(currentRecordId);
                }else{
                    System.debug('Inserto datos del Cliente');
                    NAV_Integraciones_WS.consumirWSClienteBSalePOST(currentRecordId);
                }
			}		
		}catch(Exception ex){
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
		}
	}
}