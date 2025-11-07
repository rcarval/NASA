/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para controlar datos en Ticket versión PDF
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     30-10-2021   EFR      Creación de la Clase.
***********************************************************************************/
public class NAV_TicketPDFController  {
	public String idReserva { get; set; }
	public Integer total { get; set; }
	public List<NAV_WrapperTicketPDF> tickets { get; set; }
	public NAV_TicketPDFController(ApexPages.StandardController controller){
        idReserva = ApexPages.CurrentPage().getParameters().get('id');
		List<Detalle_Reserva__c> detalles = [SELECT Id, Name, Nombre_Pasajero__r.Name, Reserva__r.CreatedBy.Sucursal__c,
											 Reserva__r.Codigo_Viaje__c, Reserva__r.CreatedDate, Reserva__r.Codigo_Reserva__c, 
											 Tipo_de_identificacion__c, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Nacionalidad__pc,
											 Reserva__r.Puerto_Origen__r.Name, Reserva__r.Puerto_Destino__r.Name, Reserva__r.Itinerario_asociado__r.NAVE__c,
											 Reserva__r.Fecha_de_Reserva__c, Reserva__r.Fecha_Viaje__c, Ubicacion__c, Numero__c, Reserva__r.Fecha_Hora_de_Viaje__c, 
											 Valor_neto_Ticket_Pasajero_desc__c, Valor_Pasajero__c, Desc_Ticket_Pasajero__c, Desc_Tasa_Emb_Des_Pasajero__c,
											 Total_Detalle_Reserva_butacas__c, Reserva__r.Itinerario_asociado__r.Fecha_de_Viaje__c, RecordType.Name,
											 Placa_Patente_Vehiculo__c, Tara__c, Marca__c, Ano_Ve__c, Capacidad_Comprometida__c, Valor_Carga__c, 
											 Unidad_de_medida__c, Tipo_de_Carga__c, ML_Portabicicleta__c, Total_Detalle_Reserva_Vehiculo_ML__c,
											 Desc_Ticket_Vehiculo_Bicicleta__c, Total_Detalle_Reserva_pallet__c, Tipo_de_Vehiculo__c, Tasa_Desembarque__c,
											 Tasa_Embarque__c, Pasajero_Conductor__c, Persona_que_entrega__r.Name,Descripcion_Documento__c,
											 VALOR_TASA_E_D_PASAJERO_DESC__c, VALOR_TASA_E_D_VEHICULO_ML_DESC__c, VALOR_TICKET_CARGA_DEC__c, 
											 VALOR_TICKET_PASAJERO_DESC__c, VALOR_TICKET_VEHICULO_ML_DESC__c, Sin_Acomodacion__c,Cantidad__c,VC_Valor_Bruto__c,Descriptor__c,
											 Reserva__r.Contacto_Reserva__r.name
											 FROM Detalle_Reserva__c 
											 WHERE Reserva__c =:idReserva
											 	AND Item_anulado__c = false];
		tickets = new List<NAV_WrapperTicketPDF>();
		total = detalles.size();
		for(Detalle_Reserva__c det : detalles){
			//Datos de reservas
			NAV_WrapperTicketPDF ticket = new NAV_WrapperTicketPDF();
			ticket.fechaEmisionValor = det.Reserva__r.CreatedDate.date().format();
			Schema.DescribeFieldResult fieldResult = User.Sucursal__c.getDescribe();
			List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
			for( Schema.PicklistEntry f : ple) {
				if(f.getValue() == det.Reserva__r.CreatedBy.Sucursal__c){
					ticket.oficinaValor = f.getLabel();
				}
			}
            
			if(det.RecordType.Name.contains('Butaca')){
				if(det.Sin_Acomodacion__c == true){
					ticket.esSinAcomodacion = true;
					ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
					ticket.ticketValor = formatName(det.Name);
					ticket.dPNombreValor = det.Nombre_Pasajero__r.Name;
					ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
					ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
					ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
					ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
					ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
					ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
					ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
					ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
					IF(det.Descripcion_Documento__c.contains('CONEXIÓN TRANS BUS')){
						ticket.dvTipoButacaValor = 'CONEXIÓN BUS';
					}else{
						ticket.dvTipoButacaValor = 'S/A';
					}
					ticket.dvNumeroButacaValor = det.Numero__c;
					ticket.dvTarifaValor = '$ '+formatDecimal(det.VALOR_TICKET_PASAJERO_DESC__c,0);
					ticket.dvTasaEmbarqueTitulo = 'T/E';
					ticket.dvTasaEmbarqueValor = '$ '+formatDecimal(det.VALOR_TASA_E_D_PASAJERO_DESC__c,0);
					ticket.dvDescuentoValor = '$ '+formatDecimal(det.Desc_Ticket_Pasajero__c,0);
					ticket.dvTotalValor = '$ '+formatDecimal(det.Total_Detalle_Reserva_butacas__c,0);
				}else{
					ticket.esButaca = true;
					ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
					ticket.ticketValor = formatName(det.Name);
					ticket.dPNombreValor = det.Nombre_Pasajero__r.Name;
					ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
					ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
					ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
					ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
					ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
					ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
					ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
					ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
					ticket.dvTipoButacaValor = det.Ubicacion__c;
					ticket.dvNumeroButacaValor = det.Numero__c;
					ticket.dvTarifaValor = '$ '+formatDecimal(det.VALOR_TICKET_PASAJERO_DESC__c,0);
					ticket.dvTasaEmbarqueTitulo = 'T/E';
					ticket.dvTasaEmbarqueValor = '$ '+formatDecimal(det.VALOR_TASA_E_D_PASAJERO_DESC__c,0);
					ticket.dvDescuentoValor = '$ '+formatDecimal(det.Desc_Ticket_Pasajero__c,0);
					ticket.dvTotalValor = '$ '+formatDecimal(det.Total_Detalle_Reserva_butacas__c,0);
				}
			}else if(det.RecordType.Name.contains('Pista')){
				ticket.esVehiculo = true;
				ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
				ticket.ticketValor = formatName(det.Name);
				ticket.dPNombreValor = det.Pasajero_Conductor__c;
				ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
				ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
				ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
				ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
				ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
				ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
				ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
				ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
				ticket.ticketNombre = 'GUIA';
                if(det.Tipo_de_Vehiculo__c.contains('METRO')){
                    ticket.datosPasajeroTitulo = 'DATOS ADICIONALES:'; 
				ticket.dPPatenteValor = '';
                }else{
                  ticket.datosPasajeroTitulo = 'DATOS DEl VEHICULO:';  
				ticket.dPPatenteValor = det.Placa_Patente_Vehiculo__c;
                }

				ticket.dvTipoButacaTitulo = 'TIPO';
				ticket.dvTipoButacaValor = det.Tipo_de_Vehiculo__c;

				ticket.dPTaraValor = String.valueOf(det.Tara__c);
				ticket.dPMarcaValor = det.Marca__c;
				ticket.dPAnoValor = String.valueOf(det.Ano_Ve__c);
				Decimal metros = 0;
				metros = det.Capacidad_Comprometida__c;
				if(det.ML_Portabicicleta__c != null){
					metros = metros + det.ML_Portabicicleta__c;
				}
				ticket.dPMetrosValor = String.valueOf(metros);
				ticket.dvTarifaValor = '$ '+formatDecimal(det.VALOR_TICKET_VEHICULO_ML_DESC__c,0);
				ticket.dvTasaEmbarqueTitulo = 'T/E';
				ticket.dvTasaEmbarqueValor = '$ '+formatDecimal(det.VALOR_TASA_E_D_VEHICULO_ML_DESC__c,0);
				ticket.dvDescuentoValor = '$ '+formatDecimal(det.Desc_Ticket_Vehiculo_Bicicleta__c,0);
				ticket.dvTotalValor = '$ '+formatDecimal(det.Total_Detalle_Reserva_Vehiculo_ML__c,0);
			}else if(det.RecordType.Name.contains('Pallet')){
				ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
				ticket.ticketValor = formatName(det.Name);
				ticket.dPNombreValor = det.Persona_que_entrega__r.Name;
				ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
				ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
				ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
				ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
				ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
				ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
				ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
				ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
				ticket.esCarga = true;
				ticket.ticketNombre = 'GUIA';
				ticket.datosPasajeroTitulo = 'DATOS DEL PALLET/TONELADA';
				ticket.dPNombreTitulo = 'DUEÑO';
				ticket.dPCargaValor = det.Tipo_de_Carga__c;
                if(det.Descriptor__c.contains('Tonelada')){
                    ticket.dPUnidadValor ='Tonelada';
                }else{
                    ticket.dPUnidadValor = det.Unidad_de_medida__c;
                }
				ticket.dPCantidadValor = formatDecimal(det.Capacidad_Comprometida__c,0);
				ticket.dvTarifaValor = '$ '+formatDecimal(det.VALOR_TICKET_CARGA_DEC__c,0);
				ticket.dvDescuentoValor = '$ '+formatDecimal(0,0);
				ticket.dvTotalValor = '$ '+formatDecimal(det.Total_Detalle_Reserva_pallet__c,0);
			}else if(det.RecordType.Name.contains('Bicicletas')){
				ticket.esBicicleta = true;
				ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
				ticket.ticketValor = formatName(det.Name);
				ticket.dPNombreValor = det.Pasajero_Conductor__c;
				ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
				ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
				ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
				ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
				ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
				ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
				ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
				ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
				ticket.ticketNombre = 'GUIA';
				ticket.datosPasajeroTitulo = 'DUEÑO';
				ticket.dvTipoButacaTitulo = 'TIPO';
				ticket.dvTipoButacaValor = det.Tipo_de_Vehiculo__c;
				ticket.dvTarifaValor = '$ '+formatDecimal(det.VALOR_TICKET_VEHICULO_ML_DESC__c,0);
				ticket.dvTasaEmbarqueTitulo = 'T/E';
				ticket.dvTasaEmbarqueValor = '$ '+formatDecimal(det.VALOR_TASA_E_D_VEHICULO_ML_DESC__c,0);
				ticket.dvDescuentoValor = '$ '+formatDecimal(det.Desc_Ticket_Vehiculo_Bicicleta__c,0);
				ticket.dvTotalValor = '$ '+formatDecimal(det.Total_Detalle_Reserva_Vehiculo_ML__c,0);
			}else if(det.RecordType.Name.contains('Venta')){
                if(det.Descriptor__c.contains('Bus Conexion') ){
                    ticket.esVentaCruzada = true;
                    ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
                    ticket.ticketValor = 'Contacto '+formatName(det.Name);
                    ticket.dPNombreValor = det.Reserva__r.Contacto_Reserva__r.name;
                    ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
                    ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
                    ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
                    ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
                    ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
                    ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
                    ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
                    ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
                    ticket.ticketNombre = 'GUIA';
                    ticket.datosPasajeroTitulo =  det.Descriptor__c;
                    ticket.dvTipoButacaTitulo = 'TIPO';
                    ticket.dvTipoButacaValor = det.Descriptor__c;
                    string patente = '';
                    List<Item_Folio__c> itemFolioPatente = [SELECT Name FROM Item_Folio__c WHERE Item_Reserva__c =:det.id];
                    if(itemFolioPatente.size()>0){
                        for(Item_Folio__c itemfolio : itemFolioPatente ){
                            patente = patente + ' '+ itemfolio.Name;
                        }
                    }
                    ticket.dPPatenteTitulo='PasajerosRut:';
                    ticket.dPPatenteValor = patente;
                    Decimal cantidad = Decimal.valueOf(det.Cantidad__c); // Convertir la cadena a Decimal
                    Decimal valorDividido = det.VC_Valor_Bruto__c / cantidad;
                    ticket.dvTarifaValor = '$ ' + formatDecimal(valorDividido, 0);
                    ticket.dvTasaEmbarqueTitulo = 'CANTIDAD';
                    ticket.dvTasaEmbarqueValor = det.Cantidad__c;
                    ticket.dvDescuentoValor = '$ '+formatDecimal(det.Desc_Ticket_Vehiculo_Bicicleta__c,0);
                    ticket.dvTotalValor = '$ '+formatDecimal(det.VC_Valor_Bruto__c,0); 
                }else{
                    ticket.esVentaCruzada = true;
                    ticket.codigoRuta = det.Reserva__r.Codigo_Reserva__c;
                    ticket.ticketValor = formatName(det.Name);
                    ticket.dPNombreValor = det.Reserva__r.Contacto_Reserva__r.name;
                    ticket.dPTipoDocumentoValor = det.Tipo_de_identificacion__c;
                    ticket.dpNumeroDocumentoValor = det.Doc_Identificacion_Pasajero__c;
                    ticket.dpNacionalidadValor = det.Nombre_Pasajero__r.Nacionalidad__pc;
                    ticket.dvOrigenValor = det.Reserva__r.Puerto_Origen__r.Name;
                    ticket.dvDestinoValor = det.Reserva__r.Puerto_Destino__r.Name;
                    ticket.dvNaveValor = String.valueOf(det.Reserva__r.Itinerario_asociado__r.NAVE__c);
                    ticket.dvFechaValor = det.Reserva__r.Fecha_Hora_de_Viaje__c.date().format();
                    ticket.dvHoraValor = String.valueOf(det.Reserva__r.Fecha_Hora_de_Viaje__c.format('HH:mm aa'));
                    ticket.ticketNombre = 'GUIA';
                    ticket.datosPasajeroTitulo =  det.Descriptor__c;
                    ticket.dvTipoButacaTitulo = 'TIPO';
                    ticket.dvTipoButacaValor = det.Descriptor__c;
                    string patente = '';
                    List<Item_Folio__c> itemFolioPatente = [SELECT Name FROM Item_Folio__c WHERE Item_Reserva__c =:det.id];
                    if(itemFolioPatente.size()>0){
                        for(Item_Folio__c itemfolio : itemFolioPatente ){
                            patente = patente + ' '+ itemfolio.Name;
                        }
                    }
                    ticket.dPPatenteValor = patente;
                    Decimal cantidad = Decimal.valueOf(det.Cantidad__c); // Convertir la cadena a Decimal
                    Decimal valorDividido = det.VC_Valor_Bruto__c / cantidad;
                    ticket.dvTarifaValor = '$ ' + formatDecimal(valorDividido, 0);
                    ticket.dvTasaEmbarqueTitulo = 'CANTIDAD';
                    ticket.dvTasaEmbarqueValor = det.Cantidad__c;
                    ticket.dvDescuentoValor = '$ '+formatDecimal(det.Desc_Ticket_Vehiculo_Bicicleta__c,0);
                    ticket.dvTotalValor = '$ '+formatDecimal(det.VC_Valor_Bruto__c,0); 
                }
				
			}
			tickets.add(ticket);
		}
	}
    //Funcion para formatear un numero con su escala
    public static String formatDecimal(Decimal value, Integer scale) {
        String retval = '';
        if(value != null) {
            if(scale == null) {
                scale = value.scale();
            }
            retval = value.format();
            if(scale <= 0) {
                retval = Decimal.valueOf(value.round()).format().replace(',','.');
            }else if(scale > 0 && scale <= 18){
                Long modulus = Long.valueOf('1000000000000000000'.left(scale+1));
                Long msd = (Math.abs(value)*modulus).round();
                Long lsd = Math.mod(msd,modulus);
                msd = ((value > 0)?(msd - lsd):(lsd - msd))/modulus;
                retval = Decimal.valueOf(msd).format().replace(',','.')+','+(String.valueOf(modulus+lsd).substring(1));
            }
        }
        return retval;
    }
	//Funcion para formatear el nombre del detalle de reserva
	public static String formatName(String nombre){
		String retVal = '';
		if(nombre.contains('-')){
			String[] fullName = nombre.split('-');
			retVal = fullName[0];
			retVal = retVal + '-' + String.valueOf(Integer.valueOf(fullName[1]));
		}else{
			retVal = nombre;
		}
		return retVal;
	}
}