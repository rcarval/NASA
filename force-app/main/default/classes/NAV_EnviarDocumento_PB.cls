public class NAV_EnviarDocumento_PB  {
	public static NAV_Integraciones_WS integracionesWS{get;set;}
	public static NAV_Integraciones_SOQL consultasSOQL{get;set;}
	
	@InvocableMethod(label='Consumir WS Documento BSale' description='Consumir WS Documento BSale')
	public static void ConsumoWSDocumentoBSale(List<Id> inputParams) {
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
		
				
				//Obtengo los datos de Documento en base al ID del registro
				Documento__c datosDocumento = consultasSOQL.getDatosDocumento(currentRecordId);

				//Si los campos PDF Documento y N° Documento están vacíos
				//Se procede a hacer el envío de datos a Bsales
				//De lo contrario, la variable documentoEnviado cambia a True
				if(String.isBlank(datosDocumento.PDF_Documento__c) && String.isBlank(String.valueOf(datosDocumento.N_Documento__c))){
					NAV_Integraciones_WS.consumirWSDocumento(currentRecordId);
				}
			}		
		}catch(Exception ex){
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
		}
	}
}