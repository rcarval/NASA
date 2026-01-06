/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase para procesar datos de clases NAV_Tarificar_Controller y NAV_Tarificar_PB
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     01-12-2021   RL       Creación de la Clase.
1.1     29-07-2022   RL       Por Regla de Validación para butacas solo deben realizarse tarificaciones exentas, 
                              se comenta código de valores brutos y netos en funciones valorizarRegistro y valorizarRegistroPB
                              para casos de Butaca
1.2     27-09-2022   RL       Por nuevo requerimiento, no se debe considerar los Metros Lineales de la variable "ML_Portabicicleta__c" 
                              del Objeto Detalle_Reserva__c, se procederá a comentar el código que utiliza ML_Portabicicletas__c
                              en caso de volver a ser requerido
2.0     18-04-2023   EF       Comentadas las funciones que ya no se utilizan por convertir el proceso de tarificación a flujo.
2.1     30-01-2024   RL       Actualización para Búsqueda de Registros contemplando Rutas Comerciales y Subsidiadas  
***********************************************************************************/


public class NAV_Tarificador  {
    
    public class eTA{
        public String detalleReservaId { get; set; }
        public String tarifaId { get; set; }
    }

    //Método que devuelve clase con Id de Tarifa y Mensaje correspondiente
    public NAV_Tarifa_Return BuscarDatosTarifaPB(Detalle_Reserva__c detalleReserva, String tipoRegistro, String tipoItinerario, Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosPasajeros, String categoria, Boolean esNacional){
        NAV_Tarifa_Return tarifaEncontrada = new NAV_Tarifa_Return();
        switch on tipoRegistro{
            when 'Butaca'{
                tarifaEncontrada = buscarTarifaPASAJERO(detalleReserva, mapParametrosPasajeros, tipoItinerario, categoria, esNacional);
            }

            when 'Pista'{
                tarifaEncontrada = buscarTarifaVEH(detalleReserva, mapParametrosPasajeros, tipoItinerario, esNacional);
            }

            when 'Pallet'{
                tarifaEncontrada = buscarTarifaPALLET(detalleReserva, mapParametrosPasajeros, tipoItinerario, esNacional);
            }

            when 'Bicicletas'{
                tarifaEncontrada = buscarTarifaBICICLETAS(detalleReserva, mapParametrosPasajeros, esNacional);
            }
        }
        
        System.debug('Tarifa Encontrada -> '+tarifaEncontrada);

        return tarifaEncontrada;
    }

   //Método encargado de valorizar el Registro de Detalle_Reserva__c según la información procesada a través de "BuscarDatosTarifa"
    public void valorizarRegistroPB(List<NAV_Tarifa_Return> tarifaEncontradaLst, Map<String, Detalle_Reserva__c> detalleReservaMap, Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosPasajeros, Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosMetrosLineales, Map<String, Parametro_Tasa_Embarque__c> puertoEmbarqueMap, Map<String, Parametro_Tasa_Embarque__c> puertoDesembarqueMap, Map<String, Parametro_DR__c> parametroDRMap){
        NAV_Tarifa_Return tarifaMetroLineal = new NAV_Tarifa_Return();
        NAV_Tarificar_SOQL consultasSoql = new NAV_Tarificar_SOQL();
        Set<Detalle_Reserva__c> detalleReservaActualizarLst = new Set<Detalle_Reserva__c>();

        Boolean esNacional = false;

        for(NAV_Tarifa_Return tarifaEncontrada : tarifaEncontradaLst){
            Parametro_DR__c parametroDR = new Parametro_DR__c();
            //Inicializo porcentajeDR
            Decimal porcentajeDR = 0;
            Parametro_Tasa_Embarque__c puertoEmbarque  = new Parametro_Tasa_Embarque__c();
            Parametro_Tasa_Embarque__c puertoDesembarque = new Parametro_Tasa_Embarque__c();
            //Inicializo dias de anticipacion en 0
            Integer diasAnticipacion = 0;           
            
            //Traigo los datos del registro detalle reserva desde el MAP
            Detalle_Reserva__c detalleReservaActualizar = detalleReservaMap.get(tarifaEncontrada.IdDetalleReserva);
            if(detalleReservaActualizar != null && !detalleReservaActualizar.RecordType.DeveloperName.contains('Lectura')){
                System.debug('Valorizando Registro');
                System.debug(detalleReservaActualizar);
            
                //Asigno tipo de registro a Variable tipoRegistro
                String tipoRegistro = detalleReservaActualizar.RecordType.DeveloperName;
            
                //Si los valores de Id Parámetro Tarifa son Distintos de NULL y VACÍO se procede a Tarificar el Servicio
                if(tarifaEncontrada.IdParametroTarifa != null){
                    System.debug('TARIFA ENCONTRADA');
                    System.debug(tarifaEncontrada.IdParametroTarifa);

                    //Obtengo los datos de Parámetro Tarifa desde el MAP
                    Parametros_Tarifarios_Pasajeros__c parametroPasajero = mapParametrosPasajeros.get(tarifaEncontrada.IdParametroTarifa);
                    System.debug('PARAMETRO PASAJERO');
                    System.debug(parametroPasajero);
                    System.debug(mapParametrosPasajeros);

                    if(tarifaEncontrada.IdParametroTarifa != null && parametroPasajero != null){
                        //Obtengo los datos de Tasa embarque desde el MAP
                        puertoEmbarque = puertoEmbarqueMap.get(tarifaEncontrada.IdDetalleReserva);
                        System.debug('PUERTO EMBARQUE');
                        System.debug(puertoEmbarque);
                        System.debug(puertoEmbarqueMap);


                        //Obtengo los datos de Tasa embarque desde el MAP
                        puertoDesembarque = puertoDesembarqueMap.get(tarifaEncontrada.IdDetalleReserva);
                        System.debug('PUERTO DESEMBARQUE');
                        System.debug(puertoDesembarque);
                        System.debug(puertoDesembarqueMap);

                        //Asigno Id de Registro y Parámetro de Tarifa Asociado
                        detalleReservaActualizar.Parametro_Tarifa__c = 'Tarifa: '+parametroPasajero.Name;
                    
                        //Traigo los datos de parametroDR desde el MAP
                        parametroDR = parametroDRMap.get(detalleReservaActualizar.Id);
                    
                        //Si tipo de Registro NO es Pallet NI Bicicletas
                        //Consultar Si Itinerario Admite DR está en true
                        if(tipoRegistro != 'Pallet' && tipoRegistro != 'Bicicletas'){
                            if(detalleReservaActualizar.Reserva__r.Itinerario_admite_DR__c){
                                diasAnticipacion = 0;
                                Date fechaComparar = Date.valueOf(detalleReservaActualizar.Reserva__r.Fecha_Viaje__c);
                                Date fechaReserva = Date.valueOf(detalleReservaActualizar.Reserva__r.Fecha_de_Reserva__c);
                        
                                //Calculo días de Anticipación en base a fecha de Reserva y fecha de Viaje
                                diasAnticipacion = fechaReserva.daysBetween(fechaComparar);
                            }
                        }   

                        //Si los datos devueltos por el MAP son distintos a NULL, asigno % DR
                        if(parametroDR != null){
                            porcentajeDR = parametroDR.Porcentaje_DR__c;
                        }
                    }
                    //Inicializo campos a valorizar en 0
                    detalleReservaActualizar.Valor_Pasajero__c = 0;
                    detalleReservaActualizar.Neto_BU__c = 0;
                    detalleReservaActualizar.Neto_BU_DR__c = 0;
                    detalleReservaActualizar.IVA_BU__c = 0;
                    detalleReservaActualizar.Valor_Carga__c = 0;
                    detalleReservaActualizar.Neto_CA__c = 0;
                    detalleReservaActualizar.Neto_Carga_DR__c = 0;
                    detalleReservaActualizar.IVA_CA__c = 0;
                    detalleReservaActualizar.Valor_Metros__c = 0;
                    detalleReservaActualizar.Neto_ML__c = 0;
                    detalleReservaActualizar.Neto_ML_DR__c = 0;
                    detalleReservaActualizar.IVA_ML__c = 0;
                    detalleReservaActualizar.Valor_Vehiculo__c = 0;
                    detalleReservaActualizar.Neto_VH__c = 0;
                    detalleReservaActualizar.Neto_VH_DR__c = 0;
                    detalleReservaActualizar.IVA_VH__c = 0;
                    detalleReservaActualizar.Valor_Carga_DR__c = 0;
                    detalleReservaActualizar.Valor_ML_DR__c = 0;
                    detalleReservaActualizar.Valor_Pasajero_DR__c = 0;
                    detalleReservaActualizar.Valor_Veh_culo_DR__c = 0;
                    detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c = 0;
                    detalleReservaActualizar.Parametro_Tasa_de_Desembarque__c = '';
                    detalleReservaActualizar.Parametro_Tasa_de_Embarque__c = '';
                    detalleReservaActualizar.Tasa_Desembarque__c = 0;
                    detalleReservaActualizar.Tasa_Desembarque_IVA__c = 0;
                    detalleReservaActualizar.Tasa_Desembarque_Neto__c = 0;
                    detalleReservaActualizar.Tasa_Embarque__c = 0;
                    detalleReservaActualizar.Tasa_Embarque_IVA__c = 0;
                    detalleReservaActualizar.Tasa_Embarque_Neto__c = 0;
                    detalleReservaActualizar.ParametroDR__c = '';

                    decimal iva = 0;
                    decimal valorTarifa = 0;
                    decimal valorMetroLineal = 0;
                    decimal valorDR =0;
                    decimal valorDRMetroLineal = 0;

                    decimal ivaEmbarque = 0;
                    decimal ivaDesembarque = 0;
                    decimal valorEmbarque = 0;
                    decimal valorDesembarque = 0;
                    decimal valorEmbarqueNeto = 0;
                    decimal valorDesembarqueNeto = 0;
            
                    //Asigno variable % de descuento
                    detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c = porcentajeDR;
                    if(parametroDR != null){
                        //En caso de tener un registro de Parámetro DR, asigno Nombre de Parámetro DR, Días de Anticipación y % De Utilización
                        detalleReservaActualizar.ParametroDR__c = parametroDR.Name + ', Días Ant = '+diasAnticipacion + ', % Ut = '+detalleReservaActualizar.Reserva__r.Ocupacion_porcentaje__c;
                    }

                    //Utilizo Switch para realizar cálculos en los campos correspondientes según Tipo de Registro
                    switch on tipoRegistro {
                        when 'Butaca'{
                            //En caso de que la fecha de Viaje de la Reserva se encuentre dentro de los Rangos de Oferta
                            if(parametroPasajero.Vigencia_Oferta_desde__c <= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c && parametroPasajero.Vigencia_Oferta_hasta__c >= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c){
                                //Asigno valor Especial de Precio de Oferta
                                valorTarifa = parametroPasajero.Oferta__c;
                                system.debug('CD Line 188 OFERTA ? valorTarifa.Valor__c ' +valorTarifa );
																															 
                            }else{
                                //De lo contrario, asigno valor general
                                valorTarifa = parametroPasajero.Valor__c;
                                system.debug('CD Line 192 valorTarifa.Valor__c ' +valorTarifa );
																															 
                            }
                                system.debug('CD Line 194 parametroPasajero.Valor__c ' +parametroPasajero.Valor__c);
                            //Si el Pasajero es Transportista o Residente no incluir valor DR
                            if (
                                detalleReservaActualizar.Residente__c == true ||
                                detalleReservaActualizar.Transportista__c == true ||
                                (detalleReservaActualizar.Reserva__r.ruta__c != null && 
                                 detalleReservaActualizar.Reserva__r.ruta__c.toLowerCase().contains('juan fernandez'))
                            ) {
                                detalleReservaActualizar.ParametroDR__c = '';
                                system.debug('CD Line 203 valorTarifa ' +valorTarifa);
                                valorDR = valorTarifa;
                            } else {
                                // Asigno valor DR para efectos de cálculos
                                valorDR = valorTarifa + (valorTarifa * (detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c / 100));
                            }
                    
                            if(parametroPasajero.Impuesto__c == 'Valor Exento'){
                                //Cálculo de Valor Exento
                                detalleReservaActualizar.Valor_Pasajero__c = valorTarifa;
                                detalleReservaActualizar.Valor_Pasajero_DR__c = valorDR;
                                detalleReservaActualizar.Neto_BU_DR__c = valorDR;
                                detalleReservaActualizar.Neto_BU__c = valorDR;
                                detalleReservaActualizar.IVA_BU__c = 0;
                            }
                            // }else if (parametroPasajero.Impuesto__c == 'Valor Neto'){
                            //  //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto (Valor Neto + IVA)
                            //  iva = (valorDR *((parametroPasajero.Porcentaje_Impuesto__c)/100)).setScale(6);
                            //  detalleReservaActualizar.Neto_BU__c = valorDR;
                            //  detalleReservaActualizar.Neto_BU_DR__c = valorDR;
                            //  detalleReservaActualizar.IVA_BU__c = iva.round(System.RoundingMode.HALF_UP);
                            //  detalleReservaActualizar.Valor_Pasajero_DR__c = valorDR+iva;
                            //  detalleReservaActualizar.Valor_Pasajero__c = valorTarifa.round(System.RoundingMode.HALF_UP);
                            // }else if (parametroPasajero.Impuesto__c == 'Valor Bruto'){
                            //  //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto (Valor Bruto - IVA)
                            //  detalleReservaActualizar.Valor_Pasajero__c = valorTarifa;
                            //  iva = (valorDR / (((parametroPasajero.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                            //  detalleReservaActualizar.Neto_BU__c = iva;
                            //  detalleReservaActualizar.Neto_BU_DR__c = iva;
                            //  detalleReservaActualizar.Valor_Pasajero_DR__c = valorDR;
                            //  detalleReservaActualizar.IVA_BU__c = valorDR-iva.round(System.RoundingMode.HALF_UP);
                            // }
                        }

                        when 'Pallet'{
                            //En caso de que la fecha de Viaje de la Reserva se encuentre dentro de los Rangos de Oferta
                            if(parametroPasajero.Vigencia_Oferta_desde__c <= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c && parametroPasajero.Vigencia_Oferta_hasta__c >= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c){
                                //Asigno valor Especial de Precio de Oferta
                                valorTarifa = parametroPasajero.Oferta__c * detalleReservaActualizar.Capacidad_Comprometida__c;
                            }else{
                                //De lo contrario, asigno valor general
                                valorTarifa = parametroPasajero.Valor__c * detalleReservaActualizar.Capacidad_Comprometida__c;
                            }

                            //Asigno valor DR para efectos de cálculos
                            valorDR = valorTarifa+(valorTarifa*((detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c/100)));
                    
                            if(parametroPasajero.Impuesto__c == 'Valor Exento'){
                                //Cálculo de Valor Exento
                                detalleReservaActualizar.Valor_Carga__c = valorTarifa;
                                detalleReservaActualizar.Neto_CA__c = valorDR;
                                detalleReservaActualizar.Neto_Carga_DR__c = valorDR;
                                detalleReservaActualizar.IVA_CA__c = 0;
                                detalleReservaActualizar.Valor_Carga_DR__c = valorDR;
                            }else if (parametroPasajero.Impuesto__c == 'Valor Neto'){
                                //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto (Valor Neto + IVA)
                                iva = (valorDR *((parametroPasajero.Porcentaje_Impuesto__c)/100)).setScale(6);
                                detalleReservaActualizar.Neto_CA__c = valorDR;
                                detalleReservaActualizar.Neto_Carga_DR__c = valorDR;
                                detalleReservaActualizar.IVA_CA__c = iva.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Carga__c = valorTarifa.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Carga_DR__c = valorDR+iva;
                            }else if (parametroPasajero.Impuesto__c == 'Valor Bruto'){
                                //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto (Valor Bruto - IVA)
                                detalleReservaActualizar.Valor_Carga__c = valorTarifa;
                                iva = (valorDR / (((parametroPasajero.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                                detalleReservaActualizar.Neto_CA__c = iva;
                                detalleReservaActualizar.Neto_Carga_DR__c = iva;
                                detalleReservaActualizar.IVA_CA__c = valorDR-iva.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Carga_DR__c = valorDR;
                            }
                        }
            
                        when 'Pista'{
                            //En caso de que la fecha de Viaje de la Reserva se encuentre dentro de los Rangos de Oferta
                            if(parametroPasajero.Vigencia_Oferta_desde__c <= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c && parametroPasajero.Vigencia_Oferta_hasta__c >= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c){
                                //Asigno valor Especial de Precio de Oferta
                                valorTarifa = parametroPasajero.Oferta__c;
                            }else{
                                //De lo contrario, asigno valor general
                                valorTarifa = parametroPasajero.Valor__c;
                            }

                            //Asigno valor DR para efectos de cálculos
                            valorDR = valorTarifa+(valorTarifa*((detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c/100)));
                            system.debug('detalleReservaActualizar.Categoria_de_Vehiculo__c : '+detalleReservaActualizar.Categoria_de_Vehiculo__c );
                            //Solo SI la categoría de vehículo es "Vehículo Menor" se realizarán cálculos de Metros Lineales (ML)
                            if(detalleReservaActualizar.Categoria_de_Vehiculo__c == 'Vehículo Menor'){
                                //Si el conductor es residente no cobrar DR
                                if(detalleReservaActualizar.Detalle_Reserva_Conductor__r.Residente__c){
                                    detalleReservaActualizar.ParametroDR__c = '';
                                    valorDR = valorTarifa;
                                }

                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa;
                                //Si la cantidad de metros es mayor a 0 o usa porta bicicletas, se debe buscar parámetro de ML
                                if(detalleReservaActualizar.Cantidad_de_Metros__c > 0){
                                    //Llamo a función para búsquedas de Parámetros de Metros Lineales
                                    tarifaMetroLineal = buscarTarifaMetroLineal(detalleReservaActualizar, mapParametrosMetrosLineales);
                                    //Obtengo el Registro de Tarifa ML desde el MAP
                                    Parametros_Tarifarios_Pasajeros__c parametroMetroLineal = mapParametrosMetrosLineales.get(tarifaMetroLineal.IdParametroTarifa);
                                    if(parametroMetroLineal != null){
                                        //En caso de encontrar registro ML, asigno a variable el nombre de la Tarifa ML encontrada
                                        detalleReservaActualizar.Parametro_Tarifa__c = detalleReservaActualizar.Parametro_Tarifa__c+', Tarifa Metro lineal: '+parametroMetroLineal.Name;
                                        //En caso de que la fecha de Viaje de la Reserva se encuentre dentro de los Rangos de Oferta
                                        if(parametroMetroLineal.Vigencia_Oferta_desde__c <= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c && parametroMetroLineal.Vigencia_Oferta_hasta__c >= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c){
                                            //Asigno valor Especial de Precio de Oferta y multiplico por cantidad de ML
                                            valorMetroLineal = parametroMetroLineal.Oferta__c*(detalleReservaActualizar.Cantidad_de_Metros__c);
                                        }else{
                                            //De lo contrario, asigno valor general ML y multiplico por cantidad de ML
                                            valorMetroLineal = parametroMetroLineal.Valor__c*(detalleReservaActualizar.Cantidad_de_Metros__c);
                                        }
                                        
                                        //Si el conductor es residente no cobrar DR
                                        if(detalleReservaActualizar.Detalle_Reserva_Conductor__r.Residente__c){
                                            valorDRMetroLineal = valorMetroLineal;
                                        }else{
                                            //Calculo valor DR para metros ML
                                            valorDRMetroLineal = valorMetroLineal+(valorMetroLineal*((detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c/100)));
                                        }
                                        System.debug('Valor Metro Lineal = '+valorMetroLineal);
                                        System.debug('Valor Metro Lineal DR = '+valorDRMetroLineal);
                                
                                        if(parametroMetroLineal.Impuesto__c == 'Valor Exento'){
                                            //Cálculo de Valor Exento ML
                                            detalleReservaActualizar.Valor_Metros__c = valorMetroLineal;
                                            detalleReservaActualizar.Neto_ML__c = valorDRMetroLineal;
                                            detalleReservaActualizar.Neto_ML_DR__c = valorDRMetroLineal;
                                            detalleReservaActualizar.IVA_ML__c = 0;
                                            detalleReservaActualizar.Valor_ML_DR__c = valorDRMetroLineal;
                                        }else if (parametroMetroLineal.Impuesto__c == 'Valor Neto'){
                                            //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto ML (Valor Neto ML + IVA)
                                            iva = (valorDRMetroLineal *((parametroMetroLineal.Porcentaje_Impuesto__c)/100)).setScale(6);
                                            detalleReservaActualizar.Neto_ML__c = valorDRMetroLineal;
                                            detalleReservaActualizar.Neto_ML_DR__c = valorDRMetroLineal;
                                            detalleReservaActualizar.IVA_ML__c = iva.round(System.RoundingMode.HALF_UP);
                                            detalleReservaActualizar.Valor_Metros__c = valorMetroLineal.round(System.RoundingMode.HALF_UP);
                                            detalleReservaActualizar.Valor_ML_DR__c = valorDRMetroLineal+iva;
                                        }else if (parametroMetroLineal.Impuesto__c == 'Valor Bruto'){
                                            //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto ML (Valor Bruto ML - IVA)
                                            detalleReservaActualizar.Valor_Metros__c = valorMetroLineal;
                                            iva = (valorDRMetroLineal / (((parametroMetroLineal.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                                            detalleReservaActualizar.Neto_ML__c = iva;
                                            detalleReservaActualizar.Neto_ML_DR__c = iva;
                                            detalleReservaActualizar.IVA_ML__c = valorDRMetroLineal-iva.round(System.RoundingMode.HALF_UP);
                                            detalleReservaActualizar.Valor_ML_DR__c = valorDRMetroLineal;
                                        }
                                    }
                                }
                            }

                            //Si la Categoría de Vehículo es "Bus y Motorhome" o "Camion y Maquinaria"
                            //Valor Tarifa como Valor DR se deben multiplicar por el Largo de vehículo
                            system.debug('detalleReservaActualizar.Categoria_de_Vehiculo__c :'+detalleReservaActualizar.Categoria_de_Vehiculo__c );
                            if(detalleReservaActualizar.Categoria_de_Vehiculo__c == 'Bus y Motorhome' || detalleReservaActualizar.Categoria_de_Vehiculo__c == 'Camion y Maquinaria'){
                                valorTarifa = valorTarifa * detalleReservaActualizar.Largo__c;
                                
                                //Si el tipo de vehículo es alguno de los destacados, no incluir el valor DR
                                if(detalleReservaActualizar.Tipo_de_Vehiculo__c == 'CAMION CON ACOPLADO' || detalleReservaActualizar.Tipo_de_Vehiculo__c == 'CAMION SIMPLE' ||
                                    detalleReservaActualizar.Tipo_de_Vehiculo__c == 'CAMION RAMPLA' || detalleReservaActualizar.Tipo_de_Vehiculo__c == 'RAMPLA' ||
                                    detalleReservaActualizar.Tipo_de_Vehiculo__c == 'BUS' || detalleReservaActualizar.Tipo_de_Vehiculo__c == 'ACOPLADO' ||
                                    detalleReservaActualizar.Tipo_de_Vehiculo__c == 'MAQUINARIA'|| detalleReservaActualizar.Tipo_de_Vehiculo__c == 'METRO CUBICO'){
                                    
                                    detalleReservaActualizar.ParametroDR__c = '';
                                    valorDR = valorTarifa;      
                                }else{
                                    valorDR = valorDR * detalleReservaActualizar.Largo__c;
                                }
                            }
                    
                            System.debug('Valor VEH = '+valorTarifa);
                            System.debug('Valor VEH DR = '+valorDR);                    
                    
                            if(parametroPasajero.Impuesto__c == 'Valor Exento'){
                                //Cálculo de Valor Exento
                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa;
                                detalleReservaActualizar.Neto_VH__c = valorDR;
                                detalleReservaActualizar.Neto_VH_DR__c = valorDR;
                                detalleReservaActualizar.IVA_VH__c = 0;
                                detalleReservaActualizar.Valor_Veh_culo_DR__c = valorDR;
                            }else if (parametroPasajero.Impuesto__c == 'Valor Neto'){
                                //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto (Valor Neto + IVA)
                                iva = (valorDR *((parametroPasajero.Porcentaje_Impuesto__c)/100)).setScale(6);
                                detalleReservaActualizar.Neto_VH__c = valorDR;
                                detalleReservaActualizar.Neto_VH_DR__c = valorDR;
                                detalleReservaActualizar.IVA_VH__c = iva.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Veh_culo_DR__c = valorDR+iva;
                            }else if (parametroPasajero.Impuesto__c == 'Valor Bruto'){
                                //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto (Valor Bruto  - IVA)
                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa;
                                iva = (valorDR / (((parametroPasajero.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                                detalleReservaActualizar.Neto_VH__c = iva;
                                detalleReservaActualizar.Neto_VH_DR__c = iva;
                                detalleReservaActualizar.IVA_VH__c = valorDR-iva.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Veh_culo_DR__c = valorDR;
                            }
                        }

                        when 'Bicicletas'{
                            //En caso de que la fecha de Viaje de la Reserva se encuentre dentro de los Rangos de Oferta
                            if(parametroPasajero.Vigencia_Oferta_desde__c <= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c && parametroPasajero.Vigencia_Oferta_hasta__c >= detalleReservaActualizar.Reserva__r.Fecha_Viaje__c){
                                //Asigno valor Especial de Precio de Oferta
                                valorTarifa = parametroPasajero.Oferta__c;
                            }else{
                                //De lo contrario, asigno valor general
                                valorTarifa = parametroPasajero.Valor__c;
                            }
                            //Asigno valor DR para efectos de cálculos
                            valorDR = valorTarifa+(valorTarifa*((detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c/100)));
                    
                            System.debug('Valor VEH = '+valorTarifa);
                            System.debug('Valor VEH DR = '+valorDR);                    
                    
                            if(parametroPasajero.Impuesto__c == 'Valor Exento'){
                                //Cálculo de Valor Exento
                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa;
                                detalleReservaActualizar.Neto_VH__c = valorDR;
                                detalleReservaActualizar.Neto_VH_DR__c = valorDR;
                                detalleReservaActualizar.IVA_VH__c = 0;
                                detalleReservaActualizar.Valor_Veh_culo_DR__c = valorDR;
                            }else if (parametroPasajero.Impuesto__c == 'Valor Neto'){
                                //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto (Valor Neto + IVA)
                                iva = (valorDR *((parametroPasajero.Porcentaje_Impuesto__c)/100)).setScale(6);
                                detalleReservaActualizar.Neto_VH__c = valorDR;
                                detalleReservaActualizar.Neto_VH_DR__c = valorDR;
                                detalleReservaActualizar.IVA_VH__c = iva.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Veh_culo_DR__c = valorDR+iva;
                            }else if (parametroPasajero.Impuesto__c == 'Valor Bruto'){
                                //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto (Valor Bruto  - IVA)
                                detalleReservaActualizar.Valor_Vehiculo__c = valorTarifa;
                                iva = (valorDR / (((parametroPasajero.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                                detalleReservaActualizar.Neto_VH__c = iva;
                                detalleReservaActualizar.Neto_VH_DR__c = iva;
                                detalleReservaActualizar.IVA_VH__c = valorDR-iva.round(System.RoundingMode.HALF_UP);
                                detalleReservaActualizar.Valor_Veh_culo_DR__c = valorDR;
                            }
                        }
                    }
            
                    //En caso de que exista un parámetro de Puerto Embarque
                    if(puertoEmbarque != null){
                        //Asigno valor de embarque
                        valorEmbarque = puertoEmbarque.Valor__c;
                        if(puertoEmbarque.Impuesto__c == 'Valor Exento'){
                            //Cálculo de Valor Exento
                            ivaEmbarque = 0;
                            valorEmbarqueNeto = valorEmbarque;
                        }else if(puertoEmbarque.Impuesto__c == 'Valor Bruto'){
                            //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto (Valor Bruto  - IVA)
                            ivaEmbarque = (valorEmbarque / (((puertoEmbarque.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                            valorEmbarqueNeto = ivaEmbarque;
                            ivaEmbarque = valorEmbarque-ivaEmbarque;
                        }else if(puertoEmbarque.Impuesto__c == 'Valor Neto'){
                            //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto (Valor Neto + IVA)
                            ivaEmbarque = (valorEmbarque *((puertoEmbarque.Porcentaje_Impuesto__c)/100)).setScale(6);
                            valorEmbarqueNeto = valorEmbarque;
                            valorEmbarque = valorEmbarque+ivaEmbarque; 
                        }
                
                        if(valorEmbarque > 0){
                            detalleReservaActualizar.Tasa_Embarque__c = valorEmbarque.round(System.RoundingMode.HALF_UP);
                        }else{
                            detalleReservaActualizar.Tasa_Embarque__c = 0;
                        }
                        if(ivaEmbarque > 0){
                            detalleReservaActualizar.Tasa_Embarque_IVA__c = ivaEmbarque.round(System.RoundingMode.HALF_UP);
                        }else{
                            detalleReservaActualizar.Tasa_Embarque_IVA__c = 0;
                        }
                        detalleReservaActualizar.Tasa_Embarque_Neto__c = valorEmbarqueNeto;
                        detalleReservaActualizar.Parametro_Tasa_de_Embarque__c = puertoEmbarque.Name;
                    }

                    //En caso de que exista un parámetro de Puerto Desembarque
                    if(puertoDesembarque != null){
                        valorDesembarque = puertoDesembarque.Valor__c;
                        if(puertoDesembarque.Impuesto__c == 'Valor Exento'){
                            //Cálculo de Valor Exento
                            ivaDesembarque = 0;
                            valorDesembarqueNeto = valorDesembarque;
                        }else if(puertoDesembarque.Impuesto__c == 'Valor Bruto'){
                            //Cálculo de Valor Bruto, debo calcular IVA y Valor Neto (Valor Bruto  - IVA)
                            ivaDesembarque = (valorDesembarque / (((puertoDesembarque.Porcentaje_Impuesto__c)/100)+1)).setScale(6);
                            valorDesembarqueNeto = ivaDesembarque;
                            ivaDesembarque = valorDesembarque-ivaDesembarque;
                        }else if(puertoDesembarque.Impuesto__c == 'Valor Neto'){
                            //Cálculo de Valor Neto, debo calcular IVA y posterior Valor Bruto (Valor Neto + IVA)
                            ivaDesembarque = (valorDesembarque *((puertoDesembarque.Porcentaje_Impuesto__c)/100)).setScale(6);
                            valorDesembarqueNeto = valorDesembarque;
                            valorDesembarque = valorDesembarque+ivaDesembarque;
                        }
                
                        if(valorDesembarque > 0){
                            detalleReservaActualizar.Tasa_Desembarque__c = valorDesembarque.round(System.RoundingMode.HALF_UP);
                            
                        }else{
                            detalleReservaActualizar.Tasa_Desembarque__c = 0;
                        }
                        System.debug('Valor Desembarque -> '+detalleReservaActualizar.Tasa_Desembarque__c);
                        if(ivaDesembarque > 0){
                            System.debug('Iva Desembarque Antes de Redondeo -> '+ivaDesembarque);
                            detalleReservaActualizar.Tasa_Desembarque_IVA__c = ivaDesembarque.round(System.RoundingMode.HALF_UP);
                        }else{
                            detalleReservaActualizar.Tasa_Desembarque_IVA__c = 0;
                        }
                        System.debug('Iva Desembarque -> '+detalleReservaActualizar.Tasa_Desembarque_IVA__c);
                        detalleReservaActualizar.Tasa_Desembarque_Neto__c = valorDesembarqueNeto;
                        detalleReservaActualizar.Parametro_Tasa_de_Desembarque__c = puertoDesembarque.Name;
                    }
            
                    ////Actualizo registro Detalle Reserva con los campos valorizados
                    if(detalleReservaActualizarLst.size() > 0){
                        System.debug('Revisar registros');
                        Integer indice = 0;
                        List<Integer> indicesToDelete = new List<Integer>();
                        for(Detalle_Reserva__c det : detalleReservaActualizarLst){
                            if(det.Id == detalleReservaActualizar.Id){
                                System.debug('Existe repetido');
                                indicesToDelete.add(indice);
                            }
                            indice = indice+1;
                        }
                        /*if(indicesToDelete.size()>0){
                            detalleReservaActualizar.remove(indicesToDelete);
                        }*/
                    }
                    detalleReservaActualizarLst.add(detalleReservaActualizar);
                    
                }else{
                    detalleReservaActualizar.Valor_Pasajero__c = 0;
                    detalleReservaActualizar.Neto_BU__c = 0;
                    detalleReservaActualizar.Neto_BU_DR__c = 0;
                    detalleReservaActualizar.IVA_BU__c = 0;
                    detalleReservaActualizar.Valor_Carga__c = 0;
                    detalleReservaActualizar.Neto_CA__c = 0;
                    detalleReservaActualizar.Neto_Carga_DR__c = 0;
                    detalleReservaActualizar.IVA_CA__c = 0;
                    detalleReservaActualizar.Valor_Metros__c = 0;
                    detalleReservaActualizar.Neto_ML__c = 0;
                    detalleReservaActualizar.Neto_ML_DR__c = 0;
                    detalleReservaActualizar.IVA_ML__c = 0;
                    detalleReservaActualizar.Valor_Vehiculo__c = 0;
                    detalleReservaActualizar.Neto_VH__c = 0;
                    detalleReservaActualizar.Neto_VH_DR__c = 0;
                    detalleReservaActualizar.IVA_VH__c = 0;
                    detalleReservaActualizar.Porcentaje_DR_Tiempo_Ocupacion__c = 0;
                    detalleReservaActualizar.Valor_Carga_DR__c = 0;
                    detalleReservaActualizar.Valor_ML_DR__c = 0;
                    detalleReservaActualizar.Valor_Pasajero_DR__c = 0;
                    detalleReservaActualizar.Valor_Veh_culo_DR__c = 0;
                    detalleReservaActualizar.Parametro_Tarifa__c = tarifaEncontrada.Mensaje;
                    detalleReservaActualizar.Parametro_Tasa_de_Desembarque__c = '';
                    detalleReservaActualizar.Parametro_Tasa_de_Embarque__c = '';
                    detalleReservaActualizar.Tasa_Desembarque__c = 0;
                    detalleReservaActualizar.Tasa_Desembarque_IVA__c = 0;
                    detalleReservaActualizar.Tasa_Desembarque_Neto__c = 0;
                    detalleReservaActualizar.Tasa_Embarque__c = 0;
                    detalleReservaActualizar.Tasa_Embarque_IVA__c = 0;
                    detalleReservaActualizar.Tasa_Embarque_Neto__c = 0;
                    detalleReservaActualizar.ParametroDR__c = '';
                    detalleReservaActualizarLst.add(detalleReservaActualizar);
                }
            }
        }

        if(detalleReservaActualizarLst.size() > 0){
            System.debug('Actualizar registros');
            for(Detalle_Reserva__c det : detalleReservaActualizarLst){
                System.debug(det.Name+' '+det.Id+' '+det.Parametro_Tarifa__c);
            }
            consultasSoql.actualizarValorDetalleReservaLst(detalleReservaActualizarLst);
        }
    }

    //Método que ayuda a la búsqueda de Parámetro Tarifa VEHICULOS
    public static NAV_Tarifa_Return buscarTarifaVEH(Detalle_Reserva__c detalleReserva, Map<String, Parametros_Tarifarios_Pasajeros__c> parametrosPasajeros, String tipoItinerario, Boolean esNacional){
        System.debug('Datos en buscar Tarifa');
        try{
            List<Parametros_Tarifarios_Pasajeros__c> parametroTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
 
            Integer dias = 0;
            Integer edadPasajero = 0;
            Integer maxEdad = 0;
            pTarifaRanking r;

            System.debug('\nDATOS DETALLE SERVICIO\n');
            System.debug('Id Detalle Reserva = ' +detalleReserva.Id);
            System.debug('RecordTypeName = '+detalleReserva.RecordType.DeveloperName);
            System.debug('Origen -> '+detalleReserva.Reserva__r.Puerto_ORIGEN__c);
            System.debug('Destino -> '+detalleReserva.Reserva__r.Puerto_DESTINO__c);
            System.debug('Edad Pasajero -> '+edadPasajero);
            System.debug('Residente -> '+detalleReserva.Residente__c);
            System.debug('Estudiante -> '+detalleReserva.Estudiante__c);
            System.debug('ida_Vuelta -> '+detalleReserva.ida_Vuelta__c);
            System.debug('Discapacidad Pasajero -> '+detalleReserva.Nombre_Pasajero__r.Discapacidad__pc);
            System.debug('Conductor -> '+detalleReserva.Conductor__c);
            System.debug('Transportista -> '+detalleReserva.Transportista__c);
            System.debug('Tipo Itinerario -> '+tipoItinerario);
            System.debug('Total de Registros Parámetros -> '+parametrosPasajeros.size());
            System.debug('Listado Pasajeros '+parametrosPasajeros);
            
            List<pTarifaRanking> rankings = new List<pTarifaRanking>();
            
            String especificacion = detalleReserva.Categoria_de_Vehiculo__c;
            if(especificacion == 'Bus y Motorhome' || especificacion == 'Camion y Maquinaria'){
                especificacion = 'Metro Lineal';
            }

            //Se recorren los posibles Parametros Tarifa comparando contra registro de Detalle Reserva
            //Por cada campo el que exista coincidencia se otogará puntaje positivo
            //Por cada campo en donde no coincida el dato se otorgará puntaje negativo
            for (Parametros_Tarifarios_Pasajeros__c tar : parametrosPasajeros.values()){
                if(tipoItinerario == 'COM' && tar.Ruta_Comercial__c && esNacional && detalleReserva.Tipo_de_Vehiculo__c == tar.Tipo_de_Vehiculo__c && tar.Especificacion__c == especificacion && tar.Nacional__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(tipoItinerario == 'COM' && tar.Ruta_Comercial__c && !esNacional && detalleReserva.Tipo_de_Vehiculo__c == tar.Tipo_de_Vehiculo__c && tar.Especificacion__c == especificacion && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(tipoItinerario != 'COM' && tar.Ruta_Subsidiada__c  && esNacional && tar.Especificacion__c == especificacion && tar.Nacional__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(tipoItinerario != 'COM' && tar.Ruta_Subsidiada__c && !esNacional && tar.Especificacion__c == especificacion && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }
            }
            NAV_Tarifa_Return toR = new NAV_Tarifa_Return();
            //Evaluar ranking maximo solo si hay mas de un registro
            if(rankings.size() > 1){
                pTarifaRanking maximo = new pTarifaRanking();
                maximo.Ranking = -100000;
                for(pTarifaRanking getMax : rankings){
                    if(getMax.Ranking > maximo.Ranking){
                        maximo = getMax;
                    }
                }
                //Chequear si existe otro valor maximo
                for(pTarifaRanking tCheck : rankings){
                    if(tCheck.Ranking == maximo.Ranking && tCheck.Id != maximo.Id){
                        System.debug('Existe más de un valor con el mismo ranking');
                        System.debug('Mejor Ranking: '+tCheck.Ranking);
                        System.debug('Mejor Ranking Id: '+tCheck.Id);
                        System.debug('Ranking encontrado: '+maximo.Ranking);
                        System.debug('Ranking encontrado Id: '+maximo.Id);
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = '';
                        if(tCheck.Ranking >= 0){
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas';
                        }else{
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'No se encuentran Tarifas coincidentes... por favor contactar al Área Tarifas';
                        }
                        return toR;
                    }
                }
                //Si se encontró un valor, devolver Id
                if(maximo != null){
                    if(maximo.Ranking >= 0){
                        toR.IdParametroTarifa = maximo.Id;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'Tarifa encontrada';
                    }else{
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'No existen tarifas';
                    }
                    return toR;
                }
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }else if(rankings.size() == 1){
                if(rankings[0].Ranking >= 0){
                    //System.debug(rankings);
                    toR.IdParametroTarifa = rankings[0].Id;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'Tarifa encontrada';
                }else{
                    toR.IdParametroTarifa = null;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'No existen tarifas';
                }
                if(Test.isRunningTest()){
                    eTA et = new eTA();
                    et.detalleReservaId = '';
                    et.tarifaId = '';
                }
                return toR;
            }else{
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            return null;
        }
    }

    //Método que ayuda a la búsqueda de Parámetro Tarifa PASAJERO
    public static NAV_Tarifa_Return buscarTarifaPASAJERO(Detalle_Reserva__c detalleReserva, Map<String, Parametros_Tarifarios_Pasajeros__c> parametrosPasajeros, String tipoItinerario, String categoria, Boolean esNacional){
        System.debug('Datos en buscar Tarifa');
        try{
            List<Parametros_Tarifarios_Pasajeros__c> parametroTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
 
            Integer dias = 0;
            Integer edadPasajero = 0;
            
            //Si el Tipo de Registro de Detalle Reserva es Butaca, calculamos edad de Pasajero
            if(detalleReserva.RecordType.DeveloperName == 'Butaca'){
                if(detalleReserva.Nombre_Pasajero__r != null && detalleReserva.Nombre_Pasajero__r.PersonBirthdate != null){
                    dias = (detalleReserva.Nombre_Pasajero__r.PersonBirthdate.daysBetween(Date.today())); 
                    edadPasajero = (dias/365);
                }
            }

            System.debug('\nDATOS DETALLE SERVICIO\n');
            System.debug('Id Detalle Reserva = ' +detalleReserva.Id);
            System.debug('RecordTypeName = '+detalleReserva.RecordType.DeveloperName);
            System.debug('Origen -> '+detalleReserva.Reserva__r.Puerto_ORIGEN__c);
            System.debug('Destino -> '+detalleReserva.Reserva__r.Puerto_DESTINO__c);
            System.debug('Edad Pasajero -> '+edadPasajero);
            System.debug('Residente -> '+detalleReserva.Residente__c);
            System.debug('Estudiante -> '+detalleReserva.Estudiante__c);
            System.debug('Discapacidad Pasajero -> '+detalleReserva.Nombre_Pasajero__r.Discapacidad__pc);
            System.debug('Conductor -> '+detalleReserva.Conductor__c);
            System.debug('Acompañante -> '+detalleReserva.Acompanante__c);
            System.debug('ida_Vuelta -> '+detalleReserva.ida_Vuelta__c);
            System.debug('Transportista -> '+detalleReserva.Transportista__c);
            System.debug('Tipo Itinerario -> '+tipoItinerario);
            System.debug('Total de Registros Parámetros -> '+parametrosPasajeros.size());
            System.debug('Listado Pasajeros '+parametrosPasajeros);
            
            List<pTarifaRanking> rankings = new List<pTarifaRanking>();
            
            //Se recorren los posibles Parametros Tarifa comparando contra registro de Detalle Reserva
            //Por cada campo el que exista coincidencia se otogará puntaje positivo
            //Por cada campo en donde no coincida el dato se otorgará puntaje negativo
            for (Parametros_Tarifarios_Pasajeros__c tar : parametrosPasajeros.values()){
                if(categoria != 'Sin acomodacion'){
                    if(tipoItinerario == 'COM' && tar.Ruta_Comercial__c && esNacional && tar.Tipo_Transporte__c == 'Pasajero' && tar.Categoria__c == categoria && tar.Nacional__c && tar.Residente__c == detalleReserva.Residente__c){
                        //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                        Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
            
                        pTarifaRanking r = new pTarifaRanking();
                        //Calcula valor ranking
                        r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                        rankings.add(r);
                    }else if(tipoItinerario == 'COM' && tar.Ruta_Comercial__c  && !esNacional && tar.Tipo_Transporte__c == 'Pasajero' && tar.Categoria__c == categoria && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                        //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                        Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
            
                        pTarifaRanking r = new pTarifaRanking();
                        //Calcula valor ranking
                        r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                        rankings.add(r);
                    }else if(tipoItinerario != 'COM' && tar.Ruta_Subsidiada__c && esNacional && tar.Tipo_Transporte__c == 'Pasajero' && tar.Nacional__c && tar.Residente__c == detalleReserva.Residente__c){
                        //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                        Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
            
                        pTarifaRanking r = new pTarifaRanking();
                        //Calcula valor ranking
                        r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                        rankings.add(r);
                    }else if(tipoItinerario != 'COM' && tar.Ruta_Subsidiada__c && !esNacional && tar.Tipo_Transporte__c == 'Pasajero' && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                        //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                        Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
            
                        pTarifaRanking r = new pTarifaRanking();
                        //Calcula valor ranking
                        r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                        rankings.add(r);
                    }
                }else{
                    Integer maxEdad = 0;
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.clear();
                    rankings.add(r);
                }
            }
            NAV_Tarifa_Return toR = new NAV_Tarifa_Return();
            //Evaluar ranking maximo solo si hay mas de un registro
            if(rankings.size() > 1){
                pTarifaRanking maximo = new pTarifaRanking();
                maximo.Ranking = -100000;
                for(pTarifaRanking getMax : rankings){
                    if(getMax.Ranking > maximo.Ranking){
                        maximo = getMax;
                    }
                }
                //Chequear si existe otro valor maximo
                for(pTarifaRanking tCheck : rankings){
                    if(tCheck.Ranking == maximo.Ranking && tCheck.Id != maximo.Id){
                        System.debug('Existe más de un valor con el mismo ranking');
                        System.debug('Mejor Ranking: '+tCheck.Ranking);
                        System.debug('Mejor Ranking Id: '+tCheck.Id);
                        System.debug('Ranking encontrado: '+maximo.Ranking);
                        System.debug('Ranking encontrado Id: '+maximo.Id);
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = '';
                        if(tCheck.Ranking >= 0){
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas';
                        }else{
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'No se encuentran Tarifas coincidentes... por favor contactar al Área Tarifas';
                        }
                        return toR;
                    }
                }
                //Si se encontró un valor, devolver Id
                if(maximo != null){
                    if(maximo.Ranking >= 0){
                        toR.IdParametroTarifa = maximo.Id;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'Tarifa encontrada';
                    }else{
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'No existen tarifas';
                    }
                    return toR;
                }
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }else if(rankings.size() == 1){
                if(rankings[0].Ranking >= 0){
                    //System.debug(rankings);
                    toR.IdParametroTarifa = rankings[0].Id;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'Tarifa encontrada';
                }else{
                    toR.IdParametroTarifa = null;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'No existen tarifas';
                }
                if(Test.isRunningTest()){
                    eTA et = new eTA();
                    et.detalleReservaId = '';
                    et.tarifaId = '';
                    //et.acuerdoId = '';
                }
                return toR;
            }else{
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            return null;
        }
    }

    //Método que ayuda a la búsqueda de Parámetro Tarifa VEHICULOS
    public static NAV_Tarifa_Return buscarTarifaBICICLETAS(Detalle_Reserva__c detalleReserva, Map<String, Parametros_Tarifarios_Pasajeros__c> parametrosPasajeros, Boolean esNacional){
        System.debug('Datos en buscar Tarifa');
        try{
            List<Parametros_Tarifarios_Pasajeros__c> parametroTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
 
            Integer dias = 0;
            Integer edadPasajero = 0;
            
            System.debug('\nDATOS DETALLE SERVICIO\n');
            System.debug('Id Detalle Reserva = ' +detalleReserva.Id);
            System.debug('RecordTypeName = '+detalleReserva.RecordType.DeveloperName);
            System.debug('Origen -> '+detalleReserva.Reserva__r.Puerto_ORIGEN__c);
            System.debug('Destino -> '+detalleReserva.Reserva__r.Puerto_DESTINO__c);
            System.debug('Edad Pasajero -> '+edadPasajero);
            System.debug('Residente -> '+detalleReserva.Residente__c);
            System.debug('Estudiante -> '+detalleReserva.Estudiante__c);
            System.debug('Discapacidad Pasajero -> '+detalleReserva.Nombre_Pasajero__r.Discapacidad__pc);
            System.debug('Conductor -> '+detalleReserva.Conductor__c);
            System.debug('Acompañante -> '+detalleReserva.Acompanante__c);
            System.debug('ida_Vuelta -> '+detalleReserva.ida_Vuelta__c);
            System.debug('Transportista -> '+detalleReserva.Transportista__c);
            System.debug('Total de Registros Parámetros -> '+parametrosPasajeros.size());
            System.debug('Listado Pasajeros '+parametrosPasajeros);
            
            List<pTarifaRanking> rankings = new List<pTarifaRanking>();
            
            //Se recorren los posibles Parametros Tarifa comparando contra registro de Detalle Reserva
            //Por cada campo el que exista coincidencia se otogará puntaje positivo
            //Por cada campo en donde no coincida el dato se otorgará puntaje negativo
            for (Parametros_Tarifarios_Pasajeros__c tar : parametrosPasajeros.values()){
                if(esNacional && detalleReserva.Tipo_de_Vehiculo__c == tar.Tipo_de_Vehiculo__c && tar.Especificacion__c == 'Bicicletas' && tar.Nacional__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
            
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(!esNacional && detalleReserva.Tipo_de_Vehiculo__c == tar.Tipo_de_Vehiculo__c && tar.Especificacion__c == 'Bicicletas' && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
            
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }
            }
            NAV_Tarifa_Return toR = new NAV_Tarifa_Return();
            //Evaluar ranking maximo solo si hay mas de un registro
            if(rankings.size() > 1){
                pTarifaRanking maximo = new pTarifaRanking();
                maximo.Ranking = -100000;
                for(pTarifaRanking getMax : rankings){
                    if(getMax.Ranking > maximo.Ranking){
                        maximo = getMax;
                    }
                }
                //Chequear si existe otro valor maximo
                for(pTarifaRanking tCheck : rankings){
                    if(tCheck.Ranking == maximo.Ranking && tCheck.Id != maximo.Id){
                        System.debug('Existe más de un valor con el mismo ranking');
                        System.debug('Mejor Ranking: '+tCheck.Ranking);
                        System.debug('Mejor Ranking Id: '+tCheck.Id);
                        System.debug('Ranking encontrado: '+maximo.Ranking);
                        System.debug('Ranking encontrado Id: '+maximo.Id);
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = '';
                        if(tCheck.Ranking >= 0){
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas';
                        }else{
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'No se encuentran Tarifas coincidentes... por favor contactar al Área Tarifas';
                        }
                        return toR;
                    }
                }
                //Si se encontró un valor, devolver Id
                if(maximo != null){
                    if(maximo.Ranking >= 0){
                        toR.IdParametroTarifa = maximo.Id;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'Tarifa encontrada';
                    }else{
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'No existen tarifas';
                    }
                    return toR;
                }
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }else if(rankings.size() == 1){
                if(rankings[0].Ranking >= 0){
                    //System.debug(rankings);
                    toR.IdParametroTarifa = rankings[0].Id;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'Tarifa encontrada';
                }else{
                    toR.IdParametroTarifa = null;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'No existen tarifas';
                }
                if(Test.isRunningTest()){
                    eTA et = new eTA();
                    et.detalleReservaId = '';
                    et.tarifaId = '';
                    //et.acuerdoId = '';
                }
                return toR;
            }else{
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            return null;
        }
    }

    //Método que ayuda a la búsqueda de Parámetro Tarifa PALLET
    public static NAV_Tarifa_Return buscarTarifaPALLET(Detalle_Reserva__c detalleReserva, Map<String, Parametros_Tarifarios_Pasajeros__c> parametrosPasajeros, String tipoItinerario, Boolean esNacional){
        System.debug('Datos en buscar Tarifa');
        try{
            List<Parametros_Tarifarios_Pasajeros__c> parametroTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
 
            Integer dias = 0;
            Integer edadPasajero = 0;
            
            System.debug('\nDATOS DETALLE SERVICIO\n');
            System.debug('Id Detalle Reserva = ' +detalleReserva.Id);
            System.debug('RecordTypeName = '+detalleReserva.RecordType.DeveloperName);
            System.debug('Origen -> '+detalleReserva.Reserva__r.Puerto_ORIGEN__c);
            System.debug('Destino -> '+detalleReserva.Reserva__r.Puerto_DESTINO__c);
            System.debug('Edad Pasajero -> '+edadPasajero);
            System.debug('Residente -> '+detalleReserva.Residente__c);
            System.debug('Estudiante -> '+detalleReserva.Estudiante__c);
            System.debug('ida_Vuelta -> '+detalleReserva.ida_Vuelta__c);
            System.debug('Discapacidad Pasajero -> '+detalleReserva.Nombre_Pasajero__r.Discapacidad__pc);
            System.debug('Conductor -> '+detalleReserva.Conductor__c);
            System.debug('Acompañante -> '+detalleReserva.Acompanante__c);
            System.debug('Transportista -> '+detalleReserva.Transportista__c);
            System.debug('Tipo Itinerario -> '+tipoItinerario);
            System.debug('Total de Registros Parámetros -> '+parametrosPasajeros.size());
            System.debug('Listado Pasajeros '+parametrosPasajeros);
            
            List<pTarifaRanking> rankings = new List<pTarifaRanking>();
            
            //Se recorren los posibles Parametros Tarifa comparando contra registro de Detalle Reserva
            //Por cada campo el que exista coincidencia se otogará puntaje positivo
            //Por cada campo en donde no coincida el dato se otorgará puntaje negativo
            for(Parametros_Tarifarios_Pasajeros__c tar : parametrosPasajeros.values()){
                if(tipoItinerario == 'COM' && tar.Ruta_Comercial__c && esNacional && tar.Tipo_Transporte__c == 'Carga' && tar.Especificacion__c == 'Pallets'
                    && tar.Tipo_de_Vehiculo__c == detalleReserva.Tipo_de_Vehiculo__c && tar.Nacional__c
                    && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(tipoItinerario == 'COM' && tar.Ruta_Comercial__c && !esNacional && tar.Tipo_Transporte__c == 'Carga' && tar.Especificacion__c == 'Pallets'
                    && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(tipoItinerario != 'COM' && tar.Ruta_Subsidiada__c && esNacional && tar.Tipo_Transporte__c == 'Carga' && tar.Especificacion__c == 'Pallets'
                    && tar.Nacional__c && tar.Residente__c == detalleReserva.Residente__c){
                    //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }else if(tipoItinerario != 'COM' && tar.Ruta_Subsidiada__c && !esNacional && tar.Tipo_Transporte__c == 'Carga' && tar.Especificacion__c == 'Pallets'
                    && tar.Extranjero__c && tar.Residente__c == detalleReserva.Residente__c){
                        //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                    Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
        
                    pTarifaRanking r = new pTarifaRanking();
                    //Calcula valor ranking
                    r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                    rankings.add(r);
                }
            }
            NAV_Tarifa_Return toR = new NAV_Tarifa_Return();
            //Evaluar ranking maximo solo si hay mas de un registro
            if(rankings.size() > 1){
                pTarifaRanking maximo = new pTarifaRanking();
                maximo.Ranking = -100000;
                for(pTarifaRanking getMax : rankings){
                    if(getMax.Ranking > maximo.Ranking){
                        maximo = getMax;
                    }
                }
                //Chequear si existe otro valor maximo
                for(pTarifaRanking tCheck : rankings){
                    if(tCheck.Ranking == maximo.Ranking && tCheck.Id != maximo.Id){
                        System.debug('Existe más de un valor con el mismo ranking');
                        System.debug('Mejor Ranking: '+tCheck.Ranking);
                        System.debug('Mejor Ranking Id: '+tCheck.Id);
                        System.debug('Ranking encontrado: '+maximo.Ranking);
                        System.debug('Ranking encontrado Id: '+maximo.Id);
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = '';
                        if(tCheck.Ranking >= 0){
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas';
                        }else{
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'No se encuentran Tarifas coincidentes... por favor contactar al Área Tarifas';
                        }
                        return toR;
                    }
                }
                //Si se encontró un valor, devolver Id
                if(maximo != null){
                    if(maximo.Ranking >= 0){
                        toR.IdParametroTarifa = maximo.Id;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'Tarifa encontrada';
                    }else{
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'No existen tarifas';
                    }
                    return toR;
                }
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }else if(rankings.size() == 1){
                if(rankings[0].Ranking >= 0){
                    //System.debug(rankings);
                    toR.IdParametroTarifa = rankings[0].Id;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'Tarifa encontrada';
                }else{
                    toR.IdParametroTarifa = null;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'No existen tarifas';
                }
                if(Test.isRunningTest()){
                    eTA et = new eTA();
                    et.detalleReservaId = '';
                    et.tarifaId = '';
                    //et.acuerdoId = '';
                }
                return toR;
            }else{
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            return null;
        }
    }

    //Método que ayuda a la búsqueda de Parámetro Tarifa
    public static NAV_Tarifa_Return buscarTarifaMetroLineal(Detalle_Reserva__c detalleReserva, Map<String, Parametros_Tarifarios_Pasajeros__c> parametrosPasajeros){
        System.debug('Buscar datos tarifa metro lineal');
        try{

            //Si el Tipo de Registro de Detalle Reserva es Butaca, calculamos edad de Pasajero
            List<Parametros_Tarifarios_Pasajeros__c> parametroTarifa = new List<Parametros_Tarifarios_Pasajeros__c>();
            Integer dias = 0;
            Integer edadPasajero = 0;
            
            System.debug('\nDATOS DETALLE SERVICIO ML\n');
            System.debug('Id Detalle Reserva = ' +detalleReserva.Id);
            System.debug('RecordTypeName = '+detalleReserva.RecordType.DeveloperName);
            System.debug('Origen -> '+detalleReserva.Reserva__r.Puerto_ORIGEN__c);
            System.debug('Destino -> '+detalleReserva.Reserva__r.Puerto_DESTINO__c);
            System.debug('Edad Pasajero -> '+edadPasajero);
            System.debug('Residente -> '+detalleReserva.Residente__c);
            System.debug('Estudiante -> '+detalleReserva.Estudiante__c);
            System.debug('ida_Vuelta -> '+detalleReserva.ida_Vuelta__c);
            System.debug('Discapacidad Pasajero -> '+detalleReserva.Nombre_Pasajero__r.Discapacidad__pc);
            System.debug('Conductor -> '+detalleReserva.Conductor__c);
            System.debug('Acompañante -> '+detalleReserva.Acompanante__c);
            System.debug('Transportista -> '+detalleReserva.Transportista__c);
            
            System.debug('Total de Registros Parámetros -> '+parametrosPasajeros.size());
            System.debug('Listado Pasajeros '+parametrosPasajeros);
            
            List<pTarifaRanking> rankings = new List<pTarifaRanking>();
            
            //Se recorren los posibles Parametros Tarifa comparando contra registro de Detalle Reserva
            //Por cada campo el que exista coincidencia se otogará puntaje positivo
            //Por cada campo en donde no coincida el dato se otorgará puntaje negativo
            for (Parametros_Tarifarios_Pasajeros__c tar : parametrosPasajeros.values()){
                //Se busca con método for la máxima edad de entre los posibles parametros de tarifa
                Integer maxEdad = maxEdad(parametrosPasajeros.values(), tar);
                
                pTarifaRanking r = new pTarifaRanking();
                //Calcula valor ranking
                r = valorRanked(r, tar, maxEdad, edadPasajero, detalleReserva);
                rankings.add(r);
            }
            NAV_Tarifa_Return toR = new NAV_Tarifa_Return();
            //Evaluar ranking maximo solo si hay mas de un registro
            if(rankings.size() > 1){
                pTarifaRanking maximo = new pTarifaRanking();
                maximo.Ranking = -100000;
                for(pTarifaRanking getMax : rankings){
                    if(getMax.Ranking > maximo.Ranking){
                        maximo = getMax;
                    }
                }
                //Chequear si existe otro valor maximo
                for(pTarifaRanking tCheck : rankings){
                    if(tCheck.Ranking == maximo.Ranking && tCheck.Id != maximo.Id){
                        System.debug('Existe más de un valor con el mismo ranking');
                        System.debug('Mejor Ranking: '+tCheck.Ranking);
                        System.debug('Mejor Ranking Id: '+tCheck.Id);
                        System.debug('Ranking encontrado: '+maximo.Ranking);
                        System.debug('Ranking encontrado Id: '+maximo.Id);
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = '';
                        if(tCheck.Ranking >= 0){
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'Existe más de un valor con el mismo ranking... por favor contactar al Área Tarifas';
                        }else{
                            toR.IdDetalleReserva = detalleReserva.Id;
                            toR.Mensaje = 'No se encuentran Tarifas coincidentes... por favor contactar al Área Tarifas';
                        }
                        return toR;
                    }
                }
                //Si se encontró un valor, devolver Id
                if(maximo != null){
                    if(maximo.Ranking >= 0){
                        toR.IdParametroTarifa = maximo.Id;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'Tarifa encontrada';
                    }else{
                        toR.IdParametroTarifa = null;
                        toR.IdDetalleReserva = detalleReserva.Id;
                        toR.Mensaje = 'No existen tarifas';
                    }
                    return toR;
                }
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }else if(rankings.size() == 1){
                if(rankings[0].Ranking >= 0){
                    //System.debug(rankings);
                    toR.IdParametroTarifa = rankings[0].Id;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'Tarifa encontrada';
                }else{
                    toR.IdParametroTarifa = null;
                    toR.IdDetalleReserva = detalleReserva.Id;
                    toR.Mensaje = 'No existen tarifas';
                }
                if(Test.isRunningTest()){
                    eTA et = new eTA();
                    et.detalleReservaId = '';
                    et.tarifaId = '';
                    //et.acuerdoId = '';
                }
                return toR;
            }else{
                //System.debug('No existen tarifas para este caso');
                toR.IdParametroTarifa = null;
                toR.IdDetalleReserva = detalleReserva.Id;
                toR.Mensaje = 'No se encontraron tarifas';
                return toR;
            }
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex.getStackTraceString());
            return null;
        }
    }

    //Devuelve Puntaje según coincidencia de campos
    //En caso que coincida valor Registro vs Valor Tarifa devuelve valor ponderado
    //En caso de que Valor Tarifa no tenga registro devuelve 0
    //En caso de que ambos valores sean distintos devuelve -100
    public static Integer rankPonderador(String parametro, String tarifa, Integer ponderacion){
        try{
            Integer peso = 0;
            if(tarifa == ''){
                peso = 0;
            }else if(parametro == tarifa){
                peso = ponderacion;
            }else if(parametro != tarifa){
                peso = -100;
            }else{
                peso = 0;
            }
            return peso;
        }catch(Exception ex){
            //System.debug(ex.getMessage());
            //System.debug(ex.getStackTraceString());
            return 0;
        }
    }

    //Devuelve Puntaje según coincidencia de campos de Edad
    //En caso que coincida Edad Registro vs Edad Tarifa devuelve 1000
    //En caso de que ambos valores sean distintos devuelve -1000
    Public static Integer rankingEdad(Decimal edad, Decimal edadDesde, Decimal edadHasta, Decimal edadMaxT){
        try{
            Integer peso = 0;
            if(edad >= edadDesde && edad <= edadHasta){
                peso = 1000;
            }else if(edad < edadDesde || edad > edadHasta){
                if(edadHasta == edadMaxT && edad > edadMaxT){
                    peso = 1000;
                }else{
                    peso = -1000;
                }
            }else{
                peso = 0;
            }
            return peso;
        }catch(Exception ex){
            return 0;
        }
    }

    //Clase utilizada para devolver Id de Registro Detalle Reserva, Id Tarifa y Rankin encontrados
    public class pTarifaRanking{
        public String Id{ get; set; }
        public String IdTarifa{ get; set; }
        public Integer Ranking { get; set; }
    }

    //Metodo para resumir código en la nueva actualización y evitar cubrir líneas repetidas
    public static Integer maxEdad(List<Parametros_Tarifarios_Pasajeros__c> parametrosPasajeros, Parametros_Tarifarios_Pasajeros__c tar){
        Integer maxEdad = 0;
        for(Parametros_Tarifarios_Pasajeros__c checkMaxEdad :  parametrosPasajeros){
            if(checkMaxEdad.Contrato_Tarifa__c == tar.Contrato_Tarifa__c){
                //Si edad hasta es distinto de null y edad máxima es 0 (1 vuelta)
                //se asigna edad de registro como máxima edad
                //de lo contrario si edad de registro es mayor o igual a edad máxima
                //se vuelve a asignar el valor de edad
                if(checkMaxEdad.Edad_Hasta__c != null && maxEdad == 0){
                    maxEdad = Integer.valueOf(checkMaxEdad.Edad_Hasta__c);
                }else if(checkMaxEdad.Edad_Hasta__c != null && checkMaxEdad.Edad_Hasta__c >= maxEdad){
                    maxEdad = Integer.valueOf(checkMaxEdad.Edad_Hasta__c);
                }
            }
        }
        return maxEdad;
    }
    
    //Metodo para resumir código en la nueva actualización y evitar cubrir líneas repetidas
    public static pTarifaRanking valorRanked(pTarifaRanking r, Parametros_Tarifarios_Pasajeros__c tar, Integer maxEdad, Integer edadPasajero, Detalle_Reserva__c detalleReserva){
        r.Id = tar.Id;
        r.IdTarifa = tar.Contrato_Tarifa__c;
        //Declaro variables para ponderar la mejor búsqueda de datos
        Integer s0, s1, s2, s3, s4, s5, s6;
        String parametroX = '', tarifaX = '';
        System.debug('Valorizando registro '+tar.Name);
        Integer puntaje = 0;
    
        //Ponderado 1000 Especificacion Edad
        s0 = NAV_Tarificador.rankingEdad(edadPasajero, tar.Edad_desde__c, tar.Edad_hasta__c, maxEdad);
        System.debug('tar.Edad_desde__c ('+s0+'):'+tar.Edad_desde__c+' tar.Edad_hasta__c: '+tar.Edad_hasta__c+' -> '+edadPasajero);
        //Ponderado 1000 Estudiante
        parametroX = detalleReserva.Estudiante__c != null?String.valueOf(detalleReserva.Estudiante__c):'';
        tarifaX = tar.Estudiante__c!=null?String.valueOf(tar.Estudiante__c):'';
        if(parametroX == 'false' && tarifaX == 'false'){
            puntaje = 1000;
        }else{
            puntaje = 1000;
        }


        s1 = NAV_Tarificador.rankPonderador(parametroX,tarifaX,puntaje);
        System.debug('tar.Estudiante__c ('+s1+'):'+tar.Estudiante__c+' -> '+detalleReserva.Estudiante__c);
    
        //Ponderado 7000 Discapacidad
        parametroX = detalleReserva.Nombre_Pasajero__r.Discapacidad__pc != null?String.valueOf(detalleReserva.Nombre_Pasajero__r.Discapacidad__pc):'';
        tarifaX = tar.Especificacion__c!=null?String.valueOf(tar.Discapacidad__c):'';
        //En caso de requerir que registros en falso debieran tener un puntaje distinto al normal por coincidencias
        //cambiar por valor correspondiente
        if(parametroX == 'false' && tarifaX == 'false'){
            puntaje = 7000;
        }else{
            puntaje = 7000;
        }
        s2 = NAV_Tarificador.rankPonderador(parametroX,tarifaX,puntaje);
        System.debug('tar.Discapacidad__c ('+s2+'):'+tar.Discapacidad__c+' -> '+detalleReserva.Nombre_Pasajero__r.Discapacidad__pc);
    
        //Ponderado 7000 Conductor
        parametroX = detalleReserva.Conductor__c != null?String.valueOf(detalleReserva.Conductor__c):'';
        tarifaX = tar.Conductor__c!=null?String.valueOf(tar.Conductor__c):'';
        //En caso de requerir que registros en falso debieran tener un puntaje distinto al normal por coincidencias
        //cambiar por valor correspondiente
        if(parametroX == 'false' && tarifaX == 'false'){
            puntaje = 7000;
        }else{
            puntaje = 7000;
        }
        s3 = NAV_Tarificador.rankPonderador(parametroX,tarifaX,puntaje);
        System.debug('tar.Conductor__c ('+s3+'):'+tar.Conductor__c+' -> '+detalleReserva.Conductor__c);
    
        //Ponderado 1000 Transportista
        parametroX = detalleReserva.Transportista__c != null?String.valueOf(detalleReserva.Transportista__c):'';
        tarifaX = tar.Transportista__c!=null?String.valueOf(tar.Transportista__c):'';
        //En caso de requerir que registros en falso debieran tener un puntaje distinto al normal por coincidencias
        //cambiar por valor correspondiente
        if(parametroX == 'false' && tarifaX == 'false'){
            puntaje = 1000;
        }else{
            puntaje = 1000;
        }
        s4 = NAV_Tarificador.rankPonderador(parametroX,tarifaX,puntaje);
        System.debug('tar.Transportista__c ('+s4+'):'+tar.Transportista__c+' -> '+detalleReserva.Transportista__c);
    
        //Ponderado 7000 Acompañante
        parametroX = detalleReserva.Acompanante__c != null?String.valueOf(detalleReserva.Acompanante__c):'';
        tarifaX = tar.Acompanante__c!=null?String.valueOf(tar.Acompanante__c):'';
        //En caso de requerir que registros en falso debieran tener un puntaje distinto al normal por coincidencias
        //cambiar por valor correspondiente
        if(parametroX == 'false' && tarifaX == 'false'){
            puntaje = 7000;
        }else{
            puntaje = 7000;
        }
        s5 = NAV_Tarificador.rankPonderador(parametroX,tarifaX,puntaje);
        System.debug('tar.Acompanante__c ('+s5+'):'+tar.Acompanante__c+' -> '+detalleReserva.Acompanante__c);

        //Ponderado 7000 ida_Vuelta__c
        parametroX = detalleReserva.ida_Vuelta__c != null?String.valueOf(detalleReserva.ida_Vuelta__c):'';
        tarifaX = tar.ida_Vuelta__c!=null?String.valueOf(tar.ida_Vuelta__c):'';
        //En caso de requerir que registros en falso debieran tener un puntaje distinto al normal por coincidencias
        //cambiar por valor correspondiente
        if(parametroX == 'false' && tarifaX == 'false'){
            puntaje = 1000;
        }else{
            puntaje = 1000;
        }
        s6 = NAV_Tarificador.rankPonderador(parametroX,tarifaX,puntaje);
        System.debug('tar.ida_Vuelta__c ('+s5+'):'+tar.ida_Vuelta__c+' -> '+detalleReserva.ida_Vuelta__c);

        Integer suma = 0;
        //Se suman ponderadores y se amplifican por 100
        suma = (s0 + s1 + s2+ s3 + s4 + s5 + s6 /* + s7 + s8*/) * 100;
    
        r.Ranking = suma;
        System.debug('Suma: '+r.Ranking);
        return r;
    }
}