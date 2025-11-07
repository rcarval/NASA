/**********************************************************************************
Desarrollado por: Seidor
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para servicio de conexión a SAP
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     02-09-2022   EFR      Creación de la Clase.
1.1     21-12-2022   EFR      Agregar una implementacion para todo.
2.0     28-12-2022   EFR      Agregar número de caja nuevo en envío a SAP.
3.0     12-01-2023   EFR      Agregar código de ruta dependiente de tipo de itinerario (SUBV o COM)
4.0     14-03-2023   EFR      Agregar tag en xml para tipo de nota de crédito
***********************************************************************************/
public class NAV_SAPCompletoWS {
    public Id iDocumento{ get; set; }
    public NAV_SAPClass datosReserva { get; set; }
    public NAV_SAPCompletoWS(ApexPages.StandardController sc){
    }
    @InvocableMethod(label='Integracion SAP' description='Integracion SAP') //Via acreditacion
	public static void processIntegration(List<Id> inputParams){
        for(Id iAc : inputParams){
            callAcreditacion(iAc);
        }
    }
    public static void callAcreditacion(String iAcreditacion){
        NAV_SAPClass datosReserva = new NAV_SAPClass();
        //iDocumento = ApexPages.CurrentPage().getparameters().get('Id');
        Acreditacion__c acreditacion = [SELECT Reserva__c, Destinatario_documentos__r.Identificacion__c, Destinatario_documentos__r.Name, 
                                            Destinatario_documentos__r.Razon_Social__c, Destinatario_documentos__r.PersonEmail, 
                                            Destinatario_documentos__r.Nacionalidad__pc, Condicion_de_Pago__c, Destinatario_documentos__c, 
                                            Mensaje_SAP__c, Destinatario_documentos__r.Tipo_de_identificacion__c
                                        FROM Acreditacion__c
                                        WHERE Id =: iAcreditacion];
        if(acreditacion.Destinatario_documentos__c != null){
            Id anulacionNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Anulación Venta (No Tributario)').getRecordTypeId();
            Id ventaNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId();
            Id notaCredito = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Nota de Crédito').getRecordTypeId();
            Id iReserva = acreditacion.Reserva__c;
            Reserva__c reserva = [SELECT Fecha_de_Reserva__c, CreatedBy.Oficina_de_Ventas_SAP__c, CreatedBy.Name, 
                                    Itinerario_asociado__r.Nombre_de_la_Nave__r.CEBE__c,
                                    Puerto_ORIGEN__r.Sigla__c, Puerto_DESTINO__r.Sigla__c, Fecha_Hora_de_Viaje__c,
                                    Puerto_ORIGEN__r.Muelle_SAP__c, Puerto_DESTINO__r.Muelle_SAP__c,
                                    Puerto_ORIGEN__r.Name, Codigo_Reserva__c, Total_reserva__c,
                                    Itinerario_asociado__r.Nombre_Ruta__r.Codigo_Subvencionada_SAP__c,
                                    Itinerario_asociado__r.Nombre_Ruta__r.Codigo_Comercial_SAP__c,
                                    Itinerario_asociado__r.Tipo__c,Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c
                                  FROM Reserva__c
                                  WHERE Id =: iReserva];
            ServicioSAP__c integracion = [SELECT Sociedad__c
                                          FROM ServicioSAP__c
                                          LIMIT 1];
            Time zeroHours = Time.newInstance(0, 0, 0, 0);
            //datosReserva.cabecera.sociedad = integracion.Sociedad__c;
            if(reserva.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c == true){
                datosReserva.cabecera.sociedad ='1530';
            }else{
                datosReserva.cabecera.sociedad = integracion.Sociedad__c;
            }
            datosReserva.cabecera.reserva = reserva.Codigo_Reserva__c;
            datosReserva.cabecera.fechaReserva = Datetime.newInstance(reserva.Fecha_de_Reserva__c, zeroHours).format('ddMMyyyy');
            List<Documento__c> documentos = [SELECT RecordTypeId, Id, N_Documento__c, Fecha_Emision__c, Total_Neto__c, SUBTOTAL_BRUTO__c, Tipo_de_Documento__c,
                                                Caja__r.N_Caja__c, Caja__r.CreatedDate, CreatedDate, Numero_de_cuenta_para_devolucion__c,
                                                Tipo_de_cuenta_para_devoluci_n__c, Banco_para_devolucion__c, Documento_Principal__r.N_Documento__c,
                                                Documento_Principal__r.Tipo_de_Documento__c, Tipo_de_Nota_de_Credito__c, Documento_Principal__r.Correlativo_Unico__c,
                                                Correlativo_Unico__c
                                            FROM Documento__c
                                            WHERE Acreditacion__c =: iAcreditacion
                                                AND Fecha_Envio_SAP__c = null
                                            ORDER BY CreatedDate ASC];
            Set<Id> docIds = new Set<Id>();
            String caja = '', fechaArqueo = '', bancoDevolucion = '', numeroCuentaDevolucion = '', tipoCuentaDevolucion = '', tipoNota = '', tipoRegistro = '';
            for(Documento__c doc : documentos){
                docIds.add(doc.Id);
                caja = String.valueOf(doc.Caja__r.N_Caja__c);
                fechaArqueo = doc.Caja__r.CreatedDate.format('ddMMyyyy');
                bancoDevolucion = doc.Banco_para_devolucion__c!=null?doc.Banco_para_devolucion__c:'';
                numeroCuentaDevolucion = doc.Numero_de_cuenta_para_devolucion__c!=null?doc.Numero_de_cuenta_para_devolucion__c:'';
                tipoCuentaDevolucion = doc.Tipo_de_cuenta_para_devoluci_n__c!=null?doc.Tipo_de_cuenta_para_devoluci_n__c:'';
                tipoNota = doc.Tipo_de_Nota_de_Credito__c!=null?doc.Tipo_de_Nota_de_Credito__c:'';
                tipoRegistro = doc.RecordTypeId;
            }
            List<Detalle_Reserva__c> detalles = [SELECT Id, RecordTypeId FROM Detalle_Reserva__c WHERE Reserva__c =: iReserva];
            List<Forma_de_pago__c> fPagos = [SELECT Monto__c, Tipo_de_pago__c,Documento_Anulacion_Venta_NT__r.reserva__c, Nota_de_Credito__r.reserva__c,
                                 Documento_Anulacion_Venta_NT__r.SUBTOTAL_BRUTO__c,Nota_de_Credito__r.SUBTOTAL_BRUTO__c, Nota_de_Credito__c, Documento_Anulacion_Venta_NT__c,
                                 RUT_de_quien_transfiere__c,Fecha_de_transferencia__c,	X4_ultimos_digitos_tarjeta__c,Codigo_autorizacion__c,Orden_de_compra__c
                                 FROM Forma_de_pago__c
                                 WHERE Acreditacion__c =: iAcreditacion];
            datosReserva.cabecera.caja = caja;
            datosReserva.cabecera.agencia = reserva.CreatedBy.Oficina_de_Ventas_SAP__c;
            datosReserva.cabecera.vendedor = reserva.CreatedBy.Name.substring(0,5);
            datosReserva.cabecera.fechaArqueo = fechaArqueo;
            datosReserva.cabecera.transbordador = reserva.Itinerario_asociado__r.Nombre_de_la_Nave__r.CEBE__c;
            if(reserva.Itinerario_asociado__r.Tipo__c == 'SUBV'){
                datosReserva.cabecera.ruta = reserva.Itinerario_asociado__r.Nombre_Ruta__r.Codigo_Subvencionada_SAP__c;
            }else if(reserva.Itinerario_asociado__r.Tipo__c == 'COM'){
                datosReserva.cabecera.ruta = reserva.Itinerario_asociado__r.Nombre_Ruta__r.Codigo_Comercial_SAP__c;
            }
            datosReserva.cabecera.tramo = reserva.Puerto_ORIGEN__r.Muelle_SAP__c;
            //'PMONTT';// reserva.Puerto_ORIGEN__r.Sigla__c + '-' + reserva.Puerto_DESTINO__r.Sigla__c;
            datosReserva.cabecera.fechaZarpe = reserva.Fecha_Hora_de_Viaje__c.format('ddMMyyyy');
            datosReserva.cabecera.horaZarpe = reserva.Fecha_Hora_de_Viaje__c.format('hh:mm');
            datosReserva.cabecera.tipoViaje = 'N';
            if(acreditacion.Destinatario_documentos__r.Tipo_de_identificacion__c == 'Pasaporte'){
                datosReserva.cabecera.rut = '55555555-5';
            }else{
                datosReserva.cabecera.rut = acreditacion.Destinatario_documentos__r.Identificacion__c;
            }
            String nombreCliente = NAV_SAPWS.removeAccents(acreditacion.Destinatario_documentos__r.Name);
            if(nombreCliente.length() > 40){
                nombreCliente = nombreCliente.substring(0,40);
            }
            datosReserva.cabecera.nombreCliente =  nombreCliente; // maximo 40 caracteres
            datosReserva.cabecera.direccion = NAV_SAPWS.removeAccents(reserva.Puerto_ORIGEN__r.Name);
            datosReserva.cabecera.ciudad = NAV_SAPWS.removeAccents(reserva.Puerto_ORIGEN__r.Name);
            String razonSocial = NAV_SAPWS.removeAccents(acreditacion.Destinatario_documentos__r.Razon_Social__c);
            if(razonSocial.length() > 40){
                razonSocial = razonSocial.substring(0,40);
            }
            datosReserva.cabecera.razonSocial = razonSocial; // maximo 40 caracteres
            datosReserva.cabecera.email = acreditacion.Destinatario_documentos__r.PersonEmail;
            String paisNacionalidad = '';
            try{
                paisNacionalidad = [SELECT Sigla_SAP__c FROM PaisSAP__mdt WHERE MasterLabel =: acreditacion.Destinatario_documentos__r.Nacionalidad__pc].Sigla_SAP__c;
            }catch(Exception ex){
                paisNacionalidad = 'CL';
            }
            datosReserva.cabecera.pais = paisNacionalidad;
            datosReserva.cabecera.condicionPago = '1';
            System.debug('tipo de registro');
            System.debug(tipoRegistro);
            //Solo nota de credito
            if(tipoRegistro != notaCredito &&  tipoRegistro != anulacionNoTributaria){
                if(acreditacion.Condicion_de_Pago__c == 'Al día'){
                    datosReserva.cabecera.condicionPago = '1';
                }else if(acreditacion.Condicion_de_Pago__c == 'A Crédito'){
                    datosReserva.cabecera.condicionPago = '2';
                }else{
                    datosReserva.cabecera.condicionPago = '1';
                }
                datosReserva.cabecera.tipoCuenta = '';
                datosReserva.cabecera.institucionFinanciera = '';
                datosReserva.cabecera.cuenta = '';
            }else{
                String bancoStr = bancoDevolucion;
                if(bancoStr.length() > 40){
                    bancoStr = bancoStr.substring(0,40);
                }
                String codBanco = '';
                try{ 
                    codBanco = String.valueOf([SELECT Codigo_SAP__c FROM BancoSAP__mdt WHERE MasterLabel =: bancoStr].Codigo_SAP__c);
                }catch(Exception xx){
                    codBanco = '';
                }
                if(tipoNota == '0'){ //Devolución de Dinero
                    datosReserva.cabecera.condicionPago = '1';
                }else if(tipoNota == '1'){ //Forma de Pago Nueva Venta
                    datosReserva.cabecera.condicionPago = '2';
                }else{
                    datosReserva.cabecera.condicionPago = '1';
                }
                //datosReserva.cabecera.tipoCuenta = tipoCuentaDevolucion;
                datosReserva.cabecera.tipoCuenta = '01';
                datosReserva.cabecera.institucionFinanciera = codBanco;
                datosReserva.cabecera.cuenta = numeroCuentaDevolucion;
            }
            Map<String, ServicioInternoSAP__mdt> servicioSAP = new Map<String, ServicioInternoSAP__mdt>();
            List<ServicioInternoSAP__mdt> servsSAP = [SELECT DeveloperName, Codigo_Servicio_SAP__c, Descripcion_Servicio_SAP__c, Tipo_Servicio_SAP__c
                                                    FROM ServicioInternoSAP__mdt];
            for(ServicioInternoSAP__mdt sS : servsSAP){
                servicioSAP.put(sS.DeveloperName, sS);
            }
            for(Documento__c doc : documentos){
                NAV_SAPClass.documentoItem docuInside  = new NAV_SAPClass.documentoItem();
                tipoNota = doc.Tipo_de_Nota_de_Credito__c!=null?doc.Tipo_de_Nota_de_Credito__c:'';
                DocumentoTributario__mdt dT = [SELECT Codigo_SAP__c FROM DocumentoTributario__mdt WHERE MasterLabel =:doc.Tipo_de_Documento__c];
                docuInside.tipoDocumento = dT.Codigo_SAP__c;//doc.Tipo_de_Documento__c;
                if(doc.RecordTypeId == anulacionNoTributaria || doc.RecordTypeId == ventaNoTributaria){
                    String[] codigoUnico = doc.Correlativo_Unico__c.splitByCharacterType();
                    docuInside.documento = String.valueOf(codigoUnico[1]);
                }else{
                    docuInside.documento = String.valueOf(doc.N_Documento__c);
                }
                if(tipoNota == '0'){ //Devolución de Dinero 
                    docuInside.tipoNC = '1';
                }else if(tipoNota == '1'){ //Forma de Pago Nueva Venta
                    docuInside.tipoNC = '2';
                }else if(tipoNota == '3'){//Otra Devolución
                     docuInside.tipoNC = '1';
                }
                else{
                    docuInside.tipoNC = '';
                }
                docuInside.fechaDocumento = Datetime.newInstance(doc.Fecha_Emision__c, zeroHours).format('ddMMyyyy');
                List<Detalle_Documentos__c> dDocumentos = [SELECT Id, Cantidad__c, Descripcion__c, Total_Bruto__c, Tax_Id__c, Total_Neto__c, Documento__r.SUBTOTAL_BRUTO__c
                                                           FROM Detalle_Documentos__c
                                                           WHERE Documento__c =: doc.Id
                                                            AND Total_Bruto__c > 0];
                List<NAV_SAPClass.servicioItem> servicios = new List<NAV_SAPClass.servicioItem>();
                Decimal totalValor = 0, totalDocumento = 0;
                for(Detalle_Documentos__c det : dDocumentos){
                    servicios = NAV_SAPWS.servicioInterno(servicios, det, servicioSAP);
                    totalValor = totalValor + Math.round(det.Total_Neto__c);
                    totalDocumento = det.Documento__r.SUBTOTAL_BRUTO__c;
                }
                docuInside.montoNeto = String.valueOf(totalValor);
                docuInside.montoIva = String.valueOf(totalDocumento - totalValor);
                docuInside.servicios = servicios;
                datosReserva.documento.add(docuInside);
            }
            for(Forma_de_Pago__c fP : fPagos){
                NAV_SAPClass.acreditacionItem acreditacionItem = new NAV_SAPClass.acreditacionItem();
                String viaPago = '';
                try{
                    viaPago = [SELECT Sigla_SAP__c FROM ViasPagoSAP__mdt WHERE MasterLabel =: fP.Tipo_de_pago__c].Sigla_SAP__c;
                }catch(Exception ex){
                    viaPago = 'E';
                }
                String[] codRes = reserva.Codigo_Reserva__c.split('-');
                acreditacionItem.formaPago = viaPago;
                acreditacionItem.numeroPago = codRes[1];
                acreditacionItem.montoPago = String.valueOf(fP.Monto__c);
                datosReserva.acreditacion.add(acreditacionItem);
            }
            String xmlString = NAV_SAPWS.xmlData(datosReserva);
            System.debug('blanker NAV_SAPCompletoWS NAV_SAPWS.callService xmlString '+ xmlString);
            System.debug('blanker NAV_SAPCompletoWS NAV_SAPWS.callService iAcreditacion '+ iAcreditacion);
            NAV_SAPWS.callService(xmlString, iAcreditacion, false);
        }else{
            acreditacion.Mensaje_SAP__c = 'ERROR: Esta acreditación no posee Destinatario de Documentos.';
            update acreditacion;
        }
    }
}