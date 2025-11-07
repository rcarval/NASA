/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 06-15-2022
 * @last modified by  : Esteban Flores
**/
public with sharing class NAV_WrapperTicketPDF {
    public String idPagina1 { get; set; }
    public Boolean esButaca { get; set; }
    public Boolean esSinAcomodacion { get; set; }
    public Boolean esVehiculo { get; set; }
    public Boolean esBicicleta { get; set; }
    public Boolean esCarga { get; set; }
    public Boolean esVentaCruzada { get; set; }
    public String titulo { get; set; }
    public String telefono { get; set; }
    public String direccion { get; set; }
    public String logo { get; set; }
    public String fechaEmisionTitulo { get; set; }
    public String fechaEmisionValor { get; set; }
    public String oficinaTitulo { get; set; }
    public String oficinaValor { get; set; }
    public String codigoRuta { get; set; }
    public String ticketNombre { get; set; }
    public String ticketValor { get; set; }
    public String datosPasajeroTitulo { get; set; }
    public String dPNombreTitulo { get; set; }
    public String dPNombreValor { get; set; }
    public String dPTipoDocumentoTitulo { get; set; }
    public String dPTipoDocumentoValor { get; set; }
    public String dpNumeroDocumentoTitulo { get; set; }
    public String dpNumeroDocumentoValor { get; set; }
    public String dpNacionalidadTitulo { get; set; }
    public String dpNacionalidadValor { get; set; }
    public String datosViajeTitulo { get; set; }
    public String dvOrigenTitulo { get; set; }
    public String dvOrigenValor { get; set; }
    public String dvDestinoTitulo { get; set; }
    public String dvDestinoValor { get; set; }
    public String dvNaveTitulo { get; set; }
    public String dvNaveValor { get; set; }
    public String dvFechaTitulo { get; set; }
    public String dvFechaValor { get; set; }
    public String dvHoraTitulo { get; set; }
    public String dvHoraValor { get; set; }
    public String dvTipoButacaTitulo { get; set; }
    public String dvTipoButacaValor { get; set; }
    public String dvNumeroButacaTitulo { get; set; }
    public String dvNumeroButacaValor { get; set; }
    public String dvTarifaTitulo { get; set; }
    public String dvTarifaValor { get; set; }
    public String dvTasaEmbarqueTitulo { get; set; }
    public String dvTasaEmbarqueValor { get; set; }
    public String dvDescuentoTitulo { get; set; }
    public String dvDescuentoValor { get; set; }
    public String dvTotalTitulo { get; set; }
    public String dvTotalValor { get; set; }
    public String idPagina2 { get; set; }
    //Datos especificos de vehiculos y cargas
    public String dPPatenteTitulo { get; set; }
    public String dPPatenteValor { get; set; }
    public String dPTaraTitulo { get; set; }
    public String dPTaraValor { get; set; }
    public String dPMarcaTitulo { get; set; }
    public String dPMarcaValor { get; set; }
    public String dPAnoTitulo { get; set; }
    public String dPAnoValor { get; set; }
    public String dPMetrosTitulo { get; set; }
    public String dPMetrosValor { get; set; }
    public String dPCargaTitulo { get; set; }
    public String dPCargaValor { get; set; }
    public String dPUnidadTitulo { get; set; }
    public String dPUnidadValor { get; set; }
    public String dPCantidadTitulo { get; set; }
    public String dPCantidadValor { get; set; }
    public NAV_WrapperTicketPDF() {
			//Titulos
			idPagina1 = '< Original cliente >';
			titulo = '"NAVIERA AUSTRAL S.A."';
			telefono = 'fono: 65 2 270430 /9 57236662 ';
			direccion = 'Angelmó 2187, Puerto Montt.';
			fechaEmisionTitulo = 'F. EMISION';
			oficinaTitulo = 'OFICINA';
            //BUTACAS
			ticketNombre = 'N° TICKET';
			datosPasajeroTitulo = 'DATOS DEL PASAJERO';
			dPNombreTitulo = 'NOMBRE';
			dPTipoDocumentoTitulo = 'T. DOC.';
			dpNumeroDocumentoTitulo = 'N. DOC.';
			dpNacionalidadTitulo = 'NAC';
            //VEHICULOS
            dPPatenteTitulo = 'PATENTE';
            dPTaraTitulo = 'TARA';
            dPMarcaTitulo = 'MARCA';
            dPAnoTitulo = 'AÑO';
            dPMetrosTitulo = 'METROS';
            //CARGAS
            dPCargaTitulo = 'TIPO';
            dPUnidadTitulo = 'UNIDAD';
            dPCantidadTitulo = 'CANT';
            //Campos restantes
			datosViajeTitulo = 'DATOS DEL VIAJE';
			dvOrigenTitulo = 'ORIGEN';
			dvDestinoTitulo = 'DESTINO';
			dvNaveTitulo = 'NAVE';
			dvFechaTitulo = 'FECHA';
			dvHoraTitulo = 'ZARPE';
			dvTipoButacaTitulo = 'T.BUTACA';
			dvNumeroButacaTitulo = 'N° BUTACA';
			dvTarifaTitulo = 'TARIFA';
			dvDescuentoTitulo = 'DCTO.';
			dvTotalTitulo = 'TOTAL';
			idPagina2 = '< Copia Sobre Cargo >';
    }
}