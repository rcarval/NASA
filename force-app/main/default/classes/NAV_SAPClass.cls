public class NAV_SAPClass {
    public cabecera cabecera{ get; set; }
    public List<documentoItem> documento{ get; set; }
    public List<acreditacionItem> acreditacion{ get; set; }

    public class cabecera{
        public String sociedad { get; set; } //15400
        public String reserva { get; set; } //123456
        public String fechaReserva { get; set; } //01042022
        public String caja { get; set; } //707
        public String agencia { get; set; } //LL14
        public String vendedor { get; set; } //WebPay
        public String fechaArqueo { get; set; } //01042022
        public String transbordador { get; set; } //5000CL048
        public String ruta { get; set; } //205
        public String tramo { get; set; } //AYACGO
        public String fechaZarpe { get; set; } //01042022
        public String horaZarpe { get; set; } //00:00
        public String tipoViaje { get; set; } //N
        public String condicionPago { get; set; } //1
        public String rut { get; set; } //5771628-2
        public String nombreCliente { get; set; } //OMIRIAM BEROIZA VASQUEZ
        public String direccion { get; set; } //Puerto Montt
        public String ciudad { get; set; } //Puerto Montt
        public String razonSocial { get; set; } //OMIRIAM BEROIZA VASQUEZ
        public String pais { get; set; } //CL
        public String tipoCuenta { get; set; } //
        public String institucionFinanciera { get; set; } //
        public String cuenta { get; set; } //
        public String email { get; set; } //correocompleto@gmail.com
        public cabecera(){
            sociedad = '1540';
            reserva = '';
            fechaReserva = '';
            caja = '';
            agencia = '';
            vendedor = '';
            fechaArqueo = '';
            transbordador = '';
            ruta = '';
            tramo = '';
            fechaZarpe = '';
            horaZarpe = '';
            tipoViaje = '';
            condicionPago = '';
            rut = '';
            nombreCliente = '';
            direccion = '';
            ciudad = '';
            razonSocial = '';
            pais = 'CL';
            tipoCuenta = '';
            institucionFinanciera = '';
            cuenta = '';
            email = '';
        }
    }
    public class documentoItem{
        public String tipoDocumento { get; set; } //16
        public String documento { get; set; } //1201309
        public String fechaDocumento { get; set; } //01042022
        public String montoNeto { get; set; } //18860
        public String montoIva { get; set; } //0
        public String tipoNC { get; set; } //1 = Devolución de dinero | 2 = Forma de Pago Nueva Venta
        public List<servicioItem> servicios { get; set; }
        public documentoItem(){
            tipoDocumento = '';
            documento = '';
            fechaDocumento = '';
            montoNeto = '';
            montoIva = '';
            servicios = new List<servicioItem>();
        }
    }
    public class servicioItem{
        public String tipoServicio { get; set; } //20000394
        public String codigoServicio { get; set; } //0041000001
        public String desServicio { get; set; } //Servicio Transporte de Pa
        public String cantidad { get; set; } //1
        public String tipoDoctorReferencia { get; set; } //33
        public String doctoReferencia { get; set; } //
        public String montoAfecto { get; set; } //0
        public String montoExento { get; set; } //18860
        public servicioItem(){
            tipoServicio = '';
            codigoServicio = '';
            desServicio = '';
            cantidad = '';
            tipoDoctorReferencia = '';
            doctoReferencia = '';
            montoAfecto = '';
            montoExento = '';
        }
    }
    public class acreditacionItem{
        public String formaPago { get; set; } //T
        public String numeroPago { get; set; } //9876
        public String montoPago { get; set; } //30000
        public String CLAVE_REF1{ get; set; }
        public String CLAVE_REF2{ get; set; }
        public String CLAVE_REF3{ get; set; }
        public String tipoFormPago{ get; set; }
        public acreditacionItem(){
            formaPago = '';
            numeroPago = '';
            montoPago = '';
            CLAVE_REF1 = '';
            CLAVE_REF2 = '';
            CLAVE_REF3 = '';
            tipoFormPago = '';
        }
    }
    public NAV_SAPClass() {
        cabecera = new cabecera();
        documento = new List<documentoItem>();
        acreditacion = new List<acreditacionItem>();
    }
}