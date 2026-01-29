/**
* @description       : 
* @author            : Esteban Flores
* @group             : 
* @last modified on  : 08-09-2022
* @last modified by  : Esteban Flores
* @project           : 

* @last modified on  : 14-11-2024
* @last modified by  : CD -> modificacion para puelche
**/
@RestResource(urlMapping='/Web/*')
/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para exponer servicio web para pasarela
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     14-10-2021   EFR      Creación de la Clase.
1.1     23-02-2022   RL       Se crea una clase temporal para almacenar valor del ticket en NAV_WebWS_Ticket_Helper
***********************************************************************************/
global class NAV_WebWS  {
    public class capacidadNave{
        public String id { get; set; }
        public String nombre { get; set; }
        public String ubicacion { get; set; }
        public Decimal capacidad { get; set; }
        public Decimal capacidadDisponible { get; set; }
        public String unidadMedida { get; set; }
        public String itinerario { get; set; }
        public capacidadNave(String n, String u, Decimal c, Decimal cD, String um, String i){
            id = n+u+String.valueOf(c)+um;
            nombre = n;
            ubicacion = u;
            capacidad = c;
            capacidadDisponible = cD;
            unidadMedida = um;
            itinerario = i;
        }
    }
    public static String formatDate(Datetime fecha){
        return fecha.format('yyyy-MM-dd\'T\'HH:mm:ssXXX');
    }
    @HttpPost
    global static void postSalesforceInfo() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String info = req.params.get('info');
        String uuid = req.params.get('uuid');
        Id rTButaca = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
        Id rTButacaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
        Id rTPista = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
        Id rTPistaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
        Id rTCarga = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId();
        Id rTCargaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId();
        Id rTBicicleta = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId();
        String jsonText = '';
		Boolean idaVuelta = false;
        switch on info{
            when 'addCapacities'{
                Blob body = req.requestBody;
                String requestString = body.toString();
                NAV_WrapperCapacities cw = (NAV_WrapperCapacities)JSON.deserialize(requestString,NAV_WrapperCapacities.class);
                System.debug(cw);
                List<Capacidad_Tramo_Detalle_Reserva__c> capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
                //RL -> Instancio clase NAV_Tarificar_SOQL para traer método getMapPuertos
                NAV_Tarificar_SOQL consultasSOQL = new NAV_Tarificar_SOQL();
                Map<String, String> mapPuertos = consultasSOQL.getMapPuertos();

                try{
                    Reserva__c reserva = new Reserva__c();
                    if(cw.reservation != ''){
                        reserva = [SELECT Id, Name, Cantidad_de_Pasajeros__c, Cantidad_de_Vehiculos__c, Itinerario_asociado__c,
                                   Puerto_ORIGEN__c, Puerto_DESTINO__c, Fecha_Viaje__c, Fecha_Hora_de_Viaje__c, UUID__c,Ruta__c
                                   FROM Reserva__c 
                                   WHERE Id =:cw.reservation];
                        reserva.Cantidad_de_Pasajeros__c = cw.people;
                        reserva.Cantidad_de_Vehiculos__c = cw.arrayVehicles.size();
                        //RL -> Agregando Itinerario
                        reserva.Itinerario_asociado__c = cw.itinerarie;
                        //RL Falta Origen, Destino y Fecha de Viaje
                        reserva.Puerto_ORIGEN__c = mapPuertos.get(cw.departure);
                        reserva.Puerto_DESTINO__c = mapPuertos.get(cw.destination);
                        reserva.Fecha_Viaje__c = Date.valueOf(cw.tripDate);
                        reserva.Fecha_Hora_de_Viaje__c = [SELECT Salida__c FROM Escalas_Itinerario__c WHERE Puerto_Embarque__r.Name =: cw.departure AND Itinerario__c =: cw.itinerarie AND Hacer_Escala__c = true LIMIT 1].Salida__c;
                        reserva.UUID__c = uuid;
                        update reserva;
                    }else{
                        //Validar si existe una reserva en el mismo sentido y mismo uuid para dejarla anulada
                        List<Reserva__c> reservaCheck = new List<Reserva__c>();
                        if(cw.roundtrip == 'Ida'){
                            reservaCheck = [SELECT Id, Estado_de_Reserva__c FROM Reserva__c WHERE UUID__c =: uuid];
                        }else{
                            reservaCheck = [SELECT Id, Estado_de_Reserva__c FROM Reserva__c WHERE Sentido_Viaje__c =: cw.roundtrip AND UUID__c =: uuid];
                        }
                        if(reservaCheck.size() > 0){
                            for(Reserva__c rCheck : reservaCheck){
                                rCheck.Estado_de_Reserva__c = 'Anulada';
                                rCheck.UUID__c = uuid+'A';
                            }
                            update reservaCheck;
                        }
                        reserva.Canal_de_Venta__c = 'Web';
                        reserva.Tipo_de_Reserva__c = 'General';
                        reserva.Sentido_Viaje__c = cw.roundtrip;
                        reserva.Fecha_de_Reserva__c = Date.today();
                        reserva.Estado_de_Reserva__c = 'Creada';
                        reserva.Cantidad_de_Pasajeros__c = cw.people;
                        reserva.Cantidad_de_Vehiculos__c = cw.arrayVehicles.size();
                        //RL -> Agregando Itinerario
                        reserva.Itinerario_asociado__c = cw.itinerarie;
                        //RL Falta Origen, Destino y Fecha de Viaje
                        reserva.Puerto_ORIGEN__c = mapPuertos.get(cw.departure);
                        reserva.Puerto_DESTINO__c = mapPuertos.get(cw.destination);
                        reserva.Fecha_Viaje__c = Date.valueOf(cw.tripDate);
                        reserva.Fecha_Hora_de_Viaje__c = [SELECT Salida__c FROM Escalas_Itinerario__c WHERE Puerto_Embarque__r.Name =: cw.departure AND Itinerario__c =: cw.itinerarie AND Hacer_Escala__c = true LIMIT 1].Salida__c;
                        reserva.UUID__c = uuid;
                        insert reserva;
                        reserva = [SELECT Id, Name, Ruta__c FROM Reserva__c WHERE Id =:reserva.Id];
                    }
                    List<Detalle_Reserva__c> pReservasX = new List<Detalle_Reserva__c>();

                    if(cw.roundtrip == 'Ida'){
                        pReservasX = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__r.UUID__c =: uuid];
                    }else{
                        pReservasX = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__r.Sentido_Viaje__c =: cw.roundtrip AND Reserva__r.UUID__c =: uuid];
                       
                    }
                    if(pReservasX.size() > 0){
                        delete pReservasX;
                    }
                    List<Detalle_Reserva__c> preReservas = new List<Detalle_Reserva__c>();
                    System.debug('Personas de la reserva: '+cw.people);
                    if(cw.people > 0){
                        for(String sSeat : cw.seats){
                            Detalle_Reserva__c pers = new Detalle_Reserva__c();
                            pers.Reserva__c = reserva.Id;
                            pers.Numero__c = sSeat;
                            pers.Capacidad_Comprometida__c = 1;
                            pers.Unidad_de_medida__c = 'Persona';
                            pers.Ubicacion__c = 'Salón';
                            pers.RecordTypeId = rTButaca;
							pers.ida_vuelta__c = idaVuelta;
 							System.debug('CD Line 149 idaVuelta: '+ idaVuelta);
                            preReservas.add(pers);
                            System.debug(pers);
                        }
                    }
                    if(!cw.arrayVehicles.isEmpty()){
                        System.debug('Vehiculos de la reserva: '+cw.arrayVehicles.size());
                        if(cw.arrayVehicles.size() > 0){
                            Maestro_Vehiculos_Menores__c datosVehiculo = new Maestro_Vehiculos_Menores__c();     
                            for(Integer v = 0; v < cw.arrayVehicles.size(); v++){
                                Detalle_Reserva__c vehi = new Detalle_Reserva__c();
                                vehi.Reserva__c = reserva.Id;
                                //vehi.Numero__c = String.valueOf(v+1);
                                vehi.Numero__c = cw.arrayVehicles.get(v).tag;
                                if(cw.arrayVehicles.get(v).category == 'Bicicleta'){
                                    vehi.RecordTypeId = rTBicicleta;
                                    vehi.Tipo_de_Vehiculo__c = 'Bicicleta';
                                }else if(cw.arrayVehicles.get(v).category == 'Motocicleta'){
                                    vehi.RecordTypeId = rTPista;
                                    vehi.Categoria_de_Vehiculo__c = 'Motocicleta';
                                    vehi.Tipo_de_Vehiculo__c = 'Motocicleta';
                                    vehi.Capacidad_Comprometida__c = 2;
                                }else{
                                    vehi.RecordTypeId = rTPista;
                                    vehi.Ubicacion__c = 'Bajo Cubierta';
                                    if(cw.arrayVehicles.get(v).category == 'Vehículo menor'){
                                        datosVehiculo = [SELECT Id, Alto__c, Largo__c, Marca__c, Modelo__c, Tipo_de_Vehiculo__c, Peso__c 
                                                         FROM Maestro_Vehiculos_Menores__c
                                                         WHERE Marca__c =: cw.arrayVehicles.get(v).brand
                                                         AND Modelo__c =: cw.arrayVehicles.get(v).model];
                                        vehi.Tipo_de_Vehiculo__c = datosVehiculo.Tipo_de_Vehiculo__c;
                                        if(cw.arrayVehicles.get(v).bikeRack == true){
                                            vehi.ML_Portabicicleta__c = 1;
                                            vehi.Largo__c = datosVehiculo.Largo__c + cw.arrayVehicles.get(v).pullingLong + 1;
                                            vehi.Capacidad_Comprometida__c = datosVehiculo.Largo__c + cw.arrayVehicles.get(v).pullingLong + 1;
                                        }else{
                                            vehi.Largo__c = datosVehiculo.Largo__c + cw.arrayVehicles.get(v).pullingLong;
                                            vehi.Capacidad_Comprometida__c = datosVehiculo.Largo__c + cw.arrayVehicles.get(v).pullingLong;
                                        }
                                        if(cw.arrayVehicles.get(v).luggageRack == true){
                                            vehi.Alto__c = datosVehiculo.Alto__c + 1;
                                        }else{
                                            vehi.Alto__c = datosVehiculo.Alto__c;
                                        }
                                        vehi.Marca__c = cw.arrayVehicles.get(v).brand;
                                        vehi.Modelo__c = cw.arrayVehicles.get(v).model;
                                    }else{
                                        vehi.Tipo_de_Vehiculo__c = cw.arrayVehicles.get(v).vehicleType;
                                        vehi.Largo__c = cw.arrayVehicles.get(v).vLong + cw.arrayVehicles.get(v).pullingLong;
                                        vehi.Carro_Arrastre__c = cw.arrayVehicles.get(v).pullingCart;
                                        vehi.Alto__c = cw.arrayVehicles.get(v).vHigh;
                                        vehi.Porta_Equipaje__c = cw.arrayVehicles.get(v).luggageRack;
                                        vehi.Ancho__c = cw.arrayVehicles.get(v).vWidth;
                                        vehi.Porta_Bicicleta__c = cw.arrayVehicles.get(v).bikeRack;
                                        if(cw.arrayVehicles.get(v).bikeRack == true){
                                            vehi.ML_Portabicicleta__c = 1;
                                            vehi.Capacidad_Comprometida__c = vehi.Capacidad_Comprometida__c + 1;
                                        }
                                        vehi.Capacidad_Comprometida__c = cw.arrayVehicles.get(v).vLong + cw.arrayVehicles.get(v).pullingLong;
                                        vehi.Tara__c = cw.arrayVehicles.get(v).tare;
                                        vehi.Carga_Veh_culo__c = cw.arrayVehicles.get(v).load;
                                    }
                                    vehi.Porta_Bicicleta__c = cw.arrayVehicles.get(v).bikeRack;
                                    vehi.Porta_Equipaje__c = cw.arrayVehicles.get(v).luggageRack;
                                    vehi.Carro_Arrastre__c = cw.arrayVehicles.get(v).pullingCart;
                                    vehi.Categoria_de_Vehiculo__c = cw.arrayVehicles.get(v).category;
                                    vehi.Cantidad_de_Metros__c = cw.arrayVehicles.get(v).pullingLong;
                                    vehi.Unidad_de_medida__c = 'm';
                                }
                                preReservas.add(vehi);
                            }
                        }
                    }
                    System.debug('Prereservas: '+preReservas.size());
                    if(preReservas.size() > 0){
                        insert preReservas;
                        //Revisar Capacidades y actualizar detalle reservas
                        //Obtener inicio y término de escalas
                        Decimal secuenciaInicial = [SELECT Secuencia__c 
                                                    FROM Escalas_Itinerario__c 
                                                    WHERE Puerto_Embarque__r.Name =: cw.departure 
                                                    AND Itinerario__c =: cw.itinerarie
                                                    AND Hacer_Escala__c = true
                                                    LIMIT 1].Secuencia__c;
                        Decimal secuenciaFinal = [SELECT Secuencia__c 
                                                  FROM Escalas_Itinerario__c 
                                                  WHERE Puerto_Embarque__r.Name =: cw.destination
                                                  AND Itinerario__c =: cw.itinerarie
                                                  AND Hacer_Escala__c = true
                                                  LIMIT 1].Secuencia__c;
                        //Escalas dentro de la secuencia
                        Set<Id> escalasACubrir = new Set<Id>();
                        Set<Id> capacidadOtorgada = new Set<Id>();
                        List<Escalas_Itinerario__c> escalXX = [SELECT Id
                                                               FROM Escalas_Itinerario__c
                                                               WHERE Itinerario__c =: cw.itinerarie
                                                               AND Hacer_Escala__c = true
                                                               AND Secuencia__c >=: secuenciaInicial AND Secuencia__c <: secuenciaFinal];
                        //Nueva estiba de vehiculos en pistas
                        Map<Id,Capacidad_Tramo__c> capPistas = new Map<Id,Capacidad_Tramo__c>([
                            SELECT Id, Ubicacion__c, Alto__c, Capacidad_Disponible__c, Escala_Itinerario__c, Numero__c
                            FROM Capacidad_Tramo__c 
                            WHERE Escala_Itinerario__c IN: escalXX
                            AND RecordTypeId =: rTPistaC
                            ORDER BY Numero__c ASC
                        ]);
                        //Generar espacio por escala + numero
                        Map<String, Decimal> mapEscalas = new Map<String, Decimal>();
                        for(Capacidad_Tramo__c cp : capPistas.values()){
                            String idUnico = cp.Escala_Itinerario__c+cp.Numero__c;
                            Decimal total = 0, totalMap;
                            totalMap = mapEscalas.get(idUnico);
                            if(totalMap != null){
                                mapEscalas.put(idUnico, totalMap + cp.Capacidad_Disponible__c);
                            }else{
                                mapEscalas.put(idUnico, cp.Capacidad_Disponible__c);
                            }
                        }
                        Map<Id,Capacidad_Tramo__c> capButacas = new Map<Id,Capacidad_Tramo__c>([
                            SELECT Id, Numero__c, Escala_Itinerario__c
                            FROM Capacidad_Tramo__c
                            WHERE Escala_itinerario__c IN: escalXX
                            AND RecordTypeId =: rTButacaC
                        ]);
                        System.debug('Itinerario: '+cw.itinerarie);
                        System.debug('Secuencia Inicial: '+secuenciaInicial);
                        System.debug('Secuencia Final: '+secuenciaFinal);
                        System.debug('escalXX: '+escalXX);
                        System.debug('rTPista: '+rTPista);
                        for(Detalle_Reserva__c dResB : preReservas){
                            Decimal totalMetros = 0;
                            escalasACubrir = new Set<Id>();
                            for(Escalas_Itinerario__c escala : escalXX){
                                escalasACubrir.add(escala.Id);
                            }
                            if(dResB.RecordTypeId == rTPista){
                                for(Capacidad_Tramo__c cap : capPistas.values()){
                                    System.debug('Capacidad Tramo: '+cap);
                                    totalMetros = mapEscalas.get(cap.Escala_Itinerario__c+cap.Numero__c);
                                    if(dResB.Categoria_de_Vehiculo__c != 'Motocicleta' && cap.Alto__c >= dResB.Alto__c && escalasACubrir.contains(cap.Escala_Itinerario__c) && totalMetros >= dResB.Capacidad_Comprometida__c){
                                        totalMetros = totalMetros - dResB.Capacidad_Comprometida__c;
                                        mapEscalas.put(cap.Escala_Itinerario__c+cap.Numero__c, totalMetros);
                                        escalasACubrir.remove(cap.Escala_Itinerario__c);
                                        Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
                                        String codUnico = cap.Id+''+dResB.Id;
                                        capNew.Capacidad_Tramo__c = cap.Id;
                                        capNew.Detalle_Reserva__c = dResB.Id;
                                        capNew.Identificador__c = codUnico;
                                        capNew.Capacidad_Comprometida_en_Reserva__c = dResB.Capacidad_Comprometida__c;
                                        capToCreate.add(capNew);
                                    }else if(dResB.Categoria_de_Vehiculo__c == 'Motocicleta' && escalasACubrir.contains(cap.Escala_Itinerario__c) && totalMetros >= dResB.Capacidad_Comprometida__c){
                                        totalMetros = totalMetros - dResB.Capacidad_Comprometida__c;
                                        mapEscalas.put(cap.Escala_Itinerario__c+cap.Numero__c, totalMetros);
                                        escalasACubrir.remove(cap.Escala_Itinerario__c);
                                        Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
                                        String codUnico = cap.Id+''+dResB.Id;
                                        capNew.Capacidad_Tramo__c = cap.Id;
                                        capNew.Detalle_Reserva__c = dResB.Id;
                                        capNew.Identificador__c = codUnico;
                                        capNew.Capacidad_Comprometida_en_Reserva__c = dResB.Capacidad_Comprometida__c;
                                        capToCreate.add(capNew);
                                    }
                                    /*
AND Alto__c >=: dResB.Alto__c
AND Capacidad_Disponible__c >=: dResB.Capacidad_Comprometida__c
*/
                                }
                                System.debug('prereserva vehiculo');
                            }else if(dResB.RecordTypeId == rTButaca){
                                /*
AND Numero__c =: dResB.Numero__c 
*/
                                for(Capacidad_Tramo__c cap : capButacas.values()){
                                    System.debug('Comparaciones: ');
                                    System.debug('cap.Numero__c ('+cap.Numero__c+') == dResB.Numero__c ('+dResB.Numero__c+')');
                                    System.debug('escalasACubrir.contains(cap.Escala_Itinerario__c) '+escalasACubrir.contains(cap.Escala_Itinerario__c));
                                    if(cap.Numero__c == dResB.Numero__c && escalasACubrir.contains(cap.Escala_Itinerario__c)){
                                        System.debug('Crear capacidad butaca');
                                        capButacas.remove(cap.Id);
                                        escalasACubrir.remove(cap.Escala_Itinerario__c);
                                        Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
                                        String codUnico = cap.Id+''+dResB.Id;
                                        capNew.Capacidad_Tramo__c = cap.Id;
                                        capNew.Detalle_Reserva__c = dResB.Id;
                                        capNew.Identificador__c = codUnico;
                                        capNew.Capacidad_Comprometida_en_Reserva__c = 1;
                                        capToCreate.add(capNew);
                                    }
                                }
                                System.debug('prereserva butaca');
                            }
                        }
                        //Unir Capacidades
                        System.debug('prereserva capacidades a crear '+capToCreate.size());
                        if(capToCreate.size() > 0){
                            try{
                                Database.SaveResult[] resInserts = Database.insert(capToCreate, false);
                                Boolean error = false;
                                for(Database.SaveResult rR : resInserts){
                                    if(!rR.isSuccess()){
                                        for(Database.Error err : rR.getErrors()){
                                            String statusCode = String.valueOf(err.getStatusCode());
                                            if(!statusCode.contains('DUPLICATE')){
                                                error = true;
                                                String dataR = JSON.serialize(rR);
                                                jsonText = '{ "estado": "nook", "id": "3", "nombre": "Error", "mensaje": "Las capacidades no estan disponibles" }';
                                            }
                                        }
                                        //System.debug('Error capacidad: Id: '+rR.id+', Numero: '+dResB.Numero__c+', Capacidad: '+dResB.Capacidad_Comprometida__c);
                                        System.debug('Capacidades a insertar: '+capToCreate);
                                        System.debug('Errores de insercion:'+rR.getErrors());
                                    }else{
                                        System.debug('Inserción exitosa: Id: '+rR.id);
                                    }
                                }
                                if(!error){
                                    jsonText = '{ "estado": "ok", "id": "'+reserva.Id+'", "nombre": "'+reserva.Name+'", "mensaje": "Registros creados exitosamente" }';
                                }else{
                                    jsonText = '{ "estado": "nook", "id": "1", "nombre": "Error", "mensaje": "No hay capacidades disponibles" }';
                                }
                            }catch(Exception exT){
                                String mensaje = exT.getMessage();
                                if(mensaje.contains('DUPLICATE_VALUE')){
                                    System.debug('Error');
                                    System.debug('Tipo de excepción: ' + exT.getTypeName());
                                    System.debug('Mensaje: ' + exT.getMessage());
                                    System.debug('Causa: ' + exT.getCause());
                                    System.debug('Línea: ' + exT.getLineNumber());
                                    System.debug('Traza: ' + exT.getStackTraceString());
                                    jsonText = '{ "estado": "ok", "id": "'+reserva.Id+'", "nombre": "'+reserva.Name+'", "mensaje": "Registros creados exitosamente" }';
                                }else{
                                    jsonText = '{ "estado": "nook", "id": "2", "nombre": "Error", "mensaje": "No se pudo asociar la capacidad" }';
                                }
                            }
                            capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
                        }
                    }
                }catch(Exception ex){
                    System.debug('Error');
                    System.debug('Tipo de excepción: ' + ex.getTypeName());
                    System.debug('Mensaje: ' + ex.getMessage());
                    System.debug('Causa: ' + ex.getCause());
                    System.debug('Línea: ' + ex.getLineNumber());
                    System.debug('Traza: ' + ex.getStackTraceString());
                    jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                }
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'addPerson'{
                Blob body = req.requestBody;
                String requestString = body.toString();
                NAV_WrapperPerson pw = (NAV_WrapperPerson)JSON.deserialize(requestString,NAV_WrapperPerson.class);
                try{
                    Account cuenta = new Account();
                    cuenta.FirstName = pw.pName;
                    cuenta.LastName = pw.pLastname;
                    cuenta.Identificacion__c = pw.pDocNum;
                    cuenta.PersonBirthdate = Date.valueOf(pw.pBirthdate);
                    cuenta.Tipo_de_identificacion__c = pw.pDocType;
                    if(pw.pEmail != 'null'){
                        if(pw.pEmail != null){
                            cuenta.PersonEmail = pw.pEmail;
                        }
                    }
                    if(pw.pPhone != 'null'){
                        if(pw.pPhone != null){
                            cuenta.Phone = pw.pPhone;
                        }
                    }
                    //Falta genero y nacionalidad
                    if(pw.pGender == 'Masculino'){
                        cuenta.Sexo__pc = 'M';
                    }else{
                        cuenta.Sexo__pc = 'F';
                    }
                    cuenta.Nacionalidad__pc = pw.pNationality;
                    upsert cuenta Identificacion__c;
                    Boolean esResidente = false;
                    try{
                        Residente__c resi = [SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
                                             Comuna__c, N_Certificado__c, Fecha_Certificado__c 
                                             FROM Residente__c 
                                             WHERE Identificacion__c =: pw.pDocNum];
                        if(resi.Id != null){
                            esResidente = true;
                        }
                    }catch(Exception exR){
                        esResidente = false;
                    }
                    List<Reserva__c> ReservasCountt = new List<Reserva__c>();
				    ReservasCountt = [SELECT Id,Ruta__c FROM Reserva__c WHERE UUID__c =: uuid];
                        if(ReservasCountt.size()>1  ){
                            if(ReservasCountt[0].Ruta__c.contains('Juan Fernandez') || ReservasCountt[0].Ruta__c.contains('Selkirk') ){
                                                            idaVuelta = true ;
                            system.debug('CD Line 131 idaVuelta: '+ idaVuelta);
                            }

                        }
                    //insert cuenta;
                    Detalle_Reserva__c dRes = [SELECT Id, Nombre_Pasajero__c, Conductor__c, Residente__c, Doc_Identificacion_Pasajero__c,
                                               Tipo_de_identificacion__c, Tarificar__c, Ida_Vuelta__c
                                               FROM Detalle_Reserva__c
                                               WHERE Reserva__c =: pw.reservation
                                               AND Numero__c =: pw.seat
                                               AND RecordTypeId =: rTButaca
                                               LIMIT 1];
                    dRes.Residente__c = esResidente;
                    dRes.Nombre_Pasajero__c = cuenta.Id;
                    dRes.Doc_Identificacion_Pasajero__c = pw.pDocNum;
                    dRes.Tipo_de_identificacion__c = pw.pDocType;
                    if(pw.pIsDriver != null){
                        dRes.Conductor__c = pw.pIsDriver;
                    }else{
                        dRes.Conductor__c = false;
                    }

					dRes.Ida_Vuelta__c = idaVuelta;
                    dRes.Tarificar__c = true;
                    update dRes;
                    Reserva__c reserva = [SELECT Estado_de_Reserva__c FROM Reserva__c WHERE Id =:pw.reservation];
                    //Cuando datactil implemente el estado de la reserva, descomentar la linea siguiente
                    //jsonText = '{ "estado": "ok", "id": "'+dRes.Id+'", "estado": "'+reserva.Estado_de_Reserva__c+'", "mensaje": "Registros asociados exitosamente" }';
                    jsonText = '{ "estado": "ok", "id": "'+dRes.Id+'", "mensaje": "Registros asociados exitosamente" }';
                }catch(Exception ex){
                    String mError = ex.getMessage();
                    if(mError.contains('DUPLICATE_VALUE')){
                        Detalle_Reserva__c dRes = [SELECT Id 
                                                   FROM Detalle_Reserva__c 
                                                   WHERE Reserva__c =: pw.reservation 
                                                   AND Numero__c =: pw.seat 
                                                   AND RecordTypeId =: rTButaca
                                                   LIMIT 1];
                        jsonText = '{ "estado": "ok", "id": "'+dRes.Id+'", "mensaje": "Registro ya encontrado" }';
                    }else{
                        System.debug('Error');
                        System.debug('Tipo de excepción: ' + ex.getTypeName());
                        System.debug('Mensaje: ' + ex.getMessage());
                        System.debug('Causa: ' + ex.getCause());
                        System.debug('Línea: ' + ex.getLineNumber());
                        System.debug('Traza: ' + ex.getStackTraceString());
                        jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                    }
                }
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'addVehicle'{
                Blob body = req.requestBody;
                String requestString = body.toString();
                NAV_WrapperVehicles vw = (NAV_WrapperVehicles)JSON.deserialize(requestString,NAV_WrapperVehicles.class);
                System.debug('Datos Vehículo');
                System.debug(vw);
                try{
                    Id dResConductor = null;
                    Account disp = new Account();
                    Account rece = new Account();
                    Account driv = new Account();
                    //Persona que entrega y persona que retira
                    if(vw.dispatcher != null && vw.receiver != null){
                        if(vw.dispatcher != null){
                            disp.FirstName = vw.dispatcher.pName;
                            disp.LastName = vw.dispatcher.pLastname;
                            disp.Identificacion__c = vw.dispatcher.pDocNum;
                            disp.PersonBirthdate = Date.valueOf(vw.dispatcher.pBirthdate);
                            disp.Tipo_de_identificacion__c = vw.dispatcher.pDocType;
                            disp.PersonEmail = vw.dispatcher.pEmail;
                            disp.Phone = vw.dispatcher.pPhone;
                            //Falta genero y nacionalidad
                            if(vw.dispatcher.pGender == 'Masculino'){
                                disp.Sexo__pc = 'M';
                            }else{
                                disp.Sexo__pc = 'F';
                            }
                            disp.Nacionalidad__pc = vw.dispatcher.pNationality;
                            upsert disp Identificacion__c;
                        }
                        if(vw.receiver != null){
                            rece.FirstName = vw.receiver.pName;
                            rece.LastName = vw.receiver.pLastname;
                            rece.Identificacion__c = vw.receiver.pDocNum;
                            rece.PersonBirthdate = Date.valueOf(vw.receiver.pBirthdate);
                            rece.Tipo_de_identificacion__c = vw.receiver.pDocType;
                            rece.PersonEmail = vw.receiver.pEmail;
                            rece.Phone = vw.receiver.pPhone;
                            //Falta genero y nacionalidad
                            if(vw.receiver.pGender == 'Masculino'){
                                rece.Sexo__pc = 'M';
                            }else{
                                rece.Sexo__pc = 'F';
                            }
                            rece.Nacionalidad__pc = vw.receiver.pNationality;
                            upsert rece Identificacion__c;
                        }
                    }
                    //Conductor
                    if(vw.driver != null){
                        driv.FirstName = vw.driver.pName;
                        driv.LastName = vw.driver.pLastname;
                        driv.Identificacion__c = vw.driver.pDocNum;
                        driv.PersonBirthdate = Date.valueOf(vw.driver.pBirthdate);
                        driv.Tipo_de_identificacion__c = vw.driver.pDocType;
                        driv.PersonEmail = vw.driver.pEmail;
                        driv.Phone = vw.driver.pPhone;
                        //Falta genero y nacionalidad
                        if(vw.driver.pGender == 'Masculino'){
                            driv.Sexo__pc = 'M';
                        }else{
                            driv.Sexo__pc = 'F';
                        }
                        driv.Nacionalidad__pc = vw.driver.pNationality;
                        upsert driv Identificacion__c;
                        dResConductor = [SELECT Id 
                                         FROM Detalle_Reserva__c
                                         WHERE Reserva__c =: vw.reservation
                                         AND Nombre_Pasajero__r.Identificacion__c =: vw.driver.pDocNum
                                         AND Nombre_Pasajero__r.Tipo_de_identificacion__c =: vw.driver.pDocType
                                         LIMIT 1].Id;
                    }
                    Detalle_Reserva__c dRes = new Detalle_Reserva__c();
                    dRes = [SELECT Id, Nombre_Pasajero__c, Conductor__c, Cantidad_de_metros__c, 
                            Persona_que_entrega__c, Persona_que_retira__c, Tarificar__c
                            FROM Detalle_Reserva__c
                            WHERE Reserva__c =: vw.reservation
                            AND Categoria_de_Vehiculo__c =: vw.category
                            //AND Tipo_de_Vehiculo__c =: vw.vehicleType
                            AND Marca__c =: vw.brand
                            AND Modelo__c =: vw.model
                            AND Numero__c =: vw.tag
                            LIMIT 1];
                    if(disp != null){
                        dRes.Persona_que_entrega__c = disp.Id;
                    }
                    if(rece != null){
                        dRes.Persona_que_retira__c = rece.Id;
                    }
                    if(driv != null){
                        dRes.Detalle_Reserva_Conductor__c = dResConductor;
                        //dRes.Conductor__c = true;
                    }
                    dRes.Tarificar__c = true;
                    dRes.Placa_Patente_Vehiculo__c = vw.licensePlate.toUpperCase();
                    update dRes;
                    jsonText = '{ "estado": "ok", "id": "'+dRes.Id+'", "mensaje": "Registros creados exitosamente" }';
                }catch(Exception ex){
                    System.debug('Error');
                    System.debug('Tipo de excepción: ' + ex.getTypeName());
                    System.debug('Mensaje: ' + ex.getMessage());
                    System.debug('Causa: ' + ex.getCause());
                    System.debug('Línea: ' + ex.getLineNumber());
                    System.debug('Traza: ' + ex.getStackTraceString());
                    jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                }
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'addPaymentData'{
                Blob body = req.requestBody;
                String requestString = body.toString();
                NAV_WrapperPaymentData pdw = (NAV_WrapperPaymentData)JSON.deserialize(requestString,NAV_WrapperPaymentData.class);
                System.debug(pdw);
                System.debug(pdw.datosFactura);
                System.debug(pdw.datosContacto);
                try{
                    Account contactoFacturacion = new Account();
                    Account contactoReserva = new Account();
                    List<Account> contactos = new List<Account>();
                    //Contacto de la reserva
                    try{
                        contactoReserva = [SELECT FirstName, LastName, Identificacion__c, PersonEmail, Phone
                                           FROM Account
                                           WHERE Identificacion__c =: pdw.datosContacto.rut];
                        contactoReserva.FirstName = pdw.datosContacto.nombre;
                        contactoReserva.LastName = pdw.datosContacto.apellido;
                        contactoReserva.Identificacion__c = pdw.datosContacto.rut;
                        contactoReserva.PersonEmail = pdw.datosContacto.correo;
                        contactoReserva.Phone = pdw.datosContacto.telefono;
                        update contactoReserva;
                    }catch(Exception exCR){
                        //No existe contacto Reserva
                        contactoReserva.FirstName = pdw.datosContacto.nombre;
                        contactoReserva.LastName = pdw.datosContacto.apellido;
                        contactoReserva.Identificacion__c = pdw.datosContacto.rut;
                        contactoReserva.Tipo_de_identificacion__c = 'RUT';
                        contactoReserva.PersonEmail = pdw.datosContacto.correo;
                        contactoReserva.Phone = pdw.datosContacto.telefono;
                        insert contactoReserva;
                    }
                    if(pdw.tipoDocumento != 'Boleta' && pdw.tipoDocumento != 'Ninguno'){
                        //Contacto de facturacion
                        try{
                            contactoFacturacion = [SELECT Id, Identificacion__c, Razon_Social__c, 
                                                   Giro__c, BillingStreet, BillingState
                                                   FROM Account
                                                   WHERE Identificacion__c =: pdw.datosFactura.rut];
                            contactoFacturacion.Identificacion__c = pdw.datosFactura.rut;
                            contactoFacturacion.Razon_Social__c = pdw.datosFactura.razonSocial;
                            contactoFacturacion.Giro__c = pdw.datosFactura.giro;
                            contactoFacturacion.BillingStreet = pdw.datosFactura.direccion;
                            contactoFacturacion.BillingState = pdw.datosFactura.comuna;
                            if(pdw.datosFactura.ciudad == null){
                                contactoFacturacion.BillingCity = pdw.datosFactura.comuna;
                            }else{
                                contactoFacturacion.BillingCity = pdw.datosFactura.ciudad;
                            }
                            update contactoFacturacion;
                        }catch(Exception exCF){
                            //No existe contacto Facturacion
                            Id rTCuentaEmpresa = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta Empresa').getRecordTypeId();
                            contactoFacturacion.RecordTypeId = rTCuentaEmpresa;
                            contactoFacturacion.Name = pdw.datosFactura.razonSocial;
                            contactoFacturacion.Identificacion__c = pdw.datosFactura.rut;
                            contactoFacturacion.Tipo_de_identificacion__c = 'RUT';
                            contactoFacturacion.Razon_Social__c = pdw.datosFactura.razonSocial;
                            contactoFacturacion.Giro__c = pdw.datosFactura.giro;
                            contactoFacturacion.BillingStreet = pdw.datosFactura.direccion;
                            contactoFacturacion.BillingState = pdw.datosFactura.comuna;
                            if(pdw.datosFactura.ciudad == null){
                                contactoFacturacion.BillingCity = pdw.datosFactura.comuna;
                            }else{
                                contactoFacturacion.BillingCity = pdw.datosFactura.ciudad;
                            }
                            insert contactoFacturacion;
                        }
                    }
                    List<Reserva__c> reservas = [SELECT BP_Facturacion__c, Contacto_Reserva__c, Tipo_Documento__c, Integracion_Web__c
                                                 FROM Reserva__c
                                                 WHERE UUID__c =: uuid];
                    for(Reserva__c rX : reservas){
                        rX.Tipo_Documento__c = pdw.tipoDocumento;
                        Datetime ahora = System.now();
                        if(rX.Integracion_Web__c != null){
                            rX.Integracion_Web__c = rX.Integracion_Web__c + '\n' +ahora.format('yyyy-MM-dd h:mm:ss SS')+':'+requestString;
                        }else{
                            rX.Integracion_Web__c = ahora.format('yyyy-MM-dd h:mm:ss SS')+':'+requestString;
                        }
                        if(pdw.tipoDocumento != 'Boleta'){
                            rX.BP_Facturacion__c = contactoFacturacion.Id;
                        }
                        rX.Contacto_Reserva__c = contactoReserva.Id;
                    }
                    update reservas;
                    jsonText = '{ "estado": "ok",';
                    jsonText = jsonText + '"id":"'+uuid+'",';
                    jsonText = jsonText + '"mensaje":"Registro de reserva actualizado exitosamente" }';
                }catch(Exception ex){
                    System.debug('Error');
                    System.debug('Tipo de excepción: ' + ex.getTypeName());
                    System.debug('Mensaje: ' + ex.getMessage());
                    System.debug('Causa: ' + ex.getCause());
                    System.debug('Línea: ' + ex.getLineNumber());
                    System.debug('Traza: ' + ex.getStackTraceString());
                    jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                }
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'addPayment'{
                Blob body = req.requestBody;
                String requestString = body.toString();
                NAV_WrapperPayments pw = (NAV_WrapperPayments)JSON.deserialize(requestString,NAV_WrapperPayments.class);
                Id ida;
                Id vuelta;
                Decimal totalIda = 0;
                Decimal totalVuelta = 0;
                try{
                    List<Reserva__c> reservas = [SELECT Id, VCI__c, Amount__c, Buy_Order__c, Card_Number__c, Authorization_Code__c, Payment_Type__c,
                                                 Response_Code__c, Commerce_Code__c, Status__c, Tipo_Documento__c, BP_Facturacion__c, Contacto_Reserva__c,
                                                 Sentido_Viaje__c, Total_reserva__c, Integracion_Web__c
                                                 FROM Reserva__c
                                                 WHERE UUID__c =: uuid];
                    for(Reserva__c rX : reservas){
                        rX.VCI__c = pw.vci;
                        rX.Amount__c = Decimal.valueOf(pw.amount);
                        rX.Buy_Order__c = pw.buy_order;
                        rX.Card_Number__c = pw.card_number;
                        rX.Authorization_Code__c = pw.authorization_code;
                        rX.Payment_Type__c = pw.payment_type;
                        rX.Response_Code__c = pw.response_code;
                        rX.Commerce_Code__c = pw.commerce_code;
                        rX.Status__c = pw.status;
                        Datetime ahora = System.now();
                        if(rX.Integracion_Web__c != null){
                            rX.Integracion_Web__c = rX.Integracion_Web__c + '\n' +ahora.format('yyyy-MM-dd h:mm:ss SS')+':'+requestString;
                        }else{
                            rX.Integracion_Web__c = ahora.format('yyyy-MM-dd h:mm:ss SS')+':'+requestString;
                        }
                        if(rX.Sentido_Viaje__c == 'Ida'){
                            ida = rX.Id;
                            totalIda = rX.Total_reserva__c;
                        }
                        if(rX.Sentido_Viaje__c == 'Vuelta'){
                            vuelta = rX.Id;
                            totalVuelta = rX.Total_reserva__c;
                        }
                    }
                    update reservas;
                    List<Acreditacion__c> acred = new List<Acreditacion__c>();
                    for(Reserva__c rX : reservas){
                        Acreditacion__c acX = new Acreditacion__c();
                        if(rX.Tipo_Documento__c == 'Ninguno' || rX.Tipo_Documento__c == 'Boleta'){
                            acX.Destinatario_Documentos__c = rX.Contacto_Reserva__c;
                            acX.Documentos_a_emitir__c = 'Sin documentos';
                        }else if(rX.Tipo_Documento__c == 'Factura mixta'){
                            acX.Destinatario_Documentos__c = rX.BP_Facturacion__c;
                            acX.Documentos_a_emitir__c = 'Factura mixta';
                        }else if(rX.Tipo_Documento__c == 'Factura exenta'){
                            acX.Destinatario_Documentos__c = rX.BP_Facturacion__c;
                            acX.Documentos_a_emitir__c = 'Facturas separadas';
                        }
                        acX.Reserva__c = rX.Id;
                        if(ida != null && vuelta != null){
                            if(rX.Id != ida){
                                acX.Reserva_relacionada__c = ida;
                                acred.add(acX);
                            }else if(rX.Id != vuelta){
                                acX.Reserva_relacionada__c = vuelta;
                                acred.add(acX);
                            }
                        }else{
                            acred.add(acX);
                        }
                    }
                    if(pw.status == 'ok'){
                        insert acred;
                        List<Forma_de_pago__c> formPago = new List<Forma_de_pago__c>();
                        Caja__c caja = [SELECT Id FROM Caja__c ORDER BY CreatedDate LIMIT 1];
                        for(Acreditacion__c acX : acred){
                            Forma_de_pago__c fPago = new Forma_de_pago__c();
                            fPago.X4_ultimos_digitos_tarjeta__c = pw.card_number;
                            fPago.Acreditacion__c = acX.Id;
                            //fPago.Balance__c = Decimal.valueOF(pw.balance);
                            fPago.Orden_de_Compra__c = pw.buy_order;
                            fPago.Codigo_autorizacion__c = pw.authorization_code;
                            fPago.Codigo_comercio__c = pw.commerce_code;
                            fPago.Codigo_respuesta__c = pw.response_code;
                            fPago.Numero__c = pw.installments_number;
                            fPago.Estado__c = pw.status;
                            fPago.Caja__c = caja.Id;
                            String fechaCompra = pw.accounting_date;
                            String fechaTransaccion = pw.transaction_date;
                            fPago.Fecha_compra__c = Date.newInstance(Integer.valueOf(fechaCompra.substring(4,8)),Integer.valueOf(fechaCompra.substring(2,4)),Integer.valueOf(fechaCompra.substring(0,2)));
                            fPago.Fecha_transaccion__c = Date.newInstance(Integer.valueOf(fechaTransaccion.substring(4,8)),Integer.valueOf(fechaTransaccion.substring(2,4)),Integer.valueOf(fechaTransaccion.substring(0,2)));
                            fPago.ID_sesion__c = pw.session_id;
                            fPago.Shares_number__c = pw.shares_number;
                            //Monto Total
                            fPago.Monto_Ida_y_Vuelta__c = Decimal.valueOf(pw.amount);
                            //fPago.Tipo_de_pago__c = pw.payment_type;
                            fPago.RecordTypeId = Schema.SObjectType.Forma_de_pago__c.getRecordTypeInfosByName().get('WEB').getRecordTypeId();
                            fPago.VCI__c = pw.vci;
                            if(ida == acX.Reserva__c){
                                fPago.Monto__c = totalIda;//Decimal.valueOf(pw.amount);
                            }else if(vuelta == acX.Reserva__c){
                                fPago.Monto__c = totalVuelta;
                            }
                            formPago.add(fPago);
                        }
                        if(formPago.size() > 0){
                            insert formPago;
                        }
                    }
                    jsonText = '{ "estado": "ok",';
                    jsonText = jsonText + '"id":"'+uuid+'",';
                    jsonText = jsonText + '"mensaje":"Registro de reserva actualizado exitosamente" }';
                }catch(Exception ex){
                    Datetime ahora = System.now();
                    String rMensaje = '';
                    rMensaje = 'Tipo de excepción: ' + ex.getTypeName();
                    rMensaje = rMensaje + '- Causa: ' + ex.getCause();
                    rMensaje = rMensaje + '- Línea: ' + ex.getLineNumber();
                    rMensaje = rMensaje + '- Traza: ' + ex.getStackTraceString();
                    rMensaje = rMensaje + '- Mensaje: ' + ex.getMessage();
                    List<Reserva__c> reservas = [SELECT Id, Integracion_Web__c FROM Reserva__c WHERE UUID__c =: uuid];
                    for(Reserva__c rX : reservas){
                        rX.Integracion_Web__c = rX.Integracion_Web__c + '\n' +ahora.format('yyyy-MM-dd h:mm:ss SS')+':'+rMensaje;
                    }
                    update reservas;
                    List<Acreditacion__c> acreditaciones = [SELECT Id FROM Acreditacion__c WHERE Reserva__r.UUID__c =: uuid];
                    delete acreditaciones;
                    System.debug('Error');
                    System.debug('Tipo de excepción: ' + ex.getTypeName());
                    System.debug('Mensaje: ' + ex.getMessage());
                    System.debug('Causa: ' + ex.getCause());
                    System.debug('Línea: ' + ex.getLineNumber());
                    System.debug('Traza: ' + ex.getStackTraceString());
                    jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                }
                res.responseBody = Blob.valueOf(jsonText);
            }
            when else{
                Blob body = req.requestBody;
                String requestString = body.toString();
                System.debug(requestString);
                res.responseBody = Blob.valueOf('{error:true}');
            }
        }
    }
    
    @HttpDelete
    global static void deleteSalesforceInfo(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String uuid = req.params.get('uuid');
        String jsonText = '';
        List<Reserva__c> reservas = [SELECT Id, Estado_de_Reserva__c, UUID__c FROM Reserva__c WHERE UUID__c =:uuid];
        if(reservas.size() > 0){
            for(Reserva__c resX : reservas){
                resX.Estado_de_Reserva__c = 'Anulada';
                resX.UUID__c = resX.UUID__c+'AW';
            }
            update reservas;
            jsonText = '{ "estado": "ok", "mensaje": "Reserva anulada." }';
        }else{
            jsonText = '{ "estado": "error", "mensaje": "No existe la reserva." }';
        }
        res.responseBody = Blob.valueOf(jsonText);
    }
    
    @HttpGet
    global static void getSalesforceInfo() {
        RestContext.response.addHeader('Content-Type', 'application/json');
        String[] dias = new String[]{'','Lun','Mar','Mié','Jue','Vie','Sáb','Dom'};
            RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Id rTButaca = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
        Id rTButacaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
        Id rTPista = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
        Id rTPistaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
        Id rTCarga = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId();
        Id rTCargaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId();
        Id rTBicicleta = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId();
        String info = req.params.get('info');
        String uuid = req.params.get('uuid');
        String jsonText = '';
        switch on info {
            when 'origins'{
                jsonText = '';
                List<String> origins = new List<String>();
                Set<String> origenes = new Set<String>();
                List<OrigenDestino__c> oDs = [SELECT Origen__r.Name, Destino__r.Name 
                                              FROM OrigenDestino__c
                                              WHERE Empresa_Puelche__c =false];
                for(OrigenDestino__c oD : oDs){
                    origins.add(oD.Origen__r.Name);
                    origins.add(oD.Destino__r.Name);
                }
                origins.sort();
                origenes.addAll(origins);
                jsonText = JSON.serialize(origenes);
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'destinations'{
                jsonText = '';
                String origen = req.params.get('origen');
                Set<String> destinos = new Set<String>();
                Map<Id, Decimal> secuenciasMap = new Map<Id, Decimal>();
                List<Escalas_Itinerario__c> escalas = [SELECT Id, Puerto_Destino__r.Name, Secuencia__c, Itinerario__c
                                                       FROM Escalas_Itinerario__c 
                                                       WHERE Puerto_Embarque__r.Name =: origen 
                                                       AND Itinerario__r.Empresa_Puelche__c =false
                                                       ORDER BY Itinerario__c];
                List<String> orden = new List<String>();
                for(Escalas_Itinerario__c escala : escalas){
                    orden.add(escala.Puerto_Destino__r.Name);
                    secuenciasMap.put(escala.Itinerario__c, escala.Secuencia__c);
                }
                List<Escalas_Itinerario__c> escalasIntermedias = [SELECT Id, Puerto_Destino__r.Name
                                                                  FROM Escalas_Itinerario__c 
                                                                  WHERE Secuencia__c >: secuenciasMap.values()
                                                                  AND Itinerario__c IN: secuenciasMap.keySet()
                                                                  ORDER BY Itinerario__c];
                for(Escalas_Itinerario__c escala : escalasIntermedias){
                    if(origen != escala.Puerto_Destino__r.Name){
                        orden.add(escala.Puerto_Destino__r.Name);
                    }
                }
                orden.sort();
                destinos.addAll(orden);
                jsonText = '{ "destinos": [';
                String jArray = '';
                for(String des : destinos){
                    if(des != '--'){
                        jArray = '"'+des+'",' + jArray;
                    }
                }
                if(jArray.right(1) == ','){
                    jsonText = jsonText + jArray.substring(0,jArray.length() -1);
                }
                jsonText = jsonText + ']}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'nationalities'{
                jsonText = '{ "nacionalidades": [';
                List<String> pickListValuesList= new List<String>();
                Schema.DescribeFieldResult fieldResult = Account.Nacionalidad__pc.getDescribe();
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                for( Schema.PicklistEntry pickListVal : ple){
                    pickListValuesList.add(pickListVal.getLabel());
                }
                String jArray = '';
                for(String nac : pickListValuesList){
                    if(nac != '--'){
                        jArray = '"'+nac+'",' + jArray;
                    }
                }
                if(jArray.right(1) == ','){
                    jsonText = jsonText + jArray.substring(0,jArray.length() -1);
                }
                jsonText = jsonText + ']}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'vehicles'{
                List<String> tiposO = new List<String>();
                Set<String> tipos = new Set<String>();
                List<Tipo_Vehiculos__mdt> tVs = [SELECT MasterLabel FROM Tipo_Vehiculos__mdt WHERE Disponible_web__c = true];
                for(Tipo_Vehiculos__mdt tV : tVs){
                    tiposO.add(tV.MasterLabel);
                }
                tiposO.sort();
                tipos.addAll(tiposO);
                jsonText = '{ "vehicles": [';
                for(String tip : tipos){
                    jsonText = jsonText + '"'+tip+'",';
                }
                if(jsonText.contains(',')){
                    jsonText = jsonText.substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + ']}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'brand'{
                List<String> ordenM = new List<String>();
                Set<String> marcasS = new Set<String>();
                List<Maestro_Vehiculos_Menores__c> vM = [SELECT Marca__c FROM Maestro_Vehiculos_Menores__c];
                for(Maestro_Vehiculos_Menores__c men : vM){
                    ordenM.add(men.Marca__c);
                }
                ordenM.sort();
                marcasS.addAll(ordenM);
                jsonText = '{ "brands": [';
                for(String mar : marcasS){
                    jsonText = jsonText + '"'+mar+'",';
                }
                if(jsonText.contains(',')){
                    jsonText = jsonText.substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + ']}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'models'{
                String marca = req.params.get('m');
                List<String> ordenM = new List<String>();
                Set<String> modelosS = new Set<String>();
                List<Maestro_Vehiculos_Menores__c> vM = [SELECT Modelo__c FROM Maestro_Vehiculos_Menores__c WHERE Marca__c =: marca];
                for(Maestro_Vehiculos_Menores__c men : vM){
                    ordenM.add(men.Modelo__c);
                }
                ordenM.sort();
                modelosS.addAll(ordenM);
                jsonText = '{ "models": [';
                for(String mod : modelosS){
                    jsonText = jsonText + '"'+mod+'",';
                }
                if(jsonText.contains(',')){
                    jsonText = jsonText.substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + ']}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'itineraries'{ // Si hay que estibar, esto se debe cambiar
                String fechaString = req.params.get('f');
                String fechaFix = fechaString.substringBefore('T');
                String fechaFix2 = fechaString.substringAfter('T');
                String[] fechaFix3 = fechaFix2.substringBefore('Z').split(':');
                Integer hourFix = Integer.valueOf(fechaFix3[0]);
                Integer minuteFix = Integer.valueOf(fechaFix3[1]);
                Integer secondFix = Integer.valueOf(fechaFix3[2].substringBefore('.'));
                Integer milisecondFix =  Integer.valueOf(fechaFix3[2].substringAfter('.'));
                Date fechaFixD = Date.valueOf(fechaFix);
                Time fechaFixH = Time.newInstance(hourFix, minuteFix, secondFix, milisecondFix);
                Datetime fechaStd = Datetime.newInstance(fechaFixD, fechaFixH);
                //String[] fecha = res.params.get('f').split('/');
                String origen = req.params.get('o');
                String destino = req.params.get('d');
                String personas = req.params.get('p');
                String vehiculos = req.params.get('v');
                System.debug(origen);
                System.debug(destino);
                String[] tipoVehiculos = req.params.get('t').split(',');
                String[] portaEquipaje = req.params.get('pe').split(',');
                String[] portaBicicleta = req.params.get('pm').split(',');
                String[] carrosArrastre = req.params.get('ca').split(',');
                String[] largoCarros = req.params.get('lc').split(',');
                Decimal[] altosVehiculos = new Decimal[]{};
                    Decimal maxAlto = 0;
                Decimal largoCompleto = 0;
                Boolean hayCuatroRuedas = false;
                for(String tVehiculo : tipoVehiculos){
                    if(tVehiculo != 'Motocicleta' && tVehiculo != 'Bicicleta'){
                        hayCuatroRuedas = true;
                    }else if(tVehiculo == 'Motocicleta'){
                        largoCompleto = largoCompleto + 2;
                    }
                }
                if(hayCuatroRuedas){
                    String[] marcas = req.params.get('m').split(',');
                    String[] modelos = req.params.get('mo').split(',');
                    if(marcas.size() > 0 && Decimal.valueOf(vehiculos) > 0){
                        for(Integer i=0; i<marcas.size(); i++){
                            if(marcas[i] != ''){
                                Decimal altoVehiculo = 0;
                                Maestro_Vehiculos_Menores__c vM = [SELECT Alto__c, Largo__c
                                                                   FROM Maestro_Vehiculos_Menores__c 
                                                                   WHERE Marca__c =: marcas[i]
                                                                   AND Modelo__c =: modelos[i]
                                                                   LIMIT 1];
                                if(portaEquipaje[i] == '1'){
                                    altoVehiculo = vM.Alto__c + 1;
                                }else{
                                    altoVehiculo = vM.Alto__c;
                                }
                                altosVehiculos.add(altoVehiculo);
                                if(portaBicicleta[i] == '1'){
                                    largoCompleto = largoCompleto + vM.Largo__c + 1;
                                }else{
                                    largoCompleto = largoCompleto + vM.Largo__c;
                                }
                                if(carrosArrastre[i] == '1'){
                                    largoCompleto = largoCompleto + Decimal.valueOf(largoCarros[i]);
                                }
                                System.debug('Largo despues de calculos: '+largoCompleto);
                            }
                            for(Decimal aV : altosVehiculos){
                                if(maxAlto < aV){
                                    maxAlto = aV;
                                }
                            }
                        }
                    }
                }
                System.debug('Mostrar alto maximo: '+maxAlto);
                //Datetime fechaZarpe = Datetime.newInstance(Integer.valueOf(fecha[2]), Integer.valueOf(fecha[1]), Integer.valueOf(fecha[0]), 0, 0, 0);
                Datetime fechaZarpe = fechaStd;
                Datetime fechaZarpeUnaSemana = fechaZarpe.addDays(14);
                fechaZarpeUnaSemana.addHours(23);
                fechaZarpeUnaSemana.addMinutes(59);
                fechaZarpeUnaSemana.addSeconds(59);
                //Obtener itinerarios de una semana en adelante
                List<Escalas_Itinerario__c> itinerarios = [SELECT Id, Itinerario__r.Name, Itinerario__r.Fecha_de_Viaje__c, Itinerario__r.RUTA__c, 
                                                           Itinerario__r.Nombre_de_la_Nave__r.Name, Inicio_Embarque__c, 
                                                           Itinerario__c, Millas_de_Navegacion__c, Navegacion__c, Observacion__c, 
                                                           Puerto_Destino__c, ETA_Puerto_Destino__c, Puerto_Embarque__c, Salida__c, 
                                                           Secuencia__c, Tiempo_Embarque__c, Itinerario__r.Nombre_de_la_Nave__r.Carga_Maxima_Vehiculos__c,
                                                           Itinerario__r.Tipo__c, Itinerario__r.Fecha_Zarpe__c, Itinerario__r.Fecha_Termino__c,
                                                           Itinerario__r.Pasajero_Web_Nac__c, Itinerario__r.Pasajero_Web_Ext__c,
                                                           Itinerario__r.Vehiculo_Web_Nac__c, Itinerario__r.Vehiculo_Web_Ext__c
                                                           FROM Escalas_Itinerario__c
                                                           WHERE Salida__c >: fechaZarpe
                                                           AND Salida__c <: fechaZarpeUnaSemana
                                                           /*
WHERE Itinerario__r.Fecha_de_Viaje__c >: fechaZarpe
AND Itinerario__r.Fecha_de_Viaje__c <: fechaZarpeUnaSemana
*/
                                                           AND Puerto_Embarque__r.Name =: origen
                                                           AND Itinerario__r.Canal_Web__c = true
                                                           AND Itinerario__r.Estado__c = 'Disponible para venta'
                                                           AND Hacer_Escala__c = true
                                                           ORDER BY Itinerario__r.Fecha_de_Viaje__c, Secuencia__c
                                                           LIMIT 10];
                System.debug('Numero de itinerarios: '+itinerarios.size());
                jsonText = '{ "itinerarios": [';
                for(Escalas_Itinerario__c pI : itinerarios){
                    Integer carga = 0;
                    Decimal pista = 0.0;
                    Integer butaca = 0;
                    Integer sinAcomodacion = 0;
                    //Manejo de Capacidades
                    List<Capacidad_Tramo__c> capacidades = new List<Capacidad_Tramo__c>();
                    List<Capacidad_Tramo__c> capPrimerTramo = new List<Capacidad_Tramo__c>();
                    List<Capacidad_Tramo__c> capPrimerTramoP = new List<Capacidad_Tramo__c>();
                    List<Capacidad_Tramo__c> capPrimerTramoV = new List<Capacidad_Tramo__c>();
                    List<Capacidad_Tramo__c> capPrimerTramoC = new List<Capacidad_Tramo__c>();
                    if(maxAlto > 0){
                        capPrimerTramoV = [SELECT Id, Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
                                           Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
                                           No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c
                                           FROM Capacidad_Tramo__c
                                           WHERE Escala_itinerario__c =: pI.Id
                                           AND RecordTypeId =: rTPistaC
                                           AND Alto__c >=: maxAlto];
                    }else{
                        capPrimerTramoV = [SELECT Id, Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
                                           Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
                                           No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c
                                           FROM Capacidad_Tramo__c
                                           WHERE Escala_itinerario__c =: pI.Id
                                           AND RecordTypeId =: rTPistaC];
                    }
                    //Todo tipo de registro distinto a Pista: Butacas y Pallets
                    capPrimerTramoP = [SELECT Id, Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
                                       Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
                                       No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c
                                       FROM Capacidad_Tramo__c
                                       WHERE Escala_itinerario__c =: pI.Id
                                       AND RecordTypeId !=: rTPistaC];
                    capPrimerTramo.addAll(capPrimerTramoP);
                    capPrimerTramo.addAll(capPrimerTramoV);
                    System.debug('Itinerario: '+pI.Itinerario__c);
                    Decimal secuenciaFinal = 0;
                    try{
                        secuenciaFinal = [SELECT Secuencia__c 
                                          FROM Escalas_Itinerario__c 
                                          WHERE Puerto_Destino__r.Name =: destino 
                                          AND Itinerario__c =: pI.Itinerario__c 
                                          AND Hacer_Escala__c = true].Secuencia__c;
                    }catch(Exception ex){
                        System.debug('sin secuencia final');
                    }
                    Integer escalas = -1;
                    Decimal hours = 0.0;
                    if(secuenciaFinal >= pI.Secuencia__c){
                        List<Capacidad_Tramo__c> capRestantesV = new List<Capacidad_Tramo__c>();
                        List<Capacidad_Tramo__c> capRestantesP = new List<Capacidad_Tramo__c>();
                        List<Capacidad_Tramo__c> capRestantes = new List<Capacidad_Tramo__c>();
                        if(maxAlto > 0){
                            capRestantesV = [SELECT Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
                                             Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
                                             No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c
                                             FROM Capacidad_Tramo__c
                                             WHERE Escala_itinerario__c <>: pI.Id
                                             AND Escala_itinerario__r.Itinerario__c =: pI.Itinerario__c
                                             AND (Escala_itinerario__r.Secuencia__c >: pI.Secuencia__c AND Escala_itinerario__r.Secuencia__c <=: secuenciaFinal)
                                             AND Alto__c >=: maxAlto
                                             AND RecordTypeId =: rTPistaC];
                        }else{
                            capRestantesV = [SELECT Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
                                             Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
                                             No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c
                                             FROM Capacidad_Tramo__c
                                             WHERE Escala_itinerario__c <>: pI.Id
                                             AND Escala_itinerario__r.Itinerario__c =: pI.Itinerario__c
                                             AND (Escala_itinerario__r.Secuencia__c >: pI.Secuencia__c AND Escala_itinerario__r.Secuencia__c <=: secuenciaFinal)
                                             AND RecordTypeId =: rTPistaC];
                        }
                        //Todo tipo de registro distinto a Pista: Butacas y Pallets
                        capRestantesP = [SELECT Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
                                         Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
                                         No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c
                                         FROM Capacidad_Tramo__c
                                         WHERE Escala_itinerario__c <>: pI.Id
                                         AND Escala_itinerario__r.Itinerario__c =: pI.Itinerario__c
                                         AND (Escala_itinerario__r.Secuencia__c >: pI.Secuencia__c AND Escala_itinerario__r.Secuencia__c <=: secuenciaFinal)
                                         AND RecordTypeId !=: rTPistaC];
                        capRestantes.addAll(capRestantesP);
                        capRestantes.addAll(capRestantesV);
                        Map<String, Capacidad_Tramo__c> capExistente = new Map<String, Capacidad_Tramo__c>();
                        for(Capacidad_Tramo__c cP : capPrimerTramo){
                            cP.Ancho__c = cP.Capacidad_Disponible__c;
                            capExistente.put(String.valueOf(cP.Numero__c)+String.valueOf(cP.RecordTypeId), cP);
                            /*
capExistente.put(String.valueOf(cP.Numero__c)+String.valueOf(cP.RecordTypeId), cP);
if(cP != null){
capacidades.add(cP);
if(cP.RecordTypeId == rTPistaC){
pista = pista + Integer.valueOf(cP.Capacidad_Disponible__c);
}else if(cP.RecordTypeId == rTButacaC){
butaca = butaca + Integer.valueOf(cP.Capacidad_Disponible__c);
}
}
*/
                        }
                        if(capRestantes.size() > 0){
                            for(Capacidad_Tramo__c cR : capRestantes){
                                String code = String.valueOf(cR.Numero__c)+String.valueOf(cR.RecordTypeId);
                                Capacidad_Tramo__c cP = capExistente.get(code);
                                if(cP != null){
                                    Decimal capReal = 0, capRealEvaluable = 0;
                                    capReal = cP.Ancho__c;
                                    capRealEvaluable = cR.Capacidad__c - cR.Capacidad_Comprometida__c;
                                    if(capRealEvaluable < capReal){
                                        cP.Ancho__c = capRealEvaluable;
                                    }
                                }
                            }
                            /*
for(Capacidad_Tramo__c cR : capRestantes){
String code = String.valueOf(cR.Numero__c)+String.valueOf(cR.RecordTypeId);
Capacidad_Tramo__c cP = capExistente.get(code);
if(cP != null){
if(cP.Capacidad_Disponible__c == cR.Capacidad_Disponible__c){
capacidades.add(cP);
}
}
}
*/
                        }
                        System.debug('Para contabilizar: ');
                        for( Capacidad_Tramo__c cT : capExistente.values()){
                            if(cT.RecordTypeId == rTPistaC){
                                pista = pista + (cT.Ancho__c);
                            }else if(cT.RecordTypeId == rTButacaC){
                                butaca = butaca + Integer.valueOf(cT.Ancho__c);
                            }
                        }
                        List<Escalas_Itinerario__c> viajeDetalle = [SELECT Inicio_Embarque__c, Secuencia__c, Salida__c, ETA_Puerto_Destino__c
                                                                    FROM Escalas_Itinerario__c
                                                                    WHERE Itinerario__c =: pI.Itinerario__c
                                                                    AND Secuencia__c <=: secuenciaFinal
                                                                    AND Hacer_Escala__c = true
                                                                    ORDER BY Secuencia__c ASC];
                        Date fechaInicio = pI.Salida__c.date(), fechaFin;
                        Time horaInicio = pI.Salida__c.time(), horaFin;
                        Long fIniL = pI.Salida__c.getTime(), mls;
                        escalas = Integer.valueOf(secuenciaFinal) - Integer.valueOf(pI.Secuencia__c);
                        for(Escalas_Itinerario__c vD : viajeDetalle){
                            System.debug('Secuencia Escala siguiente: '+vD.Secuencia__c);
                            Long fFinL = vD.ETA_Puerto_Destino__c.getTime();
                            mls = fFinL - fIniL;
                            horaFin = vD.ETA_Puerto_Destino__c.time();
                            fechaFin = vD.ETA_Puerto_Destino__c.date();
                        }
                        hours = ((mls / 1000) / 60);
                        String zarpeDia = dias[Integer.valueOf(pI.Salida__c.format('u'))];
                        String fechaLinda = zarpeDia+' '+fechaInicio.day()+', '+fechaInicio.month();
                        Time zarpeH = pI.Salida__c.time();
                        String horaLinda = '';
                        if(zarpeH.hour()<10){
                            horaLinda = '0'+String.valueOf(zarpeH.hour());
                        }else{
                            horaLinda = String.valueOf(zarpeH.hour());
                        }
                        if(zarpeH.minute()<10){
                            horaLinda = horaLinda + ':' + '0'+String.valueOf(zarpeH.minute());
                        }else{
                            horaLinda = horaLinda + ':' + String.valueOf(zarpeH.minute());
                        }
                    }
                    if(escalas < 0){
                        escalas = 0;
                    }
                    if(pista < 0){
                        pista = 0;
                    }
                    if(pista >= largoCompleto){
                        jsonText = jsonText + '{ "Id": "'+pI.Id+'",' +
                            '"Nombre":"'+pI.Itinerario__r.Name+'",' +
                            '"Itinerario":"'+pI.Itinerario__c+'",' +
                            '"Fecha":"'+formatDate(pI.Salida__c)+'",' +
                            '"Nave":"'+pI.Itinerario__r.Nombre_de_la_Nave__r.Name +'",' +
                            '"Escalas":"'+escalas+'",' +
                            '"Duracion":"'+hours+'",' +
                            '"Personas":"'+butaca+'",' +
                            '"Vehiculos":"'+pista+'",' +
                            '"PasajeroNacional":"'+pI.Itinerario__r.Pasajero_Web_Nac__c+'",' +
                            '"PasajeroExtranjero":"'+pI.Itinerario__r.Pasajero_Web_Ext__c+'",' +
                            '"VehiculoNacional":"'+pI.Itinerario__r.Vehiculo_Web_Nac__c+'",' +
                            '"VehiculoExtranjero":"'+pI.Itinerario__r.Vehiculo_Web_Ext__c+'",' +
                            '"FechaItinerario":"'+formatDate(pI.Itinerario__r.Fecha_de_Viaje__c)+'"},';
                    }
                }
                String lastCharacter = jsonText.right(1);
                if(lastCharacter == ','){
                    jsonText = jsonText.substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + ']}';
                System.debug('JSON Itinerario');
                System.debug(jsonText);
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'capacities'{
                String itinerario = req.params.get('i');
                String origen = req.params.get('o');
                String destino = req.params.get('d');
                System.debug('Id Itinerario -> '+itinerario);
                Decimal secuenciaInicial = [SELECT Secuencia__c 
                                            FROM Escalas_Itinerario__c
                                            WHERE Puerto_Embarque__r.Name =: origen
                                            AND Itinerario__c =: itinerario
                                            LIMIT 1].Secuencia__c;
                Decimal secuenciaFinal = [SELECT Secuencia__c 
                                          FROM Escalas_Itinerario__c
                                          WHERE Puerto_Embarque__r.Name =: destino
                                          AND Itinerario__c =: itinerario
                                          LIMIT 1].Secuencia__c;
                //Obtener capacidades de la nave
                List<Capacidad_Tramo__c> capTramos = [SELECT Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Disponible__c, 
                                                      Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c, 
                                                      No_disponible_Venta__c, Numero__c, Ubicacion__c, Unidad_de_medida__c,
                                                      Escala_itinerario__r.Itinerario__c
                                                      FROM Capacidad_Tramo__c
                                                      WHERE Escala_itinerario__r.Itinerario__c =: itinerario
                                                      AND Escala_itinerario__r.Secuencia__c >=: secuenciaInicial
                                                      AND Escala_itinerario__r.Secuencia__c <: secuenciaFinal
                                                      ORDER BY Numero__c, RecordTypeId ASC];
                System.debug('Id Itinerario -> '+itinerario);
                Set<capacidadNave> capacidades = new Set<capacidadNave>();
                Map<String, capacidadNave> capFull = new Map<String, capacidadNave>();
                Set<String> capToRemove = new Set<String>();
                
                for(Capacidad_Tramo__c cap : capTramos){
                    if(cap.Capacidad_Disponible__c == 0.0){
                        capToRemove.add(cap.Numero__c+cap.Unidad_de_medida__c);
                    }
                    capacidadNave cN = new capacidadNave(cap.Numero__c, cap.Ubicacion__c, cap.Capacidad__c, cap.Capacidad_Disponible__c, cap.Unidad_de_medida__c, cap.Escala_itinerario__r.Itinerario__c);
                    capFull.put(cap.Numero__c+cap.Unidad_de_medida__c, cN);
                }
                capFull.keySet().removeAll(capToRemove);
                for(capacidadNave cN : capFull.values()){
                    capacidades.add(cN);
                }
                jsonText = '{ "Capacidad": [';
                for(capacidadNave cNave : capacidades){
                    if(cNave.nombre != null){
                        jsonText = jsonText + '{ "capacidad":"'+cNave.capacidad+'",';
                        jsonText = jsonText + '"capacidadDisponible":"'+cNave.capacidadDisponible+'",';
                        jsonText = jsonText + '"numero":"'+cNave.nombre+'",';
                        jsonText = jsonText + '"unidadMedida":"'+cNave.unidadMedida+'",';
                        jsonText = jsonText + '"itinerario":"'+cNave.itinerario+'" },';
                    }
                }
                String lastCharacter = jsonText.right(1);
                if(lastCharacter == ','){
                    jsonText = jsonText .substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + ']}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'person'{
                String identificador = req.params.get('id');
                Boolean esResidente = false;
                jsonText = '{ "Persona": {';
                try{
                    Account acc = [SELECT Id, LastName, FirstName, PersonBirthdate, Identificacion__c, Tipo_de_identificacion__c, Discapacidad__pc,
                                   Sexo__pc, Nacionalidad__pc
                                   FROM Account
                                   WHERE Identificacion__c =: identificador
                                   AND IsPersonAccount = true];
                    String fechaCompleta = '';
                    fechaCompleta = String.valueOf(acc.PersonBirthdate.year());
                    if(acc.PersonBirthdate.month() < 10){
                        fechaCompleta = fechaCompleta + '-0'+String.valueOf(acc.PersonBirthdate.month());
                    }else{
                        fechaCompleta = fechaCompleta + '-'+String.valueOf(acc.PersonBirthdate.month());
                    }
                    if(acc.PersonBirthdate.day() < 10){
                        fechaCompleta = fechaCompleta + '-0'+String.valueOf(acc.PersonBirthdate.day());
                    }else{
                        fechaCompleta = fechaCompleta + '-'+String.valueOf(acc.PersonBirthdate.day());
                    }
                    jsonText = jsonText + '"Nombre":"'+acc.FirstName+'",';
                    jsonText = jsonText + '"Apellido":"'+acc.LastName+'",';
                    jsonText = jsonText + '"FechaNacimiento":"'+fechaCompleta+'",';
                    jsonText = jsonText + '"Discapacitado":"'+acc.Discapacidad__pc+'", ';
                    try{
                        Residente__c resi = [SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
                                             Comuna__c, N_Certificado__c, Fecha_Certificado__c 
                                             FROM Residente__c 
                                             WHERE Identificacion__c =: identificador];
                        if(resi.Id != null){
                            esResidente = true;
                        }
                    }catch(Exception exR){
                        esResidente = false;
                    }
                    jsonText = jsonText + '"Residente":"'+esResidente+'"';
                    
                    //RL -> agrego valor Género si se encuentra registrado
                    if(String.isNotBlank(acc.Sexo__pc)){
                        if(acc.Sexo__pc == 'M'){
                            jsonText = jsonText + ', "Genero":"Masculino"';
                        }else{
                            jsonText = jsonText + ', "Genero":"Femenino"';
                        }
                    }
                    
                    //RL -> agrego valor Nacionalidad si se encuentra registrado
                    if(String.isNotBlank(acc.Nacionalidad__pc)){
                        jsonText = jsonText + ', "Nacionalidad":"'+acc.Nacionalidad__pc+'"';
                    }
                }catch(Exception ex){
                    try{
                        Residente__c resi = [SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
                                             Comuna__c, N_Certificado__c, Fecha_Certificado__c 
                                             FROM Residente__c 
                                             WHERE Identificacion__c =: identificador];
                        if(resi.Id != null){
                            jsonText = jsonText + '"Nombre":"'+resi.Nombre_del_Residente__c+'",';
                            esResidente = true;
                        }
                    }catch(Exception exR){
                        esResidente = false;
                    }
                    jsonText = jsonText + '"Residente":"'+esResidente+'"';
                }
                jsonText = jsonText + '}}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'vehicle'{
                String patente = req.params.get('pat');
                jsonText = '{ "Vehiculo": {';
                try{
                    Detalle_Reserva__c detR = [SELECT Id, Tipo_de_Vehiculo__c, Marca__c, Modelo__c, Categoria_de_Vehiculo__c, Ano_Ve__c
                                               FROM Detalle_Reserva__c 
                                               WHERE Placa_Patente_Vehiculo__c =: patente 
                                               ORDER BY CreatedDate ASC
                                               LIMIT 1];
                    jsonText = jsonText + '"Tipo":"'+detR.Tipo_de_Vehiculo__c+'",';
                    jsonText = jsonText + '"Marca":"'+detR.Marca__c+'",';
                    jsonText = jsonText + '"Modelo":"'+detR.Modelo__c+'",';
                    jsonText = jsonText + '"Ano":"'+detR.Ano_Ve__c+'",';
                    jsonText = jsonText + '"Categoria":"'+detR.Categoria_de_Vehiculo__c+'"';
                }catch(Exception ex){
                    System.debug('No existe');
                }
                jsonText = jsonText + '}}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'rates'{
                List<Detalle_Reserva__c> detFull = [SELECT Id, Tarificar__c FROM Detalle_Reserva__c WHERE Reserva__r.UUID__c =: uuid];
                for(Detalle_Reserva__c dFu : detFull){
                    dFu.Tarificar__c = true;
                }
                update detFull;
                List<Detalle_Reserva__c> detPeople = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
                                                      Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
                                                      Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, Reserva__c, Reserva__r.Sentido_Viaje__c, 
                                                      Tarificacion_validada__c
                                                      FROM Detalle_Reserva__c
                                                      WHERE RecordTypeId =: rTButaca
                                                      AND Reserva__r.UUID__c =: uuid];
                List<Detalle_Reserva__c> detVehiculos = [SELECT Id, Placa_Patente_Vehiculo__c, Categoria_de_Vehiculo__c, Tipo_de_Vehiculo__c, Carro_Arrastre__c, 
                                                         Porta_Equipaje__c, Porta_Bicicleta__c, Capacidad_Comprometida__c, Valor_Veh_culo_DR__c,
                                                         Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Detalle_Reserva__c, Valor_ML_DR__c, 
                                                         Reserva__c, Reserva__r.Sentido_Viaje__c, 
                                                         Tarificacion_validada__c
                                                         FROM Detalle_Reserva__c
                                                         WHERE (RecordTypeId =: rTPista OR RecordTypeId =: rTBicicleta)
                                                         AND Reserva__r.UUID__c =: uuid];
                jsonText = '{ "reserva": {';
                jsonText = jsonText + ' "pasajeros": [';
                Boolean tarifaExiste = false;
                for(Detalle_Reserva__c dRe : detPeople){
                    jsonText = jsonText + '{';
                    jsonText = jsonText + '"reserva":"'+dRe.Reserva__c+'",';
                    jsonText = jsonText + '"tipoReserva":"'+dRe.Reserva__r.Sentido_Viaje__c+'",';
                    jsonText = jsonText + '"identificacion":"'+dRe.Doc_Identificacion_Pasajero__c+'",';
                    if(dRe.Nombre_Pasajero__c != null){
                        jsonText = jsonText + '"nombre":"'+dRe.Nombre_Pasajero__r.Name+'",';
                    }else{
                        jsonText = jsonText + '"nombre":"No existe",';
                    }
                    jsonText = jsonText + '"numero":"'+dRe.Numero__c+'",';
                    jsonText = jsonText + '"conductor":'+dRe.Conductor__c+',';
                    jsonText = jsonText + '"estudiante":'+dRe.Estudiante__c+',';
                    jsonText = jsonText + '"residente":'+dRe.Residente__c+',';
                    if(dRe.Nombre_Pasajero__c != null){
                        jsonText = jsonText + '"discapacitado":'+dRe.Nombre_Pasajero__r.Discapacidad__pc+',';
                    }else{
                        jsonText = jsonText + '"discapacitado":false,';
                    }
                    Decimal tasa = 0;
                    if(dRe.Tasa_Desembarque__c > 0){
                        tasa = tasa + dRe.Tasa_Desembarque__c;
                    }
                    if(dRe.Tasa_Embarque__c > 0){
                        tasa = tasa + dRe.Tasa_Embarque__c;
                    }
                    jsonText = jsonText + '"tasaEmbarque":"'+tasa+'",';
                    jsonText = jsonText + '"traslado":"'+dRe.Valor_Pasajero_DR__c+'",';
                    jsonText = jsonText + '"pasaje":"'+dRe.Valor_Detalle_Reserva__c+'",';
                    tarifaExiste = dRe.Tarificacion_validada__c;
                    jsonText = jsonText + '"tarifaExistente": '+tarifaExiste+'';
                    jsonText = jsonText + '},';
                }
                String lastCharacter = jsonText.right(1);
                if(lastCharacter == ','){
                    jsonText = jsonText.substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + '], "vehiculos": [';
                for(Detalle_Reserva__c dRe : detVehiculos){
                    jsonText = jsonText + '{';
                    jsonText = jsonText + '"reserva":"'+dRe.Reserva__c+'",';
                    jsonText = jsonText + '"tipoReserva":"'+dRe.Reserva__r.Sentido_Viaje__c+'",';
                    jsonText = jsonText + '"patente":"'+dRe.Placa_Patente_Vehiculo__c+'",';
                    jsonText = jsonText + '"categoria":"'+dRe.Categoria_de_Vehiculo__c+'",';
                    jsonText = jsonText + '"tipo":"'+dRe.Tipo_de_Vehiculo__c+'",';
                    jsonText = jsonText + '"carroarrastre":'+dRe.Carro_Arrastre__c+',';
                    jsonText = jsonText + '"portaequipaje":'+dRe.Porta_Equipaje__c+',';
                    jsonText = jsonText + '"portabicicleta":'+dRe.Porta_Bicicleta__c+',';
                    if(dRe.Capacidad_Comprometida__c != null){
                        jsonText = jsonText + '"metros":"'+dRe.Capacidad_Comprometida__c+'",';
                    }else{
                        jsonText = jsonText + '"metros":"0",';
                    }
                    Decimal tasa = 0;
                    if(dRe.Tasa_Desembarque__c > 0){
                        tasa = tasa + dRe.Tasa_Desembarque__c;
                    }
                    if(dRe.Tasa_Embarque__c > 0){
                        tasa = tasa + dRe.Tasa_Embarque__c;
                    }
                    jsonText = jsonText + '"tasaEmbarque":"'+tasa+'",';
                    Decimal valorTraslado = 0;
                    if(dRe.Valor_ML_DR__c > 0){
                        valorTraslado = valorTraslado + dRe.Valor_ML_DR__c;
                    }
                    if(dRe.Valor_Veh_culo_DR__c > 0){
                        valorTraslado = valorTraslado + dRe.Valor_Veh_culo_DR__c;
                    }
                    jsonText = jsonText + '"traslado":"'+valorTraslado+'",';
                    jsonText = jsonText + '"pasaje":"'+dRe.Valor_Detalle_Reserva__c+'",';
                    tarifaExiste = dRe.Tarificacion_validada__c;
                    jsonText = jsonText + '"tarifaExistente": '+tarifaExiste+'';
                    jsonText = jsonText + '},';
                }
                lastCharacter = jsonText.right(1);
                if(lastCharacter == ','){
                    jsonText = jsonText.substring(0,jsonText.length()-1);
                }
                jsonText = jsonText + ']}}';
                res.responseBody = Blob.valueOf(jsonText);
            }
            when 'getDocuments'{
                String lastCharacter = '';
                NAV_WebWS_Ticket_Helper ticketHelper = new NAV_WebWS_Ticket_Helper();
                ticketHelper.ticketFalso();
                ticketHelper.ticketReal(uuid);
                try{
                    jsonText = '{ "estado": "ok",';
                    jsonText = jsonText + '"id":"'+uuid+'",';
                    jsonText += '"documentos":[{"ticket":"'+ticketHelper.tickets[1]+'"}]}';
                    /* jsonText = jsonText + '"documentos":[';
                   for(String tick : ticketHelper.tickets){
                        jsonText = jsonText + '{"ticket":"'+tick+'"}';
                    }
                    jsonText = jsonText + ']}';
                    lastCharacter = jsonText.right(1);
                    if(lastCharacter == ','){
                        jsonText = jsonText.substring(0,jsonText.length()-1);
                    }
                    jsonText = jsonText + ']}';*/
                }catch(Exception ex){
                    System.debug('Error');
                    System.debug('Tipo de excepción: ' + ex.getTypeName());
                    System.debug('Mensaje: ' + ex.getMessage());
                    System.debug('Causa: ' + ex.getCause());
                    System.debug('Línea: ' + ex.getLineNumber());
                    System.debug('Traza: ' + ex.getStackTraceString());
                    jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                }
                res.responseBody = Blob.valueOf(jsonText);
            }when 'getReservas'{
                String identificador = req.params.get('id');
               /* List<Reserva__c> reserva = [SELECT Id,UUID__c,Codigo_Reserva__c,Fecha_Hora_de_Viaje__c FROM Reserva__c
                                            WHERE Contacto_Reserva__r.Identificacion__c =: identificador
                                            AND Estado_de_Reserva__c = 'Acreditada'
                                            AND Fecha_Hora_de_Viaje__c >= :System.now()
                                            AND Empresa_Puelche__c = false];  */
                
                List<Detalle_Reserva__c> reserva = [SELECT reserva__r.Id,reserva__r.UUID__c,reserva__r.Codigo_Reserva__c,reserva__r.Fecha_Hora_de_Viaje__c 
                                                    FROM Detalle_Reserva__c
                                                    WHERE Doc_Identificacion_Pasajero__c =: identificador
                                                    AND Estado_Reserva__c = 'Acreditada'
                                                    AND reserva__r.Fecha_Hora_de_Viaje__c >= :System.now()
                                                    AND reserva__r.Empresa_Puelche__c = false];
                
                try{
                    
                    jsonText = '{ "estado": "ok",';
                    jsonText = jsonText + '"id":"'+identificador+'",';
                    jsonText = jsonText +'"reserva": [';
                    for(Detalle_Reserva__c Re : reserva){
                        jsonText = jsonText + '{"uuid":"'+Re.reserva__r.UUID__c+'",';
                        jsonText = jsonText + '"nReserva":"'+Re.reserva__r.Codigo_Reserva__c+'",';
                        jsonText = jsonText + '"fechaViaje":"'+Re.reserva__r.Fecha_Hora_de_Viaje__c+'"},';
                    }
                    
                    jsonText = jsonText + ']}';
                    
                }catch(Exception ex){
                    System.debug('Error');
                    System.debug('Tipo de excepción: ' + ex.getTypeName());
                    System.debug('Mensaje: ' + ex.getMessage());
                    System.debug('Causa: ' + ex.getCause());
                    System.debug('Línea: ' + ex.getLineNumber());
                    System.debug('Traza: ' + ex.getStackTraceString());
                    jsonText = '{ "estado": "error", "id": "", "mensaje": "'+ex.getMessage()+'" }';
                }
                res.responseBody = Blob.valueOf(jsonText);
            }when else{
                res.responseBody = Blob.valueOf('{error:true}');
            }
        }
    }
}