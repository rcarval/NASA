/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para inserción de capacidades en programación masiva de itinerarios
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     31-10-2021   EFR      Creación de la Clase.
***********************************************************************************/
global class NAV_CapacidadesInsertBatch implements Database.Batchable<SObject>{
	global Capacidad_Tramo__c[] capacidades { get; set; }
	global NAV_CapacidadesInsertBatch(){
		System.debug('Iniciando inserción de capacidades');
	}
	global Capacidad_Tramo__c[] start(Database.BatchableContext context){
		return capacidades;
	}
   	global void execute(Database.BatchableContext context, Capacidad_Tramo__c[] scope){
		System.debug('Capacidades a insertar :'+scope.size());
		insert scope;
	}
	global void finish(Database.BatchableContext context){
		System.debug('Proceso finalizado enviando correo');
		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		message.toAddresses = new String[] { 'eflores@nectia.com' };
		message.optOutPolicy = 'FILTER';
		message.subject = 'Itinerarios completados';
		message.plainTextBody = 'Se ha completado la generación masiva de itinerarios.';
		Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
		if (results[0].success){
			System.debug('The email was sent successfully.');
		} else {
			System.debug('The email failed to send: ' + results[0].errors[0].message);
		}
	}
}