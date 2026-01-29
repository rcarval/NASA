/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Naviera Austral
  Descripción: Clase Mock para pruebas de Servicio Web Envio de datos a Bsales
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 30-11-2021            RL                   Creación de Clase.
 *****************************/

@isTest
global class NAV_EnviarDocumento_Exception_Mock implements HTTPCalloutMock {
	global HTTPResponse respond (HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        String body;
		
		body = '{\n';
		body =+ '	"href": "https://api.bsale.cl/v1/documents/185340.json",\n';
		body =+ '	"id": 185340,\n';
		body =+ '	"emissionDate": 1565049600,\n';
		body =+ '	"expirationDate": 1565049600,\n';
		body =+ '	"generationDate": 1638287715,\n';
		body =+ '	"number": 1326,\n';
		body =+ '	"serialNumber": null,\n';
		body =+ '	"totalAmount": 1190,\n';
		body =+ '	"netAmount": 1000,\n';
		body =+ '	"taxAmount": 190,\n';
		body =+ '	"exemptAmount": 0,\n';
		body =+ '	"exportTotalAmount": 0,\n';
		body =+ '	"exportNetAmount": 0,\n';
		body =+ '	"exportTaxAmount": 0,\n';
		body =+ '	"exportExemptAmount": 0,\n';
		body =+ '	"commissionRate": 0,\n';
		body =+ '	"commissionNetAmount": 0,\n';
		body =+ '	"commissionTaxAmount": 0,\n';
		body =+ '	"commissionTotalAmount": 0,\n';
		body =+ '	"percentageTaxWithheld": 0,\n';
		body =+ '	"purchaseTaxAmount": 0,\n';
		body =+ '	"purchaseTotalAmount": 0,\n';
		body =+ '	"address": "Dirección",\n';
		body =+ '	"municipality": "Comuna",\n';
		body =+ '	"city": "Desierto",\n';
		body =+ '	"urlTimbre": null,\n';
		body =+ '	"urlPublicView": "https://app2.bsale.cl/view/18790/ac5f622d4a09?sfd=99",\n';
		body =+ '	"urlPdf": "https://app2.bsale.cl/view/18790/ac5f622d4a09.pdf?sfd=99",\n';
		body =+ '	"urlPublicViewOriginal": "https://app2.bsale.cl/view/18790/ac5f622d4a09",\n';
		body =+ '	"urlPdfOriginal": "https://app2.bsale.cl/view/18790/ac5f622d4a09.pdf",\n';
		body =+ '	"token": "ac5f622d4a09",\n';
		body =+ '	"state": 0,\n';
		body =+ '	"urlXml": "https://api.bsale.cl/v1/18790/files/ac5f622d4a09.xml",\n';
		body =+ '	"ted": null,\n';
		body =+ '	"salesId": null,\n';
		body =+ '	"informedSii": 2,\n';
		body =+ '	"responseMsgSii": null,\n';
		body =+ '	"document_type": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/document_types/10.json",\n';
		body =+ '		"id": "10"\n';
		body =+ '	},\n';
		body =+ '	"client": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/clients/10318.json",\n';
		body =+ '		"id": "10318"\n';
		body =+ '	},\n';
		body =+ '	"office": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/offices/1.json",\n';
		body =+ '		"id": "1"\n';
		body =+ '	},\n';
		body =+ '	"user": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/users/648.json",\n';
		body =+ '		"id": "648"\n';
		body =+ '	},\n';
		body =+ '	"coin": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/coins/1.json",\n';
		body =+ '		"id": "1"\n';
		body =+ '	},\n';
		body =+ '	"references": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/documents/185340/references.json"\n';
		body =+ '	},\n';
		body =+ '	"document_taxes": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/documents/185340/document_taxes.json"\n';
		body =+ '	},\n';
		body =+ '	"details": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/documents/185340/details.json"\n';
		body =+ '	},\n';
		body =+ '	"sellers": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/documents/185340/sellers.json"\n';
		body =+ '	},\n';
		body =+ '	"attributes": {\n';
		body =+ '		"href": "https://api.bsale.cl/v1/documents/185340/attributes.json"\n';
		body =+ '	}\n';
		body =+ '}\n';
		res.setStatusCode(200);
		res.setBody(body);
		
		return res;
	}
}