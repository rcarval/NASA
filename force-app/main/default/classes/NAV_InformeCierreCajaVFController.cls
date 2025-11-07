/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para PDF de informe de cierre de caja
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     10-01-2022   EFR      Creación de la Clase.
***********************************************************************************/
public with sharing class NAV_InformeCierreCajaVFController {
  public Id iCaja { get; set; }
    public Boolean showTable { get; set; }
  public String fechaApertura { get; set; }
  public String fechaCierre { get; set; }
  public String agencia { get; set; }
  public String nombreCajero { get; set; }
  public String idCajero { get; set; }
  public String sucursal { get; set; }
  public String observaciones { get; set; }
    //Formas de pago
    public Integer cTickets { get; set; }
    public Decimal mTickets { get; set; }
    public Integer cNotas { get; set; }
    public Decimal mNotas { get; set; }
    public Integer cCuponera { get; set; }
    public Decimal mCuponera { get; set; }
    public Integer cDeposito { get; set; }
    public Decimal mDeposito { get; set; }
    public Integer cPendiente { get; set; }
    public Decimal mPendiente { get; set; }
    public Integer cTransferencias { get; set; }
    public Decimal mTransferencias { get; set; }
    public Integer cWeb { get; set; }
    public Decimal mWeb { get; set; }
    public Integer cDebito { get; set; }
    public Decimal mDebito { get; set; }
    public Integer cCredito { get; set; }
    public Decimal mCredito { get; set; }
    public Integer cTCredito { get; set; }
    public Decimal mTCredito { get; set; }
    public Integer cEfectivo { get; set; }
    public Decimal mEfectivo { get; set; }
    public Integer cCheques { get; set; }
    public Decimal mCheques { get; set; }
    public Integer cCredito30 { get; set; }
    public Decimal mCredito30 { get; set; }
    public Integer cContado { get; set; }
    public Decimal mContado { get; set; }
    //Documentos
    public Integer cAnulacion { get; set; }
    public Decimal mAnulacion { get; set; }
    public Integer cTicket { get; set; }
    public Decimal mTicket { get; set; }
    public Integer cAfecto { get; set; }
    public Decimal mAfecto { get; set; }
    public Integer cExento { get; set; }
    public Decimal mExento { get; set; }
    public Integer cNC { get; set; }
    public Decimal mNC { get; set; }
    public Integer cMixtas { get; set; }
    public Decimal mMixtas { get; set; }
    public Integer cBoletas{ get; set; }
    public Decimal mBoletas { get; set; }
    public Integer ConteoTotalFMPNAV{ get; set; }
    public Integer ConteoTotalDOCNAV{ get; set; }
    public Decimal MontoTotalFMPNAV { get; set; }
    public Decimal MontoTotalDOCNAV { get; set; }
    //Puelche
        //Formas de pago
        public Integer cTicketsPue { get; set; }
        public Decimal mTicketsPue { get; set; }
        public Integer cNotasPue { get; set; }
        public Decimal mNotasPue { get; set; }
        public Integer cCuponeraPue { get; set; }
        public Decimal mCuponeraPue { get; set; }
        public Integer cDepositoPue { get; set; }
        public Decimal mDepositoPue { get; set; }
        public Integer cPendientePue { get; set; }
        public Decimal mPendientePue { get; set; }
        public Integer cTransferenciasPue { get; set; }
        public Decimal mTransferenciasPue { get; set; }
        public Integer cWebPue { get; set; }
        public Decimal mWebPue { get; set; }
        public Integer cDebitoPue { get; set; }
        public Decimal mDebitoPue { get; set; }
        public Integer cCreditoPue { get; set; }
        public Decimal mCreditoPue { get; set; }
        public Integer cTCreditoPue { get; set; }
        public Decimal mTCreditoPue { get; set; }
        public Integer cEfectivoPue { get; set; }
        public Decimal mEfectivoPue { get; set; }
        public Integer cChequesPue { get; set; }
        public Decimal mChequesPue { get; set; }
        public Integer cCredito30Pue { get; set; }
        public Decimal mCredito30Pue { get; set; }
        public Integer cContadoPue { get; set; }
        public Decimal mContadoPue { get; set; }
        //Documentos
        public Integer cAnulacionPue { get; set; }
        public Decimal mAnulacionPue { get; set; }
        public Integer cTicketPue { get; set; }
        public Decimal mTicketPue { get; set; }
        public Integer cAfectoPue { get; set; }
        public Decimal mAfectoPue { get; set; }
        public Integer cExentoPue { get; set; }
        public Decimal mExentoPue { get; set; }
        public Integer cNCPue { get; set; }
        public Decimal mNCPue { get; set; }
        public Integer cMixtasPue { get; set; }
        public Decimal mMixtasPue { get; set; }
        public Integer cBoletasPue { get; set; }
        public Decimal mBoletasPue { get; set; }
        public Integer ConteoTotalFMPPue { get; set; }
        public Integer ConteoTotalDOCPue { get; set; }
        public Decimal MontoTotalFMPPue { get; set; }
        public Decimal MontoTotalDOCPue { get; set; }

    public List<Documento__c> listaDocumentosNAV { get; set; }
    public List<Documento__c> listaDocumentosPUE { get; set; }
    public NAV_InformeCierreCajaVFController(ApexPages.StandardController sCtrl){
    iCaja = ApexPages.CurrentPage().getParameters().get('id');
    Schema.DescribeFieldResult sucursalDatos = User.Sucursal__c.getDescribe();
    List<Schema.PicklistEntry> sucursalValor = sucursalDatos.getPicklistValues();
        Id boletaRT = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Boleta').getRecordTypeId();
        Id facturaART = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Afecta').getRecordTypeId();
        Id facturaERT = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Exenta').getRecordTypeId();
        Id facturaMRT = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Factura Mixta').getRecordTypeId();
        Id notaCredito = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Nota de Crédito').getRecordTypeId();
        Id ventaNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Documento Venta (No Tributario)').getRecordTypeId();
        Id anulacionNoTributaria = Schema.SObjectType.Documento__c.getRecordTypeInfosByName().get('Anulación Venta (No Tributario)').getRecordTypeId();
        cTickets = 0;
        mTickets = 0;
        cNotas = 0;
        mNotas = 0;
        cCuponera = 0;
        mCuponera = 0;
        cDeposito = 0;
        mDeposito = 0;
        cPendiente = 0;
        mPendiente = 0;
        cTransferencias = 0;
        mTransferencias = 0;
        cWeb = 0;
        mWeb = 0;
        cDebito = 0;
        mDebito = 0;
        cCredito = 0;
        mCredito = 0;
        cTCredito = 0;
        mTCredito = 0;
        cEfectivo = 0;
        mEfectivo = 0;
        cCheques = 0;
        mCheques = 0;
        cCredito30 = 0;
        mCredito30 = 0;
        cContado = 0;
        mContado = 0;
        cAnulacion = 0;
        mAnulacion = 0;
        cTicket = 0;
        mTicket = 0;
        cAfecto = 0;
        mAfecto = 0;
        cExento = 0;
        mExento = 0;
        cNC = 0;
        mNC = 0;
        cMixtas = 0;
        mMixtas = 0;
        cBoletas = 0;
        mBoletas = 0;

        //Puelche 
        cTicketsPue = 0;
        mTicketsPue = 0;
        cNotasPue = 0;
        mNotasPue = 0;
        cCuponeraPue = 0;
        mCuponeraPue = 0;
        cDepositoPue = 0;
        mDepositoPue = 0;
        cPendientePue = 0;
        mPendientePue = 0;
        cTransferenciasPue = 0;
        mTransferenciasPue = 0;
        cWebPue = 0;
        mWebPue = 0;
        cDebitoPue = 0;
        mDebitoPue = 0;
        cCreditoPue = 0;
        mCreditoPue = 0;
        cTCreditoPue = 0;
        mTCreditoPue = 0;
        cEfectivoPue = 0;
        mEfectivoPue = 0;
        cChequesPue = 0;
        mChequesPue = 0;
        cCredito30Pue = 0;
        mCredito30Pue = 0;
        cContadoPue = 0;
        mContadoPue = 0;
        cAnulacionPue = 0;
        mAnulacionPue = 0;
        cTicketPue = 0;
        mTicketPue = 0;
        cAfectoPue = 0;
        mAfectoPue = 0;
        cExentoPue = 0;
        mExentoPue = 0;
        cNCPue = 0;
        mNCPue = 0;
        cMixtasPue = 0;
        mMixtasPue = 0;
        cBoletasPue = 0;
        mBoletasPue = 0;

        ConteoTotalFMPNAV= 0;
        ConteoTotalDOCNAV= 0;
        MontoTotalFMPNAV = 0;
        MontoTotalDOCNAV = 0;

        ConteoTotalFMPPue = 0;
        MontoTotalFMPPue = 0;
        ConteoTotalDOCPue = 0;
        MontoTotalDOCPue = 0;

        try{
           Caja__c cajaData = new Caja__c();
            if(!Test.isRunningTest()){
                cajaData = [SELECT Id, Name, N_Caja__c, Numero_de_Caja__c, Estado_de_la_Caja__c, FechaUltimoCierre__c, FechaCaja__c, 
                            WEB__c, AnulacionTicket__c, Cuponera__c, Pendiente__c, LastModifiedDate, 
                            CreatedDate, CreatedById, CreatedBy.Sucursal__c, CreatedBy.Name, CreatedBy.Department, 
                            T_Debito__c, FacturaAfecta__c, T_Credito__c, FacturaExenta__c, Efectivo__c, Nota_Credito__c, Transferencia__c, 
                            FacturaMixta__c, Cheque__c, Boleta__c, Credito__c, TicketsSinDocumentos__c, Deposito__c, Observacion_Caja__c, 
                            TotalDocAnulacionValidamenteEmitidosF__c, TotalDocVtaValidamenteEmitidosF__c, TotalDocVtaValidamenteEmitidos__c, 
                            TotalDocAnulacionValidamenteEmitidos__c, DocumentosPendientesBsaleF__c, DocumentosPendientesBsale__c
                            FROM Caja__c 
                            WHERE Id =: iCaja AND Estado_de_la_Caja__c ='Cerrada'];
            }else{
                cajaData = [SELECT Id, Name, N_Caja__c, Numero_de_Caja__c, Estado_de_la_Caja__c, FechaUltimoCierre__c, FechaCaja__c, 
                            WEB__c, AnulacionTicket__c, Cuponera__c, Pendiente__c, LastModifiedDate, 
                            CreatedDate, CreatedById, CreatedBy.Sucursal__c, CreatedBy.Name, CreatedBy.Department, 
                            T_Debito__c, FacturaAfecta__c, T_Credito__c, FacturaExenta__c, Efectivo__c, Nota_Credito__c, Transferencia__c, 
                            FacturaMixta__c, Cheque__c, Boleta__c, Credito__c, TicketsSinDocumentos__c, Deposito__c, Observacion_Caja__c, 
                            TotalDocAnulacionValidamenteEmitidosF__c, TotalDocVtaValidamenteEmitidosF__c, TotalDocVtaValidamenteEmitidos__c, 
                            TotalDocAnulacionValidamenteEmitidos__c, DocumentosPendientesBsaleF__c, DocumentosPendientesBsale__c
                            FROM Caja__c 
                            WHERE Id =: iCaja];
            }

            
            
                showTable = true; 
				List<Forma_de_Pago__c> lFormasDePago = [SELECT RecordTypeId, RecordType.Name, Monto__c
                                                    FROM Forma_de_Pago__c
                                                    WHERE Caja__c =: iCaja AND Empresa_Puelche__c = false];

            List<Documento__c> lDocumentos = [SELECT RecordTypeId, RecordType.Name, SUBTOTAL_BRUTO__c,Name
            FROM Documento__c
            WHERE Caja__c =: iCaja AND Empresa_Puelche__c = false];
            if(!Test.isRunningTest()){
             listaDocumentosNAV = [SELECT RecordTypeId, RecordType.Name, SUBTOTAL_BRUTO__c,Name,N_Documento__c,Correlativo_unico__c,CreatedDate
                                  FROM Documento__c
                                  WHERE Caja__c =: iCaja AND Empresa_Puelche__c = false ORDER BY RecordType.Name ASC];               
            } 

            List<Forma_de_Pago__c> lFormasDePagoPUE = [SELECT RecordTypeId, RecordType.Name, Monto__c
            FROM Forma_de_Pago__c
            WHERE Caja__c =: iCaja AND Empresa_Puelche__c = true];  

            List<Documento__c> lDocumentosPUE = [SELECT RecordTypeId, RecordType.Name, SUBTOTAL_BRUTO__c,Name
                                              FROM Documento__c
                                              WHERE Caja__c =: iCaja AND Empresa_Puelche__c = true];
            if(!Test.isRunningTest()){
                listaDocumentosPUE = [SELECT RecordTypeId, RecordType.Name, SUBTOTAL_BRUTO__c,Name,N_Documento__c,Correlativo_unico__c, CreatedDate
                                      FROM Documento__c
                                      WHERE Caja__c =: iCaja AND Empresa_Puelche__c = true ORDER BY RecordType.Name ASC];  
            }

            fechaApertura = cajaData.CreatedDate.format();
            fechaCierre = cajaData.LastModifiedDate.format();
            for( Schema.PicklistEntry sV : sucursalValor) {
                if(sV.getValue() == cajaData.CreatedBy.Sucursal__c){
                    agencia = sV.getValue();
                    sucursal  = sV.getLabel();
                }
            }
            nombreCajero = cajaData.CreatedBy.Name;
            idCajero = cajaData.N_Caja__c;
            observaciones = cajaData.Observacion_Caja__c;
            for(Forma_de_Pago__c fPago : lFormasDePago){
                switch on fPago.RecordType.Name{
                    when 'Cheque a fecha', 'Cheque al día'{
                        cCheques = cCheques + 1;
                        mCheques = mCheques + fPago.Monto__c;
                    }
                    when 'Con Documento de Anulación Venta (No Tributario)'{
                        cTickets = cTickets + 1;
                        mTickets = mTickets + fPago.Monto__c;
                    }
                    when 'Con Nota de Crédito'{
                        cNotas = cNotas + 1;
                        mNotas = mNotas + fPago.Monto__c;
                    }
                    when 'Crédito'{
                        cCredito = cCredito + 1;
                        mCredito = mCredito + fPago.Monto__c;
                    }
                    when 'Tarjeta crédito'{
                        cTCredito = cTCredito + 1;
                        mTCredito = mTCredito + fPago.Monto__c;
                    }
                    when 'Cuponera'{
                        cCuponera = cCuponera + 1;
                        mCuponera = mCuponera + fPago.Monto__c;
                    }
                    when 'Depósito cheque'{
                        cDeposito = cDeposito + 1;
                        mDeposito = mDeposito + fPago.Monto__c;
                    }
                    when 'Depósito efectivo'{
                        cDeposito = cDeposito + 1;
                        mDeposito = mDeposito + fPago.Monto__c;
                    }
                    when 'Efectivo'{
                        cEfectivo = cEfectivo + 1;
                        mEfectivo = mEfectivo + fPago.Monto__c;
                    }
                    when 'Pendiente'{
                        cPendiente = cPendiente + 1;
                        mPendiente = mPendiente + fPago.Monto__c;
                    }
                    when 'Tarjeta débito'{
                        cDebito = cDebito + 1;
                        mDebito = mDebito + fPago.Monto__c;
                    }
                    when 'Transferencia bancaria'{
                        cTransferencias = cTransferencias + 1;
                        mTransferencias = mTransferencias + fPago.Monto__c;
                    }
                    when 'WEB'{
                        cWeb = cWeb + 1;
                        mWeb = mWeb + fPago.Monto__c;
                    }
                }
                ConteoTotalFMPNAV += 1;
                MontoTotalFMPNAV += fPago.Monto__c;
            }
            for(Documento__c dPago : lDocumentos){
                switch on dPago.RecordType.Name {
                    when 'Anulación Venta (No Tributario)' {
                        cAnulacion += 1;
                        mAnulacion += dPago.SUBTOTAL_BRUTO__c;
                    }
                    when 'Boleta' {
                        cBoletas += 1;
                        mBoletas += dPago.SUBTOTAL_BRUTO__c;
                    }
                    when 'Documento Venta (No Tributario)' {
                        cTicket += 1;
                        mTicket += dPago.SUBTOTAL_BRUTO__c;
                    }
                    when ' Factura Afecta' {
                        cAfecto += 1;
                        mAfecto += dPago.SUBTOTAL_BRUTO__c;
                    }
                    when 'Factura Exenta' {
                        cExento += 1;
                        mExento += dPago.SUBTOTAL_BRUTO__c;
                    }
                    when 'Factura Mixta' {
                        cMixtas += 1;
                        mMixtas += dPago.SUBTOTAL_BRUTO__c;
                    }
                    when 'Nota de Crédito' {
                        cNC += 1;
                        mNC += dPago.SUBTOTAL_BRUTO__c;
                    }
                }
                
                ConteoTotalDOCNAV += 1;
                // Excluir del monto total si es Anulación o Nota de Crédito
                if (dPago.RecordType.Name != 'Anulación Venta (No Tributario)' &&
                    dPago.RecordType.Name != 'Nota de Crédito') {
                        MontoTotalDOCNAV += dPago.SUBTOTAL_BRUTO__c;
                    }
            }

            for(Forma_de_Pago__c fPagoPue : lFormasDePagoPUE){
                switch on fPagoPue.RecordType.Name{
                    when 'Cheque a fecha', 'Cheque al día'{
                        cChequesPue = cChequesPue + 1;
                        mChequesPue = mChequesPue + fPagoPue.Monto__c;
                    }
                    when 'Con Documento de Anulación Venta (No Tributario)'{
                        cTicketsPue = cTicketsPue + 1;
                        mTicketsPue = mTicketsPue + fPagoPue.Monto__c;
                    }
                    when 'Con Nota de Crédito'{
                        cNotasPue = cNotasPue + 1;
                        mNotasPue = mNotasPue + fPagoPue.Monto__c;
                    }
                    when 'Crédito'{
                        cCreditoPue = cCreditoPue + 1;
                        mCreditoPue = mCreditoPue + fPagoPue.Monto__c;
                    }
                    when 'Tarjeta crédito'{
                        cTCreditoPue = cTCreditoPue + 1;
                        mTCreditoPue = mTCreditoPue + fPagoPue.Monto__c;
                    }
                    when 'Cuponera'{
                        cCuponeraPue = cCuponeraPue + 1;
                        mCuponeraPue = mCuponeraPue + fPagoPue.Monto__c;
                    }
                    when 'Depósito cheque'{
                        cDepositoPue = cDepositoPue + 1;
                        mDepositoPue = mDepositoPue + fPagoPue.Monto__c;
                    }
                    when 'Depósito efectivo'{
                        cDepositoPue = cDepositoPue + 1;
                        mDepositoPue = mDepositoPue + fPagoPue.Monto__c;
                    }
                    when 'Efectivo'{
                        cEfectivoPue = cEfectivoPue + 1;
                        mEfectivoPue = mEfectivoPue + fPagoPue.Monto__c;
                    }
                    when 'Pendiente'{
                        cPendientePue = cPendientePue + 1;
                        mPendientePue = mPendientePue + fPagoPue.Monto__c;
                    }
                    when 'Tarjeta débito'{
                        cDebitoPue = cDebitoPue + 1;
                        mDebitoPue = mDebitoPue + fPagoPue.Monto__c;
                    }
                    when 'Transferencia bancaria'{
                        cTransferenciasPue = cTransferenciasPue + 1;
                        mTransferenciasPue = mTransferenciasPue + fPagoPue.Monto__c;
                    }
                    when 'WEB'{
                        cWebPue = cWebPue + 1;
                        mWebPue = mWebPue + fPagoPue.Monto__c;
                    }
                }
                ConteoTotalFMPPue += 1;
                MontoTotalFMPPue += fPagoPue.Monto__c;
            }
            for(Documento__c dPagoPue : lDocumentosPUE){
                switch on dPagoPue.RecordType.Name {
                    when 'Anulación Venta (No Tributario)'{
                        cAnulacionPue = cAnulacionPue + 1;
                        mAnulacionPue = mAnulacionPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                    when 'Boleta'{
                        cBoletasPue = cBoletasPue + 1;
                        mBoletasPue = mBoletasPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                    when 'Documento Venta (No Tributario)'{
                        cTicketPue = cTicketPue + 1;
                        mTicketPue = mTicketPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                    when 'Factura Afecta'{
                        cAfectoPue = cAfectoPue + 1;
                        mAfectoPue = mAfectoPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                    when 'Factura Exenta'{
                        cExentoPue = cExentoPue + 1;
                        mExentoPue = mExentoPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                    when 'Factura Mixta'{
                        cMixtasPue = cMixtasPue + 1;
                        mMixtasPue = mMixtasPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                    when 'Nota de Crédito'{
                        cNCPue = cNCPue + 1;
                        mNCPue = mNCPue + dPagoPue.SUBTOTAL_BRUTO__c;
                    }
                }
                ConteoTotalDOCPue += 1;
                // Excluir del monto total si es Anulación o Nota de Crédito
                if (dPagoPue.RecordType.Name != 'Anulación Venta (No Tributario)' &&
                    dPagoPue.RecordType.Name != 'Nota de Crédito') {
                        MontoTotalDOCPue+= dPagoPue.SUBTOTAL_BRUTO__c;
                    }
          
            }
            
        }catch(Exception ex){
            showTable = false;
            System.debug('Error');
            System.debug('Tipo de excepción: ' + ex.getTypeName());
            System.debug('Mensaje: ' + ex.getMessage());
            System.debug('Causa: ' + ex.getCause());
            System.debug('Línea: ' + ex.getLineNumber());
            System.debug('Traza: ' + ex.getStackTraceString());
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Esta caja no se encuentra cerrada'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
        }
    }
    @InvocableMethod(label='Enviar Informe de Caja' description='Envia PDF con informe de caja')
    public static void enviarInformeCaja(List<Id> cajaIds) {
        for(Id cId : cajaIds){
            Caja__c cajaData = [SELECT Id, Estado_de_la_Caja__c
                                FROM Caja__c 
                                WHERE Id =: cId];
            IF(cajaData.Estado_de_la_Caja__c =='Cerrado'){
                 NAV_InformeCierreCajaVFController.enviarCorreo(cId);
            }           
        }
    }
    public static void enviarCorreo(Id idCaja){
        //Obtener el usuario a la que se le enviará el correo
        Id userCajaId = [SELECT CreatedById FROM Caja__c WHERE Id =: idCaja].CreatedById;
        String correo = [SELECT Email FROM User WHERE Id =: userCajaId].Email;
        //Obtener PDF de la caja
        PageReference pdf =  Page.NAV_InformeCierreCajaPDF;
        pdf.getParameters().put('Id',idCaja);
        //Blob b = pdf.getContentAsPDF();
        Blob b;
        if(!Test.isRunningTest())
        {
            b = pdf.getContentAsPDF();
        }
        else
        {
            b = Blob.valueOf('Contenido Para Test');
        }
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setContentType('application/pdf');
        efa.setFileName('informeCierreCaja.pdf');
        efa.setInline(false);
        efa.setBody(b);


        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {correo};
        String[] bccToAddresses = new String[] {'informecajanaviera@cpt.cl'};
        mail.setToAddresses(toAddresses);
        mail.setBccAddresses(bccToAddresses);
        mail.setSubject('Informe de Caja Cerrada');
        mail.setHtmlBody('Adjunto encontrará el informe del cierre de la caja.');
        mail.plainTextBody = 'Adjunto encontrará el informe del cierre de la caja.';
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        Messaging.SendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}