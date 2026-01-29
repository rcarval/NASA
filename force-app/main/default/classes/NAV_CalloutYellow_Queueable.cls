public class NAV_CalloutYellow_Queueable implements Queueable {
    private String estadoItinerario;
    private List<Reserva__c> lstReserva;
    private static final String DEVELOPER_NAME = 'ItineraryUpdate';

    // Método estático para verificar metadata
    private static integracion_Yellow__mdt getMetadata() {
        if(Test.isRunningTest()) {
            return new Integracion_Yellow__mdt(DeveloperName = 'ItineraryUpdate',
            Endpoint__c = 'https://test.api.yellow.com',
            Api_key__c = 'test-api-key-123',
            Code__c = 'TEST_EVENT_CODE',
            Metodo__c = 'POST',
            Sender__c = 'EXAMPLE',
            botId__c = 'YELLOW_BOT_TEST',
            TimeOut__c = 120000);
        }
            // Consulta real solo si no es test o si no hay mock
            return [SELECT Endpoint__c, Api_key__c, Code__c, Metodo__c,
                    Sender__c, botId__c, TimeOut__c 
                    FROM integracion_Yellow__mdt 
                    WHERE DeveloperName = :DEVELOPER_NAME
                    LIMIT 1]; 
        
        

    }

    // Constructor
    public NAV_CalloutYellow_Queueable(String estadoItinerario, List<Reserva__c> lstReserva) {
        this.estadoItinerario = estadoItinerario;
        this.lstReserva = lstReserva;
    }

    // Método execute requerido por la interfaz Queueable
    public void execute(QueueableContext context) {
        // Iterar sobre la lista de reservas y realizar la llamada HTTP para cada una
        for (Reserva__c reserva : lstReserva) {
            llamarServicioYellow(estadoItinerario, reserva);
        }
    }

    // Método para realizar la llamada HTTP
    private static void llamarServicioYellow(String estadoItinerario, Reserva__c reserva) {

        integracion_Yellow__mdt integracion = getMetadata();

        String url = integracion.Endpoint__c;
        String metodo = integracion.Metodo__c;
        Integer timeout = (Integer) integracion.TimeOut__c;
        Map<String, String> mapHeaderParams = new Map<String, String>{
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
            'x-api-key' => integracion.Api_key__c
        };

        try{
            
            Datetime miFechaHora = reserva.Fecha_Hora_de_Viaje__c;
            String fechaFormateada = miFechaHora.format('dd-MM-yyyy HH:mm (a)');
            
            System.debug('fechaFormateada-->'+fechaFormateada);

            // Crear el cuerpo JSON
            JSONGenerator jsonGen = JSON.createGenerator(true);
            jsonGen.writeStartObject();
            jsonGen.writeStringField('botId', integracion.botId__c);
            jsonGen.writeStringField('sender', integracion.Sender__c);
            jsonGen.writeFieldName('data');
            jsonGen.writeStartObject();
            jsonGen.writeFieldName('event');
            jsonGen.writeStartObject();
            jsonGen.writeStringField('code', integracion.Code__c);
            jsonGen.writeFieldName('data');
            jsonGen.writeStartObject();
            //jsonGen.writeStringField('Nombre_Itinerario', reserva.Itinerario_asociado__r.Nombre_Ruta__r.Name); 
			jsonGen.writeStringField('Nombre_Itinerario', reserva.Puerto_ORIGEN__r.Name );
            jsonGen.writeStringField('Estado_Itinerario', estadoItinerario);
            jsonGen.writeStringField('Fecha_Hora_Reprogramacion', fechaFormateada);
            jsonGen.writeStringField('Ruta', reserva.Ruta__c);
            jsonGen.writeStringField('Nave', reserva.Nave__c);
            jsonGen.writeStringField('Nombre_Contacto', reserva.Contacto_Reserva__r.Name);
            jsonGen.writeStringField('Correo_Contacto', reserva.Correo_Contacto__c);
            jsonGen.writeStringField('Telefono_Contacto', reserva.Telefono_Contacto__c);
            jsonGen.writeStringField('Codigo_Reserva', reserva.Name);
            jsonGen.writeEndObject();
            jsonGen.writeEndObject();
            jsonGen.writeEndObject();
            jsonGen.writeEndObject();

            String jsonString = jsonGen.getAsString();
            System.debug('Request: ' + jsonString);

            // Realizar la llamada HTTP
            sendApi(url, metodo, mapHeaderParams, jsonString, timeout);
            //System.debug('Response body: ' + retornoHtml.getBody());
        }catch(Exception ex){
            System.debug('Error: '+ex.getMessage());
            System.debug(ex.getStackTraceString());
        }

    }

    // Método para enviar la solicitud HTTP
    @future(callout=true)
    private static void sendApi(String sUrl, String sMethod, Map<String, String> mapHeaderParams, String jsonStr, Integer timeOut) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(sUrl);
        request.setMethod(sMethod);
        request.setTimeout(timeOut);

        if (mapHeaderParams != null && !mapHeaderParams.isEmpty()) {
            for (String sParam : mapHeaderParams.keySet()) {
                request.setHeader(sParam, mapHeaderParams.get(sParam));
            }
        }

        if (String.isNotBlank(jsonStr)) {
            request.setBody(jsonStr);
        }

        HttpResponse response = new HttpResponse();
        try {
            response = http.send(request);
            System.debug('Response: ' + response.getBody());
        } catch (CalloutException e) {
            System.debug('Exception: ' + e.getMessage());
        }
    }
}