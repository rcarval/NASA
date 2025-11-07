public with sharing class NAV_ConfirmacionReserva implements Schedulable {

    // public NAV_ConfirmacionReserva() {
    // }

    //Este es el método principal que Salesforce ejecutará cuando el trabajo programado se active (que contiene toda la lógica)
    //Método requerido por la interfaz Schedulable
    public void execute(SchedulableContext sc) { //Preguntar a rodrigo que es el sc
        System.debug('Iniciando procesamiento de reservas');
        processUnprocessedReservations();
    }

    // Método principal de Confirmación de reserva
    public static void processUnprocessedReservations() {
        //Obtener fecha límite desde configuración
        Date limitDate = getLimitDate(); //validar que es distinto de null

        //Consultar reservas pendientes 
        List<Reserva__c> reservations = getPendingReservations(limitDate);
        
        if(reservations.isEmpty()) {
            System.debug('No hay reservas pendientes de procesar.');
            return;
        }
        
        //Procesar y agrupar reservas
        Map<Id, List<Reserva__c>> reservationsByContact = groupReservationsByContact(reservations);
    }


    //Método para obtenere las fechas limite
    private static Date getLimitDate() {
        try {
            //Acá le pido que lea la etiqueta y obtenga el valor de la etiqueta
            String startDate = System.Label.Start_Date;
            //acá lepido que lo convierta al formato que necesitamos
            //Reemplaza T por un espacio
            return convertirStringAFecha(startDate);
            //Si ocutre un error lo muestra en un log
        } catch(Exception e) {
            System.debug('Error de lectura en fecha límite: ' + e.getMessage());
            // Retrocede 1 día como valor seguro
            return null;
        }
    }
    
    /**
     * Convierte un string en formato "dd-MM-yyyy" a Date.
     * @param fechaStr String con la fecha.
     * @return Date Fecha convertida.
     */
    public static Date convertirStringAFecha(String fechaStr) {
        if (fechaStr == null) return null;
        
        List<String> partes = fechaStr.split('-');
        if (partes.size() != 3) return null;
        
        Integer dia = Integer.valueOf(partes[0]);
        Integer mes = Integer.valueOf(partes[1]);
        Integer anio = Integer.valueOf(partes[2]);
        
        return Date.newInstance(anio, mes, dia);
    }



    //Metodo para consultar las reservas no procesadas (pendientes)
    private static List<Reserva__c> getPendingReservations(Date limitDate) {
        return [
            //QUery para acceder a los datos necesarios
            SELECT Id, Contacto_Reserva__r.Name, Contacto_Reserva__r.Correo_Electronico__c, 
                   Telefono_Contacto__c, Correo_Contacto__c, Ruta__c, Nave__c,
                   Itinerario_asociado__r.Nombre_Ruta__r.Name, 
                   Itinerario_asociado__r.Fecha_Reprogramacion__c,
                   CreatedDate, Procesado__c
            FROM Reserva__c
            //Solo reservas no procesadas
            WHERE Procesado__c = false
            //Con contacto asignado
            AND Contacto_Reserva__c != null
                //Más recientes que la fecha que le daremos
            AND CreatedDate >= :limitDate
            ORDER BY CreatedDate ASC
            //Evita sobrepasar límites de governor -- (preguntar a Rodrigo no entendí)
            LIMIT 10000
        ];
    }

    //Metodo para agrupar reservas por cada contacto
    //Cree un mapa(MEMO CARLOS: diccionario)para poder identificar llave(Id.Contacto) : Valor(Lista de reservas)
    
    private static Map<Id, List<Reserva__c>> groupReservationsByContact(List<Reserva__c> reservations) {
        Map<Id, List<Reserva__c>> result = new Map<Id, List<Reserva__c>>();
        
        //Iteración de todas las reservas 
        for(Reserva__c res : reservations) {
            //Si elr esultado no existe como clave(key)
            if(!result.containsKey(res.Contacto_Reserva__c)) {
                //Agrega una nueva entrada  y una lista vacía de reservas
                result.put(res.Contacto_Reserva__c, new List<Reserva__c>());
            }
            //Obtiene la lista de reservas asociada al contacto y añade la reserva actual
            result.get(res.Contacto_Reserva__c).add(res);
        }
        //Dfevuelve el mpa completo con todas las reservas
        return result;
    }


}