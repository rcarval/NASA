public class NAV_WrapperPaymentData  {
    public String tipoDocumento;
    public cl_datosContacto datosContacto;
    public cl_datosFactura datosFactura;
    public class cl_datosContacto{
        public String rut;
        public String nombre;
        public String apellido;
        public String correo;
        public String telefono;
    }
    public class cl_datosFactura{
        public String rut;
        public String razonSocial;
        public String giro;
        public String direccion;
        public String comuna;
        public String ciudad;
    }
    public static NAV_WrapperPaymentData parse(String json){
        return (NAV_WrapperPaymentData) System.JSON.deserialize(json, NAV_WrapperPaymentData.class);
    }
}