/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase invocable para PB o Flow para tarificar detalle reserva
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     25-10-2021   RL       Creación de la Clase.
2.1     30-01-2024   RL       Actualización para Búsqueda de Registros contemplando Rutas Comerciales y Subsidiadas  
***********************************************************************************/

public class NAV_Tarificar_PB  {
	public static String currentRecordId {get;set;}
	public static String tipoRegistro{get;set;}
	public static String tipoItinerario{get;set;}
	public static NAV_Tarificar_SOQL consultasSoql{get;set;}
	public static Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosPasajeros{get;set;}
	public static Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosMetrosLineales{get;set;}
	public static Detalle_Reserva__c detalleReserva{get;set;}
	public static Parametro_DR__c parametroDR{get;set;}
	public static Map<String, Parametro_DR__c> parametroDRMap{get;set;}
	public static Integer diasAnticipacion{get;set;}
	public static Decimal porcentajeDR {get;set;}
	public static Parametro_Tasa_Embarque__c puertoEmbarque {get;set;}
	public static Map<String, Parametro_Tasa_Embarque__c> puertoEmbarqueMap {get;set;}
	public static Parametro_Tasa_Embarque__c puertoDesembarque {get;set;}
	public static Map<String, Parametro_Tasa_Embarque__c> puertoDesembarqueMap {get;set;}
	public static NAV_Tarificador tarificador = new NAV_Tarificador();
	public static NAV_Tarifa_Return tarifaEncontrada2 = new NAV_Tarifa_Return();
	public static List<NAV_Tarifa_Return> tarifaEncontradaLst = new List<NAV_Tarifa_Return>();

	private static boolean run = true;

	public class eTA{
        public String detalleReservaId { get; set; }
        public String tarifaId { get; set; }
    }

	@InvocableMethod(label='Tarificar Detalle Reserva' description='Tarificar Detalle Reserva')
	public static void TarificaDetalleReserva(List<Id> inputParams) {
		try{
			Set<Id> listaIds = new Set<Id>();
			listaIds.addAll(inputParams);
			
			//Inicializo variables Map
			mapParametrosPasajeros = new Map<String, Parametros_Tarifarios_Pasajeros__c>(); 
			mapParametrosMetrosLineales = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
			
			//Asigno clase Tarificar SOQL
			consultasSoql = new NAV_Tarificar_SOQL();
			
			//Obtengo los datos de Detalle Reserva en base al ID del registro y los devuelvo a Map
			Map<String, Detalle_Reserva__c> detalleReservaMap = consultasSoql.retornarDatosDetalleReservaMap(inputParams);
			System.debug('TOTAL REGISTROS DETALLE RESERVA = '+detalleReservaMap.size());
			System.debug('MAP DETALLE RESERVA');
			System.debug(detalleReservaMap);

			//Declaro variable tramoDetalle para futuras formas de cálculo
			Map<String,Capacidad_Tramo_Detalle_Reserva__c> tramoDetalleMap = new Map<String,Capacidad_Tramo_Detalle_Reserva__c>();
			tramoDetalleMap = consultasSoql.getTramoDetalleReservaMap(detalleReservaMap.values());
			System.debug('TRAMO DETALLE');
			System.debug(tramoDetalleMap);

			//Obtengo MAP de recargo DR en base a los datos del Registro
			parametroDRMap = consultasSoql.getRecargoDRMap(detalleReservaMap.values());
			System.debug('MAP PARAMETROS DR');
			System.debug(parametroDRMap);

			//Asigno a variables MAP los posibles Parámetros de Tarifa a utilizar
			//mapParametrosPasajeros = consultasSoql.getParametrosTarifaMap(detalleReservaMap.values(), tramoDetalle);
			mapParametrosPasajeros = consultasSoql.getParametrosTarifaMap(detalleReservaMap.values(), tramoDetalleMap);
			System.debug('MAP PARAMETROS TARIFA');
			System.debug(mapParametrosPasajeros);
			System.debug(mapParametrosPasajeros.size());
			
			//Si uno de los registros es de Tipo Pista, debemos traer los posibles Parámetros de Tarifa ML a utilizar
			mapParametrosMetrosLineales = consultasSoql.getParametrosTarifaMetroLinealMap(detalleReservaMap.values(),tramoDetalleMap);
			System.debug('MAP PARAMETROS ML');
			System.debug(mapParametrosMetrosLineales);
			System.debug(mapParametrosMetrosLineales.size());

			//Obtengo registro de Tasa Embarque (Si no existe retorna NULL)
			puertoEmbarqueMap = consultasSoql.getTasaEmbarqueMap(detalleReservaMap.values(),tramoDetalleMap);
			System.debug('MAP PUERTO EMBARQUE');
			System.debug(puertoEmbarqueMap);
			System.debug(puertoEmbarqueMap.size());

			//Obtengo registro de Tasa Desembarque (Si no existe retorna NULL)
			puertoDesembarqueMap = consultasSoql.getTasaDesembarqueMap(detalleReservaMap.values(),tramoDetalleMap);
			System.debug('MAP PUERTO DESEMBARQUE');
			System.debug(puertoDesembarqueMap);
			System.debug(puertoDesembarqueMap.size());

			// if(run){
			// 	run = false;
				for(Id idActual : listaIds){
					//Asigno Id del registro Detalle Reserva
					currentRecordId  = idActual;
					detalleReserva = detalleReservaMap.get(currentRecordId);
					String categoria = '';

					//Se utiliza por defecto para búsquedas de parámetros tarifas, si tipo de Identificación = RUT cambiar valor a true.
					Boolean esNacional = false;

					if(detalleReserva != null){
						//Asigno tipo de registro a Variable tipoRegistro
						tipoRegistro = detalleReserva.RecordType.DeveloperName;
						Capacidad_Tramo_Detalle_Reserva__c tramoDetalle = new Capacidad_Tramo_Detalle_Reserva__c();
            			if(tramoDetalleMap.size() > 0){
							tramoDetalle = tramoDetalleMap.get(detalleReserva.Id);
						}

						if(!tipoRegistro.contains('Lectura')){
							//Si Tipo de Registro es distinto a "Bicicletas"
							//Realizo búsqueda de Tramo Detalle Reserva y así obtener el Tipo de Itinerario
							//Caso contrario, lo obtengo del campo fórmula Tipo de Registro
							if(tipoRegistro != 'Bicicletas'){
								tipoItinerario = tramoDetalle.Tipo_de_Itinerario__c;
								//Si tipo de Registro es Butaca, debemos obtener Categoría desde Capacidad_Tramo
								if(tipoRegistro == 'Butaca'){
									categoria = tramoDetalle.Capacidad_Tramo__r.Categoria__c;
								}
							}else{
								tipoItinerario = detalleReserva.Reserva__r.Itinerario_asociado__r.Tipo__c;
							}

							switch on tipoRegistro{
								when 'Butaca'{
									//Se considera Nacional cuando el registro de detalle Reserva es del tipo RUT
									if(detalleReserva.Tipo_de_identificacion__c == 'RUT'){
										esNacional = true;
									}
								}
								when 'Pallet'{
									//Se considera Nacional cuando el registro de detalle Reserva de la persona que entrega es del tipo RUT
									if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
										esNacional = true;
									}
								}
								when 'Pista'{
									//Se considera Nacional cuando el registro de detalle Reserva de la persona identificada como conductor es del tipo RUT
									if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
										esNacional = true;
									}else{
										System.debug('Consulto por Persona que entrega');
										if(detalleReserva.Persona_que_entrega__r.Tipo_de_identificacion__c == 'RUT'){
											esNacional = true;
										}
									}
								}
								when 'Bicicletas'{
									//Se considera Nacional cuando el registro de detalle Reserva de la persona identificada como conductor es del tipo RUT
									if(detalleReserva.Detalle_Reserva_Conductor__r.Tipo_de_identificacion__c == 'RUT'){
										esNacional = true;
									}
								}
							}

							//Asigno variable Porcentaje DR en 0
							porcentajeDR = 0;
					
							//Obtengo registro de Tarifa correspondiente según los datos de Detalle Reserva
							tarifaEncontrada2 = tarificador.BuscarDatosTarifaPB(detalleReserva, tipoRegistro, tipoItinerario, mapParametrosPasajeros, categoria, esNacional);
							tarifaEncontradaLst.add(tarifaEncontrada2);
						}
					}
				}
				
				System.debug('DETALLES RESERVA');
				System.debug(tarifaEncontradaLst);
			
				//Proceso para realizar valorización de Detalles Reserva en base a los datos obtenidos
				tarificador.valorizarRegistroPB(tarifaEncontradaLst, detalleReservaMap, mapParametrosPasajeros, mapParametrosMetrosLineales, puertoEmbarqueMap, puertoDesembarqueMap, parametroDRMap);
			//}
		}catch(Exception ex){
			System.debug(ex.getMessage());
			System.debug(ex.getStackTraceString());
			System.debug(ex.getLineNumber());
		}
	}
}