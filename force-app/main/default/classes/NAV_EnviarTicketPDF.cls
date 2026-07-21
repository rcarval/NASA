/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para envío de PDF's con plantilla y tickets adjuntos
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     21-03-2022   EFR      Creación de la Clase.
1.1     28-03-2022   RL       Se agrega if Test.isRunningTest() para cubrir función getContent
1.2     04-03-2025   RCG      Se evita sendEmail en tests para evitar NO_MASS_MAIL_PERMISSION en sandbox
***********************************************************************************/
public with sharing class NAV_EnviarTicketPDF {
    public NAV_EnviarTicketPDF() {
    }	
	@InvocableMethod(label='Enviar Tickets por Correo' description='Enviar Tickets por Correo')
	public static void EnviarTickets(List<Id> reservaIds) {
        for(Id r : reservaIds){
            NAV_EnviarTicketPDF.enviaCorreo(r);
        }
    }
    public static void enviaCorreo(String rId){
        // Obtener plantilla
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Envio_Documento_Bsale2'];
        // Reserva para plantilla
        Reserva__c reserva = [SELECT Id, Contacto_Reserva__c, Contacto_Reserva__r.PersonEmail, CreatedById ,Empresa_Puelche__c FROM Reserva__c WHERE Id =:rId];
        // Validar que tenga correo
        if(reserva.Contacto_Reserva__c != null){
            if(reserva.Contacto_Reserva__r.PersonEmail != null){
                // Obtener tickets
                 PageReference pdf;
                if(reserva.Empresa_Puelche__c == false){
                    pdf =  Page.NAV_TicketPDF;
                }else{
                    pdf =  Page.PUE_TicketPDF;
                }
                pdf.getParameters().put('id', rId); 
                pdf.setRedirect(true);
                // Obtener contenido PDF
                Blob b;
                if(Test.isRunningTest()){
                    b = Blob.valueOf('Test');
                }else{
                    b = pdf.getContent();
                }
                // Crear adjunto
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('Tickets.pdf');
                efa.setBody(b);
                //Cargar correo
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setTemplateId(et.Id);
                email.setSubject( 'Tickets' );
                email.setToAddresses( new String[] { reserva.Contacto_Reserva__r.PersonEmail } );
                email.setTargetObjectId(reserva.CreatedById);
                email.setWhatId(rId);
                email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                email.setSaveAsActivity(false);
                email.setUseSignature(false);
                //Enviar correo (no enviar en tests para evitar NO_MASS_MAIL_PERMISSION en sandbox)
                if (!Test.isRunningTest()) {
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                }
            }
        }
    }
}