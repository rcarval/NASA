/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase deserializadora de respuesta del servicio /documents.json
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     09-11-2021   RL       Creación de la Clase.
***********************************************************************************/


public class NAV_Documento_JSON  {
	public class References {
		public String href {get;set;} 
	}
	
	public String href {get;set;} 
	public Integer id {get;set;} 
	public Integer emissionDate {get;set;} 
	public Integer expirationDate {get;set;} 
	public Integer generationDate {get;set;} 
	public double number_Z {get;set;} // in json: number
	public String serialNumber {get;set;} 
	public Double totalAmount {get;set;} 
	public Double netAmount {get;set;} 
	public Double taxAmount {get;set;} 
	public Double exemptAmount {get;set;} 
	public Double exportTotalAmount {get;set;} 
	public Double exportNetAmount {get;set;} 
	public Double exportTaxAmount {get;set;} 
	public Double exportExemptAmount {get;set;} 
	public Double commissionRate {get;set;} 
	public Double commissionNetAmount {get;set;} 
	public Double commissionTaxAmount {get;set;} 
	public Double commissionTotalAmount {get;set;} 
	public Double percentageTaxWithheld {get;set;} 
	public Double purchaseTaxAmount {get;set;} 
	public Double purchaseTotalAmount {get;set;} 
	public String address {get;set;} 
	public String municipality {get;set;} 
	public String city {get;set;} 
	public String urlTimbre {get;set;} 
	public String urlPublicView {get;set;} 
	public String urlPdf {get;set;} 
	public String urlPublicViewOriginal {get;set;} 
	public String urlPdfOriginal {get;set;} 
	public String token {get;set;} 
	public Integer state {get;set;} 
	public String urlXml {get;set;} 
	public String ted {get;set;} 
	public String salesId {get;set;} 
	public Integer informedSii {get;set;} 
	public String responseMsgSii {get;set;} 
	public Document_type document_type {get;set;} 
	public Document_type client {get;set;} 
	public Document_type office {get;set;} 
	public Document_type user {get;set;} 
	public Document_type coin {get;set;} 
	public References references {get;set;} 
	public References document_taxes {get;set;} 
	public References details {get;set;} 
	public References sellers {get;set;} 
	public References attributes {get;set;} 
	public String error {get;set;}

	public class Document_type {
		public String href {get;set;} 
		public String id {get;set;} 
	}
	
	
	public static NAV_Documento_JSON parse(String json) {
		return (NAV_Documento_JSON) System.JSON.deserialize(json, NAV_Documento_JSON.class);
	}
}