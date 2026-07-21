/**********************************************************************************
Desarrollado por: Seidor
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para servicio de conexión a SAP
Clase Test : NAV_SAPWSTest -> 84%
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     02-09-2022   EFR      Creación de la Clase.
2.0     14-11-2022   EFR      Reactivación de movimiento 17 (Anulación No tributaria)
3.0     28-12-2022   EFR      Agregar número de caja nuevo en envío a SAP.
4.0     12-01-2023   EFR      Agregar código de ruta dependiente de tipo de itinerario (SUBV o COM)
5.0     14-03-2023   EFR      Agregar tag en xml para tipo de nota de crédito
6.0     29-06-2023   SAC      Deuda técnica de cobertura 
7.0     05-09-2024   CD       incorporacion Número contkey documento 
8.0     17-09-2024   CD       Nuevo servicio Parqueo Venta Cruzada 
9.0     00-09-2024   CD       Puelche 
10.0    26-11-2024   FFC      se agregan campos GetStatus_SAP__c, Contador_envio_SAP__c, capturan envio y estado de envio
11.0    09-12-2024   FFC      Modificacion XML REF1 y 2 
12.0    11-04-2025   RCG      Modificación Facturación Manual
16.0    09-01-2026   CD       Modificación ref1 ref3. 

***********************************************************************************/
public class NAV_SAPWS {
    public Id iDocumento{ get; set; }
    public NAV_SAPClass datosReserva { get; set; }
    public NAV_SAPWS(ApexPages.StandardController sc){
    }
    @InvocableMethod(label='Integracion SAP' description='Integracion SAP') //Via acreditacion
    public static void processIntegration(List<Id> inputParams){
        system.debug('CD inputParams '+ inputParams);
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
                                            Mensaje_SAP__c, Destinatario_documentos__r.Tipo_de_identificacion__c,Total_a_acreditar__c, Por_acreditar__c, Contador_envio_SAP__c
                                        FROM Acreditacion__c
                                        WHERE Id =: iAcreditacion];
        if(acreditacion.Destinatario_documentos__c != null){
            Id boletaRT = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId();
            Id facturaART = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Afecta').getRecordTypeId();
            Id facturaERT = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Exenta').getRecordTypeId();
            Id facturaMRT = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Mixta').getRecordTypeId();
            Id ventaNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId();
            Id notaCredito = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Nota de Crédito').getRecordTypeId();
            Id anulacionNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Anulación Venta (No Tributario)').getRecordTypeId();
            Set<Id> idDocumentosValidos = new Set<Id>();
            idDocumentosValidos.add(boletaRT);
            idDocumentosValidos.add(facturaART);
            idDocumentosValidos.add(facturaERT);
            idDocumentosValidos.add(facturaMRT);
            idDocumentosValidos.add(ventaNoTributaria);
            idDocumentosValidos.add(notaCredito);
            idDocumentosValidos.add(anulacionNoTributaria);
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
            //datosReserva.cabecera.sociedad ='1530'; // PARA PRUEBA CON SAP OTRA EMPRESA
            if(reserva.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c == true){
                datosReserva.cabecera.sociedad ='1530';
            }else{
                datosReserva.cabecera.sociedad = integracion.Sociedad__c;
            }
                
            datosReserva.cabecera.reserva = reserva.Codigo_Reserva__c;
            datosReserva.cabecera.fechaReserva = Datetime.newInstance(reserva.Fecha_de_Reserva__c, zeroHours).format('ddMMyyyy');
            //RCG - 11-04-2025: Se agrega campo Facturacion_Manual__c
            List<Documento__c> documentos = [SELECT RecordTypeId, Id, N_Documento__c, Fecha_Emision__c, Total_Neto__c, SUBTOTAL_BRUTO__c, Tipo_de_Documento__c,
                                                Caja__r.N_Caja__c, Caja__r.CreatedDate, CreatedDate, Numero_de_cuenta_para_devolucion__c,
                                                Tipo_de_cuenta_para_devoluci_n__c, Banco_para_devolucion__c, Documento_Principal__r.N_Documento__c,
                                                Documento_Principal__r.Tipo_de_Documento__c, Tipo_de_Nota_de_Credito__c, Documento_Principal__r.Correlativo_Unico__c,
                                                Correlativo_Unico__c,RecordType.name,Tipo_de_Devolucion__c, Facturacion_Manual__c
                                            FROM Documento__c
                                            WHERE Acreditacion__c =: iAcreditacion
                                                AND Fecha_Envio_SAP__c = null
                                                AND Listo_para_SAP__c = 1
                                                AND RecordTypeId IN: idDocumentosValidos
                                            ORDER BY CreatedDate ASC];
            Set<Id> docIds = new Set<Id>();
            String caja = '', fechaArqueo = '', bancoDevolucion = '', numeroCuentaDevolucion = '', tipoCuentaDevolucion = '', tipoNota = '', tipoRegistro = '',TipoDocumento ='', TipoRegNombre ='';
            for(Documento__c doc : documentos){
                docIds.add(doc.Id);
                //RCG - 11-04-2025: Valida campo Facturacion_Manual__c para envío a SAP
                if(doc.Facturacion_Manual__c == false){
                    caja = String.valueOf(doc.Caja__r.N_Caja__c);
                    fechaArqueo = doc.Caja__r.CreatedDate.format('ddMMyyyy');
                }else{
                    caja = 'Manual00001';
                    String dFecha = '', mFecha = '';
                    String formatDate = '';
                    if(doc.Fecha_Emision__c.day() < 10){
                        dFecha = '0'+String.valueOf(doc.Fecha_Emision__c.day());
                    }else{
                        dFecha = String.valueOf(doc.Fecha_Emision__c.day());
                    }
                    if(doc.Fecha_Emision__c.month() < 10){
                        mFecha = '0'+String.valueOf(doc.Fecha_Emision__c.month());
                    }else{
                        mFecha = String.valueOf(doc.Fecha_Emision__c.month());
                    }
                    formatDate = dFecha;
                    formatDate = formatDate + mFecha;
                    formatDate = formatDate + String.valueOf(doc.Fecha_Emision__c.year());
                    fechaArqueo = formatDate;
                }
                bancoDevolucion = doc.Banco_para_devolucion__c!=null?doc.Banco_para_devolucion__c:'';
                numeroCuentaDevolucion = doc.Numero_de_cuenta_para_devolucion__c!=null?doc.Numero_de_cuenta_para_devolucion__c:'';
                tipoCuentaDevolucion = doc.Tipo_de_cuenta_para_devoluci_n__c!=null?doc.Tipo_de_cuenta_para_devoluci_n__c:'';
                tipoNota = doc.Tipo_de_Nota_de_Credito__c!=null?doc.Tipo_de_Nota_de_Credito__c:'';
                tipoRegistro = doc.RecordTypeId;
                TipoDocumento = doc.Tipo_de_Documento__c;
                TipoRegNombre = doc.RecordType.name;
            }
            List<Detalle_Reserva__c> detalles = [SELECT Id, RecordTypeId FROM Detalle_Reserva__c WHERE Reserva__c =: iReserva];
            List<Forma_de_pago__c> fPagos = [SELECT Monto__c, Tipo_de_pago__c,Documento_Anulacion_Venta_NT__r.reserva__c, Nota_de_Credito__r.reserva__c,Numero_serie__c,Payment_Type__c,
                                 Documento_Anulacion_Venta_NT__r.SUBTOTAL_BRUTO__c,Nota_de_Credito__r.SUBTOTAL_BRUTO__c, Nota_de_Credito__c, Documento_Anulacion_Venta_NT__c,Nota_de_Credito__r.N_Documento__c,
                                 RUT_de_quien_transfiere__c,Fecha_de_transferencia__c,  X4_ultimos_digitos_tarjeta__c,Codigo_autorizacion__c,Orden_de_compra__c,RUT_del_titular_del_cheque__c,Documento_Anulacion_Venta_NT__r.Correlativo_Unico__c
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
            String nombreCliente = removeAccents(acreditacion.Destinatario_documentos__r.Name);
            if(nombreCliente.length() > 40){
                nombreCliente = nombreCliente.substring(0,40);
            }
            datosReserva.cabecera.nombreCliente =  nombreCliente; // maximo 40 caracteres
            datosReserva.cabecera.direccion = removeAccents(reserva.Puerto_ORIGEN__r.Name);
            datosReserva.cabecera.ciudad = removeAccents(reserva.Puerto_ORIGEN__r.Name);
            String razonSocial = removeAccents(acreditacion.Destinatario_documentos__r.Razon_Social__c);
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
            if(String.isNotBlank(tipoRegistro) && tipoRegistro != notaCredito &&  tipoRegistro != anulacionNoTributaria){
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
                    if(fPagos[0].Tipo_de_pago__c!=null && fPagos[0].Tipo_de_pago__c == 'Crédito'){
                        datosReserva.cabecera.condicionPago = '2';
                    }else{
                       datosReserva.cabecera.condicionPago = '1'; 
                    }
                    
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
             // Ticket 00017160 
            Decimal montoPago = 0;
            String tipoPago ='',reservaAnterior='';
            tipoPago= fPagos[0].Tipo_de_pago__c;
            Decimal docpago = 0;         
            Decimal docpagoAnulacion = 0;
            Decimal docpagoNC = 0;
            Decimal docpagoAn = 0;
            Decimal docpagoNC2 = 0;
            for (Forma_de_pago__c fpago : fPagos) {
                if (tipoPago == 'Documento de Anulación' || tipoPago == 'Nota de crédito') {
                    system.debug('CD Pago Documento de Anulación');
                    if (fpago.Documento_Anulacion_Venta_NT__c != null && fpago.Documento_Anulacion_Venta_NT__r.reserva__c != null) {
                        system.debug('CD Pago Documento de Anulación ' + fpago.Documento_Anulacion_Venta_NT__r.reserva__c);
                        reservaAnterior = fpago.Documento_Anulacion_Venta_NT__r.reserva__c;
                        docpagoAn = [SELECT SUBTOTAL_BRUTO__c FROM Documento__c WHERE id = :fpago.Documento_Anulacion_Venta_NT__c].SUBTOTAL_BRUTO__c;
                        docpagoAnulacion += docpagoAn;
                    }
                    
                    if (fpago.Nota_de_Credito__c != null && fpago.Nota_de_Credito__r.reserva__c != null) {
                        system.debug('CD Pago Nota de crédito ' + fpago.Nota_de_Credito__r.reserva__c);
                        reservaAnterior = fpago.Nota_de_Credito__r.reserva__c;
                        docpagoNC2 = [SELECT SUBTOTAL_BRUTO__c FROM Documento__c WHERE id = :fpago.Nota_de_Credito__c].SUBTOTAL_BRUTO__c;
                        docpagoNC += docpagoNC2;
                    }
                }
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
                    if(tipoPago == 'Crédito' ){
                        docuInside.tipoNC = '2';
                    }else{
                       docuInside.tipoNC = '1'; 
                    }
                }
                else{
                    
                      if(tipoPago == 'Nota de crédito' || tipoPago == 'Documento de Anulación' ){
                          system.debug('CD entro a ID pago con NC o Doc Anulacion: ');
                          docpago = docpagoAnulacion + docpagoNC;
                          System.debug('Valor original :' + docpago);
                          System.debug('docpagoAnulacion' + docpagoAnulacion);
                          System.debug('docpagoNC' + docpagoNC);
                        if(acreditacion.Total_a_acreditar__c == docpago){
                            docuInside.tipoNC = '3';
                            system.debug('docuInside.tipoNC 3: ' + docuInside.tipoNC );
                        }
                        else if(acreditacion.Total_a_acreditar__c > docpago){
                           docuInside.tipoNC = '4';
                           system.debug('docuInside.tipoNC 4: ' + docuInside.tipoNC );
                        }
                        else if(acreditacion.Total_a_acreditar__c < docpago){
                            docuInside.tipoNC = '5';
                            system.debug('docuInside.tipoNC 5: ' + docuInside.tipoNC );
                        }else{ 
                             docuInside.tipoNC = '';
                        }
                    }else{
                        docuInside.tipoNC = ''; 
                    }
                }
                docuInside.fechaDocumento = Datetime.newInstance(doc.Fecha_Emision__c, zeroHours).format('ddMMyyyy');
                List<Detalle_Documentos__c> dDocumentos = [SELECT Id, Cantidad__c, Descripcion__c, Total_Bruto__c, Tax_Id__c, Total_Neto__c, Documento__r.SUBTOTAL_BRUTO__c
                                                           FROM Detalle_Documentos__c
                                                           WHERE Documento__c =: doc.Id
                                                            AND Total_Bruto__c > 0];
                List<NAV_SAPClass.servicioItem> servicios = new List<NAV_SAPClass.servicioItem>();
                Decimal totalValor = 0, totalDocumento = 0;
                for(Detalle_Documentos__c det : dDocumentos){
                    servicios = servicioInterno(servicios, det, servicioSAP);
                    totalValor = totalValor + Math.round(det.Total_Neto__c);
                    totalDocumento = det.Documento__r.SUBTOTAL_BRUTO__c;
                }
                docuInside.montoNeto = String.valueOf(totalValor);
                docuInside.montoIva = String.valueOf(totalDocumento - totalValor);
                docuInside.servicios = servicios;
                datosReserva.documento.add(docuInside);
            }
            for(Forma_de_Pago__c fP : fPagos){
                 tipoPago= fP.Tipo_de_pago__c;
                NAV_SAPClass.acreditacionItem acreditacionItem = new NAV_SAPClass.acreditacionItem();
                String viaPago = '';
                try{
                    viaPago = [SELECT Sigla_SAP__c FROM ViasPagoSAP__mdt WHERE MasterLabel =: fP.Tipo_de_pago__c].Sigla_SAP__c;
                }catch(Exception ex){
                    viaPago = 'E';
                }
                if(tipoPago == 'Nota de crédito' || tipoPago == 'Documento de Anulación' ){
                    String[] codRes= reservaAnterior.split('-');
                    System.debug('Reserva anterior 1: ' + codRes);
                    acreditacionItem.formaPago = viaPago;
                    acreditacionItem.numeroPago = 'R-'+codRes[1];
                    acreditacionItem.tipoFormPago = fP.Tipo_de_pago__c;
                    acreditacionItem.montoPago = String.valueOf(fP.Monto__c);
                    if(tipoPago == 'Nota de crédito'){
                        acreditacionItem.CLAVE_REF1 = String.valueOf(fP.Nota_de_Credito__r.N_Documento__c);
                    }else{
                        String correlativo = fP.Documento_Anulacion_Venta_NT__r.Correlativo_Unico__c;
                        System.debug('Linea 342 correlativo: ' + correlativo);
                        System.debug('Linea 343 correlativo.substring(2): ' + correlativo.substring(2));
                        acreditacionItem.CLAVE_REF1 = correlativo.substring(2); 
                         System.debug('Linea 345 CLAVE_REF1: ' + acreditacionItem.CLAVE_REF1);
                    }    
                    datosReserva.acreditacion.add(acreditacionItem);
                }else {
                    String[] codRes = reserva.Codigo_Reserva__c.split('-');
                    acreditacionItem.formaPago = viaPago;
                    acreditacionItem.numeroPago = codRes[1];
                    acreditacionItem.montoPago = String.valueOf(fP.Monto__c);
                    acreditacionItem.tipoFormPago = fP.Tipo_de_pago__c;
                    if(acreditacionItem.tipoFormPago == 'Cheque'){
                        acreditacionItem.CLAVE_REF1 = fP.Numero_serie__c;
                        acreditacionItem.CLAVE_REF3 = fP.RUT_del_titular_del_cheque__c;
                    }else if(acreditacionItem.tipoFormPago == 'Pago Web'){
                        acreditacionItem.CLAVE_REF1 = fP.Codigo_autorizacion__c;
                        if(fP.Payment_Type__c =='VP'||fP.Payment_Type__c =='VD'){
                            acreditacionItem.formaPago = '4';
                        }else{
                            acreditacionItem.formaPago = '3';
                        }
                    }else if(acreditacionItem.tipoFormPago == 'Tarjeta crédito'){
                        acreditacionItem.CLAVE_REF1 = fP.Codigo_autorizacion__c;
                    }else if(acreditacionItem.tipoFormPago == 'Tarjeta débito'){
                        acreditacionItem.CLAVE_REF1 = fP.Codigo_autorizacion__c;
                    }else if(acreditacionItem.tipoFormPago == 'Transferencia'){
                        acreditacionItem.CLAVE_REF1 = fP.RUT_de_quien_transfiere__c;
                    }
                    datosReserva.acreditacion.add(acreditacionItem);
                }
                //System.debug('Reserva anterior: ' + reservaAnterior);
            }
            String xmlString = xmlData(datosReserva);
            System.debug('blanker NAV_SAPWS NAV_SAPWS.callService xmlString '+ xmlString);
            System.debug('blanker NAV_SAPWS NAV_SAPWS.callService iAcreditacion '+ iAcreditacion);
            
            //Para ir contando las cantidades de veces que se envio a SAP dicha acreditacion
            acreditacion.Contador_envio_SAP__c = acreditacion.Contador_envio_SAP__c == null ? 1 : acreditacion.Contador_envio_SAP__c + 1;
            acreditacion.XML_Envio_SAP__c= xmlString;                                    
            update acreditacion;
            
            callService(xmlString, iAcreditacion, true);
        }else{
            acreditacion.Mensaje_SAP__c = 'ERROR: Esta acreditación no posee Destinatario de Documentos.';
            update acreditacion;
        }
    }
    //Metodo con el XML definido
    public static String xmlData(NAV_SAPClass datosReserva){
        String xml ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">';
        xml +='<soapenv:Header/>';
        xml +='<soapenv:Body>';
        xml +='   <urn:ZFI_INTEGRACION_NASA>';
        xml +='      <IE_RESERVA>';
        xml +='         <CABECERA>';
        xml +='            <SOCIEDAD>'+datosReserva.cabecera.sociedad+'</SOCIEDAD>';
        xml +='            <RESERVA>'+datosReserva.cabecera.reserva+'</RESERVA>';
        xml +='            <FECHARESERVA>'+datosReserva.cabecera.fechaReserva+'</FECHARESERVA>';
        xml +='            <CAJA>'+datosReserva.cabecera.caja+'</CAJA>';
        xml +='            <AGENCIA>'+datosReserva.cabecera.agencia+'</AGENCIA>';
        xml +='            <VENDEDOR>'+datosReserva.cabecera.vendedor+'</VENDEDOR>';
        xml +='            <FECHAARQUEO>'+datosReserva.cabecera.fechaArqueo+'</FECHAARQUEO>';
        xml +='            <TRANSBORDADOR>'+datosReserva.cabecera.transbordador+'</TRANSBORDADOR>';
        xml +='            <RUTA>'+datosReserva.cabecera.ruta+'</RUTA>';
        xml +='            <TRAMO>'+datosReserva.cabecera.tramo+'</TRAMO>';
        xml +='            <FECHAZARPE>'+datosReserva.cabecera.fechaZarpe+'</FECHAZARPE>';
        xml +='            <HORAZARPE>'+datosReserva.cabecera.horaZarpe+'</HORAZARPE>';
        xml +='            <TIPOVIAJE>'+datosReserva.cabecera.tipoViaje+'</TIPOVIAJE>';
        xml +='            <CONDICIONPAGO>'+datosReserva.cabecera.condicionPago+'</CONDICIONPAGO>';
        xml +='            <RUT>'+datosReserva.cabecera.rut+'</RUT>';
        xml +='            <NOMBRECLIENTE>'+datosReserva.cabecera.nombreCliente+'</NOMBRECLIENTE>';
        xml +='            <DIRECCION>'+datosReserva.cabecera.direccion+'</DIRECCION>';
        xml +='            <CIUDAD>'+datosReserva.cabecera.ciudad+'</CIUDAD>';
        xml +='            <RAZONSOCIAL>'+datosReserva.cabecera.razonSocial+'</RAZONSOCIAL>';
        xml +='            <PAIS>'+datosReserva.cabecera.pais+'</PAIS>';
        xml +='            <TIPOCUENTA>'+datosReserva.cabecera.tipoCuenta+'</TIPOCUENTA>';
        xml +='            <INSTITUCIONFINANCIERA>'+datosReserva.cabecera.institucionFinanciera+'</INSTITUCIONFINANCIERA>';
        xml +='            <CUENTA>'+datosReserva.cabecera.cuenta+'</CUENTA>';
        xml +='            <EMAIL>'+datosReserva.cabecera.email+'</EMAIL>';
        xml +='         </CABECERA>';
        xml +='         <DOCUMENTOS>';
        xml +='            <!--Zero or more repetitions:-->';
        for(NAV_SAPClass.documentoItem obj : datosReserva.documento){
            xml +='            <item>';
            xml +='               <TIPODOCUMENTO>'+obj.tipoDocumento+'</TIPODOCUMENTO>';
            xml +='               <DOCUMENTO>'+obj.documento+'</DOCUMENTO>';
            xml +='               <FECHADOCUMENTO>'+obj.fechaDocumento+'</FECHADOCUMENTO>';
            xml +='               <TIPONC>'+obj.tipoNC+'</TIPONC>';
            xml +='               <MONTONETO>'+obj.montoNeto+'</MONTONETO>';
            xml +='               <MONTOIVA>'+obj.montoIva+'</MONTOIVA>';
            xml +='               <SERVICIOS>';
            xml +='                  <!--Zero or more repetitions:-->';
            for(NAV_SAPClass.servicioItem objI : obj.servicios){
                xml +='                  <item>';
                xml +='                     <TIPOSERVICIO>'+objI.tipoServicio+'</TIPOSERVICIO>';
                xml +='                     <CODIGOSERVICIO>'+objI.codigoServicio+'</CODIGOSERVICIO>';
                xml +='                     <DESSERVICIO>'+objI.desServicio+'</DESSERVICIO>';
                xml +='                     <CANTIDAD>'+objI.cantidad+'</CANTIDAD>';
                xml +='                     <TIPODOCTOREFERENCIA>'+objI.tipoDoctorReferencia+'</TIPODOCTOREFERENCIA>';
                xml +='                     <DOCTOREFERENCIA>'+objI.doctoReferencia+'</DOCTOREFERENCIA>';
                xml +='                     <MONTOAFECTO>'+objI.montoAfecto+'</MONTOAFECTO>';
                xml +='                     <MONTOEXENTO>'+objI.montoExento+'</MONTOEXENTO>';
                xml +='                  </item>';
            }
            xml +='               </SERVICIOS>';
            xml +='            </item>';
        }
        xml +='         </DOCUMENTOS>';
        xml +='         <ACREDITACION>';
        xml +='            <!--Zero or more repetitions:-->';
        for(NAV_SAPClass.acreditacionItem obj : datosReserva.acreditacion){
            xml +='            <item>';
            xml +='               <FORMAPAGO>'+obj.formaPago+'</FORMAPAGO>';
            xml +='               <NUMEROPAGO>'+obj.numeroPago+'</NUMEROPAGO>';
            xml +='               <MONTOPAGO>'+obj.montoPago+'</MONTOPAGO>';
            if(obj.tipoFormPago != 'Crédito' && obj.tipoFormPago != 'Efectivo'){
                xml += '              <CLAVE_REF1>' + obj.CLAVE_REF1 + '</CLAVE_REF1>';
                if(obj.tipoFormPago == 'Cheque'){
                xml += '              <CLAVE_REF3>' + obj.CLAVE_REF3 + '</CLAVE_REF3>';
           		 }
            } 
            xml +='            </item>';
        }
        xml +='         </ACREDITACION>';
        xml +='      </IE_RESERVA>';
        xml +='      <ET_RETORNO>';
        xml +='         <!--Zero or more repetitions:-->';
        xml +='      </ET_RETORNO>';
        xml +='   </urn:ZFI_INTEGRACION_NASA>';
        xml +='</soapenv:Body>';
        xml +='</soapenv:Envelope>';
        return xml;
    }
    //Metodo con el XML de prueba
    public static String xmlTestData(){
        String xml ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">';
        xml +='<soapenv:Header/>';
        xml +='<soapenv:Body>';
        xml +='   <urn:ZFI_INTEGRACION_NASA>';
        xml +='      <IE_RESERVA>';
        xml +='         <CABECERA>';
        xml +='            <SOCIEDAD>1540</SOCIEDAD>'; //Constante -> Metadata
        xml +='            <RESERVA>123456</RESERVA>'; //Reserva__r.Codigo_Reserva__c
        xml +='            <FECHARESERVA>01042022</FECHARESERVA>'; //Reserva__r.Fecha_de_Reserva__c + time .format('ddmmyyyy')
        xml +='            <CAJA>707</CAJA>'; //Caja__r.Numero_de_Caja__c -> cambiado por N_Caja__c
        xml +='            <AGENCIA>LL14</AGENCIA>'; //Reserva__r.CreatedBy__r.(Oficina de Ventas) --> Ver traduccion
        xml +='            <VENDEDOR>WepPay</VENDEDOR>'; //Reserva__r.CreatedBy__r.Name
        xml +='            <FECHAARQUEO>01042022</FECHAARQUEO>'; //Caja__r.CreatedDate + hora .format('ddMMyyyy')
        xml +='            <TRANSBORDADOR>5000CL048</TRANSBORDADOR>'; //Reserva__r.Itinerario_asociado__r.NAVE__r.CEBE__c
        xml +='            <RUTA>205</RUTA>'; //Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Ruta_SAP__c
        xml +='            <TRAMO>AYACGO</TRAMO>'; //Reserva__r.Puerto_ORIGEN__r.Sigla__c + Reserva__r.Puerto_DESTINO__r.Sigla__c 
        xml +='            <FECHAZARPE>01042022</FECHAZARPE>'; //Reserva__r.Fecha_Hora_de_Viaje__c.format('ddMMyyyy')
        xml +='            <HORAZARPE>00:00</HORAZARPE>'; //Reserva__r.Fecha_Hora_de_Viaje__c.format('hh:mm')
        xml +='            <TIPOVIAJE>N</TIPOVIAJE>'; //N normal | E especial 
        xml +='            <CONDICIONPAGO>1</CONDICIONPAGO>';// 1 contado | 2 credito || 1 en nota de credito -> 
        //En nota de credito si se va a usar para devolver 1 si se va a usar para otra compra 2
        xml +='            <RUT>5771628-2</RUT>'; //Destinatario_documentos__r.Identificacion__c
        xml +='            <NOMBRECLIENTE>OMIRIAM BEROIZA VASQUEZ</NOMBRECLIENTE>'; //Destinatario_documentos__r.Name
        xml +='            <DIRECCION>Puerto Montt</DIRECCION>'; //Reserva__r.Puerto_ORIGEN__r.Name
        xml +='            <CIUDAD>Puerto Montt</CIUDAD>'; //Reserva__r.Puerto_ORIGEN__r.Name
        xml +='            <RAZONSOCIAL>OMIRIAM BEROIZA VASQUEZ</RAZONSOCIAL>'; //Destinatario_documentos__r.Razon_Social__c
        xml +='            <PAIS>CL</PAIS>'; //Depende del pais del cliente que paga 
        xml +='            <TIPOCUENTA/>'; //Texto de tipo de cuenta (corriente|vista|etc.)
        xml +='            <INSTITUCIONFINANCIERA/>'; //Banco
        xml +='            <CUENTA/>'; //(Numero cuenta)
        xml +='            <EMAIL>correocompleto@gmail.com</EMAIL>'; //Destinatario_documentos__r.PersonEmail
        xml +='         </CABECERA>';
        xml +='         <DOCUMENTOS>';
        xml +='            <!--Zero or more repetitions:-->';
        xml +='            <item>';
        xml +='               <TIPODOCUMENTO>16</TIPODOCUMENTO>'; //Ver Tabla
        xml +='               <DOCUMENTO>1201309</DOCUMENTO>'; //Documento__r.N_Documento__c
        xml +='               <FECHADOCUMENTO>01042022</FECHADOCUMENTO>'; //Documento__r.Fecha_Documento_Referencia__c + time .format('ddMMyyyy')
        xml +='               <MONTONETO>18860</MONTONETO>'; //Documento__r.Total_Neto__c
        xml +='               <MONTOIVA>0</MONTOIVA>'; //Documento__r.SUBTOTAL_BRUTO__c - Documento__r.Total_Neto__c ?? VALIDAR MAS ADELANTE
        xml +='               <SERVICIOS>';
        xml +='                  <!--Zero or more repetitions:-->';
        xml +='                  <item>';
        xml +='                     <TIPOSERVICIO>20000394</TIPOSERVICIO>'; //Ver en Tabla
        xml +='                     <CODIGOSERVICIO>0041000001</CODIGOSERVICIO>'; //Ver en Tabla
        xml +='                     <DESSERVICIO>Servicio Transporte de Pa</DESSERVICIO>'; //Ver en Tabla
        xml +='                     <CANTIDAD>1</CANTIDAD>'; //Número en reserva
        xml +='                     <TIPODOCTOREFERENCIA>33</TIPODOCTOREFERENCIA>'; //Documento__r.Tipo_de_Documento__c
        xml +='                     <DOCTOREFERENCIA/>'; //Nota de crédito aludiendo a factura
        xml +='                     <MONTOAFECTO>0</MONTOAFECTO>'; //Valor
        xml +='                     <MONTOEXENTO>18860</MONTOEXENTO>'; //Valor
        xml +='                  </item>';
        xml +='               </SERVICIOS>';
        xml +='            </item>';
        xml +='         </DOCUMENTOS>';
        xml +='         <ACREDITACION>';
        xml +='            <!--Zero or more repetitions:-->';
        xml +='            <item>';
        xml +='               <FORMAPAGO>T</FORMAPAGO>'; //Ver en Tabla
        xml +='               <NUMEROPAGO>9876</NUMEROPAGO>'; //NUMERO DE RESERVA cuando no exista
        xml +='               <MONTOPAGO>30000</MONTOPAGO>'; //Forma_de_pago__r.Monto__c
        xml +='            </item>';
        xml +='            <item>';
        xml +='               <FORMAPAGO>E</FORMAPAGO>';
        xml +='               <NUMEROPAGO>5432</NUMEROPAGO>';
        xml +='               <MONTOPAGO>10000</MONTOPAGO>';
        xml +='            </item>';
        xml +='         </ACREDITACION>';
        xml +='      </IE_RESERVA>';
        xml +='      <ET_RETORNO>';
        xml +='         <!--Zero or more repetitions:-->';
        xml +='      </ET_RETORNO>';
        xml +='   </urn:ZFI_INTEGRACION_NASA>';
        xml +='</soapenv:Body>';
        xml +='</soapenv:Envelope>';
        return xml;
    }
    //Metodo con xml de salida de prueba
    public static String xmlTestOutput(){
        String xml = '<soap-env:Envelope xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/">';
        xml +='<soap-env:Header/>';
        xml +='<soap-env:Body>';
        xml +='   <n0:ZFI_INTEGRACION_NASAResponse xmlns:n0="urn:sap-com:document:sap:rfc:functions">';
        xml +='      <ET_RETORNO>';
        xml +='         <item>';
        xml +='            <TIPODOCUMENTO>16</TIPODOCUMENTO>';
        xml +='            <DOCUMENTO>0001201309</DOCUMENTO>';
        xml +='            <CONT_KEY>1800132611</CONT_KEY>';
        xml +='            <MENSAJE/>';
        xml +='            <NUMERO_CONT>1400001407</NUMERO_CONT>';
        xml +='         </item>';
        xml +='      </ET_RETORNO>';
        xml +='   </n0:ZFI_INTEGRACION_NASAResponse>';
        xml +='</soap-env:Body>';
        xml +='</soap-env:Envelope>';
        return xml;
    }
    //Nuevo método para determinar el documento que se debe enviar
    public static List<NAV_SAPClass.servicioItem> servicioInterno(List<NAV_SAPClass.servicioItem> servicios, Detalle_Documentos__c det, Map<String, ServicioInternoSAP__mdt> servicioSAP){
        NAV_SAPClass.servicioItem servicioItem = new NAV_SAPClass.servicioItem();
        ServicioInternoSAP__mdt sSap = new ServicioInternoSAP__mdt();
        System.debug('Descripcion: '+det.Descripcion__c.toUpperCase());
        if(det.Descripcion__c.toUpperCase().contains('PASAJERO')){
            if(det.Descripcion__c.toUpperCase().contains('TASA')){
                System.debug('TASA EMBARQUE PASAJEROS');
                sSap = servicioSAP.get('TASA_DE_EMBARQUE_PASAJEROS');
                servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
            }else{
                System.debug('PASAJEROS');
                sSap = servicioSAP.get('PASAJERO');
                servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
            }
        }else if(det.Descripcion__c.toUpperCase().contains('PALLET')){
            sSap = servicioSAP.get('PALLET');
            servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
            servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
            servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
        }else if(det.Descripcion__c.toUpperCase().contains('BICICLETA')){
            sSap = servicioSAP.get('BICICLETA');
            servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
            servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
            servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
        }else if(det.Descripcion__c.toUpperCase().contains('VEHICULO')){
            String[] arrDescripcion = det.Descripcion__c.split(' / ');
            System.debug('blanker ' + arrDescripcion);
            if(det.Descripcion__c.toUpperCase().contains('TASA')){
                System.debug(arrDescripcion[1]);
                if(arrDescripcion[1].toUpperCase().contains('MTRS')){
                    //vehiculo pesado
                    System.debug('TASA VEHICULO PESADO');
                    sSap = servicioSAP.get('TASA_DE_EMBARQUE_METR_LIN_V_PESADOS');
                    servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                    servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                    servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
                }else{
                    //vehiculo liviano
                    if(det.Descripcion__c.toUpperCase().contains('ML')){
                        System.debug('TASA EMBARQUE VEHICULOS CARRO');
                        sSap = servicioSAP.get('TASA_DE_EMBARQUE_VEHICULOS_MEN_CON_CARRO');
                        servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                        servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                        servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
                    }else{
                        System.debug('TASA EMBARQUE VEHICULOS MENORES');
                        sSap = servicioSAP.get('TASA_DE_EMBARQUE_VEHICULOS_MENORES');
                        servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                        servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                        servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
                    }
                }
            }else{
                System.debug(arrDescripcion[1]);
                if(arrDescripcion[1].toUpperCase().contains('MTRS')){
                    //vehiculo pesado
                    System.debug('VEHICULO PESADO');
                    sSap = servicioSAP.get('METRO_LINEAL');
                    servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                    servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                    servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
                }else{
                    //vehiculo liviano
                    System.debug('CUALQUIER OTRO VEHICULO');
                    sSap = servicioSAP.get('VEHICULO');
                    servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
                    servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
                    servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
                }
            }
        }else if(det.Descripcion__c.toUpperCase().contains('TRANSBORDO')){
            sSap = servicioSAP.get('TRANSBORDO');
            servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
            servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
            servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
        }else if(det.Descripcion__c.toUpperCase().contains('USO DE ZONA PRE EMBARQUE')){
            sSap = servicioSAP.get('ZONAPREEMBARQUE');
            servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
            servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
            servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
        }
        else{
            sSap = servicioSAP.get('PASAJERO');
            servicioItem.tipoServicio = sSap.Tipo_Servicio_SAP__c;
            servicioItem.codigoServicio = sSap.Codigo_Servicio_SAP__c;
            servicioItem.desServicio = sSap.Descripcion_Servicio_SAP__c;
        }
        servicioItem.cantidad = String.valueOf(det.Cantidad__c);
        servicioItem.tipoDoctorReferencia = '';//doc.Tipo_de_Documento__c;
        servicioItem.doctoReferencia = '';
        System.debug('Detalle valor det.Total_Neto__c: ' + det.Total_Neto__c);
        if(det.Tax_Id__c == '[9]'){
            servicioItem.montoAfecto = '0';
            try{
                servicioItem.montoExento = String.valueOf(Math.round(det.Total_Neto__c));    
            }catch(Exception e){
                servicioItem.montoExento = '0';
            }
        }else{
            try{
                servicioItem.montoAfecto = String.valueOf(Math.round(det.Total_Neto__c));
            }catch(Exception e){
                servicioItem.montoAfecto = '0';
            }
            
            servicioItem.montoExento = '0';
        }
        servicios.add(servicioItem);
        return servicios;
    }
    //Metodo para llamar a servicio
    @future(callout = true)
    public static void callService(String xmlToSend, String iAcreditacion, Boolean automatico){
        Acreditacion__c acreditacion = [SELECT Id, XML_Envio__c, XML_Respuesta__c, Fecha_Envio_SAP__c, Mensaje_SAP__c, Contador_envio_SAP__c, GetStatus_SAP__c FROM Acreditacion__c WHERE Id =: iAcreditacion];
        Id anulacionNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Anulación Venta (No Tributario)').getRecordTypeId();
        Id ventaNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId();
        Id notaCredito = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Nota de Crédito').getRecordTypeId();
        List<Documento__c> documentosX = [SELECT RecordTypeId, Fecha_Envio_SAP__c,
                                          Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c
                                         FROM Documento__c 
                                         WHERE Acreditacion__c =: iAcreditacion];
        System.debug('blanker documentosX ' + documentosX);

        String NumContKey = '';
        Boolean forzarLlamado = false;
        for(Documento__c doc : documentosX){
            if(doc.RecordTypeId == notaCredito || doc.RecordTypeId == anulacionNoTributaria){
                forzarLlamado = true;
            }else if(doc.Fecha_Envio_SAP__c != null ){
                forzarLlamado = false;
            }
        }
        boolean checkPuelche =documentosX[0].Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c ;
        if(acreditacion.Fecha_Envio_SAP__c == null || forzarLlamado == true || automatico == true){
            acreditacion.Fecha_Envio_SAP__c = System.now();
            ServicioSAP__c wsData;
            if(checkPuelche == true){
                wsData  = [SELECT Endpoint__c, Usuario__c, Clave__c, Nombre_Certificado__c
                           FROM ServicioSAP__c
                           LIMIT 1];
                system.debug('wsData Puelche '+wsData);
            }else{
                wsData  = [SELECT Endpoint__c, Usuario__c, Clave__c, Nombre_Certificado__c
                           FROM ServicioSAP__c
                           LIMIT 1];
                system.debug('wsData NAVIERA '+wsData);
            }
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String username = wsData.Usuario__c;
            String password = wsData.Clave__c;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
            String endPoint = wsData.Endpoint__c;
            request.setEndpoint(endPoint);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'text/xml');
            request.setHeader('Authorization', authorizationHeader);
            request.setClientCertificateName(wsData.Nombre_Certificado__c);
            //Sirve para validar pruebas con request falso
            //xmlToSend = xmlTestData();
            request.setBody(xmlToSend);
           // request.setTimeout(3000);
            System.debug('blanker XML a Enviar callservice :');
            System.debug(xmlToSend);
            HttpResponse response = new HttpResponse();
            Dom.Document responseXML = new Dom.Document();
            String MsjStatus;
         
            
            if(!Test.isRunningTest()){          
                //Se agrega espera antes de la llamada
                Integer delay = 4000;
                System.debug('antes->'+DateTime.now().getTime());
                Long start = DateTime.now().getTime();            
                while(DateTime.now().getTime()-start < delay);
                System.debug('despues->'+ DateTime.now().getTime() );
            
                try{
                    response = http.send(request);
                    responseXML.load(response.getBody());
                    //acreditacion.GetStatus_SAP__c = acreditacion.GetStatus_SAP__c + '- OK ' + response.getStatusCode();
                    //system.debug('Respuesta WS: '+response.getBody());
                }catch(Exception ep){
                    //Error Sap
                    //acreditacion.GetStatus_SAP__c = acreditacion.GetStatus_SAP__c + '- ERROR : ' + response.getStatusCode() + ' - ' + ep.getMessage();
                    MsjStatus = 'ERROR : ' + response.getStatusCode() + ' - ' + ep.getMessage();
                    System.debug('Error de comunicacion: '+ep.getMessage());
                    System.debug('Cause: ' + ep.getCause());
                    System.debug('Line number: ' + ep.getLineNumber());
                    System.debug('Stack trace: ' + ep.getStackTraceString());
                }
            }else{
                response.setStatusCode(200);
                responseXML.load(xmlTestOutput());
                response.setBody(responseXML.toXMLString());
            }
            System.debug('blanker response.getStatusCode() ' + response.getStatusCode());
            List<Documento__c> docToUpdate = new List<Documento__c>();
            if (response.getStatusCode() == 200) {
                MsjStatus = 'OK : ' + response.getStatusCode();
                String idSAP = '';
                String mensajeSAP = '';
                String errorMensaje = '';
                dom.XmlNode rootElement = responseXML.getRootElement();
                dom.XmlNode envB = rootElement.getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/');
                dom.XmlNode odR = envB.getChildElement('ZFI_INTEGRACION_NASAResponse', 'urn:sap-com:document:sap:rfc:functions');
                dom.XmlNode etRet = odR.getChildElement('ET_RETORNO', null);
                List<dom.XmlNode> items = etRet.getChildElements();
                List<Documento__c> documentos = [SELECT Id, N_Documento__c, Numero_Contable_SAP__c, Fecha_Envio_SAP__c, RecordTypeId, Correlativo_Unico__c,Numero_ContKey_SAP__c
                                                 FROM Documento__c 
                                                 WHERE Acreditacion__c =: iAcreditacion];
                Map<String, Documento__c> docuMap = new Map<String, Documento__c>();
                for(Documento__c docu : documentos){
                    if(docu.RecordTypeId == anulacionNoTributaria || docu.RecordTypeId == ventaNoTributaria){  
                        String[] codigoUnico = docu.Correlativo_Unico__c.splitByCharacterType();
                        docuMap.put(String.valueOf(codigoUnico[1]), docu);
                    }else{
                        docuMap.put(String.valueOf(docu.N_Documento__c), docu);
                    }
                }
                for(dom.XmlNode item : items){
                    String mensaje = item.getChildElement('MENSAJE',null).getText();
                    mensajeSAP = mensaje;
                    String documento = item.getChildElement('DOCUMENTO',null).getText();
                    NumContKey = item.getChildElement('CONT_KEY',null).getText();
                    if(mensaje.contains('contabilizado')){
                        String[] datos = mensaje.splitByCharacterType();
                        idSAP = datos[29];
                        mensajeSAP = mensajeSAP + ' Ya contabilizado';
                    }else{
                        idSAP = item.getChildElement('NUMERO_CONT',null).getText();
                    }
                    Documento__c docuFound = new Documento__c();
                    docuFound = docuMap.get(documento);
                    if(docuFound == null){
                        docuFound = docuMap.get(String.valueOf(Decimal.valueOf(documento)));
                        docuMap.remove(String.valueOf(Decimal.valueOf(documento)));
                    }else{
                        docuMap.remove(documento);
                    }
                    if(docuFound != null){
                        docuFound.Numero_Contable_SAP__c = idSAP;
                        docuFound.Numero_ContKey_SAP__c = NumContKey;
                        docuFound.Fecha_Envio_SAP__c = System.now();
                        docToUpdate.add(docuFound);
                    }
                }
            }else{
                MsjStatus = 'ERROR : ' + response.getStatusCode();
                System.debug('Falla en la integración');
                System.debug(response.getBody());
            }

            if(acreditacion.XML_Envio__c != null){
                acreditacion.XML_Envio__c = xmlToSend + '' + acreditacion.XML_Envio__c;
            }else{
                acreditacion.XML_Envio__c = xmlToSend;
            }
            if(acreditacion.XML_Respuesta__c != null){
                acreditacion.XML_Respuesta__c = response.getBody() + '' + acreditacion.XML_Respuesta__c;
            }else{
                acreditacion.XML_Respuesta__c = response.getBody();
            }
            acreditacion.GetStatus_SAP__c = acreditacion.GetStatus_SAP__c == null ? MsjStatus : acreditacion.GetStatus_SAP__c + '-' + MsjStatus;
            update acreditacion;
            if(docToUpdate.size() > 0){
                //Para actualizar los documentos
                update docToUpdate;
            }
        }
        //return null;
    }
    public static String removeAccents(String texto){
        texto = texto.replaceAll('Á','A');
        texto = texto.replaceAll('É','E');
        texto = texto.replaceAll('Í','I');
        texto = texto.replaceAll('Ó','O');
        texto = texto.replaceAll('Ú','U');
        texto = texto.replaceAll('á','a');
        texto = texto.replaceAll('é','e');
        texto = texto.replaceAll('í','i');
        texto = texto.replaceAll('ó','o');
        texto = texto.replaceAll('ú','u');
        texto = texto.replaceAll('<','&lt;');
        texto = texto.replaceAll('>','&gt;');
        texto = texto.replaceAll('&','&#38;');
        texto = texto.replaceAll('\'','&#39;');
        texto = texto.replaceAll('"','&#34;');
        return texto;
    }
}