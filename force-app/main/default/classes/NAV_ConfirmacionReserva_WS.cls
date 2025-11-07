public with sharing class NAV_ConfirmacionReserva_WS {
    // Endpoint y configuración
    private static final String DEVELOPER_NAME = 'ReservationConfirmed';  
    

    
    // Método principal para enviar confirmación de reserva
    public static void sendReservationConfirmation(Id contactId, Id reservaId) {
        try {
            // Obtener datos necesarios (id de reserva e id de contacto)
            Map<String, Object> reservationData = getReservationData(contactId, reservaId);
            if(reservationData == null) {
                System.debug('No se pudo obtener datos de la reserva o contacto');
                return;
            }
            
            
            // Realizar el llamado HTTP
            HttpResponse response = makeApiCall(reservationData);
            
            // Procesar respuesta
            processResponse(response, reservaId);
            
        } catch(Exception ex) {
            System.debug('Error en sendReservationConfirmation: ' + ex.getMessage());
            System.debug(ex.getStackTraceString());
        }
    }
    

    // Método para obtener datos de reserva y contacto
    private static Map<String, Object> getReservationData(Id contactId, Id reservaId) {
        List<Reserva__c> reservas = [
            SELECT Id, Name, Contacto_Reserva__r.Name, 
                   Itinerario_asociado__r.Fecha_Reprogramacion__c
            FROM Reserva__c 
            //el WHERE por los 2 ID para dar con la reserva especifica
            WHERE Id = :reservaId AND Contacto_Reserva__c = :contactId
            LIMIT 1
        ];
        //si reservas resulta vacío vacío devolverá null
        if(reservas.isEmpty()) 
            return null;
        
        //Accede al primer elemento de la lista que es reserva con el id de contacto y de reserva
        Reserva__c reserva = reservas[0];
        
        //crea y devuelve un mapa con los datos de la reserva, organizados cómo clave:Vlaor
        return new Map<String, Object>{
            'nombrePasajero' => reserva.Contacto_Reserva__r.Name,
            'numeroReserva' => reserva.Name,
            'fechaEmbarque' => reserva.Itinerario_asociado__r.Fecha_Reprogramacion__c
        };
    }



    // Método para construir el cuerpo de la solicitud
    private static Map<String, Object> buildRequestBody(String nombrePasajero, String numeroReserva, Datetime fechaEmbarque, integracion_Yellow__mdt integracion) {
        //Convertir el DateTime
        //Verifica is fechaEmbarque no es nullo
        String fechaFormateada = fechaEmbarque != null? 
            //método que formatea la fecha en zona horaria GMT 
            fechaEmbarque.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : 
            '';
            
          //return crea una dicc compuesta??(preguntar como llamarla)  
        return new Map<String, Object>{
            //identificador del bot,  sender, data(Recipiente de la otra lista)
            'botId' => integracion.BotId__c,
            'sender' => integracion.Sender__c,
            //almacena el evento que se va a enviar
            'data' => new Map<String, Object>{
                'event' => new Map<String, Object>{
                    //almacena el tipo de evento 
                    'code' => integracion.Code__c,
                    //almacena nombrel, numero de reserva, y fecha del embarque(con formato nuevo) del pasajero
                    'data' => new Map<String, Object>{
                        'Nombre_Pasajero' => nombrePasajero,
                        'Numero_Reserva' => numeroReserva,
                        'Fecha_Embarque' => fechaFormateada
                    }
                }
            }
        };
    }
    
        // Método estático para verificar metadata
        private static integracion_Yellow__mdt getMetadata() {
            if(Test.isRunningTest()) {
                return new Integracion_Yellow__mdt(DeveloperName = 'ReservationConfirmed',
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
    

    // Método para realizar llamado HTTP del servicio externo
    private static HttpResponse makeApiCall(Map<String, Object> reservationData) {
        //configuración se la solicitud  HTTP
        //objteto request que almacena los parametros de la llamada

        integracion_Yellow__mdt integracion = getMetadata();

        String url = integracion.Endpoint__c;
        String metodo = integracion.Metodo__c;
        Integer timeout = (Integer) integracion.TimeOut__c;
        Map<String, String> mapHeaderParams = new Map<String, String>{
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
            'x-api-key' => integracion.Api_key__c
        };

        // Construir el cuerpo (JSON) de la solicitud
        Map<String, Object> requestBody = buildRequestBody(
            (String)reservationData.get('nombrePasajero'),
            (String)reservationData.get('numeroReserva'),
            (Datetime)reservationData.get('fechaEmbarque'),
            //recibe toda la info de la metadata 
            integracion
        );


        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);//establece la url de la api que se va a consumir
        request.setMethod(metodo);//tipo de metodo de la solicciutd (POST)
        request.setBody(JSON.serialize(requestBody));///convierte el mapa en formato JSON
        request.setTimeout(timeout); // estabblece el tiempo de espera a la respuesta 12 segundos de timeout

        if (mapHeaderParams != null && !mapHeaderParams.isEmpty()) {
            for (String sParam : mapHeaderParams.keySet()) {
                request.setHeader(sParam, mapHeaderParams.get(sParam));
            }
        }

        //envio de la solicitud
        Http http = new Http();
        //envia la solicitud configurada 
        return http.send(request);
    }
    
    // Método para manejar la respuesta
    private static void processResponse(HttpResponse response, Id reservaId) {
        //logs del estado de la respuesta 
        System.debug('Código de estado HTTP: ' + response.getStatusCode());
        System.debug('Respuesta del servidor: ' + response.getBody());
        
        //indica éxito de la llamada
        if(response.getStatusCode() == 200) {
            System.debug('Confirmación enviada exitosamente para reserva: ' + reservaId);
        //Cualquier código distinto de 200 se considera error
        } else {
            System.debug('Error al enviar confirmación para reserva: ' + reservaId);
        }
    }
}