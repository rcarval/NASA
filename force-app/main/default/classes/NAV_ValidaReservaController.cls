public with sharing class NAV_ValidaReservaController {
	public String idReserva { get; set; }
    public NAV_ValidaReservaController(ApexPages.StandardController controller){
        idReserva = ApexPages.CurrentPage().getParameters().get('id');
        validaReserva();
    }
    public PageReference validaReserva(){
        List<Reserva__c> reservas = [SELECT Estado_de_Reserva__c,Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c
                                     FROM Reserva__c
                                     WHERE Id =: idReserva];
        Boolean showPDF = false;
        Integer total = 0, totalToShow = 0;
        total = reservas.size();
		for(Reserva__c res : reservas){
			if(res.Estado_de_Reserva__c == 'Acreditada'){
				totalToShow = totalToShow + 1;
			}
		}
        PageReference valPage;
        
        if(reservas[0].Itinerario_asociado__r.Nombre_Ruta__r.Empresa_Puelche__c == true){
            valPage = Page.PUE_TicketPDF;
        }else{
           valPage = Page.NAV_TicketPDF;
        }
        
        valPage.setRedirect(true);
        valPage.getParameters().put('id',idReserva);
        if(total == totalToShow){
            return valPage;
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Esta reserva no se encuentra acreditada'));
            return null;
        }
    }
}