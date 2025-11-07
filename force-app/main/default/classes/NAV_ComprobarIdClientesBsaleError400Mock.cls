/****************************
  Desarrollado por: Nectia
  Autor: Rodrigo López (RL)
  Proyecto: Naviera Austral
  Descripción: Clase Mock para pruebas de Servicio Web Envio de datos a Bsales
 
  ---------------------------------------------------------------------------------
  No. Fecha                Autor                     Descripción
  ------ ---------- ---------------------------------------------------------------
  1.0 06-02-2023            RL                   Creación de Clase.
 *****************************/

 @isTest
 global class NAV_ComprobarIdClientesBsaleError400Mock implements HttpCalloutMock{
    global HTTPResponse respond (HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        String body;
		body = '{\n';
		body =+ '	"error": "document amount is less than the minimum allowed"\n';
		body =+ '}\n';
		res.setStatusCode(400);
		res.setBody(body);
		return res;
	}
}