/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase reutilizable para consumo de servicios web
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     09-11-2021   RL       Creación de la Clase.
2.0     11-02-2022   OL       Metodos creacion/actualizacion Cliente en BSALE
3.0     08-07-2022   RL       Ajuste para envío de Tax Id en servicio de Facturación acorde a definición de José Esteban (Bsale)
4.0     13-03-2025   EF       Incorporación de objeto "Referencias" para soportar N referencias de documentos
4.1     15-07-2025   EF       Se modifica el segmento de tramos y reservas
***********************************************************************************/


public class NAV_Integraciones_WS  {
    public static String sharedIdDocumento;
    //Envía datos para documento a sistema Bsales
    //Y se almacena en registro de Documento url de factura/boleta + nro de documento
    @future(callout=true)
    public static void consumirWSDocumento(String idDocumento){
        sharedIdDocumento =idDocumento;
        //Declaro variable para deserializar respuesta de WS
        NAV_Documento_JSON documentoJSON = new NAV_Documento_JSON();
        NAV_Nota_Credito_JSON documentoNcJSON = new NAV_Nota_Credito_JSON();
        NAV_ClientesBSaleJson datosCliente = new NAV_ClientesBSaleJson();
        //Declaro variable para deserializar respuesta de Detalles Documentos WS
        NAV_DetalleDocumentos_JSON detalleDocumentosJSON = new NAV_DetalleDocumentos_JSON();

        //Declaro variable para uso de clase tipo Modelo
        NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Declaro variable que recibirá respuesta de WS
        Transient String responseWs;
        Documento__c datosDocumento = new Documento__c();
        List<Referencia_Documento__c> referencias = new List<Referencia_Documento__c>();
        Account datosCuenta = new Account();
        
        Schema.DescribeFieldResult fieldResult = Documento__c.Tipo_de_Documento__c.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        Map<String, String> mapTipoDocumentos = new Map<String, String>();

        for (Schema.PicklistEntry valorPicklist : picklistEntries) {
            mapTipoDocumentos.put(valorPicklist.getValue(), valorPicklist.getLabel());
        }

        //Obtengo los datos de Documento en base al ID del registro
        datosDocumento = consultasSOQL.getDatosDocumento(idDocumento);
        
        //Retorno en una lista todos los registros de Detalle_Documento__c relacionados al Registro de Documento__c
        List<Detalle_Documentos__c> datosDetalleDocumentoList = consultasSOQL.getDatosDetalleDocumentos(idDocumento);

        //Lista de referencias
        List<Referencia_Documento__c> datosReferenciaList = consultasSOQL.getReferenciasDocumentos(idDocumento);

        //Declaro variables para consumo de WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        //String bodyWS = '';
        //String detalleWs = '';
        boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
        try{
            ////Consulto por los datos registrados en el Obj. Documento__c
            //Documento__c datosDocumento = consultasSOQL.getDatosDocumento(idDocumento);
            ////Retorno en una lista todos los registros de Detalle_Documento__c relacionados al Registro de Documento__c
            //List<Detalle_Documentos__c> datosDetalleDocumentoList = consultasSOQL.getDatosDetalleDocumentos(idDocumento);
            
            //Comienzo a armar JSON
            JSONGenerator jsonGen = JSON.createGenerator(true);
            jsonGen.writeStartObject();
            //id Documento, para evitar duplicidad
            jsonGen.writeStringField('salesId', idDocumento);
            
            if(empPuelche == true){
                DocumentosTributariosPuelche__mdt doct = [SELECT MasterLabel FROM DocumentosTributariosPuelche__mdt WHERE CodigoNasa__c =: datosDocumento.Tipo_de_Documento__c ];
                jsonGen.writeNumberField('documentTypeId', Integer.valueOf(doct.MasterLabel));
                jsonGen.writeNumberField('officeId',1);
            }else{
                jsonGen.writeNumberField('documentTypeId', Integer.valueOf(datosDocumento.Tipo_de_Documento__c)); 
                jsonGen.writeNumberField('officeId',Integer.valueOf(datosDocumento.Office_Id__c));
            }
            jsonGen.writeNumberField('emissionDate',datosDocumento.Fecha_Emision_Json__c);
            jsonGen.writeNumberField('expirationDate',datosDocumento.Fecha_Vencimiento_Json__c);
            
            //Si Declarar Documento a SII = true, usar 1, de lo contrario 0
            if(datosDocumento.Declarar_Documento_a_SII__c){
                jsonGen.writeNumberField('declareSii',1);
            }else{
                jsonGen.writeNumberField('declareSii',0);
            }

            //Si el Tipo de Documento es distinto a Nota de Crédito y Condición de Venta es distinto de null
            //Incluir condición de venta
            if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61' && String.isNotBlank(datosDocumento.Condicion_de_Venta__c)){
                api_bsale_condicion_venta__mdt datosCondicionVenta = new api_bsale_condicion_venta__mdt();
                datosCondicionVenta = consultasSOQL.getIdCondicionVenta(datosDocumento.Condicion_de_Venta__c);
                jsonGen.writeNumberField('salesConditionId',Integer.valueOf(datosCondicionVenta.Id_Condicion_Venta__c));
            }

            if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) == '61'){
                jsonGen.writeNumberField('referenceDocumentId',Integer.valueOf(datosDocumento.Documento_Principal__r.Id_Documento_Bsale__c));
                jsonGen.writeStringField('motive',datosDocumento.Motivo_Devolucion__c);
                if(datosDocumento.Tipo_de_Nota_de_Credito__c == '3' && datosDocumento.Tipo_de_Devolucion__c == 'Ajustar Precio de Productos'){
                    jsonGen.writeNumberField('priceAdjustment',1);
                }else{
                    jsonGen.writeNumberField('priceAdjustment',0);
                }

                if(datosDocumento.Tipo_de_Nota_de_Credito__c == '3' && datosDocumento.Tipo_de_Devolucion__c == 'Corregir Información'){
                    jsonGen.writeNumberField('editTexts',1);
                }else{
                    jsonGen.writeNumberField('editTexts',0);
                }
                jsonGen.writeNumberField('type',Integer.valueOf(datosDocumento.Tipo_de_Nota_de_Credito__c));
            }
            
            //Solo llenar datos de cliente cuando exista información
            if(String.isNotBlank(datosDocumento.RUT_Cliente__c) && datosDocumento.RUT_Cliente__c != null){
                jsonGen.writeFieldName('client');
                jsonGen.writeStartObject();
                if(datosDocumento.TipoIdentificacion__c == 'Pasaporte'){
                    jsonGen.writeNumberField('isForeigner',1);
                    jsonGen.writeStringField('code',datosDocumento.RUT_Cliente__c);
                }else{
                    jsonGen.writeStringField('code',datosDocumento.RUT_Cliente__c);
                }
                if(String.isNotBlank(datosDocumento.Ciudad_Cliente__c) && datosDocumento.Ciudad_Cliente__c != null){
                    jsonGen.writeStringField('city',datosDocumento.Ciudad_Cliente__c);
                }
                if(String.isNotBlank(datosDocumento.Comuna_Cliente__c) && datosDocumento.Comuna_Cliente__c != null){
                    jsonGen.writeStringField('municipality',datosDocumento.Comuna_Cliente__c);
                }
                if(String.isNotBlank(datosDocumento.Giro_Cliente__c) && datosDocumento.Giro_Cliente__c != null){
                    jsonGen.writeStringField('activity',datosDocumento.Giro_Cliente__c);
                }else{
                    jsonGen.writeStringField('activity','Actividad No Especificada');
                }
                
                if(String.isNotBlank(datosDocumento.Direccion_Cliente__c) && datosDocumento.Direccion_Cliente__c != null){
                    jsonGen.writeStringField('address',datosDocumento.Direccion_Cliente__c);
                }
                jsonGen.writeStringField('company',datosDocumento.Razon_Social__c);
                jsonGen.writeStringField('email',datosDocumento.Correo_Cliente__c);
                jsonGen.writeEndObject();
            }

            //Si la casilla Enviar Documento a Cliente = true
            //Y correo de cliente NO está vacío
            //se agrega la opción sendEmail = 1
            if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61' && datosDocumento.Enviar_Documento_a_Cliente__c && String.isNotBlank(datosDocumento.Correo_Cliente__c)){
                jsonGen.writeNumberField('sendEmail',1);
            }
            
            //Inicio de array Detalle_Documento__c
            jsonGen.writeFieldName('details');
            jsonGen.writeStartArray();
            //Integer totalDetalles = 0;
            //Ciclo for para agregar los N detalles documento relacionados
            for(Detalle_Documentos__c detalleDocumento : datosDetalleDocumentoList)
            {
                if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61'){
                    jsonGen.writeStartObject();
                    //if(datosDocumento.RecordTypeId == Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Subsidio').getRecordTypeId()){
                    //    jsonGen.writeStringField('code','MTT01');
                    //}
                    jsonGen.writeNumberField('netUnitValue',detalleDocumento.Valor_Unitario_Neto__c);
                    jsonGen.writeNumberField('quantity',detalleDocumento.Cantidad__c);
                    //SOLO ENVIAR TAX ID Cuando sea 1 (IVA)
                    if(detalleDocumento.Tax_Id__c != null && detalleDocumento.Tax_Id__c == '[1]'){
                        jsonGen.writeStringField('taxId',detalleDocumento.Tax_Id__c);
                    }
                    jsonGen.writeStringField('comment',detalleDocumento.Descripcion__c);
                    jsonGen.writeNumberField('discount',detalleDocumento.Descuento__c);
                    jsonGen.writeEndObject();
                }else{
                    jsonGen.writeStartObject();
                    jsonGen.writeNumberField('documentDetailId',Integer.valueOf(detalleDocumento.Detalle_Documento_Principal__r.Id_Detalle_Documento_Bsale__c));
                    if(datosDocumento.Tipo_de_Nota_de_Credito__c == '3' && datosDocumento.Tipo_de_Devolucion__c == 'Ajustar Precio de Productos'){
                        jsonGen.writeStringField('comment',detalleDocumento.Descripcion__c);
                    }
                    
                    if(datosDocumento.Tipo_de_Nota_de_Credito__c == '3' && datosDocumento.Tipo_de_Devolucion__c == 'Ajustar Precio de Productos'){
                        jsonGen.writeNumberField('quantity',0);
                    }else{
                        jsonGen.writeNumberField('quantity',detalleDocumento.Cantidad__c);
                    }
                    
                    if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) == '61' 
                       && datosDocumento.Tipo_de_Nota_de_Credito__c == '0'
                       && datosDocumento.Tipo_de_Devolucion__c == 'Retornar Productos'){
                        jsonGen.writeNumberField('unitValue',0);
                    }else{
                        jsonGen.writeNumberField('unitValue',detalleDocumento.Valor_Unitario_Neto__c);
                    }
                    jsonGen.writeEndObject(); 
                }
            }

            //Agrego referencias solo SI el tipo de documento no es de tipo Nota de Crédito.
            //Condicion para la referencia, debe tener datos el Folio de Referencia, debe tener una Fecha de Referencia y debe existir un texto de Referencia
            if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61' && datosReferenciaList.size() > 0){
                jsonGen.writeEndArray();
                jsonGen.writeFieldName('references');
                jsonGen.writeStartArray();
                for(Referencia_Documento__c ref : datosReferenciaList){
                    jsonGen.writeStartObject();
                    jsonGen.writeStringField('number',ref.Folio__c);
                    Time toAddTime = Time.newInstance(0,0,0,0);
                    Datetime toEpoch = Datetime.newInstance(ref.Fecha__c, toAddTime);
                    Long epoch = toEpoch.getTime() / 1000;
                    jsonGen.writeNumberField('referenceDate', epoch);
                    jsonGen.writeStringField('reason',ref.Referencia__c);
                    //si código de referencia es HES, enviar como variable de texto
                    if(ref.Tipo_Documento__c == 'HES' || ref.Tipo_Documento__c == 'UDP'){
                        jsonGen.writeStringField('codeSii',ref.Tipo_Documento__c);
                    }else{
                        jsonGen.writeNumberField('codeSii',Integer.valueOf(ref.Tipo_Documento__c));
                    }
                    jsonGen.writeEndObject();
                }
                //Comentado por referencias anteriores en campo, ahora se usan las referencias del objeto relacionado
                /*
                if(String.isNotBlank(datosDocumento.Folio_referencia__c) && datosDocumento.Fecha_Documento_Referencia_Json__c > 0 
                && String.isNotBlank(datosDocumento.Referencia__c)){
                    jsonGen.writeStartObject();
                    jsonGen.writeStringField('number',datosDocumento.Folio_referencia__c);
                    jsonGen.writeNumberField('referenceDate',datosDocumento.Fecha_Documento_Referencia_Json__c);
                    jsonGen.writeStringField('reason',datosDocumento.Referencia__c);
                    //si código de referencia es HES, enviar como variable de texto
                    if(datosDocumento.CodigoTipoDocReferencia__c == 'HES'){
                        jsonGen.writeStringField('codeSii',datosDocumento.CodigoTipoDocReferencia__c);
                    }else{
                        jsonGen.writeNumberField('codeSii',Integer.valueOf(datosDocumento.CodigoTipoDocReferencia__c));
                    }
                    jsonGen.writeEndObject();
                }

                //Condicion para la referencia adicional, debe tener datos el Folio de Referencia, debe tener una Fecha de Referencia y debe existir un texto de Referencia
                if(String.isNotBlank(datosDocumento.Folio_referencia_2__c) && datosDocumento.Fecha_Documento_Referencia_Json_2__c > 0
                && String.isNotBlank(datosDocumento.Referencia_2__c)){
                    jsonGen.writeStartObject();
                    jsonGen.writeStringField('number',datosDocumento.Folio_referencia_2__c);
                    jsonGen.writeNumberField('referenceDate',datosDocumento.Fecha_Documento_Referencia_Json_2__c);
                    jsonGen.writeStringField('reason',datosDocumento.Referencia_2__c);
                    //si código de referencia es HES, enviar como variable de texto
                    if(datosDocumento.C_digo_Tipo_Doc_Referencia_2__c == 'HES'){
                        jsonGen.writeStringField('codeSii',datosDocumento.C_digo_Tipo_Doc_Referencia_2__c);
                    }else{
                        jsonGen.writeNumberField('codeSii',Integer.valueOf(datosDocumento.C_digo_Tipo_Doc_Referencia_2__c));
                    }
                    jsonGen.writeEndObject();
                }
                */
                jsonGen.writeEndArray();
            }else{
                jsonGen.writeEndArray();
            }

            //Si el Tipo de Documento es distinto a Nota de Crédito y Condición de Venta es distinto de null
            //Incluir condición de venta
            if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61' && String.isNotBlank(datosDocumento.Condicion_de_Venta__c)){
                api_bsale_condicion_venta__mdt datosCondicionVenta = new api_bsale_condicion_venta__mdt();
                jsonGen.writeFieldName('payments');
                jsonGen.writeStartArray();
                jsonGen.writeStartObject();
                if(datosDocumento.Condicion_de_Venta__c == 'Al_Dia'){
                    jsonGen.writeNumberField('paymentTypeId',1);
                    jsonGen.writeNumberField('amount',Integer.valueOf(datosDocumento.Total_Neto__c));
                    jsonGen.writeNumberField('recordDate',datosDocumento.Fecha_Emision_Json__c);
                }else{
                    jsonGen.writeNumberField('paymentTypeId',4);
                    jsonGen.writeNumberField('amount',Integer.valueOf(datosDocumento.Total_Neto__c));
                }
               
                jsonGen.writeEndObject();
                jsonGen.writeEndArray();
            }

            api_bsale_atributos_documentos__mdt datosDinamicosMdt = new api_bsale_atributos_documentos__mdt();
            
            //Agrego switch para atributos dinámicos
            switch on mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c){
                //Factura Afecta
                when '33'{
                    datosDinamicosMdt = consultasSOQL.getAtributosDinamicosFacturaAfecta(); 
                }

                //Factura Exenta
                when '34'{
                    datosDinamicosMdt = consultasSOQL.getAtributosDinamicosFacturaExenta();
                }

                //Boleta Electrónica
                when'35'{
                    datosDinamicosMdt = consultasSOQL.getAtributosDinamicosBoleta();
                }
            }

            if(datosDinamicosMdt != null && mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61'){
                jsonGen.writeFieldName('dynamicAttributes');
                jsonGen.writeStartArray();
                jsonGen.writeStartObject();
                //Numero Reserva
                jsonGen.writeNumberField('dynamicAttributeId',Integer.valueOf(datosDinamicosMdt.Id_Reserva__c));
                jsonGen.writeStringField('description',datosDocumento.Reserva__c);
                jsonGen.writeEndObject();
                jsonGen.writeStartObject();
                //Viaje Fecha
                jsonGen.writeNumberField('dynamicAttributeId',Integer.valueOf(datosDinamicosMdt.Id_Fecha_Viaje__c));
                jsonGen.writeStringField('description',String.valueOf(Datetime.newInstance(datosDocumento.Fecha_Zarpe__c.year(),datosDocumento.Fecha_Zarpe__c.month(), datosDocumento.Fecha_Zarpe__c.day(), datosDocumento.Fecha_Zarpe__c.hour(), datosDocumento.Fecha_Zarpe__c.minute(), datosDocumento.Fecha_Zarpe__c.second())));
                jsonGen.writeEndObject();
                jsonGen.writeStartObject();
                //Viaje Nave
                jsonGen.writeNumberField('dynamicAttributeId',Integer.valueOf(datosDinamicosMdt.Id_Nave__c));
                jsonGen.writeStringField('description',datosDocumento.Nave__c);
                jsonGen.writeEndObject();
                jsonGen.writeStartObject();
                //Tramo
                jsonGen.writeNumberField('dynamicAttributeId',Integer.valueOf(datosDinamicosMdt.Id_Tramo__c));
                jsonGen.writeStringField('description',datosDocumento.Tramo__c);
                jsonGen.writeEndObject();
                jsonGen.writeEndArray();
            }

            jsonGen.writeEndObject();
            
            //Obtengo Token de Bsale desde metadata
            //api_bsale_token__mdt token = consultasSOQL.getToken();
            system.debug('CD 1 empPuelche' + empPuelche);
            //api_bsale_token__mdt token = consultasSOQL.getToken();
            if(empPuelche == true){
                // Obtengo Token de Bsale desde metadata puelche
                system.debug('CD ingreso Token de Bsale desde metadata puelche 1');
                api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                accessToken = tokenPuelche.access_token__c;
            } else {
                // Obtengo Token de Bsale desde metadata NAVIERA
                system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 1');
                api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                accessToken = tokenNaviera.access_token__c;
            }
            
            //Obtengo Token de Bsale desde metadata
            api_bsale_token__mdt token = consultasSOQL.getToken();
            

            api_bsale__mdt datosWS = new api_bsale__mdt();

            //Obtengo Datos para solicitud Http 
            if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61'){
                datosWS = consultasSOQL.getWsEnvioDocumento();
            }else{
                datosWS = consultasSOQL.getWsEnvioNcDocumento();
            }

            //Asigno link de endpoint, tipo de conexión y access_token
            urlEndpoint = datosWS.ws_endpoint__c;
            metodo = datosWS.tipo_ws_documento__c;
            //accessToken = token.access_token__c;
        
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            //Asigno variables a parámetros de solicitud http request
            req.setEndpoint(urlEndpoint);
            req.setMethod(metodo);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            req.setTimeout(120000);
            req.setBody(jsonGen.getAsString());
            System.debug('Request');
            System.debug(req);
            System.debug('Body');
            System.debug(jsonGen.getAsString());

            //Declaro Http Response y envío datos del Request
            HttpResponse res = new HttpResponse();
            res = h.send(req);
        
            try{
                //Si respuesta tiene código 200 o 201 procedo a realizar deserialización de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                    responseWs = responseWs.replace('"number":','"number_Z":');
                }else{
                    //De lo contrario asigno ERROR como respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    try{
                        responseWs = res.getBody();
                        documentoJSON = NAV_Documento_JSON.parse(responseWs);
                    }catch(Exception ex){
                        //De lo contrario asigno ERROR como respuesta
                        documentoJSON = null;
                        System.debug('ERROR AL INTENTAR DESERIALIZAR RESPUESTA');
                        System.debug(ex.getMessage());
                        System.debug(ex.getStackTraceString());
                        System.debug(ex.getLineNumber());
                    }
                    responseWs = 'ERROR';
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR';
            }

            try{
                //Si responseWs es distinto a ERROR 
                //Utilizo clase NAV_Documento_JSON para deserializar respuesta de WS
                System.debug('RESPUESTA');
                System.debug(responseWs);
                if(responseWs != 'ERROR'){
                    if(mapTipoDocumentos.get(datosDocumento.Tipo_de_Documento__c) != '61'){
                        System.debug(responseWs);
                        documentoJSON = NAV_Documento_JSON.parse(responseWs);
                        System.debug('RESPUESTA');
                        System.debug(documentoJSON);
                        //Si los campos number_Z es distinto de NULL y mayor a 0
                        //Y urlPDF es distinto a NULL y vacío
                        //Debo obtener id de Detalles Documento Bsale
                        if(documentoJSON.number_Z != null && documentoJSON.number_Z > 0 && String.isNotBlank(documentoJSON.urlPdf)){
                            detalleDocumentosJSON = consumirWSDocumentoDetalleDocumento(documentoJSON.details.href);
                        }

                        datosCliente = consumirWsGetClientesRut(datosDocumento.RUT_Cliente__c);

                        //JSON Recibido desde Bsales es distinto a NULL
                        if(documentoJSON != null){
                            //Si los campos number_Z es distinto de NULL y mayor a 0
                            //Y urlPDF es distinto a NULL y vacío
                            //Se ejecutará proceso de grabado de datos Bsale
                            if(documentoJSON.number_Z != null && documentoJSON.number_Z > 0 && String.isNotBlank(documentoJSON.urlPdf)){
                                System.debug('grabar datos');
                                
                                String jsonGuardar = '';
                                jsonGuardar = 'JSON '+String.valueOf(Datetime.now()) + '<br>';
                                if(String.isNotBlank(datosDocumento.Json_BSale__c)){
                                    jsonGuardar += jsonGen.getAsString().replace('\n','<br>') + '<br><br>' + datosDocumento.Json_BSale__c;
                                    if(jsonGuardar.length() > 131072){
                                        jsonGuardar = 'JSON '+String.valueOf(Datetime.now()) + '<br>';
                                        jsonGuardar += jsonGen.getAsString().replace('\n','<br>');
                                    }
                                }else{
                                    jsonGuardar += jsonGen.getAsString().replace('\n','<br>');   
                                }

                                consultasSOQL.registrarDocumentoBsale(idDocumento, documentoJSON.number_Z, documentoJSON.urlPdf, documentoJSON.details.href, String.valueOf(documentoJSON.id), jsonGuardar);
                                
                                //Si ID Cliente Bsale es nulo en el registro de la Cuenta, asocio Id de Bsale al registro de cuenta
                                if(String.isNotBlank(documentoJSON.client.id) && String.isBlank(datosDocumento.Acreditacion__r.Destinatario_documentos__r.Id_Cliente_BSale__c)){
                                    String datosIdState = '';
                                    if(datosCliente.items != null){
                                        for(NAV_ClientesBSaleJson.Items cliente : datosCliente.items){
                                            datosIdState = 'Id = '+cliente.id+' State = '+cliente.state+'\b';
                                        }
                                    }
                                    consultasSOQL.registrarIdClienteBSale(documentoJSON.client.id, datosDocumento.Acreditacion__r.Destinatario_documentos__c, datosIdState);
                                }

                                //Si Detalle Documentos y Respuesta de Detalle Documentos Bsales > 0 asociar registros
                                if(datosDetalleDocumentoList.size() > 0 && detalleDocumentosJSON.items.size() > 0){
                                    System.debug('Actualizar registros de Detalle Documentos');
                                    consultasSOQL.registrarIdDetalleDocumentosBsale(datosDetalleDocumentoList, detalleDocumentosJSON);
                                }
                            }
                        }
                    }else{
                        System.debug(responseWs);
                        documentoNcJSON = NAV_Nota_Credito_JSON.parse(responseWs);
                        System.debug('RESPUESTA');
                        System.debug(documentoNcJSON);
                        
                        //JSON Recibido desde Bsales es distinto a NULL
                        if(documentoNcJSON != null){
                            //Si los campos number_Z es distinto de NULL y mayor a 0
                            //Y urlPDF es distinto a NULL y vacío
                            //Se ejecutará proceso de obtener antecedentes de la NC y grabado de datos Bsale
                            if(documentoNcJSON.credit_note.id != null && Integer.valueOf(documentoNcJSON.credit_note.id) > 0 && String.isNotBlank(documentoNcJSON.credit_note.href)){
                                System.debug('Obtener Datos PDF');
                                if(documentoNcJSON.credit_note.id != null && Integer.valueOf(documentoNcJSON.credit_note.id) > 0 && String.isNotBlank(documentoNcJSON.credit_note.href)){
                                    documentoJSON = consumirWSGetDocumento(documentoNcJSON.credit_note.href);
                                    detalleDocumentosJSON = consumirWSDocumentoDetalleDocumento(documentoJSON.details.href);
                                }
                                
                                String jsonGuardar = '';
                                jsonGuardar = 'JSON '+String.valueOf(Datetime.now()) + '<br>';
                                if(String.isNotBlank(datosDocumento.Json_BSale__c)){
                                    jsonGuardar += jsonGen.getAsString().replace('\n','<br>') + '<br><br>' + datosDocumento.Json_BSale__c;
                                    if(jsonGuardar.length() > 131072){
                                        jsonGuardar = 'JSON '+String.valueOf(Datetime.now()) + '<br>';
                                        jsonGuardar += jsonGen.getAsString().replace('\n','<br>');
                                    }
                                }else{
                                    jsonGuardar += jsonGen.getAsString().replace('\n','<br>');
                                }

                                consultasSOQL.registrarDocumentoBsale(idDocumento, documentoJSON.number_Z, documentoJSON.urlPdf, documentoJSON.details.href, String.valueOf(documentoJSON.id), jsonGuardar);
                                
                                //Si Detalle Documentos y Respuesta de Detalle Documentos Bsales > 0 asociar registros
                                if(datosDetalleDocumentoList.size() > 0 && detalleDocumentosJSON.items.size() > 0){
                                    System.debug('Actualizar registros de Detalle Documentos');
                                    consultasSOQL.registrarIdDetalleDocumentosBsale(datosDetalleDocumentoList, detalleDocumentosJSON);
                                }
                            }
                        }   
                    }
                }else{
                    String mensajeError = 'Se ha producido un error al registrar el documento en BSale.';
                    if(documentoJSON != null){
                        mensajeError += '\n'+documentoJSON.error;
                    }

                    String jsonGuardar = '';
                    jsonGuardar = 'JSON '+String.valueOf(Datetime.now()) + '<br>';
                    if(String.isNotBlank(datosDocumento.Json_BSale__c)){
                        jsonGuardar += jsonGen.getAsString().replace('\n','<br>') + '<br><br>' + datosDocumento.Json_BSale__c;
                        if(jsonGuardar.length() > 131072){
                            jsonGuardar = 'JSON '+String.valueOf(Datetime.now()) + '<br>';
                            jsonGuardar += jsonGen.getAsString().replace('\n','<br>');
                        }
                    }else{
                        jsonGuardar += jsonGen.getAsString().replace('\n','<br>');   
                    }

                    consultasSOQL.registrarRespuestaBSaleDocumento(mensajeError, idDocumento, jsonGuardar);
                }
            }catch(Exception ex){
              System.debug('ERROR');
              System.debug(ex.getMessage());
              System.debug(ex.getStackTraceString());
            }
        }catch(Exception ex){
            System.debug('ERROR');
            System.debug(ex.getMessage());
             System.debug(ex.getStackTraceString());
        }
    }

    //Envía URL de detalle documentos para obtener id de items registrados en Bsale
    public static NAV_Documento_JSON consumirWSGetDocumento(String urlDocumentoBsale){
        //Declaro variable para deserializar respuesta de WS
        NAV_Documento_JSON respuestaDocumentoJson = new NAV_Documento_JSON();
        //Declaro variable para uso de clase tipo Modelo
        Transient NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Declaro variable que recibirá respuesta de WS
        Transient String responseWs;

        //Declaro variables para consumo de WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        String bodyWS = '';
        String detalleWs = '';

        try{
            if(sharedIdDocumento !=null){
                 Documento__c datosDocumento = new Documento__c();
                datosDocumento = consultasSOQL.getDatosDocumento(sharedIdDocumento);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
                system.debug('CD consumirWSGetDocumento 2 empPuelche' + empPuelche);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                if(empPuelche !=null && empPuelche == true){
                    // Obtengo Token de Bsale desde metadata puelche
                    system.debug('CD ingreso Token de Bsale desde metadata puelche 2');
                    api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                    accessToken = tokenPuelche.access_token__c;
                } else {
                    // Obtengo Token de Bsale desde metadata NAVIERA
                    system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 2');
                    api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                    accessToken = tokenNaviera.access_token__c;
                }
            }else{
               api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
               accessToken = tokenNaviera.access_token__c; 
            }
            
            //Asigno link de endpoint, tipo de conexión y access_token
            urlEndpoint = urlDocumentoBsale;
            metodo = 'GET';
            //accessToken = token.access_token__c;
        
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            //Asigno variables a parámetros de solicitud http request
            req.setEndpoint(urlEndpoint);
            req.setMethod(metodo);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            System.debug('Request');
            System.debug(req);
            
            //Declaro Http Response y envío datos del Request
            HttpResponse res = new HttpResponse();
            res = h.send(req);
        
            try{
                //Si respuesta tiene código 200 o 201 procedo a realizar deserialización de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                    responseWs = responseWs.replace('"number":','"number_Z":');
                }else{
                    //De lo contrario asigno ERROR como respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    responseWs = 'ERROR';
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR';
            }

            try{
                //Si responseWs es distinto a ERROR 
                //Utilizo clase NAV_Documento_JSON para deserializar respuesta de WS
                if(responseWs != 'ERROR'){
                  System.debug(responseWs);
                  respuestaDocumentoJson = NAV_Documento_JSON.parse(responseWs);
                  System.debug('RESPUESTA');
                  System.debug(respuestaDocumentoJson);
                }
            }catch(Exception ex){
              System.debug('ERROR');
              System.debug(ex.getMessage());
              System.debug(ex.getStackTraceString());
              respuestaDocumentoJson = null;
            }

            return respuestaDocumentoJson;
        }catch(Exception ex){
            return null;
        }
    }
 
    //Envía URL de detalle documentos para obtener id de items registrados en Bsale
    public static NAV_DetalleDocumentos_JSON consumirWSDocumentoDetalleDocumento(String urlDetalleDocumentosBsale){
        //Declaro variable para deserializar respuesta de WS
        NAV_DetalleDocumentos_JSON detalleDocumentos = new NAV_DetalleDocumentos_JSON();
        //Declaro variable para uso de clase tipo Modelo
        Transient NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Declaro variable que recibirá respuesta de WS
        Transient String responseWs;

        //Declaro variables para consumo de WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        String bodyWS = '';
        String detalleWs = '';

        try{
            //Obtengo Token de Bsale desde metadata
            //api_bsale_token__mdt token = consultasSOQL.getToken();
            if(sharedIdDocumento !=null){
                Documento__c datosDocumento = new Documento__c();
                datosDocumento = consultasSOQL.getDatosDocumento(sharedIdDocumento);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
                system.debug('CD consumirWSDocumentoDetalleDocumento 2 empPuelche' + empPuelche);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                if(empPuelche !=null && empPuelche == true){
                    // Obtengo Token de Bsale desde metadata puelche
                    system.debug('CD ingreso Token de Bsale desde metadata puelche 2');
                    api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                    accessToken = tokenPuelche.access_token__c;
                } else {
                    // Obtengo Token de Bsale desde metadata NAVIERA
                    system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 2');
                    api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                    accessToken = tokenNaviera.access_token__c;
                }
            }else{
               api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
               accessToken = tokenNaviera.access_token__c; 
            } 
            
            //Asigno link de endpoint, tipo de conexión y access_token
            urlEndpoint = urlDetalleDocumentosBsale;
            metodo = 'GET';
            //accessToken = token.access_token__c;
        
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            //Asigno variables a parámetros de solicitud http request
            req.setEndpoint(urlEndpoint);
            req.setMethod(metodo);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            System.debug('Request');
            System.debug(req);
            
            //Declaro Http Response y envío datos del Request
            HttpResponse res = new HttpResponse();
            res = h.send(req);
        
            try{
                //Si respuesta tiene código 200 o 201 procedo a realizar deserialización de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                    responseWs = responseWs.replace('"limit":','"limit_Z":');
                }else{
                    //De lo contrario asigno ERROR como respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    responseWs = 'ERROR';
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR';
            }

            try{
                //Si responseWs es distinto a ERROR 
                //Utilizo clase NAV_DetalleDocumentos_JSON para deserializar respuesta de WS
                if(responseWs != 'ERROR'){
                  System.debug(responseWs);
                  detalleDocumentos = NAV_DetalleDocumentos_JSON.parse(responseWs);
                  System.debug('RESPUESTA');
                  System.debug(detalleDocumentos);
                }
            }catch(Exception ex){
              System.debug('ERROR');
              System.debug(ex.getMessage());
              System.debug(ex.getStackTraceString());
              detalleDocumentos = null;
            }

            return detalleDocumentos;
        }catch(Exception ex){
            return null;
        }
    }
    
    //Envia URL para crear usuario en BSale (Account sin BSale ID)
    @future(callout=true)
    public static void consumirWSClienteBSalePOST (String accountId){
        //Variable para desearealizar respesta
        NAV_ClienteBSale_JSON respuestaBSale = new NAV_ClienteBSale_JSON();
        //Variable para uso de clase tipo Modelo
        Transient NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Variable que recibirá respuesta de WS
        Transient String responseWs;
        //Variable para convertir id de BSale de respuesta de Int a Str
        String bSaleIdString;

        //Variables consumo WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        String bodyWS = '';
        String detalleWs = '';

        Account datosCuenta = consultasSOQL.getAccount(accountId);

        try{
            //Creación del body
            bodyWS += ' {\n';
            bodyWS += '   "municipality": "'+ datosCuenta.BillingState +'",\n';
            bodyWS += '   "activity": "'+datosCuenta.Giro__c+'",\n';
            bodyWS += '   "phone": "'+ datosCuenta.Phone +'",\n';
            bodyWS += '   "city": "'+ datosCuenta.BillingCity +'",\n';
            if(datosCuenta.RecordType.DeveloperName == 'PersonAccount'){
                bodyWS += '   "lastName": "'+ datosCuenta.LastName +'",\n';
                bodyWS += '   "firstName": "'+ datosCuenta.FirstName +'",\n';
            }else{
                bodyWS += '   "lastName": "",\n';
                bodyWS += '   "firstName": "'+ datosCuenta.Razon_Social__c +'",\n';
                bodyWS += '   "company": "'+ datosCuenta.Razon_Social__c +'",\n';
            }
            bodyWS += '   "address": "'+ datosCuenta.BillingStreet + ' ' + datosCuenta.BillingPostalCode +'",\n';
            bodyWS += '   "email": "'+ datosCuenta.PersonEmail +'",\n';
            if(datosCuenta.Tipo_de_identificacion__c == 'Pasaporte'){
                bodyWS += '   "isForeigner":1,\n';
                bodyWS += '   "code": "'+ datosCuenta.RUT_formato__c +'"\n';
            }else{
                bodyWS += '   "code": "'+ datosCuenta.RUT_formato__c +'"\n';
            }
            bodyWS += ' }\n';

            if(sharedIdDocumento !=null){
                 Documento__c datosDocumento = new Documento__c();
                datosDocumento = consultasSOQL.getDatosDocumento(sharedIdDocumento);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
                system.debug('CD consumirWSClienteBSalePOST 2 empPuelche' + empPuelche);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                if(empPuelche !=null && empPuelche == true){
                    // Obtengo Token de Bsale desde metadata puelche
                    system.debug('CD ingreso Token de Bsale desde metadata puelche 2');
                    api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                    accessToken = tokenPuelche.access_token__c;
                } else {
                    // Obtengo Token de Bsale desde metadata NAVIERA
                    system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 2');
                    api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                    accessToken = tokenNaviera.access_token__c;
                }
            }else{
               api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
               accessToken = tokenNaviera.access_token__c; 
            } 

            //Generacion de token de BSale
            //api_bsale_token__mdt token = consultasSOQL.getToken();
            
            //Generacion de datos para consulta http
            api_bsale__mdt datosWS = consultasSOQL.getWsPostCliente();
            
            //Asignacion de endpoint, metodo y access token
            urlEndpoint = datosWS.ws_endpoint__c;
            metodo = datosWS.tipo_ws_documento__c;
            //accessToken = token.access_token__c;

            //Formacion variables Http
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();

            //Asignacion variables a parametros de http request
            req.setEndpoint(urlEndpoint);
            req.setMethod(metodo);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            req.setBody(bodyWS);
            system.debug('request: '+req);
            system.debug('request body: '+req.getBody());
            
            //Envio del request
            res = h.send(req);
            
            try{
                //Si la respuesta tiene codigo 200 o 201 procede a deserealizacion de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                }else{
                    //caso contrario se asigna error a respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    System.debug('Mensaje del Request = '+res.getBody());
                    responseWs = res.getBody();
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR';
            }

            try{
                //Deserealizacion de responseWs cuando el valor es distinto a ERROR
                //Clase deserealizadora NAV_ClienteBSale_JSON
                if(responseWs != 'ERROR'){
                    system.debug(responseWs);
                    respuestaBSale = NAV_ClienteBSale_JSON.parse(responseWs);
                    bSaleIdString = String.valueOf(respuestaBSale.id);
                    system.debug('RESPONSE');
                    system.debug(respuestaBSale);

                    //Si campo ID de BSale viene vacío, registrar respuesta errónea.
                    //Si Id Cliente BSale en Salesforce es vacío y ID Bsale de JSON es distinto de vacío, asociar ID a cuenta.
                    //Si Id Cliente BSale en Salesforce NO es vacío y ID Bsale de JSON es distinto a vacío, guardar mensaje de actualización exitosa.
                    if(respuestaBSale != null && String.isNotBlank(respuestaBSale.error)){
                        consultasSOQL.registrarRespuestaBSale(respuestaBSale.error, accountId);
                    }else{
                        if(respuestaBSale == null || String.isBlank(String.valueOf(respuestaBSale.id))){
                            consultasSOQL.registrarRespuestaBSale('Se ha producido un error, contacte al Administrador', accountId);
                        }else{
                            if(String.isBlank(datosCuenta.Id_Cliente_BSale__c) && String.isNotBlank(String.valueOf(respuestaBSale.id))){
                                String datosIdState = '';
                                datosIdState = 'Id = '+respuestaBSale.id+' State = '+respuestaBSale.state;
                                consultasSOQL.registrarIdClienteBSale(String.valueOf(respuestaBSale.Id), accountId, datosIdState);
                            }else{
                                if(String.isNotBlank(datosCuenta.Id_Cliente_BSale__c) && String.isNotBlank(String.valueOf(respuestaBSale.id))){
                                    consultasSOQL.registrarRespuestaBSale('Registro actualizado en BSale exitósamente', accountId);
                                }
                            }
                        }
                    }
                }else{
                    consultasSOQL.registrarRespuestaBSale('Se ha producido un error, contacte al Administrador', accountId);
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                respuestaBSale = null;
            }

            system.debug(respuestaBsale);
            system.debug(respuestaBsale.id);
            system.debug(bSaleIdString);
            
            //Antes del return, se inserta en la cuenta que envio el POST su nuevo id de BSale entregado por el servicio
            //IF
            //consultasSOQL.registrarIdClienteBSale(bSaleIdString, accountId);
            //
            //return respuestaBSale;
            
        }catch(Exception ex){
            System.debug('ERROR');
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            //return null;
        }
    }
    
    //Envia URL para actualizar usuario en BSale (Account con BSale ID)
    @future(callout=true)
    //public static NAV_ClienteBSale_JSON consumirWSClienteBSalePUT (String accountId, Account datosCuenta){
        public static void consumirWSClienteBSalePUT (String accountId){
        //Variable para desearealizar respesta
        NAV_ClienteBSale_JSON respuestaBSale = new NAV_ClienteBSale_JSON();
        //Variable para uso de clase tipo Modelo
        Transient NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Variable que recibirá respuesta de WS
        Transient String responseWs;

        Account datosCuenta = consultasSOQL.getAccount(accountId);

        //Variables consumo WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        String bodyWS = '';
        String detalleWs = '';
        try{    
            //Creación del body
            bodyWS += ' {\n';
            bodyWS += '   "id": "'+ datosCuenta.Id_Cliente_BSale__c +'",\n';
            bodyWS += '   "municipality": "'+ datosCuenta.BillingState +'",\n';
            bodyWS += '   "activity": "'+datosCuenta.Giro__c+'",\n';
            bodyWS += '   "phone": "'+ datosCuenta.Phone +'",\n';
            bodyWS += '   "city": "'+ datosCuenta.BillingCity +'",\n';
            if(datosCuenta.RecordType.DeveloperName == 'PersonAccount'){
                bodyWS += '   "lastName": "'+ datosCuenta.LastName +'",\n';
                bodyWS += '   "firstName": "'+ datosCuenta.FirstName +'",\n';
            }else{
                bodyWS += '   "lastName": "",\n';
                bodyWS += '   "firstName": "'+ datosCuenta.Razon_Social__c +'",\n';
                bodyWS += '   "company": "'+ datosCuenta.Razon_Social__c +'",\n';
            }
            if(String.isNotBlank(datosCuenta.BillingPostalCode)){
                bodyWS += '   "address": "'+ datosCuenta.BillingStreet + ' ' + datosCuenta.BillingPostalCode +'",\n';
            }else{
                bodyWS += '   "address": "'+ datosCuenta.BillingStreet+'",\n';
            }
            bodyWS += '   "email": "'+ datosCuenta.PersonEmail +'",\n';
            if(datosCuenta.Tipo_de_identificacion__c == 'Pasaporte'){
                bodyWS += '   "isForeigner":1,\n';
                bodyWS += '   "code": "'+ datosCuenta.RUT_formato__c +'"\n';
            }else{
                bodyWS += '   "code": "'+ datosCuenta.RUT_formato__c +'"\n';
            }
            bodyWS += ' }\n';

            if(sharedIdDocumento !=null){
                 Documento__c datosDocumento = new Documento__c();
                datosDocumento = consultasSOQL.getDatosDocumento(sharedIdDocumento);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
                system.debug('CD consumirWSClienteBSalePUT 2 empPuelche' + empPuelche);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                if(empPuelche !=null && empPuelche == true){
                    // Obtengo Token de Bsale desde metadata puelche
                    system.debug('CD ingreso Token de Bsale desde metadata puelche 2');
                    api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                    accessToken = tokenPuelche.access_token__c;
                } else {
                    // Obtengo Token de Bsale desde metadata NAVIERA
                    system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 2');
                    api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                    accessToken = tokenNaviera.access_token__c;
                }
            }else{
               api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
               accessToken = tokenNaviera.access_token__c; 
            } 

            //Generacion de token de BSale
            //api_bsale_token__mdt token = consultasSOQL.getToken();      

            //Generacion de datos para consulta http
            api_bsale__mdt datosWS = consultasSOQL.getWsPutCliente();
            
            //Asignacion de endpoint, metodo y access token
            urlEndpoint = datosWS.ws_endpoint__c+accountId+'.json';
            metodo = datosWS.tipo_ws_documento__c;
            //accessToken = token.access_token__c;

            //Formacion variables Http
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();

            //Asignacion variables a parametros de http request
            req.setEndpoint(urlEndpoint);
            req.setMethod(metodo);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            req.setBody(bodyWS);
            system.debug('request: '+req);
            system.debug('request body: '+req.getBody());
            
            //Envio del request
            res = h.send(req);
            
            try{
                //Si la respuesta tiene codigo 200 o 201 procede a deserealizacion de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                }else{
                    //caso contrario se asigna error a respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    System.debug('Mensaje del Request = '+res.getBody());
                    responseWs = res.getBody();
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR '+ex.getMessage();
            }

            try{
                //Deserealizacion de responseWs cuando el valor es distinto a ERROR
                //Clase deserealizadora NAV_ClienteBSale_JSON
                if(responseWs != 'ERROR'){
                    system.debug(responseWs);
                    respuestaBSale = NAV_ClienteBSale_JSON.parse(responseWs);
                    //bSaleIdString = String.valueOf(respuestaBSale.id);
                    system.debug('RESPONSE');
                    system.debug(respuestaBSale);
                    //Si campo ID de BSale viene vacío, registrar respuesta errónea.
                    //Si Id Cliente BSale en Salesforce es vacío y ID Bsale de JSON es distinto de vacío, asociar ID a cuenta.
                    //Si Id Cliente BSale en Salesforce NO es vacío y ID Bsale de JSON es distinto a vacío, guardar mensaje de actualización exitosa.
                    if(respuestaBSale != null && String.isNotBlank(respuestaBSale.error)){
                        consultasSOQL.registrarRespuestaBSale(respuestaBSale.error, accountId);
                    }else{
                        if(respuestaBSale == null || String.isBlank(String.valueOf(respuestaBSale.id))){
                            consultasSOQL.registrarRespuestaBSale('Se ha producido un error, contacte al Administrador', accountId);
                        }else{
                            if(String.isBlank(datosCuenta.Id_Cliente_BSale__c) && String.isNotBlank(String.valueOf(respuestaBSale.id))){
                                String datosIdState = '';
                                datosIdState = 'Id = '+respuestaBSale.id+' State = '+respuestaBSale.state;
                                consultasSOQL.registrarIdClienteBSale(String.valueOf(respuestaBSale.Id), accountId, datosIdState);
                            }else{
                                if(String.isNotBlank(datosCuenta.Id_Cliente_BSale__c) && String.isNotBlank(String.valueOf(respuestaBSale.id))){
                                    consultasSOQL.registrarRespuestaBSale('Registro actualizado en BSale exitósamente', accountId);
                                }
                            }
                        }
                    }
                }else{
                    consultasSOQL.registrarRespuestaBSale('Se ha producido un error, contacte al Administrador', accountId);
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                respuestaBSale = null;
            }

            system.debug(respuestaBsale);
            system.debug(respuestaBsale.id);
            //system.debug(bSaleIdString);
            
            //return respuestaBSale;
            
        }catch(Exception ex){
            System.debug('ERROR');
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            //return null;
        }
    }

    //Consume Servicio para obtener clientes relacionados a un RUT
    @future(callout=true)
    public static void consumirWSGetClientes(String accountId){
        //Variable para desearealizar respesta
        NAV_ClientesBSaleJson respuestaBSale = new NAV_ClientesBSaleJson();
        //Variable para uso de clase tipo Modelo
        Transient NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Variable que recibirá respuesta de WS
        Transient String responseWs;

        Account datosCuenta = consultasSOQL.getAccount(accountId);
        
        //Variables consumo WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        String bodyWS = '';
        String detalleWs = '';

        try{
            if(sharedIdDocumento !=null){
                 Documento__c datosDocumento = new Documento__c();
                datosDocumento = consultasSOQL.getDatosDocumento(sharedIdDocumento);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
                system.debug('CD consumirWSGetClientes  2 empPuelche' + empPuelche);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                if(empPuelche !=null && empPuelche == true){
                    // Obtengo Token de Bsale desde metadata puelche
                    system.debug('CD ingreso Token de Bsale desde metadata puelche 2');
                    api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                    accessToken = tokenPuelche.access_token__c;
                } else {
                    // Obtengo Token de Bsale desde metadata NAVIERA
                    system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 2');
                    api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                    accessToken = tokenNaviera.access_token__c;
                }
            }else{
               api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
               accessToken = tokenNaviera.access_token__c; 
            }
            
            //Generacion de token de BSale
            //api_bsale_token__mdt token = consultasSOQL.getToken();
            
            //Generacion de datos para consulta http
            api_bsale__mdt datosWS = consultasSOQL.getWsPostCliente();
            
            //Asignacion de endpoint, metodo y access token
            urlEndpoint = datosWS.ws_endpoint__c;
            metodo = datosWS.tipo_ws_documento__c;
            //accessToken = token.access_token__c;

            //Formacion variables Http
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();

            //Asignacion variables a parametros de http request
            req.setEndpoint(urlEndpoint+'?code='+datosCuenta.RUT_formato__c);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            system.debug('request: '+req);
            
            //Envio del request
            res = h.send(req);
            
            try{
                //Si la respuesta tiene codigo 200 o 201 procede a deserealizacion de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                    responseWs = responseWs.replace('"limit":','"limit_Z":');
                }else{
                    //caso contrario se asigna error a respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    System.debug('Mensaje del Request = '+res.getBody());
                    responseWs = res.getBody();
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR';
            }

            try{
                //Deserealizacion de responseWs cuando el valor es distinto a ERROR
                //Clase deserealizadora NAV_ClientesBSaleJson
                if(responseWs != 'ERROR'){
                    system.debug(responseWs);
                    respuestaBSale = NAV_ClientesBSaleJson.parse(responseWs);
                    system.debug('RESPONSE');
                    system.debug(respuestaBSale);

                    //Si campo ID de BSale viene vacío, registrar respuesta errónea.
                    //Si Id Cliente BSale en Salesforce es vacío y ID Bsale de JSON es distinto de vacío, asociar ID a cuenta.
                    //Si Id Cliente BSale en Salesforce NO es vacío y ID Bsale de JSON es distinto a vacío, guardar mensaje de actualización exitosa.
                    if(respuestaBSale != null && String.isNotBlank(respuestaBSale.error)){
                        consultasSOQL.registrarRespuestaBSale(respuestaBSale.error, accountId);
                    }else{
                        if(respuestaBSale != null || respuestaBSale.items.size() > 0){
                            String datosIdState = '';
                            String concatenado = '';
                            for(NAV_ClientesBSaleJson.Items cliente : respuestaBSale.items){
                                try
                                {
                                    System.debug('Id = '+cliente.id+' State = '+cliente.state);
                                    datosIdState = 'Id = '+cliente.id+' State = '+cliente.state+'\b';
                                    concatenado = concatenado  + 'Id = '+cliente.id+' State = '+cliente.state+'\b';
                                }
                                catch(Exception ex){
                                    consultasSOQL.registrarRespuestaBSale('ERROR(1) : ' + concatenado  , accountId);
                                    consultasSOQL.registrarIdsStatesCliente(accountId, 'aaaaaa');
                                    //consultasSOQL.registrarRespuestaBSale('ERROR(1) : ' + ex.getMessage(), accountId);
                                    System.debug('ERROR');
                                    System.debug(ex.getMessage());
                                    System.debug(ex.getStackTraceString());
                                    break;
                                }
                            }
                            consultasSOQL.registrarIdsStatesCliente(accountId, datosIdState);
                        }
                        else
                        {
                            consultasSOQL.registrarRespuestaBSale(respuestaBSale.error, accountId);
                        }
                    }
                }else{
                    consultasSOQL.registrarRespuestaBSale('Se ha producido un error, contacte al Administrador', accountId);
                }
            }catch(Exception ex){
                consultasSOQL.registrarRespuestaBSale('ERROR(1) : ' + ex.getMessage(), accountId);
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                respuestaBSale = null;
            }
            
        }catch(Exception ex){
            consultasSOQL.registrarRespuestaBSale('ERROR(2) : ' + ex.getMessage(), accountId);
            System.debug('ERROR');
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
        }
    }

    public static NAV_ClientesBSaleJson consumirWSGetClientesRUT(String rutCliente){
        //Variable para desearealizar respesta
        NAV_ClientesBSaleJson respuestaBSale = new NAV_ClientesBSaleJson();
        //Variable para uso de clase tipo Modelo
        Transient NAV_Integraciones_SOQL consultasSOQL = new NAV_Integraciones_SOQL();
        //Variable que recibirá respuesta de WS
        Transient String responseWs;

        //Variables consumo WS
        String urlEndpoint;
        String metodo;
        String accessToken;
        String bodyWS = '';
        String detalleWs = '';

        try{
            if(sharedIdDocumento !=null){
                 Documento__c datosDocumento = new Documento__c();
                datosDocumento = consultasSOQL.getDatosDocumento(sharedIdDocumento);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                boolean empPuelche = datosDocumento.Acreditacion__r.Reserva__r.Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c;
                system.debug('CD consumirWSGetClientesRUT 2 empPuelche' + empPuelche);
                //api_bsale_token__mdt token = consultasSOQL.getToken();
                if(empPuelche !=null && empPuelche == true){
                    // Obtengo Token de Bsale desde metadata puelche
                    system.debug('CD ingreso Token de Bsale desde metadata puelche 2');
                    api_bsale_token_puelche__mdt tokenPuelche = consultasSOQL.getTokenPuelche();
                    accessToken = tokenPuelche.access_token__c;
                } else {
                    // Obtengo Token de Bsale desde metadata NAVIERA
                    system.debug('CD ingreso Token de Bsale desde metadata NAVIERA 2');
                    api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
                    accessToken = tokenNaviera.access_token__c;
                }
            }else{
               api_bsale_token__mdt tokenNaviera = consultasSOQL.getToken();
               accessToken = tokenNaviera.access_token__c; 
            } 

            //Generacion de token de BSale
            //api_bsale_token__mdt token = consultasSOQL.getToken();
            
            //Generacion de datos para consulta http
            api_bsale__mdt datosWS = consultasSOQL.getWsPostCliente();
            
            //Asignacion de endpoint, metodo y access token
            urlEndpoint = datosWS.ws_endpoint__c;
            metodo = datosWS.tipo_ws_documento__c;
            //accessToken = token.access_token__c;

            //Formacion variables Http
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();

            //Asignacion variables a parametros de http request
            req.setEndpoint(urlEndpoint+'?code='+rutCliente);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('access_token', accessToken);
            system.debug('request: '+req);
            
            //Envio del request
            res = h.send(req);
            
            try{
                //Si la respuesta tiene codigo 200 o 201 procede a deserealizacion de datos
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){
                    responseWs = res.getBody();
                    responseWs = responseWs.replace('"limit":','"limit_Z":');
                }else{
                    //caso contrario se asigna error a respuesta
                    System.debug('ERROR EN LA LLAMADA');
                    System.debug('Servicio = '+urlEndpoint);
                    System.debug('Código de Status del Request = '+res.getStatusCode());
                    System.debug('Status del Request = '+res.getStatus());
                    System.debug('Mensaje del Request = '+res.getBody());
                    responseWs = res.getBody();
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                responseWs = 'ERROR';
            }

            try{
                //Deserealizacion de responseWs cuando el valor es distinto a ERROR
                //Clase deserealizadora NAV_ClientesBSaleJson
                if(responseWs != 'ERROR'){
                    system.debug(responseWs);
                    respuestaBSale = NAV_ClientesBSaleJson.parse(responseWs);
                    system.debug('RESPONSE');
                    system.debug(respuestaBSale);
                    return respuestaBSale;
                }else{
                    return null;
                }
            }catch(Exception ex){
                System.debug('ERROR');
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                return null;
            }
            
        }catch(Exception ex){
            System.debug('ERROR');
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            return null;
        }
    }
    
}