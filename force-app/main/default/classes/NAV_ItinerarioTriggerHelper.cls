/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para ejecución de funciones en trigger de itinerarios
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     23-08-2021   EFR      Creación de la Clase.
***********************************************************************************/
public with sharing class NAV_ItinerarioTriggerHelper {
    public static boolean runOnce = false;
    public static Datetime fechaHoy = Datetime.now();
    public NAV_ItinerarioTriggerHelper (){
    }
    public void creaItinerarios(Programacion_de_Itinerario__c[] newData){
        List<OrigenDestino__c> oDs = [SELECT Origen__c, Destino__c, Distancia__c FROM OrigenDestino__c];
        Set<Id> rutas = new Set<Id>();
        Set<Id> naves = new Set<Id>();
        List<Mantenedor_de_Tramos__c> mTra = new List<Mantenedor_de_Tramos__c>();
        Map<Id, Mantenedor_Nave__c> realNaves = new Map<Id, Mantenedor_Nave__c>();
        Map<String, Mantenedor_de_Tramos__c> realTramos = new Map<String, Mantenedor_de_Tramos__c>();
        List<Escalas_itinerario__c> escalasToInsert = new List<Escalas_Itinerario__c>();
        Datetime inicioEmbarque, desembarque, horaSalida;
        System.debug('Programacion_de_Itinerario__c After insert');
        System.debug('Obtencion de rutas y naves');
        for(Programacion_de_Itinerario__c pI : newData){
            //Obtener rutas y naves
            rutas.add(pI.Nombre_Ruta__c);
            naves.add(pI.Nombre_de_la_Nave__c);
        }
        if(naves.size() > 0){
            realNaves = new Map<Id, Mantenedor_Nave__c>([SELECT Id, Carga_Maxima_Vehiculos__c, Eslora__c, IMO__c, Manga__c, Matricula__c, Name, Peso_Muerto__c, Puntal__c, Senal_distintiva__c, TRG__c, Velocidad_Navegacion__c
                                                         FROM Mantenedor_Nave__c
                                                         WHERE Id IN:naves]);
        }
        if(rutas.size() > 0){
            mTra = [SELECT Nombre_de_Ruta__c, Id, DESTINO__c, Name, ORIGEN__c, OwnerId, Puerto_Destino__c, Puerto_Zarpe__c, Secuencia__c, Tiempo_Embarque__c
                    FROM Mantenedor_de_Tramos__c
                    WHERE Nombre_de_Ruta__c IN :rutas
                    ORDER BY Secuencia__c ASC];
            for(Mantenedor_de_Tramos__c mTr : mTra){
                realTramos.put(mTr.Nombre_de_ruta__c, mTr);
            }
        }
        Boolean firstOne = true;
        Decimal millas = 0, horas = 0;
        Time tiempoEmbarque, navegacion;
        for(Programacion_de_Itinerario__c pI : newData){
            firstOne = true;
            for(Mantenedor_de_Tramos__c mT : mTra){
                Mantenedor_Nave__c mN = realNaves.get(pI.Nombre_de_la_Nave__c);
                if(oDs.size() > 0){
                    for(OrigenDestino__c oDX : oDs){
                        if((mT.ORIGEN__c == oDX.Origen__c && mT.DESTINO__c == oDX.Destino__c) || (mT.ORIGEN__c == oDX.Destino__c && mT.DESTINO__c == oDX.Origen__c)){
                            millas = oDX.Distancia__c;
                            horas = oDX.Distancia__c / mN.Velocidad_Navegacion__c;
                            Decimal dataFix = (oDX.Distancia__c / mN.Velocidad_Navegacion__c) * 60;
                            Integer segundosFix = Integer.valueOf(dataFix.setScale(0) * 60);
                            navegacion = Time.newInstance(0, 0, segundosFix, 0);
                        }
                    }
                }
                if(firstOne){
                    //horaSalida = inicio embarque + tiempo embarque
                    //desembarque = horaSalida + horas navegacion
                    Integer year = pI.Fecha_de_Viaje__c.year();
                    Integer month = pI.Fecha_de_Viaje__c.month();
                    Integer day = pI.Fecha_de_Viaje__c.day();
                    Integer hour = pI.Fecha_de_Viaje__c.hour();
                    Integer minutes = pI.Fecha_de_Viaje__c.minute();
                    Integer seconds = pI.Fecha_de_Viaje__c.second();
                    Integer hourT = mT.Tiempo_Embarque__c.hour();
                    Integer minutesT = mT.Tiempo_Embarque__c.minute();
                    Integer secondsT = mT.Tiempo_Embarque__c.second();
					Integer hourN = navegacion.hour();
                    Integer minutesN = navegacion.minute();
                    Integer secondsN = navegacion.second();
                    inicioEmbarque = Datetime.newInstance(year, month, day, Integer.valueOf(hour-hourT), Integer.valueOf(minutes-minutesT), Integer.valueOf(seconds-secondsT));
                    //inicioEmbarque = pI.Fecha_de_Viaje__c;
                    tiempoEmbarque = mT.Tiempo_Embarque__c;
                    //horaSalida = Datetime.newInstance(year, month, day, Integer.valueOf(hour+hourT), Integer.valueOf(minutes+minutesT), Integer.valueOf(seconds+secondsT));
                    horaSalida = pI.Fecha_de_Viaje__c;
                    desembarque = Datetime.newInstance(year, month, day, Integer.valueOf(hour+hourN), Integer.valueOf(minutes+minutesN), Integer.valueOf(seconds+secondsN));
                }else{
                    //horaSalida = inicio embarque + tiempo embarque
                    //desembarque = horaSalida + horas navegacion
                    Integer year = desembarque.year();
                    Integer month = desembarque.month();
                    Integer day = desembarque.day();
                    Integer hour = desembarque.hour();
                    Integer minutes = desembarque.minute();
                    Integer seconds = desembarque.second();
                    Integer hourT = mT.Tiempo_Embarque__c.hour();
                    Integer minutesT = mT.Tiempo_Embarque__c.minute();
                    Integer secondsT = mT.Tiempo_Embarque__c.second();
                    Integer hourN = navegacion.hour();
                    Integer minutesN = navegacion.minute();
                    Integer secondsN = navegacion.second();
                    inicioEmbarque = Datetime.newInstance(year, month, day, hour, minutes, seconds);
                    tiempoEmbarque = Time.newInstance(hourT, minutesT, secondsT, 0);
                    horaSalida = Datetime.newInstance(year, month, day, Integer.valueOf(hour+hourT), Integer.valueOf(minutes+minutesT), Integer.valueOf(seconds+secondsT));
                    desembarque = Datetime.newInstance(year, month, day, Integer.valueOf(hour+hourT+hourN), Integer.valueOf(minutes+minutesN+minutesT), Integer.valueOf(seconds+secondsN+secondsT));
                }
                if(navegacion == null){
                    navegacion = Time.newInstance(0, 0, 0, 0);
                }
                Escalas_Itinerario__c esIt = new Escalas_Itinerario__c();
                esIt.Name = mT.Name;
                esIt.Hacer_Escala__c = true;
                esIt.Inicio_Embarque__c = inicioEmbarque;
                esIt.Itinerario__c = pI.Id;
                esIt.Millas_de_Navegacion__c = millas;
                esIt.Navegacion__c = navegacion;
                esIt.Observacion__c = '';
                esIt.Puerto_Destino__c = mT.DESTINO__c;
                //Romper fecha
                esIt.ETA_Puerto_Destino__c = desembarque;
                esIt.Puerto_Embarque__c = mT.ORIGEN__c;
                //Romper fecha
                esIt.Salida__c = horaSalida;
                esIt.Secuencia__c = mT.Secuencia__c;
                esIt.Tiempo_Embarque__c = tiempoEmbarque;
                //Datos para fijar
                esIt.i_ETA_Puerto_Destino__c = desembarque;
                esIt.i_Inicio_Embarque__c = inicioEmbarque;
                esIt.i_Millas_de_Navegacion__c = millas;
                esIt.i_Navegacion__c = navegacion;
                esIt.i_Puerto_Destino__c = mT.DESTINO__c;
                esIt.i_Salida__c = horaSalida;
                esIt.i_Tiempo_Embarque__c = tiempoEmbarque;
                escalasToInsert.add(esIt);
                System.debug('Escala para insertar');
                System.debug(esIt);
                firstOne = false;
            }
        }
        System.debug('Navegacion: ');
        System.debug(navegacion);
		Integer total = escalasToInsert.size();
        if(total > 0){
			List<Escalas_Itinerario__c> escToInsert = new List<Escalas_Itinerario__c>();
            System.debug('Total: '+total);
			for(Integer i = 0; i< total; i++){
                System.debug(escalasToInsert.get(i));
				escToInsert.add(escalasToInsert.get(i));
				if(math.mod(i,9000)==0){
					insert escToInsert;
					escToInsert.clear();
				}
			}
			if(escToInsert.size() > 0){
				insert escToInsert;
			}
        }
		/*
        if(escalasToInsert.size() > 0){
            insert escalasToInsert;
        }
		*/
    }
    public List<OrigenDestino__c> distanciasOrigenDestino(){
        List<OrigenDestino__c> oD = [SELECT Origen__c, Destino__c, Distancia__c FROM OrigenDestino__c];
        return oD;
    }
}