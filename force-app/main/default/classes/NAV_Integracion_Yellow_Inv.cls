public class NAV_Integracion_Yellow_Inv {
    
    public static String varRequest = '';
    public static String varResponse = '';
    
    public class FlowInputs {         
        @InvocableVariable public Id IdItinerario;         
        @InvocableVariable public String origenDestinoRuta;         
        @InvocableVariable public String estadoItinerario;         
        @InvocableVariable public DateTime fechaHoraReprogramacion;         
    }    
    
    @InvocableMethod(label='Integrar Yellow' description='Metodo que permite integrar Salesforce con Yellow' category='Programacion_de_Itinerario__c')
    public static void integrarYellow(List<FlowInputs> request) {
        


        List<Reserva__c> lstReservaUpdate = [
            SELECT Id, Puerto_ORIGEN__r.Name, Itinerario_asociado__c, Fecha_Hora_de_Viaje__c
            FROM Reserva__c 
            WHERE Itinerario_asociado__c = :request[0].IdItinerario
            AND Contacto_Reserva__c != null
            AND Estado_de_Reserva__c = 'Acreditada'
        ];
        
        Set<String> clavesReserva = new Set<String>();
        for (Reserva__c r : lstReservaUpdate) {
            if (r.Puerto_ORIGEN__r != null && r.Itinerario_asociado__c != null) {
                String clave = r.Itinerario_asociado__c + '-' + r.Puerto_ORIGEN__r.Name;
                clavesReserva.add(clave);
            }
        }
        
        List<Escalas_Itinerario__c> lstEscalas = [
            SELECT Salida__c, Itinerario__c, Name
            FROM Escalas_Itinerario__c
            WHERE Itinerario__c = :request[0].IdItinerario
        ];
        
        Map<String, Datetime> mapaEscalas = new Map<String, Datetime>();
        for (Escalas_Itinerario__c escala : lstEscalas) {
            String clave = escala.Itinerario__c + '-' + escala.Name;
            mapaEscalas.put(clave, escala.Salida__c);
        }
        
        for (Reserva__c r : lstReservaUpdate) {
            String clave = r.Itinerario_asociado__c + '-' + r.Puerto_ORIGEN__r.Name;
            if (mapaEscalas.containsKey(clave)) {
                r.Fecha_Hora_de_Viaje__c = mapaEscalas.get(clave);
            }
        }
         if(!Test.isRunningTest()) {
        update lstReservaUpdate;
         }
        List<Reserva__c> lstReserva = [SELECT Name, Contacto_Reserva__r.Name, Telefono_Contacto__c, Correo_Contacto__c,Itinerario_asociado__c,Fecha_Hora_de_Viaje__c,
                                       Ruta__c, Nave__c, Itinerario_asociado__r.Nombre_Ruta__r.Name, Itinerario_asociado__r.Fecha_Reprogramacion__c,Puerto_ORIGEN__r.Name                                      
        FROM Reserva__c 
        WHERE Itinerario_asociado__c =: request[0].IdItinerario
        AND Contacto_Reserva__c != null
        AND Estado_de_Reserva__c = 'Acreditada']; 

        System.debug('Número de registros en lstReserva: ' + lstReserva.size());




        // Tamaño del lote
        Integer batchSize = 50;

        // Si la lista tiene más de 50 registros, dividirla en lotes
        if (lstReserva.size() > batchSize) {
        List<List<Reserva__c>> batches = new List<List<Reserva__c>>();
        List<Reserva__c> currentBatch = new List<Reserva__c>();

        for (Integer i = 0; i < lstReserva.size(); i++) {
        currentBatch.add(lstReserva[i]);

        // Cuando el lote actual alcanza el tamaño máximo, lo agregamos a la lista de lotes y creamos un nuevo lote
        if (currentBatch.size() == batchSize || i == lstReserva.size() - 1) {
        batches.add(currentBatch);
        currentBatch = new List<Reserva__c>();
        }
        }

        // Enviar cada lote a la cola
        for (List<Reserva__c> batch : batches) {
        System.enqueueJob(new NAV_CalloutYellow_Queueable(request[0].estadoItinerario, batch));
        }
        } else {
        // Si la lista tiene 50 o menos registros, enviarla directamente a la cola
        System.enqueueJob(new NAV_CalloutYellow_Queueable(request[0].estadoItinerario, lstReserva));
        }
        
    }
 
}