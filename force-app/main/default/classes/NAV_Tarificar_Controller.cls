/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Controller para Visualforce NAV_Tarificar_VF
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     16-09-2021   RL       Creación de la Clase.
2.0		18-04-2023	 EF		  Comentar lineas que no se usan con nuevo flujo de Tarificación.
***********************************************************************************/


public class NAV_Tarificar_Controller  {
	public String currentRecordId {get;set;}
	public String URLretorno{get;set;}

	/*
	public String tipoRegistro{get;set;}
	public String tipoItinerario{get;set;}
	public NAV_Tarificar_SOQL consultasSoql{get;set;}
	public Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosPasajeros{get;set;}
	public Map<String, Parametros_Tarifarios_Pasajeros__c> mapParametrosMetrosLineales{get;set;}
	public Detalle_Reserva__c detalleReserva{get;set;}
	public Parametro_DR__c parametroDR{get;set;}
	public Decimal porcentajeDR {get;set;}
	public Integer diasAnticipacion {get;set;}
	Parametro_Tasa_Embarque__c puertoEmbarque {get;set;}
	Parametro_Tasa_Embarque__c puertoDesembarque {get;set;}
	*/

	NAV_Tarificador tarificador = new NAV_Tarificador();
	public NAV_Tarifa_Return tarifaEncontrada2 = new NAV_Tarifa_Return();

	public NAV_Tarificar_Controller(ApexPages.StandardController controller){
		//Asigno Id del registro Detalle Reserva
		currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
		//Obtengo URL base para función de Retorno
		String urlVal = ApexPages.currentPage().getHeaders().get('Referer');
        
		//Asigno URLretorno con datos de ID y URL base
		URLretorno = urlVal+currentRecordId;
		/*
		//Inicializo variables Map
		mapParametrosPasajeros = new Map<String, Parametros_Tarifarios_Pasajeros__c>(); 
		mapParametrosMetrosLineales = new Map<String, Parametros_Tarifarios_Pasajeros__c>();
		
        
		//Asigno variable Porcentaje DR en 0
		porcentajeDR = 0;
		
		//Asigno clase Tarificar SOQL
		consultasSoql = new NAV_Tarificar_SOQL();
		
		//Obtengo los datos de Detalle Reserva en base al ID del registro
		detalleReserva = consultasSoql.retornarDatosDetalleReserva(currentRecordId);
		
		if(detalleReserva.Reserva__r.Estado_de_Reserva__c == 'Creada' || detalleReserva.Reserva__r.Estado_de_Reserva__c == 'Reservada'){

			//Asigno tipo de registro a Variable tipoRegistro
			tipoRegistro = detalleReserva.RecordType.DeveloperName;
			
			//Declaro variable tramoDetalle para futuras formas de cálculo
			Capacidad_Tramo_Detalle_Reserva__c tramoDetalle = new Capacidad_Tramo_Detalle_Reserva__c();
			String categoria = '';
			
			//Si Tipo de Registro es distinto a "Bicicletas"
			//Realizo búsqueda de Tramo Detalle Reserva y así obtener el Tipo de Itinerario
			//Caso contrario, lo obtengo del campo fórmula Tipo de Registro
			if(tipoRegistro != 'Bicicletas'){
				tramoDetalle = consultasSoql.getTramoDetalleReserva(detalleReserva.Id);
				tipoItinerario = tramoDetalle.Tipo_de_Itinerario__c;
			}else{
				tipoItinerario = detalleReserva.Reserva__r.Itinerario_asociado__r.Tipo__c;
			}

			//Si tipo de Registro es Butaca, debemos obtener Categoría desde Capacidad_Tramo
			if(tipoRegistro == 'Butaca'){
				categoria = tramoDetalle.Capacidad_Tramo__r.Categoria__c;
			}

			//Si tipo de Registro NO es Pallet NI Bicicletas
			//Consultar Si Itinerario Admite DR está en true
			if(tipoRegistro != 'Pallet' && tipoRegistro != 'Bicicletas'){
				if(detalleReserva.Reserva__r.Itinerario_admite_DR__c){
					diasAnticipacion = 0;
					Date fechaComparar = Date.valueOf(detalleReserva.Reserva__r.Fecha_Viaje__c);
					Date fechaReserva = Date.valueOf(detalleReserva.Reserva__r.Fecha_de_Reserva__c);
					
					//Calculo días de Anticipación en base a fecha de Reserva y fecha de Viaje
					diasAnticipacion = fechaReserva.daysBetween(fechaComparar);
					
					//Obtengo recargo DR en base a los datos del Registro
					parametroDR = consultasSoql.getRecargoDR(diasAnticipacion, detalleReserva.Reserva__r.Ocupacion_porcentaje__c,detalleReserva.Reserva__r.Fecha_Viaje__c);
					if(parametroDR != null){
						//Si parametro DR es distinto de NULL obtengo el % para cálculos
						porcentajeDR = parametroDR.Porcentaje_DR__c;
					}
					System.debug('Días de Anticipacion = '+diasAnticipacion);
					System.debug('% DR = '+porcentajeDR);
				}
			}

			try{
			//Asigno a variables MAP los posibles Parámetros de Tarifa a utilizar
			mapParametrosPasajeros = consultasSoql.getParametrosTarifa(detalleReserva,tipoRegistro,tipoItinerario,categoria);
			if(tipoRegistro == 'Pista'){
				//Si el Tipo de Registro es de tipo Pista, debemos traer los posibles Parámetros de Tarifa ML a utilizar
				mapParametrosMetrosLineales = consultasSoql.getParametrosTarifaMetroLineal(detalleReserva,tipoItinerario);
			}
			
			//Obtengo registro de Tasa Embarque (Si no existe retorna NULL)
			puertoEmbarque = consultasSoql.getTasaEmbarque(detalleReserva.Reserva__r.Puerto_ORIGEN__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, tipoItinerario, tipoRegistro);
			
			//Obtengo registro de Tasa Desembarque (Si no existe retorna NULL)
			puertoDesembarque = consultasSoql.getTasaDesembarque(detalleReserva.Reserva__r.Puerto_DESTINO__c, detalleReserva.Reserva__r.Fecha_Viaje__c, detalleReserva, tipoItinerario, tipoRegistro);
			
			//Obtengo registro de Tarifa correspondiente según los datos de Detalle Reserva
			tarifaEncontrada2 = tarificador.BuscarDatosTarifa(detalleReserva, tipoRegistro, tipoItinerario, mapParametrosPasajeros);
			System.debug('Tarifa Encontrada 2 = '+tarifaEncontrada2);
			}catch(Exception ex){
				System.debug(ex.getMessage());
				System.debug(ex.getStackTraceString());
			}
		}
		*/
	}

	//Proceso para realizar valorización del Detalle Reserva en base a los datos obtenidos
	public void valorizarRegistro(){
		/*
		System.debug(currentRecordId);
		System.debug(detalleReserva);
		System.debug(tarifaEncontrada2);
		System.debug(mapParametrosPasajeros);
		System.debug(mapParametrosMetrosLineales);
		System.debug(puertoEmbarque);
		System.debug(puertoDesembarque);
		System.debug(porcentajeDR);
		System.debug(diasAnticipacion);
		System.debug(parametroDR);
		tarificador.valorizarRegistro(currentRecordId, detalleReserva, tarifaEncontrada2, mapParametrosPasajeros, mapParametrosMetrosLineales, puertoEmbarque, puertoDesembarque, porcentajeDR, diasAnticipacion, parametroDR);
		*/
		Detalle_Reserva__c detalleReserva = new Detalle_Reserva__c();
		detalleReserva.Id = currentRecordId;
		detalleReserva.Tarificar__c = true;
		update detalleReserva;
	}

	//Retorno registro POST-Cálculo al detalle de "Detalle_Reserva__c" según el ID encontrado
	public PageReference redirect(){
        PageReference acctPage = new PageReference(URLretorno);
        acctPage.setRedirect(true);
        return acctPage;
    }
}