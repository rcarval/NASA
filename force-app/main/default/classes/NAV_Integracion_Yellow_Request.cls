public class NAV_Integracion_Yellow_Request {
    public String botId;
    public String sender;
    public Data data;

    public class Data {
        public Event event;
    }

    public class Event {
        public String code;
        public EventData data;
    }

    public class EventData {
        public String Nombre_Itinerario;
        public String Estado_Itinerario;
        public String Fecha_Hora_Reprogramacion;
        public String Ruta;
        public String Nave;
        public String Nombre_Contacto;
        public String Correo_Contacto;
        public String Telefono_Contacto;
    }

    public static NAV_Integracion_Yellow_Request parse(String json) {
        return (NAV_Integracion_Yellow_Request) System.JSON.deserialize(json, NAV_Integracion_Yellow_Request.class);
    }
}