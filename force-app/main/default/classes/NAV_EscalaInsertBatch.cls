/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para inserción masiva de escalas en itinerarios masivos
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     31-10-2021   EFR      Creación de la Clase.
***********************************************************************************/
global class NAV_EscalaInsertBatch implements Database.Batchable<SObject>{
	global Set<Id> iEscalas { get; set; }
	global List<Capacidad_Tramo__c> capacidadesTramo { get; set; }
	global NAV_EscalaInsertBatch(){
		capacidadesTramo = new List<Capacidad_Tramo__c>();
	}
	global Database.QueryLocator start(Database.BatchableContext context){
		String query = 'SELECT Id, Name, Itinerario__c FROM Escalas_Itinerario__c WHERE Id IN:iEscalas';
		return Database.getQueryLocator(query);
	}
   	global void execute(Database.BatchableContext context, List<Escalas_Itinerario__c> scope){
		Set<Id> programasIds = new Set<Id>();
		Set<Id> rutasIds = new Set<Id>();
		Set<Id> navesIds = new Set<Id>();
		List<Boolean> canales = new List<Boolean>();
		List<Capacidad_Nave__c> capacidadesNave = new List<Capacidad_Nave__c>();
		Map<Id, Programacion_de_Itinerario__c> programaciones;
		Map<String, Escalas_Itinerario__c> escalasData = new Map<String, Escalas_Itinerario__c>();
		for(Escalas_Itinerario__c eIt : scope){
			programasIds.add(eIt.Itinerario__c);
			escalasData.put(String.valueOf(eIt.Id+'_'+eIt.Itinerario__c), eIt);
		}
		programaciones = new Map<Id, Programacion_de_Itinerario__c>([SELECT Id, Nombre_de_la_Nave__c, Nombre_Ruta__c, Canal_Web__c FROM Programacion_de_Itinerario__c WHERE Id IN:programasIds]);
		for(Programacion_de_Itinerario__c pIt : programaciones.values()){
			navesIds.add(pIt.Nombre_de_la_Nave__c);
			rutasIds.add(pIt.Nombre_Ruta__c);
		}
		capacidadesNave = [SELECT Alto__c, Ancho__c, Capacidad__c, Name, Categoria__c, Cupo_Venta_Local__c, Nave__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c, No_disponible_Venta__c
							FROM Capacidad_Nave__c
							WHERE Nave__c IN : navesIds];
		for(String dEscT : escalasData.keySet()){
			String[] data = dEscT.split('_');
			Programacion_de_Itinerario__c pData = programaciones.get(data[1]);
			for(Capacidad_Nave__c cN : capacidadesNave){
				if(cN.Nave__c == pData.Nombre_de_la_Nave__c){
					Capacidad_Tramo__c cT = new Capacidad_Tramo__c();
					cT.Alto__c = cN.Alto__c;
					cT.Ancho__c = cN.Ancho__c;
					cT.Canal_Web__c = pData.Canal_Web__c;
					cT.Capacidad__c = cN.Capacidad__c;
					cT.Categoria__c = cN.Categoria__c;
					cT.Cupo_Venta_Local__c = cN.Cupo_Venta_Local__c;
					cT.Escala_itinerario__c = data[0];
					cT.Numero__c = cN.Numero__c;
					if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
					}else if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId();
					}else if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Pista').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
					}else if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Sin Acomodación').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Sin Acomodación').getRecordTypeId();
					}
					cT.No_disponible_Venta__c = cN.No_disponible_Venta__c;
					cT.Ubicacion__c = cN.Ubicacion__c;
					cT.Unidad_de_medida__c = cN.Unidad_de_medida__c;
					capacidadesTramo.add(cT);
				}
			}
		}
        for(Escalas_Itinerario__c eIt : scope){
			Programacion_de_Itinerario__c pData = programaciones.get(eIt.Itinerario__c);
			for(Capacidad_Nave__c cN : capacidadesNave){
				if(cN.Nave__c == pData.Nombre_de_la_Nave__c){
					Capacidad_Tramo__c cT = new Capacidad_Tramo__c();
					cT.Alto__c = cN.Alto__c;
					cT.Ancho__c = cN.Ancho__c;
					cT.Canal_Web__c = pData.Canal_Web__c;
					cT.Capacidad__c = cN.Capacidad__c;
					cT.Categoria__c = cN.Categoria__c;
					cT.Cupo_Venta_Local__c = cN.Cupo_Venta_Local__c;
					cT.Escala_itinerario__c = eIt.Id;
					cT.Numero__c = cN.Numero__c;
					if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Butaca').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
					}else if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Carga').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId();
					}else if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Pista').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
					}else if(cN.RecordTypeId == Schema.SObjectType.Capacidad_Nave__c.getRecordTypeInfosByName().get('Capacidad Nave Sin Acomodación').getRecordTypeId()){
						cT.RecordTypeId = Schema.SObjectType.Capacidad_tramo__c.getRecordTypeInfosByName().get('Sin Acomodación').getRecordTypeId();
					}
					cT.No_disponible_Venta__c = cN.No_disponible_Venta__c;
					cT.Ubicacion__c = cN.Ubicacion__c;
					cT.Unidad_de_medida__c = cN.Unidad_de_medida__c;
					capacidadesTramo.add(cT);
				}
			}
		}
		System.debug('Capacidades Tramo: '+capacidadesTramo.size());
		insert capacidadesTramo;
		/*
			Integer total = capacidadesTramo.size();
			if(total > 0){
				List<Capacidad_Tramo__c> capToInsert = new List<Capacidad_Tramo__c>();
				for(Integer i = 0; i< total; i++){
					capToInsert.add(capacidadesTramo.get(i));
					if(math.mod(i,9000)==0){
						insert capToInsert;
						capToInsert.clear();
					}
				}
				if(capToInsert.size() > 0){
					insert capToInsert;
				}
			}
		*/
	}
	global void finish(Database.BatchableContext context){
		System.debug('Proceso de Escalas terminado');
		System.debug('Cargando proceso para capacidades');
		System.debug('Capacidades a llenar: '+capacidadesTramo.size());
		//NAV_CapacidadesInsertBatch batchProcess = new NAV_CapacidadesInsertBatch();
		//batchProcess.capacidades = this.capacidadesTramo;
		//ID batchprocessid = Database.executeBatch(batchProcess);
	}
}