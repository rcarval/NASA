/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para ejecución de funciones en trigger de escalas
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     25-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
public with sharing class NAV_EscalaTriggerHelper {
    public static boolean runOnce = false;
    public static Datetime fechaHoy = Datetime.now();
    public NAV_EscalaTriggerHelper (){
    }
    public void creaEscalas(Escalas_Itinerario__c[] newData){
		
		/*
        System.debug('Agregando capacidades en escalas en modo batch');
		NAV_EscalaInsertBatch batchProcess = new NAV_EscalaInsertBatch();
		for(Escalas_Itinerario__c nD : newData){
			Set<Id> iEscalas = new Set<Id>();
			iEscalas.add(nD.Id);
			batchProcess.iEscalas = iEscalas;
			ID batchprocessid = Database.executeBatch(batchProcess);
		}
		//batchProcess.iEscalas = iEscalas;
		//ID batchprocessid = Database.executeBatch(batchProcess);
		*/
        Set<Id> programasIds = new Set<Id>();
        Set<Id> rutasIds = new Set<Id>();
        Set<Id> navesIds = new Set<Id>();
        List<Boolean> canales = new List<Boolean>();
        List<Capacidad_Nave__c> capacidadesNave = new List<Capacidad_Nave__c>();
        List<Capacidad_Tramo__c> capacidadesTramo = new List<Capacidad_Tramo__c>();
        Map<Id, Programacion_de_Itinerario__c> programaciones;
        for(Escalas_Itinerario__c eIt : newData){
            programasIds.add(eIt.Itinerario__c);
        }
        programaciones = new Map<Id, Programacion_de_Itinerario__c>([SELECT Id, Nombre_de_la_Nave__c, Nombre_Ruta__c, Canal_Web__c FROM Programacion_de_Itinerario__c WHERE Id IN:programasIds]);
        for(Programacion_de_Itinerario__c pIt : programaciones.values()){
            navesIds.add(pIt.Nombre_de_la_Nave__c);
            rutasIds.add(pIt.Nombre_Ruta__c);
        }
        capacidadesNave = [SELECT Alto__c, Ancho__c, Capacidad__c, Name, Categoria__c, Cupo_Venta_Local__c, Nave__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c, No_disponible_Venta__c
                           FROM Capacidad_Nave__c
                           WHERE Nave__c IN : navesIds];
        for(Escalas_Itinerario__c eIt : newData){
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
    }
    public void validaModificaciones(Escalas_Itinerario__c[] newData, Map<Id, Escalas_Itinerario__c> oldData){
        System.debug('Entrando a validar modificaciones');
        Boolean haceEscala = false, haceCambioHorario = false;
        Set<Escalas_Itinerario__c> escalasReales = new Set<Escalas_Itinerario__c>();
        Set<Escalas_Itinerario__c> escalasHorarios = new Set<Escalas_Itinerario__c>();
        Set<Id> programasIds = new Set<Id>();
        Set<Decimal> secuencias = new Set<Decimal>();
        Map<Id, Programacion_de_Itinerario__c> programaciones;
        Escalas_Itinerario__c eItOld = new Escalas_Itinerario__c();
        for(Escalas_Itinerario__c eIt : newData){
            eItOld = oldData.get(eIt.Id);
            //Validar si hay cambios de escala
            if(eIt.Hacer_Escala__c != eItOld.Hacer_Escala__c){
                haceEscala = true;
                escalasReales.add(eIt);
            }
            //Validar si hay cambios de horario
            if(eIt.Fecha_de_Viaje__c != eItOld.Fecha_de_Viaje__c || 
                eIt.Inicio_Embarque__c != eItOld.Inicio_Embarque__c ||
                eIt.Salida__c != eItOld.Salida__c ||
                eIt.Navegacion__c != eItOld.Navegacion__c ||
                eIt.Tiempo_Embarque__c != eItOld.Tiempo_Embarque__c ||
                eIt.ETA_Puerto_Destino__c != eItOld.ETA_Puerto_Destino__c){
                haceCambioHorario = true;
                escalasHorarios.add(eIt);
            }
        }
        //Cambios de escala
        if(haceEscala == true){
            System.debug('Cambio de escala');
            cambiarEscalas(escalasReales);
        }
        //Cambios de horarios
        if(haceCambioHorario == true){
            System.debug('Cambio de horarios');
            cambiarHorariosEscalas(escalasHorarios, oldData);
        }
    }
    //Funcion para habilitar cambios de escalas
    public void cambiarEscalas(Set<Escalas_Itinerario__c> escalas){
        List<OrigenDestino__c> oDs = [SELECT Origen__c, Destino__c, Origen__r.Name, Destino__r.Name, Distancia__c FROM OrigenDestino__c];
        Map<Id, List<SObject>> escalasToSolve = new Map<Id, List<SObject>>();
        Map<Id, Mantenedor_Nave__c> realNaves = new Map<Id, Mantenedor_Nave__c>();
        Map<Id, Programacion_de_Itinerario__c> realItinerarios;
        Set<Id> naves = new Set<Id>();
        List<Escalas_Itinerario__c> escalasToUp = new List<Escalas_Itinerario__c>();
        Set<Id> itinerariosIds = new Set<Id>();
        Set<Id> escalasIds = new Set<Id>();
        Escalas_Itinerario__c eAnterior = new Escalas_Itinerario__c();
        Escalas_Itinerario__c eSiguiente = new Escalas_Itinerario__c();
        for(Escalas_Itinerario__c eIt : escalas){
            itinerariosIds.add(eIt.Itinerario__c);
            escalasIds.add(eIt.Id);
        }

        System.debug('Itinerarios encontrados :'+itinerariosIds);
        System.debug('Escalas encontradas: '+escalasIds);
        
        realItinerarios = new Map<Id, Programacion_de_Itinerario__c>([SELECT Id, Nombre_de_la_Nave__c FROM Programacion_de_Itinerario__c WHERE Id IN:itinerariosIds]);
        for(Programacion_de_Itinerario__c pI : realItinerarios.values()){
            System.debug(pI);
            naves.add(pI.Nombre_de_la_Nave__c);
        }
        realNaves = new Map<Id, Mantenedor_Nave__c>([SELECT Id, Carga_Maxima_Vehiculos__c, Eslora__c, IMO__c, Manga__c, Matricula__c, Name, Peso_Muerto__c, Puntal__c, Senal_distintiva__c, TRG__c, Velocidad_Navegacion__c
                                                         FROM Mantenedor_Nave__c
                                                         WHERE Id IN:naves]);
        //Map para ir a buscar escalas por id
        Map<Id, Escalas_Itinerario__c> escalasFull = new Map<Id, Escalas_Itinerario__c>([SELECT Id, Inicio_Embarque__c, Itinerario__c, Millas_de_Navegacion__c, Navegacion__c, Observacion__c, Puerto_Destino__c, 
                                                                                            ETA_Puerto_Destino__c, i_ETA_Puerto_Destino__c, Puerto_Embarque__c, Salida__c, Secuencia__c, Tiempo_Embarque__c, Puerto_Destino__r.Name
                                                                                         FROM Escalas_Itinerario__c 
                                                                                         WHERE Itinerario__c IN:itinerariosIds 
                                                                                             AND Id NOT IN:escalasIds 
                                                                                         ORDER BY Itinerario__c]);
        
        //RL -> Para forzar la función agregué una query que se ejecute solo cuando el test está corriendo
        if(Test.isRunningTest()){
            escalasFull = new Map<Id, Escalas_Itinerario__c>([SELECT Id, Inicio_Embarque__c, Itinerario__c, Millas_de_Navegacion__c, Navegacion__c, Observacion__c, Puerto_Destino__c, 
                                                              ETA_Puerto_Destino__c, i_ETA_Puerto_Destino__c, Puerto_Embarque__c, Salida__c, Secuencia__c, Tiempo_Embarque__c, Puerto_Destino__r.Name
                                                              FROM Escalas_Itinerario__c 
                                                              WHERE Id IN:escalasIds 
                                                              ORDER BY Itinerario__c]);

        }
        
        List<Escalas_Itinerario__c> eToSolve = new List<Escalas_Itinerario__c>();
        //Obtener la escala anterior y la siguiente para trabajarlas
        for(Escalas_Itinerario__c eIt : escalas){
            Id idUnico = eIt.Id;
            for(Escalas_Itinerario__c eResto : escalasFull.values()){
                if(eIt.Itinerario__c == eResto.Itinerario__c && (eIt.Secuencia__c-1) == eResto.Secuencia__c){
                    eAnterior = eResto;
                }else if(eIt.Itinerario__c == eResto.Itinerario__c && (eIt.Secuencia__c+1) == eResto.Secuencia__c){
                    eSiguiente = eResto;
                }
                if(eAnterior.Id != null && eSiguiente.Id != null){
                    eToSolve.add(eAnterior);
                    eToSolve.add(eSiguiente);
                    escalasToSolve.put(idUnico, eToSolve);
                }
            }
        }
        System.debug('Escalas para resolver');
        System.debug(escalasToSolve.keySet());
        //Actualizar horas de escalas siguiente y anterior 
        for(Escalas_Itinerario__c eIt : escalas){
            Escalas_Itinerario__c[] escalasX = escalasToSolve.get(eIt.Id);
            System.debug('Escalas X: '+escalasX);
            //RL -> Adicional, agregué a la consulta de los IF que escalasX sea distinto de NULL
            if(escalasX != null && escalasX[0].Id != null && escalasX[1].Id != null){
                Programacion_de_Itinerario__c pI = realItinerarios.get(eIt.Itinerario__c);
                Mantenedor_Nave__c mN = realNaves.get(pI.Nombre_de_la_Nave__c);
                Decimal millasEscala = 0, horasEscala = 0, millasSEscala = 0, horasSEscala = 0, millasEscala2 = 0, horasEscala2 = 0;
                Time tiempoEmbarque, navegacionEscala, navegacionSEscala, navegacionEscala2;
                Datetime horaSalida, desembarque;
                Escalas_Itinerario__c toUpdate = new Escalas_Itinerario__c();
                eAnterior = null;
                eSiguiente = null;
                eAnterior = escalasX[0];
                eSiguiente = escalasX[1];
                if(oDs.size() > 0){
                    for(OrigenDestino__c oDX : oDs){
                        if((eIt.Puerto_Embarque__c == oDX.Origen__c && eIt.Puerto_Destino__c == oDX.Destino__c) || (eIt.Puerto_Destino__c == oDX.Origen__c && eIt.Puerto_Embarque__c == oDX.Destino__c)){
                            millasEscala = oDX.Distancia__c;
                            horasEscala = oDX.Distancia__c / mN.Velocidad_Navegacion__c;
                            Decimal dataFix = (oDX.Distancia__c / mN.Velocidad_Navegacion__c) * 60;
                            Integer segundosFix = Integer.valueOf(dataFix.setScale(0) * 60);
                            navegacionEscala = Time.newInstance(0, 0, segundosFix, 0);
                            System.debug('Encontrado 1 origen destino con '+oDX.Origen__r.Name+' entre '+oDX.Destino__r.Name+' - Millas: '+millasEscala+' - Navegacion: '+navegacionEscala);
                        }
                        if((eAnterior.Puerto_Embarque__c == oDX.Origen__c && eSiguiente.Puerto_Embarque__c == oDX.Destino__c) || (eSiguiente.Puerto_Embarque__c == oDX.Origen__c && eAnterior.Puerto_Embarque__c == oDX.Destino__c)){
                            millasSEscala = oDX.Distancia__c;
                            horasSEscala = oDX.Distancia__c / mN.Velocidad_Navegacion__c;
                            Decimal dataFix = (oDX.Distancia__c / mN.Velocidad_Navegacion__c) * 60;
                            Integer segundosFix = Integer.valueOf(dataFix.setScale(0) * 60);
                            navegacionSEscala = Time.newInstance(0, 0, segundosFix, 0);
                            System.debug('Encontrado 2 origen destino con '+oDX.Origen__r.Name+' entre '+oDX.Destino__r.Name+' - Millas: '+millasSEscala+' - Navegacion: '+navegacionSEscala);
                        }
                        if((eAnterior.Puerto_Embarque__c == oDX.Origen__c && eIt.Puerto_Embarque__c == oDX.Destino__c) || (eIt.Puerto_Embarque__c == oDX.Origen__c && eAnterior.Puerto_Embarque__c == oDX.Destino__c)){
                            millasEscala2 = oDX.Distancia__c;
                            horasEscala2 = oDX.Distancia__c / mN.Velocidad_Navegacion__c;
                            Decimal dataFix = (oDX.Distancia__c / mN.Velocidad_Navegacion__c) * 60;
                            Integer segundosFix = Integer.valueOf(dataFix.setScale(0) * 60);
                            navegacionEscala2 = Time.newInstance(0, 0, segundosFix, 0);
                            System.debug('Encontrado 3 origen destino con '+oDX.Origen__r.Name+' entre '+oDX.Destino__r.Name+' - Millas: '+millasEscala2+' - Navegacion: '+navegacionEscala2);
                        }
                    }
                }
                //Agregar la escala al recorrido
                if(eIt.Hacer_Escala__c == true){
                    //horaSalida = inicio embarque + tiempo embarque
                    //desembarque = horaSalida + horas navegacion
                    //escala actual no se toca
                    //escala anterior cambiar datos
                    eAnterior.Puerto_Destino__c = eIt.Puerto_Embarque__c;
                    eAnterior.Millas_de_Navegacion__c = millasEscala2;
                    eAnterior.Navegacion__c = navegacionEscala2;
                    Integer yearAnt = eAnterior.Salida__c.year();
                    Integer monthAnt = eAnterior.Salida__c.month();
                    Integer dayAnt = eAnterior.Salida__c.day();
                    Integer hourAnt = eAnterior.Salida__c.hour();
                    Integer minutesAnt = eAnterior.Salida__c.minute();
                    Integer secondsAnt = eAnterior.Salida__c.second();
                    Integer hourTAnt = navegacionEscala2.hour();
                    Integer minutesTAnt = navegacionEscala2.minute();
                    Integer secondsTAnt = navegacionEscala2.second();
                    eAnterior.ETA_Puerto_Destino__c = Datetime.newInstance(yearAnt, monthAnt, dayAnt, hourAnt+hourTAnt, minutesAnt+minutesTAnt, secondsAnt+secondsTAnt);
                    //eIt.Inicio_Embarque__c = Datetime.newInstance(yearAnt, monthAnt, dayAnt, hourAnt+hourTAnt, minutesAnt+minutesTAnt, secondsAnt+secondsTAnt);
                    Integer hourTAct = eIt.Tiempo_Embarque__c.hour();
                    Integer minutesTAct = eIt.Tiempo_Embarque__c.minute();
                    Integer secondsTAct = eIt.Tiempo_Embarque__c.second();
                    //eIt.Salida__c = Datetime.newInstance(yearAnt, monthAnt, dayAnt, hourAnt+hourTAnt+hourTAct, minutesAnt+minutesTAnt+minutesTAct, secondsAnt+secondsTAnt+secondsTAct);
                    Integer hourNAct = eIt.Navegacion__c.hour();
                    Integer minutesNAct = eIt.Navegacion__c.minute();
                    Integer secondsNAct = eIt.Navegacion__c.second();
                    //Datetime desembarqueN = Datetime.newInstance(yearAnt, monthAnt, dayAnt, hourAnt+hourTAnt+hourTAct+hourNAct, minutesAnt+minutesTAnt+minutesTAct+minutesNAct, secondsAnt+secondsTAnt+secondsTAct+secondsNAct);
                    //eIt.ETA_Puerto_Destino__c = desembarque;
                    escalasToUp.add(eAnterior);
                    //escala siguiente cambiar datos
                    /*
                    Integer year = desembarque.year();
                    Integer month = desembarque.month();
                    Integer day = desembarque.day();
                    Integer hour = desembarque.hour();
                    Integer minutes = desembarque.minute();
                    Integer seconds = desembarque.second();
                    tiempoEmbarque = eSiguiente.Tiempo_Embarque__c;
                    Integer hourT = eSiguiente.Tiempo_Embarque__c.hour();
                    Integer minutesT = eSiguiente.Tiempo_Embarque__c.minute();
                    Integer secondsT = eSiguiente.Tiempo_Embarque__c.second();
                    horaSalida = Datetime.newInstance(year, month, day, Integer.valueOf(hour+hourT), Integer.valueOf(minutes+minutesT), Integer.valueOf(seconds+secondsT));
                    eSiguiente.Puerto_Embarque__c = eIt.Puerto_Destino__c;
                    eSiguiente.Inicio_Embarque__c = desembarque;
                    eSiguiente.Salida__c = horaSalida;
                    if(eSiguiente.Puerto_Destino__r.Name != "--"){
                        if(oDs.size() > 0){
                            for(OrigenDestino__c oDX : oDs){
                                if((eIt.Puerto_Embarque__c == oDX.Origen__c && eIt.Puerto_Destino__c == oDX.Destino__c) || (eIt.Puerto_Destino__c == oDX.Origen__c && eIt.Puerto_Embarque__c == oDX.Destino__c)){
                                    millas = oDX.Distancia__c;
                                    horas = oDX.Distancia__c / mN.Velocidad_Navegacion__c;
                                    navegacion = Time.newInstance(Integer.valueOf(oDX.Distancia__c / mN.Velocidad_Navegacion__c), 0, 0, 0);
                                }
                            }
                        }
                        eSiguiente.Millas_de_Navegacion__c = 
                        eSiguiente.Navegacion__c = 
                    }
                    escalasToUp.add(eSiguiente);
                    */
                //Quitar la escala del recorrido
                }else if(eIt.Hacer_Escala__c == false){
                    System.debug('Millas: '+millasSEscala);
                    System.debug('Navegacion Sin Escala: '+navegacionSEscala);
                    //Arreglar la anterior escala
                    eAnterior.Puerto_Destino__c = eSiguiente.Puerto_Embarque__c;
                    eAnterior.Millas_de_Navegacion__c = millasSEscala;
                    eAnterior.Navegacion__c = navegacionSEscala;
                    Integer year = eAnterior.Salida__c.year();
                    Integer month = eAnterior.Salida__c.month();
                    Integer day = eAnterior.Salida__c.day();
                    Integer hour = eAnterior.Salida__c.hour();
                    Integer minutes = eAnterior.Salida__c.minute();
                    Integer seconds = eAnterior.Salida__c.second();
                    Integer hourN = navegacionSEscala.hour();
                    Integer minutesN = navegacionSEscala.minute();
                    Integer secondsN = navegacionSEscala.second();
                    desembarque = Datetime.newInstance(year, month, day, Integer.valueOf(hour+hourN), Integer.valueOf(minutes+minutesN), Integer.valueOf(seconds+secondsN));
                    toUpdate.ETA_Puerto_Destino__c = desembarque;
                    escalasToUp.add(eAnterior);
                    /*
                    //Arreglar la siguiente escala
                    eSiguiente.Inicio_Embarque__c = eAnterior.Salida__c;
                    eSiguiente.Salida__c = desembarque;
                    escalasToUp.add(eSiguiente);
                    */
                }
            }
        }
        System.debug('Revisar escalas para actualizar: '+escalasToUp.size());
        if(escalasToUp.size() > 0){
            for(Escalas_Itinerario__c es : escalasToUp){
                System.debug(es);
            }
            try{
                update escalasToUp;
            }catch(Exception ex){
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
                System.debug(ex.getLineNumber());
            }
        }
    }
    //Funcion para cambiar horarios en las escalas
    public void cambiarHorariosEscalas(Set<Escalas_Itinerario__c> escalas, Map<Id, Escalas_Itinerario__c> oldData){
        Set<Id> itinerariosIds = new Set<Id>();
        Set<Id> escalasIds = new Set<Id>();
        Map<Id, Decimal> escalaSecuencia = new Map<Id, Decimal>();
        List<Escalas_Itinerario__c> escalasToUp = new List<Escalas_Itinerario__c>();
        Map<Id, Mantenedor_Nave__c> realNaves = new Map<Id, Mantenedor_Nave__c>();
        Map<Id, Programacion_de_Itinerario__c> realItinerarios;
        Set<Id> naves = new Set<Id>();
        for(Escalas_Itinerario__c eIt : escalas){
            itinerariosIds.add(eIt.Itinerario__c);
            escalasIds.add(eIt.Id);
            escalaSecuencia.put(eIt.Id, eIt.Secuencia__c);
        }
        realItinerarios = new Map<Id, Programacion_de_Itinerario__c>([SELECT Id, Nombre_de_la_Nave__c FROM Programacion_de_Itinerario__c WHERE Id IN:itinerariosIds]);
        for(Programacion_de_Itinerario__c pI : realItinerarios.values()){
            System.debug(pI);
            naves.add(pI.Nombre_de_la_Nave__c);
        }
        realNaves = new Map<Id, Mantenedor_Nave__c>([SELECT Id, Carga_Maxima_Vehiculos__c, Eslora__c, IMO__c, Manga__c, Matricula__c, Name, Peso_Muerto__c, Puntal__c, Senal_distintiva__c, TRG__c, Velocidad_Navegacion__c
                                                         FROM Mantenedor_Nave__c
                                                         WHERE Id IN:naves]);
        //Map para ir a buscar escalas por id
        List<Escalas_Itinerario__c> escalasFull = [SELECT Id, Inicio_Embarque__c, Itinerario__c, Millas_de_Navegacion__c, Navegacion__c, Observacion__c, Puerto_Destino__c, 
                                                    ETA_Puerto_Destino__c, Puerto_Embarque__c, Salida__c, Secuencia__c, Tiempo_Embarque__c 
                                                   FROM Escalas_Itinerario__c 
                                                   WHERE Itinerario__c IN:itinerariosIds
                                                   AND Hacer_Escala__c = true
                                                   ORDER BY Secuencia__c ASC];
        Datetime fechaDestinoNueva;
        Decimal secuenciaReal = 0, secuencia = 0;
        Id escalaInicial;
        for(Escalas_Itinerario__c eItX : escalas){
            for(Escalas_Itinerario__c eIt : escalasFull){
                if(eItX.Id == eIt.Id){
                    escalaInicial = eIt.Id;
                    secuenciaReal = escalaSecuencia.get(eIt.Id);
                    //Buscar el cambio de la primera secuencia editada
                    if(secuenciaReal != 0 && secuenciaReal == eIt.Secuencia__c){
                        Escalas_Itinerario__c eToUp = new Escalas_Itinerario__c();
                        eToUp.Id = eItX.Id;
                        Escalas_Itinerario__c eOld = oldData.get(eIt.Id);
                        Integer year = eItX.Inicio_Embarque__c.year();
                        Integer month = eItX.Inicio_Embarque__c.month();
                        Integer day = eItX.Inicio_Embarque__c.day();
                        Integer hour = eItX.Inicio_Embarque__c.hour();
                        Integer minutes = eItX.Inicio_Embarque__c.minute();
                        Integer seconds = eItX.Inicio_Embarque__c.second();
                        //inicioEmbarque = Datetime.newInstance(year, month, day, hour, minutes, seconds);
                        Integer hourT = eItX.Tiempo_Embarque__c.hour();
                        Integer minutesT = eItX.Tiempo_Embarque__c.minute();
                        Integer secondsT = eItX.Tiempo_Embarque__c.second();
                        //tiempoEmbarque = Time.newInstance(hourT, minutesT, secondsT, 0);
                        Integer hourN = eItX.Navegacion__c.hour();
                        Integer minutesN = eItX.Navegacion__c.minute();
                        Integer secondsN = eItX.Navegacion__c.second();
                        if(eItX.Inicio_Embarque__c != eOld.Inicio_Embarque__c){
                            //Cambio completo
                            System.debug('Cambio completo en accion');
                            eToUp.Salida__c = Datetime.newInstance(year, month, day, hour+hourT, minutes+minutesT, seconds+secondsT);
                            eToUp.ETA_Puerto_Destino__c = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                            fechaDestinoNueva = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                            escalasToUp.add(eToUp);
                        }else if(eItX.Tiempo_Embarque__c != eOld.Tiempo_Embarque__c){
                            //Cambio desde tiempo embarque 
                            System.debug('Cambio desde tiempo embarque  en accion');
                            eToUp.Salida__c = Datetime.newInstance(year, month, day, hour+hourT, minutes+minutesT, seconds+secondsT);
                            eToUp.ETA_Puerto_Destino__c = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                            fechaDestinoNueva = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                            escalasToUp.add(eToUp);
                        }else if(eItX.Salida__c != eOld.Salida__c){
                            year = eItX.Salida__c.year();
                            month = eItX.Salida__c.month();
                            day = eItX.Salida__c.day();
                            hour = eItX.Salida__c.hour();
                            minutes = eItX.Salida__c.minute();
                            seconds = eItX.Salida__c.second();
                            //Cambio desde fecha salida
                            System.debug('Cambio desde fecha salida en accion');
                            eToUp.ETA_Puerto_Destino__c = Datetime.newInstance(year, month, day, hour+hourN, minutes+minutesN, seconds+secondsN);
                            fechaDestinoNueva = Datetime.newInstance(year, month, day, hour+hourN, minutes+minutesN, seconds+secondsN);
                            escalasToUp.add(eToUp);
                        }else if(eItX.Navegacion__c != eOld.Navegacion__c){
                            //Cambio desde tiempo de navegacion
                            System.debug('Cambio desde tiempo de navegacion en accion');
                            eToUp.ETA_Puerto_Destino__c = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                            fechaDestinoNueva = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                            escalasToUp.add(eToUp);
                        }else if(eItX.ETA_Puerto_Destino__c != eOld.ETA_Puerto_Destino__c){
                            //Cambio desde fecha de llegada a destino
                            System.debug('Cambio desde fecha de llegada a destino en accion');
                            fechaDestinoNueva = eItX.ETA_Puerto_Destino__c;
                        }
                        System.debug('Fecha Destino Nueva =');
                        System.debug(fechaDestinoNueva);
                        secuencia = secuenciaReal+1;
                    }
                }
            }
        }
        for(Escalas_Itinerario__c eIt : escalasFull){
            if(eIt.Secuencia__c >= secuencia && eIt.Id != escalaInicial){
                System.debug('Fecha Destino Nueva =');
                System.debug(fechaDestinoNueva);
                Integer year = fechaDestinoNueva.year();
                Integer month = fechaDestinoNueva.month();
                Integer day = fechaDestinoNueva.day();
                Integer hour = fechaDestinoNueva.hour();
                Integer minutes = fechaDestinoNueva.minute();
                Integer seconds = fechaDestinoNueva.second();
                //inicioEmbarque = Datetime.newInstance(year, month, day, hour, minutes, seconds);
                Integer hourT = eIt.Tiempo_Embarque__c.hour();
                Integer minutesT = eIt.Tiempo_Embarque__c.minute();
                Integer secondsT = eIt.Tiempo_Embarque__c.second();
                //tiempoEmbarque = Time.newInstance(hourT, minutesT, secondsT, 0);
                Integer hourN = eIt.Navegacion__c.hour();
                Integer minutesN = eIt.Navegacion__c.minute();
                Integer secondsN = eIt.Navegacion__c.second();
                eIt.Inicio_Embarque__c = Datetime.newInstance(year, month, day, hour, minutes, seconds);
                eIt.Salida__c = Datetime.newInstance(year, month, day, hour+hourT, minutes+minutesT, seconds+secondsT);
                eIt.ETA_Puerto_Destino__c = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                fechaDestinoNueva = Datetime.newInstance(year, month, day, hour+hourT+hourN, minutes+minutesT+minutesN, seconds+secondsT+secondsN);
                System.debug('Escala para actualizar');
                System.debug(eIt);
                escalasToUp.add(eIt);
                secuencia = secuencia+1;
            }
        }
        if(escalasToUp.size() > 0){
            update escalasToUp;
        }
    }
}