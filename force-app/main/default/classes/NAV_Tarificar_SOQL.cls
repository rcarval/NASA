/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase tipo modelo para ejecución de consultas SOQL de Controller NAV_Tarificar_Controller
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     16-09-2021   RL       Creación de la Clase.
2.0     11-04-2023   EF       Se agrega la lógica de Butacas sin acomodación y se comentan funciones ya no utilizadas.
2.1     30-01-2024   RL       Actualización para Búsqueda de Registros contemplando Rutas Comerciales y Subsidiadas  
2.2     30-01-2024   CD       Se agrega validaciones para matrix DR Ticket 21008
***********************************************************************************/

public class NAV_Tarificar_SOQL  {
    //Constructor
   /* public NAV_Tarificar_SOQL(){
    }*/

    //Retorna datos registrados en Detalle_Reserva__c para proceso de tarificación
    public Detalle_Reserva__c retornarDatosDetalleReserva(String idRegistro){
        Detalle_Reserva__c detalleReserva = [SELECT Id, Name, 
                                             RecordType.DeveloperName, Reserva__c, 
                                             Alto__c, Ancho__c, 
                                             Capacidad_Comprometida__c,  
                                             Carga_Veh_culo__c, Conductor__c, Acompanante__c, ida_Vuelta__c,Reserva__r.ruta__c,
                                             Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
                                             Estado_Reserva__c, Fono_Pasajero__c, 
                                             Largo__c, Nombre_Pasajero__c, 
                                             Numero__c, Pasajero_Conductor__c, 
                                             Placa_Patente_Vehiculo__c, Residente__c, 
                                             Tara__c, Tipo_de_Vehiculo__c, 
                                             Tipo_de_identificacion__c, Ubicacion__c, 
                                             Unidad_de_medida__c, Marca__c, 
                                             Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
                                             Estudiante__c,
                                             Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
                                             Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
                                             Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
                                             Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
                                             Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
                                             Reserva__r.Itinerario_admite_DR__c, CreatedDate,
                                             Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
                                             Carro_Arrastre__c, ML_Portabicicleta__c,
                                             Reserva__r.Itinerario_asociado__r.Tipo__c,
                                             Reserva__r.Estado_de_Reserva__c, Parametro_Tarifa__c,
                                             Detalle_Reserva_Conductor__r.Residente__c
                                             //,Nombre_Pasajero__r.Fecha_de_Nacimiento__c
                                             FROM Detalle_Reserva__c WHERE Id =: idRegistro];
        return detalleReserva;
    }
    
    //Retorna MAP de datos registrados en Detalle_Reserva__c para proceso de tarificación
    public Map<String,Detalle_Reserva__c> retornarDatosDetalleReservaMap(List<Id> idRegistros){
        List<Detalle_Reserva__c> detalleReservaLst = [SELECT Id, Name, 
                                                      RecordType.DeveloperName, Reserva__c, 
                                                      Alto__c, Ancho__c, 
                                                      Capacidad_Comprometida__c,  
                                                      Carga_Veh_culo__c, Conductor__c, Acompanante__c,ida_Vuelta__c,Reserva__r.ruta__c,
                                                      Detalle_Reserva_Conductor__c, Doc_Identificacion_Pasajero__c, 
                                                      Estado_Reserva__c, Fono_Pasajero__c, 
                                                      Largo__c, Nombre_Pasajero__c, 
                                                      Numero__c, Pasajero_Conductor__c, 
                                                      Placa_Patente_Vehiculo__c, Residente__c, 
                                                      Tara__c, Tipo_de_Vehiculo__c, 
                                                      Tipo_de_identificacion__c, Ubicacion__c, 
                                                      Unidad_de_medida__c, Marca__c, 
                                                      Modelo__c, Nombre_Pasajero__r.PersonBirthdate,
                                                      Estudiante__c,
                                                      Reserva__r.Puerto_ORIGEN__c, Reserva__r.Puerto_DESTINO__c,
                                                      Nombre_Pasajero__r.Discapacidad__pc, Transportista__c,
                                                      Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c, 
                                                      Categoria_de_Vehiculo__c, Cantidad_de_Metros__c,
                                                      Reserva__r.Fecha_de_Reserva__c, Reserva__r.Ocupacion_porcentaje__c,
                                                      Reserva__r.Itinerario_admite_DR__c, CreatedDate,
                                                      Reserva__r.Fecha_Viaje__c, Persona_que_entrega__r.Tipo_de_identificacion__c,
                                                      Carro_Arrastre__c, ML_Portabicicleta__c,
                                                      Reserva__r.Itinerario_asociado__r.Tipo__c,
                                                      Reserva__r.Estado_de_Reserva__c, Parametro_Tarifa__c,
                                                      Detalle_Reserva_Conductor__r.Residente__c
                                                      FROM Detalle_Reserva__c 
                                                      WHERE Id IN: idRegistros];
        Map<String, Detalle_Reserva__c> detalleReservaMap = new Map<String,Detalle_Reserva__c>();
        detalleReservaMap.putAll(detalleReservaLst);
        return detalleReservaMap;
    }

    //Retorna 1 solo registro de Tramo para tarificaciones para Registros de Butaca/Carga/Pista
    Public Capacidad_Tramo_Detalle_Reserva__c getTramoDetalleReserva(String idRegistro){
        Capacidad_Tramo_Detalle_Reserva__c detalleReserva = [SELECT Id, Itinerario__c, 
                                                             Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c 
                                                             FROM Capacidad_Tramo_Detalle_Reserva__c 
                                                             WHERE Detalle_Reserva__c =: idRegistro
                                                             AND Capacidad_Liberada__c = false
                                                             LIMIT 1];
        return detalleReserva;
    }

    //Retorna Map de 1 solo registro de Tramo para tarificaciones para Registros de Butaca/Carga/Pista
    public Map<String, Capacidad_Tramo_Detalle_Reserva__c> getTramoDetalleReservaMap(List<Detalle_Reserva__c> detalleReservaLst){
        Set<String> listaIdsDetalleReservas = new Set<String>();
        
        for(Detalle_Reserva__c detalleReserva : detalleReservaLst){
            System.debug(detalleReserva.RecordType.DeveloperName+' '+detalleReserva.Id);
            if(detalleReserva.RecordType.DeveloperName != 'Bicicletas'){
                listaIdsDetalleReservas.add(detalleReserva.Id);
            }
        }

        if(listaIdsDetalleReservas.size() > 0){
            List<Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaLst = [SELECT Id, Itinerario__c, 
                                                                       Tipo_de_Itinerario__c, Capacidad_Tramo__r.Categoria__c,
                                                                       Detalle_Reserva__c 
                                                                       FROM Capacidad_Tramo_Detalle_Reserva__c 
                                                                       WHERE Detalle_Reserva__c IN :  listaIdsDetalleReservas
                                                                       AND Capacidad_Liberada__c = false];

            Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleReservaMap = new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
            for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : tramoDetalleReservaLst){
                if(tramoDetalleReservaMap.get(detalleCapacidadTramo.Detalle_Reserva__c) == null){
                        tramoDetalleReservaMap.put(detalleCapacidadTramo.Detalle_Reserva__c, detalleCapacidadTramo);
                }
            }

            return tramoDetalleReservaMap;
        }else{
            return new Map<String, Capacidad_Tramo_Detalle_Reserva__c>();
        }       
    }

    //Devuelve listado de posibles Parámetros de Tarificación según la configuración del registro de Detalle_Reserva__c y Reserva
    public Map<String, Parametros_Tarifarios_Pasajeros__c> getParametrosTarifa(Detalle_Reserva__c detalleReserva, String tipoRegistro, String tipoItinerario, String categoria){
        List<Parametros_Tarifarios_Pasajeros__c> listParametros = new List<Parametros_Tarifarios_Pasajeros__c>();
        Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
        Set<String> setTipoConceptos = new Set<String>();
        
        System.debug('Tipo itinerario -> '+tipoItinerario);
        //Usar estos campos para comparar con registros de parametro Tipo de Itinerario -> SUBV, COM
        
        //Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
        Boolean esNacional = false;
      //  String  concepto = '';
        
        //Switch para armar lógica de busqueda de posibles registros de Tarifa
        switch on tipoRegistro{
            when 'Butaca'{
                //Considerar si es Sin acomodación para evitar todas las variables de persona en Butaca
                if(categoria == 'Sin acomodacion'){
                    if (tipoItinerario == 'COM'){
                        listParametros = [SELECT Id, Name, 
                                        Contrato_Tarifa__c, Oferta__c, 
                                        Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                        Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                        Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                        Valor__c, 
                                        Categoria__c, Concepto__c, 
                                        Especificacion__c, Extranjero__c, 
                                        Tipo_Transporte__c, Impuesto__c, 
                                        Porcentaje_Impuesto__c, Discapacidad__c, 
                                        Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                        Transportista__c, Edad_desde__c, 
                                        Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                        Contrato_Tarifa__r.Vigencia_hasta__c                                      
                                      FROM Parametros_Tarifarios_Pasajeros__c
                                      WHERE Tipo_Transporte__c = 'Pasajero'
                                        AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                        AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                        AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                        AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                        OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                        AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                        AND Categoria__c =: categoria
                                        AND Ruta_Comercial__c = true];
                    }else{
                        listParametros = [SELECT Id, Name, 
                                        Contrato_Tarifa__c, Oferta__c, 
                                        Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                        Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                        Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                        Valor__c, 
                                        Categoria__c, Concepto__c, 
                                        Especificacion__c, Extranjero__c, 
                                        Tipo_Transporte__c, Impuesto__c, 
                                        Porcentaje_Impuesto__c, Discapacidad__c, 
                                        Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                        Transportista__c, Edad_desde__c, 
                                        Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                        Contrato_Tarifa__r.Vigencia_hasta__c                                      
                                      FROM Parametros_Tarifarios_Pasajeros__c
                                      WHERE Tipo_Transporte__c = 'Pasajero'
                                        AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                        AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                        AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                        AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                        OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                        AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                        AND Categoria__c =: categoria
                                        AND Ruta_Subsidiada__c = true];
                    }
                }else{
                    //Se considera Nacional cuando el registro de detalle Reserva es del tipo RUT
                    if(detalleReserva.Tipo_de_identificacion__c == 'RUT'){
                        esNacional = true;
                    }
                    
                    //Búsqueda de Parámetros de Tarifa del tipo Comercial
                    if(tipoItinerario == 'COM'){
                        if(esNacional){
                            if(detalleReserva.Residente__c){
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Nacional, es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c, 
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c,ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c                                      
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Nacional__c = true)
                                                AND Residente__c =: detalleReserva.Residente__c
                                                AND Categoria__c =: categoria
                                                AND Ruta_Comercial__c = true];
                            }else{
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Nacional, NO es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c, 
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c                                      
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Nacional__c = true)
                                                AND Categoria__c =: categoria
                                                AND Residente__c = false
                                                AND Ruta_Comercial__c = true];  
                            }
                        }else{
                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                            //es Extranjero, es Residente y Pasajero (Butaca)
                            if(detalleReserva.Residente__c){
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c,  
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c                                      
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Extranjero__c = true)
                                                AND Categoria__c =: categoria
                                                AND Residente__c =: detalleReserva.Residente__c
                                                AND Ruta_Comercial__c = true];
                            }else{
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Extranjero, NO es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c, 
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c                                      
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Extranjero__c = true)
                                                AND Categoria__c =: categoria
                                                AND Residente__c = false
                                                AND Ruta_Comercial__c = true];  
                            }
                        }
                    }else{
                        //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                        if(esNacional){
                            if(detalleReserva.Residente__c){
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Nacional, es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c, 
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c    
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Nacional__c = true)
                                                AND Ruta_Subsidiada__c = true
                                                AND Residente__c =: detalleReserva.Residente__c];
                            }else{
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Nacional, NO es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c,  
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c    
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Nacional__c = true)
                                                AND Ruta_Subsidiada__c = true
                                                AND Residente__c = false];
                            }
                        }else{
                            if(detalleReserva.Residente__c){
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Extranjero, es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c,  
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c    
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Extranjero__c = true)
                                                AND Ruta_Subsidiada__c = true
                                                AND Residente__c =: detalleReserva.Residente__c];
                            }else{
                                //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                //es Extranjero, NO es Residente y Pasajero (Butaca)
                                listParametros = [SELECT Id, Name, 
                                                Contrato_Tarifa__c, Oferta__c, 
                                                Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                Valor__c, 
                                                Categoria__c, Concepto__c, 
                                                Especificacion__c, Extranjero__c, 
                                                Tipo_Transporte__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Discapacidad__c, 
                                                Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                Transportista__c, Edad_desde__c, 
                                                Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                Contrato_Tarifa__r.Vigencia_hasta__c    
                                                FROM Parametros_Tarifarios_Pasajeros__c
                                                WHERE Tipo_Transporte__c = 'Pasajero'
                                                AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                                AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                                OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                                AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                                AND (Extranjero__c = true)
                                                AND Ruta_Subsidiada__c = true
                                                AND Residente__c = false];
                            }   
                        }
                    }
                }
            }
            
            when 'Pallet'{
                //Se considera Nacional cuando el registro de detalle Reserva de la persona que entrega es del tipo RUT
                if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
                    esNacional = true;
                }

                //Búsqueda de Parámetros de Tarifa del tipo Comercial
                if(tipoItinerario == 'COM'){
                    if(esNacional){
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Nacional y Carga (Pallets)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c                                    
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Carga'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Nacional__c = true)
                                          AND Especificacion__c = 'Pallets'
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Tipo_de_Vehiculo__c =: detalleReserva.Tipo_de_Vehiculo__c
                                          AND Ruta_Comercial__c = true];
                    }else{
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Extranjero y Carga (Pallets)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c                                            
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Carga'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Extranjero__c = true)
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Especificacion__c = 'Pallets'
                                          AND Ruta_Comercial__c = true];
                    }
                }else{
                    //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                    if(esNacional){
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Nacional y Carga (Pallets)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c                                            
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Carga'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Nacional__c = true)
                                          AND Especificacion__c = 'Pallets'
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Subsidiada__c = true];
                    }else{
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Extranjero y Carga (Pallets)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c                                            
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Carga'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Extranjero__c = true)
                                          AND Especificacion__c = 'Pallets'
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Subsidiada__c = true];
                    }
                }
            }
            
            when 'Pista'{
                if(String.isNotBlank(detalleReserva.Detalle_Reserva_Conductor__c)){
                    System.debug('Consulto por Conductor');
                    //Se considera Nacional cuando el registro de detalle Reserva de la persona identificada como conductor es del tipo RUT
                    if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
                        esNacional = true;
                    }
                }else{
                    System.debug('Consulto por Persona que entrega');
                    if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
                        esNacional = true;
                    }
                }


                //Si la categoría del vehículo pertenece a "Bus y Motorhome" o "Camión y Maquinaria"
                //La especificación a utilizar debe ser Metro Lineal
                //***La especificación solo se utiliza en búsquedas Comerciales
                String especificacion = detalleReserva.Categoria_de_Vehiculo__c;
                if(especificacion == 'Bus y Motorhome' || especificacion == 'Camion y Maquinaria'){
                    especificacion = 'Metro Lineal';
                }

                //Búsqueda de Parámetros de Tarifa del tipo Comercial
                if(tipoItinerario == 'COM'){
                    if(esNacional){
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Nacional y Vehículo (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c,ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                         
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Nacional__c = true)
                                          AND Especificacion__c =: especificacion
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Tipo_de_Vehiculo__c =: detalleReserva.Tipo_de_Vehiculo__c
                                          AND Ruta_Comercial__c = true];
                    }else{
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Extranjero y Vehículo (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c, 
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                     
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Extranjero__c = true)
                                          AND Especificacion__c =: especificacion
                                          AND Tipo_de_Vehiculo__c =: detalleReserva.Tipo_de_Vehiculo__c
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Comercial__c = true];
                    }
                }else{
                    //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                    if(esNacional){
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Nacional y Vehículo (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                         
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Nacional__c = true)
                                          AND Especificacion__c =: especificacion
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Subsidiada__c = true];
                    }else{
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Extranjero y Vehículo (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c, 
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                             
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Extranjero__c = true)
                                          AND Especificacion__c =: especificacion
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Subsidiada__c = true];
                    }
                }
            }

            when 'Bicicletas'{
                if(String.isNotBlank(detalleReserva.Detalle_Reserva_Conductor__c)){
                    System.debug('Consulto por Conductor');
                    //Se considera Nacional cuando el registro de detalle Reserva de la persona identificada como conductor es del tipo RUT
                    if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
                        esNacional = true;
                    }
                }else{
                    System.debug('Consulto por Persona que entrega');
                    if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
                        esNacional = true;
                    }
                }

                //Búsqueda de Parámetros de Tarifa del tipo Comercial
                if(tipoItinerario == 'COM'){
                    if(esNacional){
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Nacional y Bicicleta (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                             
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Nacional__c = true)
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Especificacion__c = 'Bicicletas'
                                          AND Concepto__c = 'Vehículo - Bicicletas'
                                          AND Ruta_Comercial__c = true];
                    }else{
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Extranjero y Bicicleta (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c, 
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                         
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Extranjero__c = true)
                                          AND Especificacion__c = 'Bicicletas'
                                          AND Concepto__c = 'Vehículo - Bicicletas'
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Comercial__c = true];
                    }
                }else{
                    //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                    if(esNacional){
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Nacional y Bicicleta (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c,  
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                             
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Nacional__c = true)
                                          AND Especificacion__c = 'Bicicletas'
                                          AND Concepto__c = 'Vehículo - Bicicletas'
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Subsidiada__c = true];
                    }else{
                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                        //es Extranjero y Bicicleta (Pista)
                        listParametros = [SELECT Id, Name, 
                                          Contrato_Tarifa__c, Oferta__c, 
                                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                          Valor__c, 
                                          Categoria__c, Concepto__c, 
                                          Especificacion__c, Extranjero__c, 
                                          Tipo_Transporte__c, Impuesto__c, 
                                          Porcentaje_Impuesto__c, Discapacidad__c, 
                                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                          Transportista__c, Edad_desde__c, 
                                          Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                          Contrato_Tarifa__r.Vigencia_hasta__c,
                                          Tipo_de_Vehiculo__c                                         
                                          FROM Parametros_Tarifarios_Pasajeros__c
                                          WHERE Tipo_Transporte__c = 'Vehículo'
                                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                          AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                          OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                          AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                          AND (Extranjero__c = true)
                                          AND Especificacion__c = 'Bicicletas'
                                          AND Concepto__c = 'Vehículo - Bicicletas'
                                          AND Residente__c =: detalleReserva.Residente__c
                                          AND Ruta_Subsidiada__c = true];
                    }
                }   
            }
        }
        mapParametros.putAll(listParametros);
        return mapParametros;
    }

    //Devuelve MAP de listado de posibles Parámetros de Tarificación según la configuración del registro de Detalle_Reserva__c y Reserva
    public Map<String, Parametros_Tarifarios_Pasajeros__c> getParametrosTarifaMap(List<Detalle_Reserva__c> detalleReservaLst, Map<String,Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleMap){
        List<Parametros_Tarifarios_Pasajeros__c> listParametros = new List<Parametros_Tarifarios_Pasajeros__c>();
        Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
        Map<String, Parametros_Tarifarios_Pasajeros__c> mapToReturnParametros = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
        Set<String> setIdsParametrosTarifa = new Set<String>();
        String tipoRegistro = '';
        String categoria = '';
        String tipoItinerario = '';
        Set<String> listaTipoItinerario = new Set<String>();
        if(tramoDetalleMap.size() > 0){
            for(Capacidad_Tramo_Detalle_Reserva__c detalleCapacidadTramo : tramoDetalleMap.values()){
                listaTipoItinerario.add(detalleCapacidadTramo.Tipo_de_Itinerario__c);
            }
        }
        if(listaTipoItinerario.size() > 1){
            listParametros = [SELECT Id, Name, 
                            Contrato_Tarifa__c, Oferta__c, 
                            Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                            Ruta_Subsidiada__c, Ruta_Comercial__c, 
                            Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                            Valor__c, 
                            Categoria__c, Concepto__c, 
                            Especificacion__c, Extranjero__c, 
                            Tipo_Transporte__c, Impuesto__c, 
                            Porcentaje_Impuesto__c, Discapacidad__c, 
                            Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                            Transportista__c, Edad_desde__c, 
                            Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                            Contrato_Tarifa__r.Vigencia_hasta__c, Tipo_de_Vehiculo__c                               
                            FROM Parametros_Tarifarios_Pasajeros__c
                            WHERE Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                            AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                            AND (Ruta_Comercial__c = true OR Ruta_Subsidiada__c = true)
                            AND ((Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c
                                    AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c)
                                    OR (Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c
                                    AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c))];
        }else{        
            tipoItinerario = detalleReservaLst.get(0).Reserva__r.Itinerario_asociado__r.Tipo__c;
            System.debug('Tipo Itinerario: '+tipoItinerario);
            if(tipoItinerario == 'COM'){
                listParametros = [SELECT Id, Name, 
                                    Contrato_Tarifa__c, Oferta__c, 
                                    Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                    Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                    Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                    Valor__c, 
                                    Categoria__c, Concepto__c, 
                                    Especificacion__c, Extranjero__c, 
                                    Tipo_Transporte__c, Impuesto__c, 
                                    Porcentaje_Impuesto__c, Discapacidad__c, 
                                    Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                    Transportista__c, Edad_desde__c, 
                                    Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                    Contrato_Tarifa__r.Vigencia_hasta__c, Tipo_de_Vehiculo__c                               
                                FROM Parametros_Tarifarios_Pasajeros__c
                                WHERE Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                                    AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                                    AND Ruta_Comercial__c = true
                                    AND ((Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c
                                            AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c)
                                        OR (Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c
                                            AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c))];
            }else{
                listParametros = [SELECT Id, Name, 
                                    Contrato_Tarifa__c, Oferta__c, 
                                    Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                    Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                    Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                    Valor__c, 
                                    Categoria__c, Concepto__c, 
                                    Especificacion__c, Extranjero__c, 
                                    Tipo_Transporte__c, Impuesto__c, 
                                    Porcentaje_Impuesto__c, Discapacidad__c, 
                                    Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                    Transportista__c, Edad_desde__c, 
                                    Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                    Contrato_Tarifa__r.Vigencia_hasta__c, Tipo_de_Vehiculo__c                               
                                FROM Parametros_Tarifarios_Pasajeros__c
                                WHERE Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                                    AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                                    AND Ruta_Subsidiada__c = true
                                    AND ((Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c
                                            AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c)
                                        OR (Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c
                                            AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c))];
            }
        }
        mapParametros.putAll(listParametros);
        System.debug('REGISTROS = '+mapParametros.size());
        System.debug(mapParametros);
        
        for(Detalle_Reserva__c detalleReserva : detalleReservaLst){
            System.debug('Buscando Tarifa para '+detalleReserva.Name);
            tipoRegistro = '';
            categoria = '';
            tipoItinerario = '';

            //Asigno tipo de registro a Variable tipoRegistro
            tipoRegistro = detalleReserva.RecordType.DeveloperName;

            System.debug('Tipo Registro');
            System.debug(tipoRegistro);
            
            //Si Tipo de Registro es distinto a "Bicicletas"
            //Realizo búsqueda de Tramo Detalle Reserva y así obtener el Tipo de Itinerario
            //Caso contrario, lo obtengo del campo fórmula Tipo de Registro
            if(tipoRegistro != 'Bicicletas'){
                Capacidad_Tramo_Detalle_Reserva__c tramoDetalle = new Capacidad_Tramo_Detalle_Reserva__c();
                tramoDetalle = tramoDetalleMap.get(detalleReserva.Id);
                System.debug(tramoDetalle);

                tipoItinerario = tramoDetalle.Tipo_de_Itinerario__c;
                //Si tipo de Registro es Butaca, debemos obtener Categoría desde Capacidad_Tramo
                if(tipoRegistro == 'Butaca'){
                    categoria = tramoDetalle.Capacidad_Tramo__r.Categoria__c;
                }
            }else{
                tipoItinerario = detalleReserva.Reserva__r.Itinerario_asociado__r.Tipo__c;
            }

            //Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
            Boolean esNacional = false;
            String  concepto = '';

            System.debug('Categoria -> '+categoria);
            System.debug('Tipo itinerario -> '+tipoItinerario);
            //Usar estos campos para comparar con registros de parametro Tipo de Itinerario -> SUBV, COM
        
            for(Parametros_Tarifarios_Pasajeros__c parametroTarifa : listParametros){
                //Switch para armar lógica de busqueda de posibles registros de Tarifa
                switch on tipoRegistro{
                    when 'Butaca'{
                        if(parametroTarifa.Categoria__c == 'Sin acomodacion'){
                            if(tipoItinerario == 'COM' && parametroTarifa.Ruta_Comercial__c && categoria.contains('acomoda')){
                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                            }else if(parametroTarifa.Ruta_Subsidiada__c && categoria.contains('acomoda')){
                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                            }
                        }else{
                            if(parametroTarifa.Tipo_Transporte__c == 'Pasajero'){
                                //Se considera Nacional cuando el registro de detalle Reserva es del tipo RUT
                                if(detalleReserva.Tipo_de_identificacion__c == 'RUT'){
                                    esNacional = true;
                                }else{
                                    esNacional = false;
                                }
                    
                                //Búsqueda de Parámetros de Tarifa del tipo Comercial
                                if(tipoItinerario == 'COM'){
                                    if(esNacional){
                                        if(detalleReserva.Residente__c){
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Nacional, es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Nacional__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                            && parametroTarifa.Categoria__c == categoria && parametroTarifa.Ruta_Comercial__c){
                                                setIdsParametrosTarifa.add(parametroTarifa.Id); 
                                            }
                                        }else{
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Nacional, NO es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Nacional__c && parametroTarifa.Categoria__c == categoria
                                            && !parametroTarifa.Residente__c && parametroTarifa.Ruta_Comercial__c){
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }
                                    }else{
                                        //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                        //es Extranjero, es Residente y Pasajero (Butaca)
                                        if(detalleReserva.Residente__c){
                                            if(parametroTarifa.Extranjero__c && parametroTarifa.Categoria__c == categoria
                                            && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Ruta_Comercial__c){
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }else{
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Extranjero, NO es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Extranjero__c && parametroTarifa.Categoria__c == categoria
                                            && !parametroTarifa.Residente__c && parametroTarifa.Ruta_Comercial__c){
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                                    if(esNacional){
                                        if(detalleReserva.Residente__c){
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Nacional, es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Nacional__c && parametroTarifa.Ruta_Subsidiada__c
                                            && parametroTarifa.Residente__c){
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }else{
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Nacional, NO es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Nacional__c && parametroTarifa.Ruta_Subsidiada__c
                                            && !parametroTarifa.Residente__c){
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }
                                    }else{
                                        if(detalleReserva.Residente__c){
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Extranjero, es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Extranjero__c && parametroTarifa.Ruta_Subsidiada__c
                                            && parametroTarifa.Residente__c){
                                                System.debug('AGREGANDO = '+parametroTarifa.Name);
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }else{
                                            //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                            //es Extranjero, NO es Residente y Pasajero (Butaca)
                                            if(parametroTarifa.Extranjero__c && parametroTarifa.Ruta_Subsidiada__c
                                            && !parametroTarifa.Residente__c ){
                                                System.debug('AGREGANDO = '+parametroTarifa.Name);
                                                setIdsParametrosTarifa.add(parametroTarifa.Id);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    when 'Pallet'{
                        if(parametroTarifa.Tipo_Transporte__c == 'Carga' && parametroTarifa.Especificacion__c == 'Pallets'){
                            //Se considera Nacional cuando el registro de detalle Reserva de la persona que entrega es del tipo RUT
                            if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
                                esNacional = true;
                            }

                            //Búsqueda de Parámetros de Tarifa del tipo Comercial
                            if(tipoItinerario == 'COM'){
                                if(esNacional){
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Nacional y Carga (Pallets)
                                    if(parametroTarifa.Nacional__c  && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c && parametroTarifa.Ruta_Comercial__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Extranjero y Carga (Pallets)
                                    if(parametroTarifa.Extranjero__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Comercial__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }
                            }else{
                                //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                                if(esNacional){
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Nacional y Carga (Pallets)
                                    if(parametroTarifa.Nacional__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Subsidiada__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Extranjero y Carga (Pallets)
                                    if(parametroTarifa.Extranjero__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Subsidiada__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }
                            }
                        }
                    }

                    when 'Pista'{
                        if(parametroTarifa.Tipo_Transporte__c == 'Vehículo'){
                            //Se considera Nacional cuando el registro de detalle Reserva de la persona identificada como conductor es del tipo RUT
                            if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
                                esNacional = true;
                            }else{
                                System.debug('Consulto por Persona que entrega');
                                if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
                                    esNacional = true;
                                }
                            }

                            //Si la categoría del vehículo pertenece a "Bus y Motorhome" o "Camión y Maquinaria"
                            //La especificación a utilizar debe ser Metro Lineal
                            //***La especificación solo se utiliza en búsquedas Comerciales
                            String especificacion = detalleReserva.Categoria_de_Vehiculo__c;
                            if(especificacion == 'Bus y Motorhome' || especificacion == 'Camion y Maquinaria'){
                                especificacion = 'Metro Lineal';
                            }

                            //Búsqueda de Parámetros de Tarifa del tipo Comercial
                            if(tipoItinerario == 'COM'){
                                if(esNacional){
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Nacional y Vehículo (Pista)
                                    if(parametroTarifa.Nacional__c && parametroTarifa.Especificacion__c == especificacion
                                    && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c
                                    && parametroTarifa.Ruta_Comercial__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Extranjero y Vehículo (Pista)
                                    if(parametroTarifa.Extranjero__c && parametroTarifa.Especificacion__c == especificacion
                                    && parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Comercial__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }
                            }else{
                                //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                                if(esNacional){
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Nacional y Vehículo (Pista)
                                    if(parametroTarifa.Nacional__c && parametroTarifa.Especificacion__c == especificacion
                                    && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Subsidiada__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Extranjero y Vehículo (Pista)
                                    if(parametroTarifa.Extranjero__c && parametroTarifa.Especificacion__c == especificacion
                                    && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Ruta_Subsidiada__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }
                            }
                        }
                    }

                    when 'Bicicletas'{
                        if(parametroTarifa.Tipo_Transporte__c == 'Vehículo' && parametroTarifa.Especificacion__c == 'Bicicletas'
                        && parametroTarifa.Concepto__c == 'Vehículo - Bicicletas'){
                            //Se considera Nacional cuando el registro de detalle Reserva de la persona identificada como conductor es del tipo RUT
                            if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
                                esNacional = true;
                            }

                            //Búsqueda de Parámetros de Tarifa del tipo Comercial
                            if(tipoItinerario == 'COM'){
                                if(esNacional){
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Nacional y Bicicleta (Pista)
                                    if(parametroTarifa.Nacional__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Comercial__c){
                                    setIdsParametrosTarifa.add(parametroTarifa.Id);  
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Extranjero y Bicicleta (Pista)
                                    if(parametroTarifa.Extranjero__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Comercial__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id); 
                                    }
                                }
                            }else{
                                //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                                if(esNacional){
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Nacional y Bicicleta (Pista)
                                    if(parametroTarifa.Nacional__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Subsidiada__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }else{
                                    //Búsqueda de Parámetros de Tarifa cuando el Detalle Reserva
                                    //es Extranjero y Bicicleta (Pista)
                                    if(parametroTarifa.Extranjero__c && parametroTarifa.Residente__c == detalleReserva.Residente__c
                                    && parametroTarifa.Ruta_Subsidiada__c){
                                        setIdsParametrosTarifa.add(parametroTarifa.Id);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        

        if(setIdsParametrosTarifa.size() > 0){
            for(String idParametroTarifa : setIdsParametrosTarifa){
                mapToReturnParametros.put(idParametroTarifa, mapParametros.get(idParametroTarifa));
            }
        }
        
        return mapToReturnParametros;
    }

    //Devuelve listado de posibles Parámetros de Tarificación de metros lineales según la configuración del registro de Detalle_Reserva__c y Reserva
    public Map<String, Parametros_Tarifarios_Pasajeros__c> getParametrosTarifaMetroLineal(Detalle_Reserva__c detalleReserva, String tipoItinerario){
        List<Parametros_Tarifarios_Pasajeros__c> listParametros = new List<Parametros_Tarifarios_Pasajeros__c>();
        Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
        //Set<String> setTipoConceptos = new Set<String>();
        System.debug('Tipo itinerario -> '+tipoItinerario);
        //Usar estos campos para comparar con registros de parametro Tipo de Itinerario -> SUBV, COM
        
        //Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
        Boolean esNacional = false;
       // String  concepto = '';
        
        //Se considera Nacional cuando el registro de detalle Reserva es del tipo RUT
        if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
            esNacional = true;
        }

        //Búsqueda de Parámetros de Tarifa del tipo Comercial
        if(tipoItinerario == 'COM'){
            if(esNacional){
                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                //es Nacional
                listParametros = [SELECT Id, Name, 
                                  Contrato_Tarifa__c, Oferta__c, 
                                  Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                  Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                  Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                  Valor__c, 
                                  Categoria__c, Concepto__c, 
                                  Especificacion__c, Extranjero__c, 
                                  Tipo_Transporte__c, Impuesto__c, 
                                  Porcentaje_Impuesto__c, Discapacidad__c, 
                                  Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                  Transportista__c, Edad_desde__c, 
                                  Edad_hasta__c, Tipo_de_Vehiculo__c                                  
                                  FROM Parametros_Tarifarios_Pasajeros__c
                                  WHERE Tipo_Transporte__c = 'Vehículo'
                                  AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                  OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                  AND (Nacional__c = true)
                                  AND Especificacion__c = 'Metro Lineal'
                                  AND Tipo_de_Vehiculo__c =: detalleReserva.Tipo_de_Vehiculo__c
                                  AND Residente__c =: detalleReserva.Residente__c
                                  AND Ruta_Comercial__c = true];
            }else{
                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                //es Extranjero
                listParametros = [SELECT Id, Name, 
                                  Contrato_Tarifa__c, Oferta__c, 
                                  Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                  Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                  Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                  Valor__c,  
                                  Categoria__c, Concepto__c, 
                                  Especificacion__c, Extranjero__c, 
                                  Tipo_Transporte__c, Impuesto__c, 
                                  Porcentaje_Impuesto__c, Discapacidad__c, 
                                  Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                  Transportista__c, Edad_desde__c, 
                                  Edad_hasta__c, Tipo_de_Vehiculo__c                              
                                  FROM Parametros_Tarifarios_Pasajeros__c
                                  WHERE Tipo_Transporte__c = 'Vehículo'
                                  AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                  OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                  AND (Extranjero__c = true)
                                  AND Especificacion__c = 'Metro Lineal'
                                  AND Tipo_de_Vehiculo__c =: detalleReserva.Tipo_de_Vehiculo__c
                                  AND Residente__c =: detalleReserva.Residente__c
                                  AND Ruta_Comercial__c = true];
            }
        }else{
            //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
            if(esNacional){
                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                //es Nacional
                listParametros = [SELECT Id, Name, 
                                  Contrato_Tarifa__c, Oferta__c, 
                                  Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                  Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                  Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                  Valor__c, 
                                  Categoria__c, Concepto__c, 
                                  Especificacion__c, Extranjero__c, 
                                  Tipo_Transporte__c, Impuesto__c, 
                                  Porcentaje_Impuesto__c, Discapacidad__c, 
                                  Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                  Transportista__c, Edad_desde__c, 
                                  Edad_hasta__c, Tipo_de_Vehiculo__c                                      
                                  FROM Parametros_Tarifarios_Pasajeros__c
                                  WHERE Tipo_Transporte__c = 'Vehículo'
                                  AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                  OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                  AND (Nacional__c = true)
                                  AND Especificacion__c = 'Metro Lineal'
                                  AND Residente__c =: detalleReserva.Residente__c
                                  AND Ruta_Subsidiada__c = true];
            }else{
                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                //es Extranjero
                listParametros = [SELECT Id, Name, 
                                  Contrato_Tarifa__c, Oferta__c, 
                                  Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                  Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                  Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                  Valor__c, 
                                  Categoria__c, Concepto__c, 
                                  Especificacion__c, Extranjero__c, 
                                  Tipo_Transporte__c, Impuesto__c, 
                                  Porcentaje_Impuesto__c, Discapacidad__c, 
                                  Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                  Transportista__c, Edad_desde__c, 
                                  Edad_hasta__c, Tipo_de_Vehiculo__c                                      
                                  FROM Parametros_Tarifarios_Pasajeros__c
                                  WHERE Tipo_Transporte__c = 'Vehículo'
                                  AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReserva.Reserva__r.Fecha_Viaje__c
                                  AND ((Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c)
                                  OR (Puerto_ORIGEN__c =: detalleReserva.Reserva__r.Puerto_DESTINO__c
                                  AND Puerto_DESTINO__c =: detalleReserva.Reserva__r.Puerto_ORIGEN__c))
                                  AND (Extranjero__c = true)
                                  AND Especificacion__c = 'Metro Lineal'
                                  AND Residente__c =: detalleReserva.Residente__c
                                  AND Ruta_Subsidiada__c = true];
            }
        }
        
        mapParametros.putAll(listParametros);
        return mapParametros;
    }

    //Devuelve MAP de posibles Parámetros de Tarificación de metros lineales según la configuración del registro de Detalle_Reserva__c y Reserva
    public Map<String, Parametros_Tarifarios_Pasajeros__c> getParametrosTarifaMetroLinealMap(List<Detalle_Reserva__c> detalleReservaLst, Map<String,Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleMap){
        List<Parametros_Tarifarios_Pasajeros__c> listParametros = new List<Parametros_Tarifarios_Pasajeros__c>();
        Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametros = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
        Map<String, Parametros_Tarifarios_Pasajeros__c> mapToReturnParametros = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
        Set<String> setIdsParametrosTarifa = new Set<String>();
        String tipoRegistro = '';
       // String categoria = '';
        String tipoItinerario = '';

        //Me traigo los posibles registros de Metros Lineales
        listParametros = [SELECT Id, Name, 
                          Contrato_Tarifa__c, Oferta__c, 
                          Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                          Ruta_Subsidiada__c, Ruta_Comercial__c, 
                          Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                          Valor__c, 
                          Categoria__c, Concepto__c, 
                          Especificacion__c, Extranjero__c, 
                          Tipo_Transporte__c, Impuesto__c, 
                          Porcentaje_Impuesto__c, Discapacidad__c, 
                          Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                          Transportista__c, Edad_desde__c, 
                          Edad_hasta__c, Tipo_de_Vehiculo__c                                      
                          FROM Parametros_Tarifarios_Pasajeros__c
                          WHERE Tipo_Transporte__c = 'Vehículo'
                          AND Especificacion__c = 'Metro Lineal'
                          AND Contrato_Tarifa__r.Vigencia_desde__c <=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                          AND Contrato_Tarifa__r.Vigencia_hasta__c >=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                          AND ((Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c
                          AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c)
                          OR (Puerto_ORIGEN__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c
                          AND Puerto_DESTINO__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c))];
        
        mapParametros.putAll(listParametros);
        if(tramoDetalleMap.size() > 0){
            for(Detalle_Reserva__c detalleReserva : detalleReservaLst){
                if(detalleReserva.RecordType.DeveloperName == 'Pista'){
                    System.debug('Buscando Tarifa para '+detalleReserva.Name);
                    tipoRegistro = '';
                    tipoItinerario = '';

                    //Asigno tipo de registro a Variable tipoRegistro
                    tipoRegistro = detalleReserva.RecordType.DeveloperName;

                    System.debug('Tipo Registro');
                    System.debug(tipoRegistro);
                    

                    //Realizo búsqueda de Tramo Detalle Reserva y así obtener el Tipo de Itinerario
                    Capacidad_Tramo_Detalle_Reserva__c tramoDetalle = new Capacidad_Tramo_Detalle_Reserva__c();
                    tramoDetalle = tramoDetalleMap.get(detalleReserva.Id);
                    tipoItinerario = tramoDetalle.Tipo_de_Itinerario__c;
                    System.debug(tramoDetalle);

                    //Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
                    Boolean esNacional = false;
                    //String  concepto = '';

                    System.debug('Tipo itinerario -> '+tipoItinerario);
                    
                    //Se considera Nacional cuando el registro de detalle Reserva es del tipo RUT
                    if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
                        esNacional = true;
                    }else{
                        System.debug('Consulto por Persona que entrega');
                        if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
                            esNacional = true;
                        }
                    }

                    for(Parametros_Tarifarios_Pasajeros__c parametroTarifa : listParametros){
                        //Búsqueda de Parámetros de Tarifa del tipo Comercial
                        if(tipoItinerario == 'COM'){
                            if(esNacional){
                                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                                //es Nacional
                                if(parametroTarifa.Nacional__c && parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c
                                && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Ruta_Comercial__c){
                                    setIdsParametrosTarifa.add(parametroTarifa.Id);
                                }
                            }else{
                                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                                //es Extranjero
                                if(parametroTarifa.Extranjero__c && parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c
                                && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Ruta_Comercial__c){
                                    setIdsParametrosTarifa.add(parametroTarifa.Id);
                                }
                            }
                        }else{
                            //Búsqueda de Parámetros de Tarifa del tipo Subsidiado
                            if(esNacional){
                                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                                //es Nacional
                                if(parametroTarifa.Nacional__c //&& parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c
                                && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Ruta_Subsidiada__c){
                                    setIdsParametrosTarifa.add(parametroTarifa.Id);
                                }   
                            }else{
                                //Búsqueda de Parámetros de Tarifa ML cuando el Detalle Reserva
                                //es Extranjero
                                if(parametroTarifa.Extranjero__c //&& parametroTarifa.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c
                                && parametroTarifa.Residente__c == detalleReserva.Residente__c && parametroTarifa.Ruta_Subsidiada__c){
                                    setIdsParametrosTarifa.add(parametroTarifa.Id);
                                }
                            }
                        }
                    }
                }
            }
        }

        if(setIdsParametrosTarifa.size() > 0){
            for(String idParametroTarifa : setIdsParametrosTarifa){
                mapToReturnParametros.put(idParametroTarifa, mapParametros.get(idParametroTarifa));
            }
        }
        
        return mapToReturnParametros;
    }

    //Actualiza datos del registro de Detalle_Reserva__c cuando se realiza el proceso de tarificar
    public void actualizarValorDetalleReserva(Detalle_Reserva__c detalleReservaActualizar){
        if(!Test.isRunningTest()){
            if(Schema.sObjectType.Detalle_Reserva__c.isUpdateable()){
                update detalleReservaActualizar;
            }  
        }
    }

    //Actualiza datos del registros de Detalle_Reserva__c cuando se realiza el proceso de tarificar
    public void actualizarValorDetalleReservaLst(Set<Detalle_Reserva__c> detalleReservaActualizarLst){
            System.debug('ACTUALIZAR REGISTROS SET');
            System.debug(detalleReservaActualizarLst);

            if(detalleReservaActualizarLst.size() > 0){
                List<Detalle_Reserva__c> detalleReservaActualizarLstToUpdate = new List<Detalle_Reserva__c>();
                for(Detalle_Reserva__c detRes : detalleReservaActualizarLst){
                    if(detalleReservaActualizarLstToUpdate.size() == 0){
                        detalleReservaActualizarLstToUpdate.add(detRes);
                    }else{
                        Integer repetido = 0;
                        for(Detalle_Reserva__c detResCheck : detalleReservaActualizarLstToUpdate){
                            if(detResCheck.Id == detRes.Id){
                                repetido = repetido+1;
                            }
                        }
                        if(repetido == 0){
                            detalleReservaActualizarLstToUpdate.add(detRes);
                        }
                    }
                }
                if(!Test.isRunningTest()){
                    
                    if(Schema.sObjectType.Detalle_Reserva__c.isUpdateable()){
                        update detalleReservaActualizarLstToUpdate;
                    } 
                }
            }
        //}
    }

    //Devuelve parámetro DR a utilizar en la tarificación del registro de Detalle_Reserva__c
    public Parametro_DR__c getRecargoDR(Integer diasAnticipacion, Decimal porcentajeUtilizacion, Date fechaViaje){
        try{
            System.debug('Dias Anticipacion = '+diasAnticipacion);
            System.debug('% Utilización = '+porcentajeUtilizacion);

            Parametro_DR__c listaDR = [SELECT Id, Name, 
                                       Porcentaje_DR__c, Anticipacion_desde__c, 
                                       Anticipacion_hasta__c, Utilizacion_desde__c,
                                       Utilizacion_hasta__c
                                       FROM Parametro_DR__c
                                       WHERE Anticipacion_hasta__c >= :diasAnticipacion
                                       AND Anticipacion_desde__c < :diasAnticipacion
                                       AND Utilizacion_hasta__c >= :porcentajeUtilizacion
                                       AND Utilizacion_desde__c < :porcentajeUtilizacion
                                       AND Nombre_Matriz_DR__r.Vigencia_desde__c <=: fechaViaje
                                       AND Nombre_Matriz_DR__r.Vigencia_hasta__c >=: fechaViaje];
            return listaDR;
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            System.debug(ex.getLineNumber());
            return null;
        }
    }

    //Devuelve MAP de parámetro DR a utilizar en la tarificación del registro de Detalle_Reserva__c
    public Map<String,Parametro_DR__c> getRecargoDRMap(List<Detalle_Reserva__c> detalleReservaLst){
        //try{
            String tipoRegistro = '';
            String categoria = '';
            Integer diasAnticipacion = 0;
            Map<String, Parametro_DR__c> parametroDrMap = new Map<String, Parametro_DR__c>();

            List<Parametro_DR__c> parametroDrLst = [SELECT Id, Name, 
                                                    Porcentaje_DR__c, Anticipacion_desde__c, 
                                                    Anticipacion_hasta__c, Utilizacion_desde__c,
                                                    Utilizacion_hasta__c, Nombre_Matriz_DR__r.Vigencia_desde__c,
                                                    Nombre_Matriz_DR__r.Vigencia_hasta__c
                                                    FROM Parametro_DR__c];
        
            for(Detalle_Reserva__c detalleReserva : detalleReservaLst){
                //Asigno tipo de registro a Variable tipoRegistro
                tipoRegistro = detalleReserva.RecordType.DeveloperName;
				categoria = detalleReserva.Categoria_de_Vehiculo__c;
                //Si tipo de Registro NO es Pallet NI Bicicletas
                //Consultar Si Itinerario Admite DR está en true
                //Ticket 21008 categoria , Conductor__c
                if(tipoRegistro != 'Pallet' && tipoRegistro != 'Bicicletas'){
                    if(categoria != 'Camion y Maquinaria'){                      
                          if(detalleReserva.Reserva__r.Itinerario_admite_DR__c){
                                diasAnticipacion = 0;
                                Date fechaComparar = Date.valueOf(detalleReserva.Reserva__r.Fecha_Viaje__c);
                                Date fechaReserva = Date.valueOf(detalleReserva.Reserva__r.Fecha_de_Reserva__c);
                            
                                //Calculo días de Anticipación en base a fecha de Reserva y fecha de Viaje
                                diasAnticipacion = fechaReserva.daysBetween(fechaComparar);
        
                                System.debug('Dias Anticipacion = '+diasAnticipacion);
                                System.debug('% Utilización = '+detalleReserva.Reserva__r.Ocupacion_porcentaje__c);
                    
                                for(Parametro_DR__c parametroDR : parametroDrLst){
                                    if(parametroDR.Anticipacion_hasta__c >= diasAnticipacion
                                       && parametroDR.Anticipacion_desde__c < diasAnticipacion
                                       && parametroDR.Utilizacion_hasta__c >= detalleReserva.Reserva__r.Ocupacion_porcentaje__c
                                       && parametroDR.Utilizacion_desde__c < detalleReserva.Reserva__r.Ocupacion_porcentaje__c
                                       && parametroDR.Nombre_Matriz_DR__r.Vigencia_desde__c <= Date.valueOf(detalleReserva.Reserva__r.Fecha_Viaje__c)
                                       && parametroDR.Nombre_Matriz_DR__r.Vigencia_hasta__c >= Date.valueOf(detalleReserva.Reserva__r.Fecha_Viaje__c)){
                                        parametroDrMap.put(detalleReserva.Id, parametroDR);
                                       }
                                }
                            }                        
                    }  

                }
            }
            return parametroDrMap;
        //}catch(Exception ex){
        //  System.debug(ex.getMessage());
        //  System.debug(ex.getStackTraceString());
        //  System.debug(ex.getLineNumber());
        //  return null;
        //}
    }


    //Devuelve parámetros de Tasa de Embarque para casos de Personas y Vehículos
    Public Parametro_Tasa_Embarque__c getTasaEmbarque(String puertoOrigen, Date fechaViaje, Detalle_Reserva__c detalleReserva, String tipoItinerario, String tipoRegistro){
        try{
            //Concepto Para Personas o Vehiculos
            Parametro_Tasa_Embarque__c tasaEmbarque = new Parametro_Tasa_Embarque__c();
            switch on tipoRegistro{
                when 'Butaca'{
                    if(tipoItinerario == 'COM'){
                        //Búsqueda de Tasas de Embarque para Rutas comerciales 
                        //para Personas (Butaca)
                        tasaEmbarque = [SELECT Id, Name, 
                                        Aplicar__c, Puerto__c, 
                                        Residente__c, Vigencia_desde__c, 
                                        Vigencia_hasta__c, Ruta_Comercial__c, 
                                        Ruta_Subvencionada__c, Impuesto__c, 
                                        Porcentaje_Impuesto__c, Vigencia__c,
                                        Valor__c 
                                        FROM Parametro_Tasa_Embarque__c 
                                        WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                        AND Residente__c =: detalleReserva.Residente__c
                                        AND Puerto__c =: puertoOrigen
                                        AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                        AND Vigencia_desde__c <=: fechaViaje
                                        AND Vigencia_hasta__c >=: fechaViaje
                                        AND Concepto__c = 'Tasa Pasajero'
                                        AND Ruta_Comercial__c = true];
                    }else{
                        //Búsqueda de Tasas de Embarque para Rutas subsidiadas 
                        //para Personas (Butaca)
                        tasaEmbarque = [SELECT Id, Name, 
                                        Aplicar__c, Puerto__c, 
                                        Residente__c, Vigencia_desde__c, 
                                        Vigencia_hasta__c, Ruta_Comercial__c, 
                                        Ruta_Subvencionada__c, Impuesto__c, 
                                        Porcentaje_Impuesto__c, Vigencia__c,
                                        Valor__c 
                                        FROM Parametro_Tasa_Embarque__c 
                                        WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                        AND Residente__c =: detalleReserva.Residente__c
                                        AND Puerto__c =: puertoOrigen
                                        AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                        AND Vigencia_desde__c <=: fechaViaje
                                        AND Vigencia_hasta__c >=: fechaViaje
                                        AND Concepto__c = 'Tasa Pasajero'
                                        AND Ruta_Subvencionada__c = true];
                    }
                }

                when 'Pista'{
                    //Primero se consulta si la reserva de vehículos tiene un conductor asignado
                    if(String.isNotBlank(detalleReserva.Pasajero_Conductor__c) && detalleReserva.Pasajero_Conductor__c != ''){
                        //La categoría de Vehículo debe ser "Vehículo Menor" o "Bus y Motorhome" o "Camion y Maquinaria"
                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                            if(tipoItinerario == 'COM'){
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Ruta_Comercial__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                        Aplicar__c, Puerto__c, 
                                                        Residente__c, Vigencia_desde__c, 
                                                        Vigencia_hasta__c, Ruta_Comercial__c, 
                                                        Ruta_Subvencionada__c, Impuesto__c, 
                                                        Porcentaje_Impuesto__c, Vigencia__c,
                                                        Valor__c
                                                        FROM Parametro_Tasa_Embarque__c 
                                                        WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                        AND Residente__c =: detalleReserva.Residente__c
                                                        AND Puerto__c =: puertoOrigen
                                                        AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                        AND Vigencia_desde__c <=: fechaViaje
                                                        AND Vigencia_hasta__c >=: fechaViaje
                                                        AND Concepto__c = 'Tasa hasta 12 ML'
                                                        AND Ruta_Comercial__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Ruta_Comercial__c = true];
                                    }
                                }else{
                                    System.debug('Consultar por aca');
                                    //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa Vehículos'
                                                    AND Ruta_Comercial__c = true];
                                }
                            }else{
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Ruta_Subvencionada__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa hasta 12 ML'
                                                    AND Ruta_Subvencionada__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Ruta_Subvencionada__c = true];
                                    }
                                }else{
                                    //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                Aplicar__c, Puerto__c, 
                                                Residente__c, Vigencia_desde__c, 
                                                Vigencia_hasta__c, Ruta_Comercial__c, 
                                                Ruta_Subvencionada__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Vigencia__c,
                                                Valor__c
                                                FROM Parametro_Tasa_Embarque__c 
                                                WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                AND Residente__c =: detalleReserva.Residente__c
                                                AND Puerto__c =: puertoOrigen
                                                AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                AND Vigencia_desde__c <=: fechaViaje
                                                AND Vigencia_hasta__c >=: fechaViaje
                                                AND Concepto__c = 'Tasa Vehículos'
                                                AND Ruta_Subvencionada__c = true];
                                }
                            }
                        }
                    }else{
                        //Se realizan búsquedas de Parametros de Tasas de embarque donde el vehículo NO posee conductor relacionado
                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                            if(tipoItinerario == 'COM'){
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Residente__c = false
                                                    AND Ruta_Comercial__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                        Aplicar__c, Puerto__c, 
                                                        Residente__c, Vigencia_desde__c, 
                                                        Vigencia_hasta__c, Ruta_Comercial__c, 
                                                        Ruta_Subvencionada__c, Impuesto__c, 
                                                        Porcentaje_Impuesto__c, Vigencia__c,
                                                        Valor__c
                                                        FROM Parametro_Tasa_Embarque__c 
                                                        WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                        AND Puerto__c =: puertoOrigen
                                                        AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                        AND Vigencia_desde__c <=: fechaViaje
                                                        AND Vigencia_hasta__c >=: fechaViaje
                                                        AND Concepto__c = 'Tasa hasta 12 ML'
                                                        AND Residente__c = false
                                                        AND Ruta_Comercial__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Residente__c = false
                                                    AND Ruta_Comercial__c = true];
                                    }
                                }else{
                                    System.debug('Consultar por aca');
                                    //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa Vehículos'
                                                    AND Residente__c = false
                                                    AND Ruta_Comercial__c = true];
                                }
                            }else{
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Residente__c = false
                                                    AND Ruta_Subvencionada__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa hasta 12 ML'
                                                    AND Residente__c = false
                                                    AND Ruta_Subvencionada__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Puerto__c =: puertoOrigen
                                                    AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Residente__c = false
                                                    AND Ruta_Subvencionada__c = true];
                                    }
                                }else{
                                    //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                Aplicar__c, Puerto__c, 
                                                Residente__c, Vigencia_desde__c, 
                                                Vigencia_hasta__c, Ruta_Comercial__c, 
                                                Ruta_Subvencionada__c, Impuesto__c, 
                                                Porcentaje_Impuesto__c, Vigencia__c,
                                                Valor__c
                                                FROM Parametro_Tasa_Embarque__c 
                                                WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                AND Puerto__c =: puertoOrigen
                                                AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                AND Vigencia_desde__c <=: fechaViaje
                                                AND Vigencia_hasta__c >=: fechaViaje
                                                AND Concepto__c = 'Tasa Vehículos'
                                                AND Residente__c = false
                                                AND Ruta_Subvencionada__c = true];
                                }
                            }
                        }
                    }
                }
            }
            System.debug('Tasa embarque ='+tasaEmbarque);
            return tasaEmbarque;
        }catch(Exception ex){
            //En caso de no encontrar registros retorno null
            return null;
        }
    }

    //Devuelve MAP parámetros de Tasa de Embarque para casos de Personas y Vehículos
    Public Map<String, Parametro_Tasa_Embarque__c> getTasaEmbarqueMap(List<Detalle_Reserva__c> detalleReservaLst, Map<String,Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleMap){
        List<Parametro_Tasa_Embarque__c> tasasEmbarquesLst = new List<Parametro_Tasa_Embarque__c>();
        Map<String, Parametro_Tasa_Embarque__c> mapToReturnParametros = new Map<String, Parametro_Tasa_Embarque__c>();
        String tipoRegistro = '';
        String tipoItinerario = '';

        tasasEmbarquesLst = [SELECT Id, Name, 
                             Aplicar__c, Puerto__c, 
                             Residente__c, Vigencia_desde__c, 
                             Vigencia_hasta__c, Ruta_Comercial__c, 
                             Ruta_Subvencionada__c, Impuesto__c, 
                             Porcentaje_Impuesto__c, Vigencia__c,
                             Valor__c, Concepto__c
                             FROM Parametro_Tasa_Embarque__c 
                             WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                             AND Puerto__c =: detalleReservaLst.get(0).Reserva__r.Puerto_ORIGEN__c
                             AND (Aplicar__c = 'Al Embarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                             AND Vigencia_desde__c <=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                             AND Vigencia_hasta__c >=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c];
        
        
            for(Detalle_Reserva__c detalleReserva : detalleReservaLst){
                System.debug('Buscando Tarifa para '+detalleReserva.Name);
                tipoRegistro = '';
                tipoItinerario = '';

                //Asigno tipo de registro a Variable tipoRegistro
                tipoRegistro = detalleReserva.RecordType.DeveloperName;

                System.debug('Tipo Registro');
                System.debug(tipoRegistro);

                Capacidad_Tramo_Detalle_Reserva__c tramoDetalle = new Capacidad_Tramo_Detalle_Reserva__c();
                if(tramoDetalleMap.size() > 0){
                    tramoDetalle = tramoDetalleMap.get(detalleReserva.Id);
                }
                System.debug(tramoDetalle);

                //Si Tipo de Registro es distinto a "Bicicletas"
                //Realizo búsqueda de Tramo Detalle Reserva y así obtener el Tipo de Itinerario
                //Caso contrario, lo obtengo del campo fórmula Tipo de Registro
                if(tipoRegistro != 'Bicicletas'){
                    tipoItinerario = tramoDetalle.Tipo_de_Itinerario__c;
                }else{
                    tipoItinerario = detalleReserva.Reserva__r.Itinerario_asociado__r.Tipo__c;
                }

                //Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
                Boolean esNacional = false;
                String  concepto = '';

                System.debug('Tipo itinerario -> '+tipoItinerario);
                for(Parametro_Tasa_Embarque__c tasaEmbarque : tasasEmbarquesLst){
                    //Switch para armar lógica de busqueda de tasas de embarque según concepto Para Personas o Vehiculos
                    switch on tipoRegistro{
                        when 'Butaca'{
                            if(tasaEmbarque.Concepto__c == 'Tasa Pasajero'){
                                if(tipoItinerario == 'COM'){
                                    //Búsqueda de Tasas de Embarque para Rutas comerciales 
                                    //para Personas (Butaca)
                                    if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Ruta_Comercial__c){
                                        mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                    }
                                }else{
                                    //Búsqueda de Tasas de Embarque para Rutas subsidiadas 
                                    //para Personas (Butaca)
                                    if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Ruta_Subvencionada__c){
                                        mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                    }
                                }
                            }
                        }

                        when 'Pista'{
                            //Primero se consulta si la reserva de vehículos tiene un conductor asignado
                            if(String.isNotBlank(detalleReserva.Pasajero_Conductor__c) && detalleReserva.Pasajero_Conductor__c != ''){
                                //La categoría de Vehículo debe ser "Vehículo Menor" o "Bus y Motorhome" o "Camion y Maquinaria"
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                                    if(tipoItinerario == 'COM'){
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa VM con Carro'
                                            && tasaEmbarque.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa hasta 12 ML'
                                                && tasaEmbarque.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa sobre 12 ML'
                                                && tasaEmbarque.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }
                                        }else{
                                            System.debug('Consultar por aca');
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Vehículos en general
                                            if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa Vehículos'
                                            && tasaEmbarque.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }
                                    }else{
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa VM con Carro'
                                            && tasaEmbarque.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa hasta 12 ML'
                                                && tasaEmbarque.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa sobre 12 ML'
                                                && tasaEmbarque.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }
                                        }else{
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Vehículos en general
                                            if(tasaEmbarque.Residente__c == detalleReserva.Residente__c && tasaEmbarque.Concepto__c == 'Tasa Vehículos'
                                            && tasaEmbarque.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }
                                    }
                                }
                            }else{
                                //Se realizan búsquedas de Parametros de Tasas de embarque donde el vehículo NO posee conductor relacionado
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                                    if(tipoItinerario == 'COM'){
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasaEmbarque.Concepto__c == 'Tasa VM con Carro' && !tasaEmbarque.Residente__c 
                                            && tasaEmbarque.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasaEmbarque.Concepto__c == 'Tasa hasta 12 ML' && !tasaEmbarque.Residente__c
                                                && tasaEmbarque.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasaEmbarque.Concepto__c == 'Tasa sobre 12 ML' && !tasaEmbarque.Residente__c
                                                && tasaEmbarque.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }
                                        }else{
                                            System.debug('Consultar por aca');
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Vehículos en general
                                            if(tasaEmbarque.Concepto__c == 'Tasa Vehículos' && !tasaEmbarque.Residente__c
                                            && tasaEmbarque.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }
                                    }else{
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasaEmbarque.Concepto__c == 'Tasa VM con Carro' && !tasaEmbarque.Residente__c
                                            && tasaEmbarque.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasaEmbarque.Concepto__c == 'Tasa hasta 12 ML' && !tasaEmbarque.Residente__c
                                                && tasaEmbarque.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasaEmbarque.Concepto__c == 'Tasa sobre 12 ML' && !tasaEmbarque.Residente__c
                                                && tasaEmbarque.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                                }
                                            }
                                        }else{
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Vehículos en general
                                            if(tasaEmbarque.Concepto__c == 'Tasa Vehículos' && !tasaEmbarque.Residente__c
                                            && tasaEmbarque.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasaEmbarque);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            
        }

        return mapToReturnParametros;
    }
    
    //Devuelve parámetros de Tasa de Desembarque para casos de Personas y Vehículos
    Public Parametro_Tasa_Embarque__c getTasaDesembarque(String puertoDestino, Date fechaViaje, Detalle_Reserva__c detalleReserva, String tipoItinerario, String tipoRegistro){
        try{
            //Concepto Para Personas o Vehiculos
            Parametro_Tasa_Embarque__c tasaEmbarque = new Parametro_Tasa_Embarque__c();
            switch on tipoRegistro{
                when 'Butaca'{
                    //Búsqueda de Tasas de Desembarque para Rutas comerciales 
                    //para Personas (Butaca)
                    if(tipoItinerario == 'COM'){
                        tasaEmbarque = [SELECT Id, Name, 
                                        Aplicar__c, Puerto__c, 
                                        Residente__c, Vigencia_desde__c, 
                                        Vigencia_hasta__c, Ruta_Comercial__c, 
                                        Ruta_Subvencionada__c, Impuesto__c, 
                                        Porcentaje_Impuesto__c, Vigencia__c,
                                        Valor__c 
                                        FROM Parametro_Tasa_Embarque__c 
                                        WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                        AND Residente__c =: detalleReserva.Residente__c
                                        AND Puerto__c =: puertoDestino
                                        AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                        AND Vigencia_desde__c <=: fechaViaje
                                        AND Vigencia_hasta__c >=: fechaViaje
                                        AND Concepto__c = 'Tasa Pasajero'
                                        AND Ruta_Comercial__c = true];
                    }else{
                        //Búsqueda de Tasas de Desembarque para Rutas subsidiadas 
                        //para Personas (Butaca)
                        tasaEmbarque = [SELECT Id, Name, 
                                        Aplicar__c, Puerto__c, 
                                        Residente__c, Vigencia_desde__c, 
                                        Vigencia_hasta__c, Ruta_Comercial__c, 
                                        Ruta_Subvencionada__c, Impuesto__c, 
                                        Porcentaje_Impuesto__c, Vigencia__c,
                                        Valor__c 
                                        FROM Parametro_Tasa_Embarque__c 
                                        WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                        AND Residente__c =: detalleReserva.Residente__c
                                        AND Puerto__c =: puertoDestino
                                        AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                        AND Vigencia_desde__c <=: fechaViaje
                                        AND Vigencia_hasta__c >=: fechaViaje
                                        AND Concepto__c = 'Tasa Pasajero'
                                        AND Ruta_Subvencionada__c = true];
                    }
                }

                when 'Pista'{
                    //Primero se consulta si la reserva de vehículos tiene un conductor asignado
                    if(String.isNotBlank(detalleReserva.Pasajero_Conductor__c) && detalleReserva.Pasajero_Conductor__c != ''){
                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                            //La categoría de Vehículo debe ser "Vehículo Menor" o "Bus y Motorhome" o "Camion y Maquinaria"
                            if(tipoItinerario == 'COM'){
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Ruta_Comercial__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa hasta 12 ML'
                                                    AND Ruta_Comercial__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Ruta_Comercial__c = true];
                                    }
                                }else{
                                    //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa Vehículos'
                                                    AND Ruta_Comercial__c = true];
                                }
                            }else{
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Desembarque para Rutas Subsidiadas 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Ruta_Subvencionada__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Desembarque para Rutas Subsidiadas 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa hasta 12 ML'
                                                    AND Ruta_Subvencionada__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Desembarque para Rutas Subsidiadas 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Ruta_Subvencionada__c = true];
                                    }
                                }else{
                                    //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: detalleReserva.Residente__c
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa Vehículos'
                                                    AND Ruta_Subvencionada__c = true];
                                }
                            }
                        }
                    }else{
                        //Se realizan búsquedas de Parametros de Tasas de embarque donde el vehículo NO posee conductor relacionado
                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                            if(tipoItinerario == 'COM'){
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Ruta_Comercial__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa hasta 12 ML'
                                                    AND Ruta_Comercial__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Ruta_Comercial__c = true];
                                    }
                                }else{
                                    //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa Vehículos'
                                                    AND Ruta_Comercial__c = true];
                                }
                            }else{
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                    //Búsqueda de Tasas de Desembarque para Rutas Subsidiadas 
                                    //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa VM con Carro'
                                                    AND Ruta_Subvencionada__c = true];
                                }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                    if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                        //Búsqueda de Tasas de Desembarque para Rutas Subsidiadas 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa hasta 12 ML'
                                                    AND Ruta_Subvencionada__c = true];
                                    }else{
                                        //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                        //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                        tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa sobre 12 ML'
                                                    AND Ruta_Subvencionada__c = true];
                                    }
                                }else{
                                    //Búsqueda de Tasas de Desembarque para Rutas Comerciales 
                                    //para Vehículos en general
                                    tasaEmbarque = [SELECT Id, Name, 
                                                    Aplicar__c, Puerto__c, 
                                                    Residente__c, Vigencia_desde__c, 
                                                    Vigencia_hasta__c, Ruta_Comercial__c, 
                                                    Ruta_Subvencionada__c, Impuesto__c, 
                                                    Porcentaje_Impuesto__c, Vigencia__c,
                                                    Valor__c
                                                    FROM Parametro_Tasa_Embarque__c 
                                                    WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                                    AND Residente__c =: false
                                                    AND Puerto__c =: puertoDestino
                                                    AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                                    AND Vigencia_desde__c <=: fechaViaje
                                                    AND Vigencia_hasta__c >=: fechaViaje
                                                    AND Concepto__c = 'Tasa Vehículos'
                                                    AND Ruta_Subvencionada__c = true];
                                }
                            }
                        }
                    }
                }
            }
            System.debug('Tasa desembarque ='+tasaEmbarque);
            return tasaEmbarque;
        }catch(Exception ex){
            //En caso de no encontrar registros retorno null
            return null;
        }
    }

    //Devuelve MAP parámetros de Tasa de Embarque para casos de Personas y Vehículos
    Public Map<String, Parametro_Tasa_Embarque__c> getTasaDesembarqueMap(List<Detalle_Reserva__c> detalleReservaLst, Map<String, Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleMap){
        List<Parametro_Tasa_Embarque__c> tasasDesembarquesLst = new List<Parametro_Tasa_Embarque__c>();
        Map<String, Parametro_Tasa_Embarque__c> mapToReturnParametros = new Map<String, Parametro_Tasa_Embarque__c>();
        String tipoRegistro = '';
        String tipoItinerario = '';

        tasasDesembarquesLst = [SELECT Id, Name, 
                                Aplicar__c, Puerto__c, 
                                Residente__c, Vigencia_desde__c, 
                                Vigencia_hasta__c, Ruta_Comercial__c, 
                                Ruta_Subvencionada__c, Impuesto__c, 
                                Porcentaje_Impuesto__c, Vigencia__c,
                                Valor__c, Concepto__c
                                FROM Parametro_Tasa_Embarque__c 
                                WHERE (Vigencia__c = 'Actual' OR Vigencia__c = 'Futura')
                                AND Puerto__c =: detalleReservaLst.get(0).Reserva__r.Puerto_DESTINO__c
                                AND (Aplicar__c = 'Al Desembarque' OR Aplicar__c = 'Al Embarque y Desembarque')
                                AND Vigencia_desde__c <=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c
                                AND Vigencia_hasta__c >=: detalleReservaLst.get(0).Reserva__r.Fecha_Viaje__c];
        
      
            for(Detalle_Reserva__c detalleReserva : detalleReservaLst){
                System.debug('Buscando Tarifa para '+detalleReserva.Name);
                tipoRegistro = '';
                tipoItinerario = '';

                //Asigno tipo de registro a Variable tipoRegistro
                tipoRegistro = detalleReserva.RecordType.DeveloperName;

                System.debug('Tipo Registro');
                System.debug(tipoRegistro);
                Capacidad_Tramo_Detalle_Reserva__c tramoDetalle = new Capacidad_Tramo_Detalle_Reserva__c();
                if(tramoDetalleMap.size() > 0){
                    tramoDetalle = tramoDetalleMap.get(detalleReserva.Id);
                }
                System.debug(tramoDetalle);

                //Si Tipo de Registro es distinto a "Bicicletas"
                //Realizo búsqueda de Tramo Detalle Reserva y así obtener el Tipo de Itinerario
                //Caso contrario, lo obtengo del campo fórmula Tipo de Registro
                if(tipoRegistro != 'Bicicletas'){
                    tipoItinerario = tramoDetalle.Tipo_de_Itinerario__c;
                }else{
                    tipoItinerario = detalleReserva.Reserva__r.Itinerario_asociado__r.Tipo__c;
                }

                //Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
                //Boolean esNacional = false;
                //String  concepto = '';

                System.debug('Tipo itinerario -> '+tipoItinerario);
                for(Parametro_Tasa_Embarque__c tasasDesembarques : tasasDesembarquesLst){
                    //Switch para armar lógica de busqueda de tasas de embarque según concepto Para Personas o Vehiculos
                    switch on tipoRegistro{
                        when 'Butaca'{
                            if(tasasDesembarques.Concepto__c == 'Tasa Pasajero'){
                                if(tipoItinerario == 'COM'){
                                    //Búsqueda de Tasas de Embarque para Rutas comerciales 
                                    //para Personas (Butaca)
                                    if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Ruta_Comercial__c){
                                        mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                    }
                                }else{
                                    //Búsqueda de Tasas de Embarque para Rutas subsidiadas 
                                    //para Personas (Butaca)
                                    if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Ruta_Subvencionada__c){
                                        mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                    }
                                }
                            }
                        }

                        when 'Pista'{
                            //Primero se consulta si la reserva de vehículos tiene un conductor asignado
                            if(String.isNotBlank(detalleReserva.Pasajero_Conductor__c) && detalleReserva.Pasajero_Conductor__c != ''){
                                //La categoría de Vehículo debe ser "Vehículo Menor" o "Bus y Motorhome" o "Camion y Maquinaria"
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                                    if(tipoItinerario == 'COM'){
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa VM con Carro'
                                            && tasasDesembarques.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa hasta 12 ML'
                                                && tasasDesembarques.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa sobre 12 ML'
                                                && tasasDesembarques.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }
                                        }else{
                                            System.debug('Consultar por aca');
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Vehículos en general
                                            if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa Vehículos'
                                            && tasasDesembarques.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }
                                    }else{
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa VM con Carro'
                                            && tasasDesembarques.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa hasta 12 ML'
                                                && tasasDesembarques.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa sobre 12 ML'
                                                && tasasDesembarques.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }
                                        }else{
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Vehículos en general
                                            if(tasasDesembarques.Residente__c == detalleReserva.Residente__c && tasasDesembarques.Concepto__c == 'Tasa Vehículos'
                                            && tasasDesembarques.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }
                                    }
                                }
                            }else{
                                //Se realizan búsquedas de Parametros de Tasas de embarque donde el vehículo NO posee conductor relacionado
                                if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' || detalleReserva.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReserva.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                                    if(tipoItinerario == 'COM'){
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasasDesembarques.Concepto__c == 'Tasa VM con Carro' && !tasasDesembarques.Residente__c 
                                            && tasasDesembarques.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasasDesembarques.Concepto__c == 'Tasa hasta 12 ML' && !tasasDesembarques.Residente__c
                                                && tasasDesembarques.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasasDesembarques.Concepto__c == 'Tasa sobre 12 ML' && !tasasDesembarques.Residente__c
                                                && tasasDesembarques.Ruta_Comercial__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }
                                        }else{
                                            System.debug('Consultar por aca');
                                            //Búsqueda de Tasas de Embarque para Rutas Comerciales 
                                            //para Vehículos en general
                                            if(tasasDesembarques.Concepto__c == 'Tasa Vehículos' && !tasasDesembarques.Residente__c
                                            && tasasDesembarques.Ruta_Comercial__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }
                                    }else{
                                        if(detalleReserva.Categoria_de_Vehiculo__c == 'Vehículo Menor' && detalleReserva.Carro_Arrastre__c){
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Categoría "Vehículo Menor" y tenga Carro de Arrastre
                                            if(tasasDesembarques.Concepto__c == 'Tasa VM con Carro' && !tasasDesembarques.Residente__c
                                            && tasasDesembarques.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }else if(detalleReserva.Categoria_de_Vehiculo__c != 'Vehículo Menor' && detalleReserva.Cantidad_de_Metros__c > 0){
                                            if(detalleReserva.Cantidad_de_Metros__c > 0 && detalleReserva.Cantidad_de_Metros__c <= 12){
                                                //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 0 y menor o igual a 12
                                                if(tasasDesembarques.Concepto__c == 'Tasa hasta 12 ML' && !tasasDesembarques.Residente__c
                                                && tasasDesembarques.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }else{
                                                //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                                //para Categoría DISTINTA a "Vehículo Menor" y Cantidad de Metros sea mayor a 12
                                                if(tasasDesembarques.Concepto__c == 'Tasa sobre 12 ML' && !tasasDesembarques.Residente__c
                                                && tasasDesembarques.Ruta_Subvencionada__c){
                                                    mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                                }
                                            }
                                        }else{
                                            //Búsqueda de Tasas de Embarque para Rutas Subsidiadas 
                                            //para Vehículos en general
                                            if(tasasDesembarques.Concepto__c == 'Tasa Vehículos' && !tasasDesembarques.Residente__c
                                            && tasasDesembarques.Ruta_Subvencionada__c){
                                                mapToReturnParametros.put(detalleReserva.Id, tasasDesembarques);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            
        }
        return mapToReturnParametros;
    }
    
    //Método que retorna map de puertos según el nombre
    public Map<String, String> getMapPuertos(){
        //Inicializo variable map para retornar puertos
        Map<String, String> mapPuertos = new Map<String, String>();
        //SOQL Query para retornar todos los registros de puertos
        List<Puerto__c> puertos = [SELECT Id, Name FROM Puerto__c];
        //Agrego puertos a MAP
        for(Puerto__c puerto : puertos){
            mapPuertos.put(puerto.Name, puerto.Id);
        }
        //Retorno a puertos
        return mapPuertos;
    }

    public Parametros_Tarifarios_Pasajeros__c getParametroTarifa(String idParametroTarifa){
        Parametros_Tarifarios_Pasajeros__c parametro = [SELECT Id, Name, 
                                                        Contrato_Tarifa__c, Oferta__c, 
                                                        Tipo_de_pasajero__c, Residente__c, Nacional__c, 
                                                        Ruta_Subsidiada__c, Ruta_Comercial__c, 
                                                        Vigencia_Oferta_desde__c, Vigencia_Oferta_hasta__c, 
                                                        Valor__c,  
                                                        Categoria__c, Concepto__c, 
                                                        Especificacion__c, Extranjero__c, 
                                                        Tipo_Transporte__c, Impuesto__c, 
                                                        Porcentaje_Impuesto__c, Discapacidad__c, 
                                                        Estudiante__c, Conductor__c, Acompanante__c, ida_Vuelta__c,
                                                        Transportista__c, Edad_desde__c, 
                                                        Edad_hasta__c, Contrato_Tarifa__r.Vigencia_desde__c,
                                                        Contrato_Tarifa__r.Vigencia_hasta__c,
                                                        Tipo_de_Vehiculo__c                                       
                                                        FROM Parametros_Tarifarios_Pasajeros__c
                                                        WHERE Id =: idParametroTarifa];
        return parametro;
    }
}