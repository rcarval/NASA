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
 global class NAV_ComprobarIdClientesBSaleMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        
        //Declaro variable para crear Json
        JSONGenerator jsonGen = JSON.createGenerator(true);
        jsonGen.writeStartObject();
        jsonGen.writeStringField('href','https://api.bsale.cl/v1/clients.json');
        jsonGen.writeNumberField('count',1);
        jsonGen.writeNumberField('limit',25);
        jsonGen.writeNumberField('offset',0);
        jsonGen.writeFieldName('items');
        jsonGen.writeStartArray();
        jsonGen.writeStartObject();
        jsonGen.writeStringField('href','https://api.bsale.cl/v1/clients/10318.json');
        jsonGen.writeNumberField('id',10318);
        jsonGen.writeStringField('firstName','Victor');
        jsonGen.writeStringField('lastName','Ramos');
        jsonGen.writeStringField('email','test@mail.com');
        jsonGen.writeStringField('code','1-9');
        jsonGen.writeStringField('phone','+56988887777');
        jsonGen.writeStringField('company','INVERSIONES Y GESTIÓN TECNOLÓGICA SANTA CRUZ LIMITADA J');
        jsonGen.writeStringField('note','');
        jsonGen.writeStringField('facebook','');
        jsonGen.writeStringField('twitter','');
        jsonGen.writeNumberField('hasCredit',1);
        jsonGen.writeNumberField('maxCredit',1000000.0);
        jsonGen.writeNumberField('state',0);
        jsonGen.writeStringField('activity','Giro Informática');
        jsonGen.writeStringField('city','Puerto Varas');
        jsonGen.writeNumberField('commerciallyBlocked',0);
        jsonGen.writeStringField('municipality','Comuna');
        jsonGen.writeStringField('address','Dirección');
        jsonGen.writeNumberField('companyOrPerson',1);
        jsonGen.writeNumberField('accumulatePoints',0);
        jsonGen.writeNumberField('points',450.0);
        jsonGen.writeNumberField('pointsUpdated',1565372289);
        jsonGen.writeNumberField('sendDte',0);
        jsonGen.writeNumberField('isForeigner',1);
        jsonGen.writeNumberField('prestashopClienId',0);
        jsonGen.writeNumberField('createdAt',1510674658);
        jsonGen.writeNumberField('updatedAt',1675425628);
        jsonGen.writeFieldName('contacts');
        jsonGen.writeStartObject();
        jsonGen.writeStringField('href','https://api.bsale.cl/v1/clients/10318/contacts.json');
        jsonGen.writeEndObject();
        jsonGen.writeFieldName('attributes');
        jsonGen.writeStartObject();            
        jsonGen.writeStringField('href','https://api.bsale.cl/v1/clients/10318/attributes.json');
        jsonGen.writeEndObject();
        jsonGen.writeFieldName('addresses');
        jsonGen.writeStartObject();          
        jsonGen.writeStringField('href','https://api.bsale.cl/v1/clients/10318/addresses.json');
        jsonGen.writeEndObject();
        jsonGen.writeEndObject();
        jsonGen.writeEndArray();
        jsonGen.writeEndObject();
        
        res.setBody(jsonGen.getAsString());
        res.setStatusCode(200);
        return res;
    }
}