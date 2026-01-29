/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase tipo modelo para ejecución de consultas SOQL de clase NAV_Integraciones_WS
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     09-11-2021   RL       Creación de la Clase.
2.0     10-02-2022   OL		  Métodos para integración Clientes-BSale.
2.1	    03-03-2022	 RL		  Se agrega métodos para consulta de metadatos de atributos dinámicos
***********************************************************************************/


public class NAV_Integraciones_SOQL  {
	//Método que devuelve valor de Token de Bsale almacenado en metadata
	public api_bsale_token__mdt getToken(){
		//api_bsale_token__mdt token = [SELECT access_token__c FROM api_bsale_token__mdt WHERE MasterLabel = 'access_token_bsale'];
		api_bsale_token__mdt token = api_bsale_token__mdt.getInstance('access_token_bsale');
		return token;
	}
	public api_bsale_token_puelche__mdt getTokenPuelche(){
		//api_bsale_token__mdt token = [SELECT access_token__c FROM api_bsale_token__mdt WHERE MasterLabel = 'access_token_bsale'];
		api_bsale_token_puelche__mdt token = api_bsale_token_puelche__mdt.getInstance('access_token_bsale');
		return token;
	}
	//public api_bsale__mdt getWsTipoDocumentos(){
		//api_bsale__mdt datosWs = [SELECT Id, ws_endpoint__c, tipo_ws_documento__c FROM api_bsale__mdt WHERE MasterLabel = 'get_tipo_documentos'];
		//return datosWs;
	//}

	//Método que devuelve datos para consumo de WS para envío de documento a Bsale
	public api_bsale__mdt getWsEnvioDocumento(){
		//api_bsale__mdt datosWs = [SELECT Id, ws_endpoint__c, tipo_ws_documento__c FROM api_bsale__mdt WHERE MasterLabel = 'envio_documento'];
		api_bsale__mdt datosWs = api_bsale__mdt.getInstance('envio_documento');
		return datosWs;
	}

	//Método que devuelve datos para consumo de WS para envío de nota de crédito a Bsale
	public api_bsale__mdt getWsEnvioNcDocumento(){
		api_bsale__mdt datosWs = api_bsale__mdt.getInstance('envio_nota_credito');
		return datosWs;
	}

	//Método que devuelve datos para consumo de WS para envío de nota de crédito a Bsale
	public api_bsale_condicion_venta__mdt getIdCondicionVenta(String condicionVenta){
		api_bsale_condicion_venta__mdt datosWs = api_bsale_condicion_venta__mdt.getInstance(condicionVenta);
		return datosWs;
	}
    
	//Método que devuelve datos del registro en Documento__c
	public Documento__c getDatosDocumento(String idDocumento){
		try{
			Documento__c datosDocumento = [SELECT Id, Name, 
										   Acreditacion__c, Tipo_de_Documento__c, 
										   Office_Id__c, Fecha_Emision_Json__c, 
										   Fecha_Vencimiento_Json__c, Declarar_Documento_a_SII__c,
										   RUT_Cliente__c, Ciudad_Cliente__c, 
										   Razon_Social__c, Comuna_Cliente__c, Giro_Cliente__c, 
										   Direccion_Cliente__c, Correo_Cliente__c,
										   Enviar_Documento_a_Cliente__c, N_Documento__c,
										   PDF_Documento__c, Folio_referencia__c,
										   Fecha_Documento_Referencia_Json__c, 
										   Referencia__c,
										   Acreditacion__r.Destinatario_documentos__c,
										   Acreditacion__r.Destinatario_documentos__r.Id_Cliente_BSale__c,
										   Reserva__c, Nave__c,
										   Fecha_zarpe__c, Tramo__c, Documento_Principal__r.Id_Documento_Bsale__c,
										   Motivo_Devolucion__c, Tipo_de_Nota_de_Credito__c,
										   Tipo_de_Devolucion__c, Acreditacion__r.Total_a_acreditar__c,
										   Condicion_de_Venta__c, Contacto_Reserva__c,
										   TipoIdentificacion__c, Reenvio_BSale_Bloqueado__c,
										   CodigoTipoDocReferencia__c, Json_BSale__c,
										   Total_Neto__c, RecordTypeId,
                                           Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c
										   FROM Documento__c 
										   WHERE Id =: idDocumento];
			return datosDocumento;
		}catch(Exception ex){
			System.debug('Error en SOQL Query getDatosDocumento');
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
			return null;
		}
	}

	//Método que devuelve una Lista de registros de Detalle Documento asociados al registro de Documento
	public List<Detalle_Documentos__c> getDatosDetalleDocumentos(String idDocumento){
		try{
			List<Detalle_Documentos__c> datosDetallesDocumento = [SELECT Id, Name, 
																  Documento__c, Descripcion__c, 
																  Cantidad__c, Tax_Id__c, 
																  Valor_Unitario_Neto__c, Descuento__c,
																  Detalle_Documento_Principal__r.Id_Detalle_Documento_Bsale__c 
																  FROM Detalle_Documentos__c 
																  WHERE Documento__c =: idDocumento];
			return datosDetallesDocumento;
		}catch(Exception ex){
			System.debug('Error en SOQL Query getDatosDetalleDocumentos');
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
			return null;
		}
	}

	//Metodo que devuelve la lista de Referencias del Documento
	public List<Referencia_Documento__c> getReferenciasDocumentos(String idDocumento){
		try{
			List<Referencia_Documento__c> referenciasDocumento = [SELECT Id, Name, Documento__c, Fecha__c, Folio__c, Referencia__c,Tipo_Documento__c
																  FROM Referencia_Documento__c
																  WHERE Documento__c =: idDocumento];
			return referenciasDocumento;
		}catch(Exception ex){
			System.debug('Error en SOQL Query getReferenciasDocumentos');
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
			return null;
		}
	}

	//Registra N° de Documento y PDF Documento cuando el JSON de Bsale retorna informacíón post consumo de WS
	public void registrarDocumentoBsale(String idDocumento, Double nroDocumento, String rutaPDF, String urlDetalleDocumentos, String idDocumentoBsale, String json){
		Documento__c documento = new Documento__c();
		documento.Id = idDocumento;
		documento.N_Documento__c = nroDocumento;
		documento.PDF_Documento__c = rutaPDF;
		documento.URL_Detalle_Documentos__c = urlDetalleDocumentos;
		documento.Id_Documento_Bsale__c = idDocumentoBsale;
		documento.Respuesta_BSale__c = 'Documento emitido exitósamente en BSale.';
		documento.Reenvio_BSale_Bloqueado__c = true;
		documento.Json_BSale__c = json;
		update documento;
	}

	//Actualizo campo Respuesta_BSale__c del registro de Documento
	public void registrarRespuestaBSaleDocumento(String respuestaBSale, String idDocumento, String json){
		Documento__c documento = new Documento__c();
		documento.Id = idDocumento;
		documento.Respuesta_BSale__c = respuestaBSale;
		documento.Reenvio_BSale_Bloqueado__c = true;
		documento.Json_BSale__c = json;
		update documento;
	}

	//Registro la fecha de reenvío a bsale del Documento
	public void registrarFechaReenvioBSale(String idDocumento){
		Documento__c documento = new Documento__c();
		documento.Id = idDocumento;
		documento.Fecha_Reenvio_BSale__c = datetime.now();
		update documento;
	}

	//Registra Id Detalle Documento de BSale en Detalle Documentos cuando el JSON de Bsale retorna información post consumo de WS
	public void registrarIdDetalleDocumentosBsale(List<Detalle_Documentos__c> datosDetalleDocumentoList, NAV_DetalleDocumentos_JSON detalleDocumentosJSON){
		//Declaro lista de Detalle_Documento__c para actualizar registros
		List<Detalle_Documentos__c> detalleDocumentosToUpdate = new List<Detalle_Documentos__c>();
		
		//Recorro lista de registros de Detalle Documentos
		for(Detalle_Documentos__c detalleDocumento : datosDetalleDocumentoList){
			Detalle_Documentos__c detalleDocumentoToAdd = new Detalle_Documentos__c();
			//Asigno Id de Detalle Documento a Registro a Agregar
			detalleDocumentoToAdd.Id = detalleDocumento.Id;
			//Recorro Listado de Items de Respuesta JSON de Detalles Documentos BSale
			for(NAV_DetalleDocumentos_JSON.Items item : detalleDocumentosJSON.items){
				//Si campo Description de respuesta JSON es igual a la Descripción del registro Detalle_Documento__c de SF
				//Asocio el Id de Bsale
				if(item.variant.description == detalleDocumento.Descripcion__c){
					detalleDocumentoToAdd.Id_Detalle_Documento_Bsale__c = String.valueOf(item.id);
				}
			}

			//Agrego Registro para lista de Updates
			detalleDocumentosToUpdate.add(detalleDocumentoToAdd);
		}
		
		//Si lista de updates es mayor a 0 procedo a actualizar registro
		if(detalleDocumentosToUpdate.size() > 0){
			update detalleDocumentosToUpdate;
		}	
	}

	//Actualizo Id de Registro BSale en registro de Cuenta
	public void registrarIdClienteBSale(String idClienteBsale, String idCliente, String stateCliente){
		Account cuenta = new Account();
		cuenta.Id = idCliente;
		cuenta.Id_Cliente_BSale__c  = idClienteBsale;
		cuenta.Respuesta_BSale__c = 'Registrado exitósamente en BSale';
		cuenta.Comprobacion_BSale__c = stateCliente;
		update cuenta;
	}

	//Actualizo campo Respuesta_BSale__c del registro de Cuenta
	public void registrarRespuestaBSale (String respuestaBSale, String idCliente){
		Account cuenta = new Account();
		cuenta.Id = idCliente;
		cuenta.Respuesta_BSale__c = respuestaBSale;
		update cuenta;
	}

	//Actualizo campo Comprobacion_BSale__c del registro de Cuenta
	public void registrarIdsStatesCliente(String idCliente, String respuestaBSale){
		Account cuenta = new Account();
		cuenta.Id = idCliente;
		cuenta.Comprobacion_BSale__c = respuestaBSale;
		update cuenta;
	}

    //Método que devuelve datos para consumo WS para POST de clientes en BSale
    public api_bsale__mdt getWsPostCliente(){
        api_bsale__mdt datosWs = api_bsale__mdt.getInstance('post_cliente');
        return datosWs;
    }	

	//Método que devuelve datos para consumo WS para PUT de clientes en BSale
    public api_bsale__mdt getWsPutCliente(){
        api_bsale__mdt datosWs = api_bsale__mdt.getInstance('put_cliente');
        return datosWs;
    }	

	//Método que retorna datos de registro de Account
	public Account getAccount(string idAccount){
		try{
		Account acc = [SELECT 	Id, Id_Cliente_BSale__c, 
					   RUT_formato__c,  LastName, 
					   FirstName, PersonEmail, 
					   Phone, BillingStreet, 
					   BillingPostalCode, BillingCity, 
					   BillingState, BillingCountry,
					   Razon_Social__c, RecordType.DeveloperName,
					   Name, Tipo_de_identificacion__c,
					   Giro__c
					   FROM Account 
					   WHERE Id =: idAccount];
			return acc;
		}catch(Exception ex){
			System.debug('Error en SOQL Query getAccount');
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
			return null;
		}
	}	

	//Método que construye URL para WS PUT Clientes BSale
	// public String urlPutBSale (String preUrl, String idBSale){
	// 	//Se crean parametros para el metodo replace
	// 	String targetJSON = '.json';
	// 	String replacement = '/';

	// 	//Se almacena en urlFinal la cadena que reemplaza .json por /
	// 	String urlFinal = preUrl.replace(targetJSON, replacement);

	// 	//Se concatena lo anterior con la idBsale y la variable .json
	// 	urlFinal += idBSale+targetJSON;

	// 	//Devuelve la url final para el WS de PUT
	// 	return urlFinal;
	// }

	//Método que devuelve atributos para Factura Afecta en BSale
    public api_bsale_atributos_documentos__mdt getAtributosDinamicosFacturaAfecta(){
        api_bsale_atributos_documentos__mdt datosWs = api_bsale_atributos_documentos__mdt.getInstance('factura_nasa');
        return datosWs;
    }
	
	//Método que devuelve atributos para Factura Exenta en BSale
    public api_bsale_atributos_documentos__mdt getAtributosDinamicosFacturaExenta(){
        api_bsale_atributos_documentos__mdt datosWs = api_bsale_atributos_documentos__mdt.getInstance('factura_exenta_nasa');
        return datosWs;
    }	

	//Método que devuelve atributos para Factura Exenta en BSale
    public api_bsale_atributos_documentos__mdt getAtributosDinamicosBoleta(){
        api_bsale_atributos_documentos__mdt datosWs = api_bsale_atributos_documentos__mdt.getInstance('boleta_nasa');
        return datosWs;
    }	
}