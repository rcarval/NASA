/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Controller para Visualforce NAV_EnviaDocumento_VF
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     26-11-2021   RL       Creación de la Clase.
***********************************************************************************/

public class NAV_EnviarDocumento_Controller  {
	public String currentRecordId {get;set;}
	public String URLretorno{get;set;}
	public NAV_Integraciones_WS integracionesWS{get;set;}
	public NAV_Documento_JSON documentoJSON{get;set;}
	public NAV_DetalleDocumentos_JSON detalleDocumentosJSON {get;set;}
	public Documento__c datosDocumento{get;set;}
	public List<Detalle_Documentos__c> datosDetalleDocumentoList {get;set;}
	public NAV_Integraciones_SOQL consultasSOQL{get;set;}
	public Boolean documentoEnviado {get;set;}
	public Boolean mensajeBloqueo {get;set;}

	public NAV_EnviarDocumento_Controller(ApexPages.StandardController controller){
		//Inicializo Variable para Documento__c
		datosDocumento = new Documento__c();
		
		//Inicializo Variable para consultas SOQL
		consultasSOQL = new NAV_Integraciones_SOQL();
		
		//Inicializo Variable para clase de Integraciones
		integracionesWS = new NAV_Integraciones_WS();
		
		//Inicializo Variable que comprueba si documento ya fue enviado en False 
		documentoEnviado = false;

		//Inicializo Variable en falso de variable que debe indicar bloqueo en caso de que la casilla sea verdadera dentro de la VF
		mensajeBloqueo = false;

		try{
			//Asigno Id del registro Detalle Reserva
			currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
			
			//Obtengo URL base para función de Retorno
			String urlVal = ApexPages.currentPage().getHeaders().get('Referer');
			
			//Asigno URLretorno con datos de ID y URL base
			URLretorno = urlVal+currentRecordId;
			
			//Obtengo los datos de Documento en base al ID del registro
			datosDocumento = consultasSOQL.getDatosDocumento(currentRecordId);

			//Retorno en una lista todos los registros de Detalle_Documento__c relacionados al Registro de Documento__c
			//datosDetalleDocumentoList = consultasSOQL.getDatosDetalleDocumentos(currentRecordId);

			
		}catch(Exception ex){
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
		}
	}

	//Función que graba datos de la respuesta JSON recibida por Bsales
	public void grabarDocumento(){
		try{
			//Si el campo Registro Bloqueado es falso o NULO debe permitir el uso del botón, de lo contrario bloquea cualquier función del mismo
			Boolean bloqueoRegistro = false;
			if(datosDocumento.Reenvio_BSale_Bloqueado__c == null){
				bloqueoRegistro = false;
			}else{
				bloqueoRegistro = datosDocumento.Reenvio_BSale_Bloqueado__c;
			}
			if(!bloqueoRegistro){
				//Si los campos PDF Documento y N° Documento están vacíos
				//Se procede a hacer el envío de datos a Bsales
				//De lo contrario, la variable documentoEnviado cambia a True
				if(datosDocumento != null && String.isBlank(datosDocumento.PDF_Documento__c) && String.isBlank(String.valueOf(datosDocumento.N_Documento__c))){
					NAV_Integraciones_WS.consumirWSDocumento(currentRecordId);
					consultasSOQL.registrarFechaReenvioBSale(currentRecordId);
				}else{
					documentoEnviado = true;
				}
			}else{
				documentoEnviado = false;
				mensajeBloqueo = true;
			}
		}catch(Exception ex){
			System.debug('Error');
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
		}
	}

	//Retorno registro POST-Consumo de WS de BSale según el ID encontrado
	public PageReference redirect(){
        PageReference acctPage = new PageReference(URLretorno);
        acctPage.setRedirect(true);
        return acctPage;
    }
}