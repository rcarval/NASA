/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para pagina de reservas
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     15-09-2021   EFR      Creación de la Clase.
***********************************************************************************/
public class NAV_Reservas  {
    public Boolean valueIdaVuelta { get; set; }
	public String numReserva { get; set; }
	public Set<String> naves { get; set; }
	public Set<String> origenes { get; set; }
	public Set<String> destinos { get; set; }
	public Set<String> marcasS { get; set; }
	public Set<String> modelosS { get; set; }
	public Set<String> tipoM { get; set; }
	public Set<String> tipoC { get; set; }
	public String[] fecha { get; set; }
	public String origen { get; set; }
	public String destino { get; set; }
	public String personas { get; set; }
	public String vehiculos { get; set; }
	public String cargas { get; set; }
	public String sinAcomodacion { get; set; }
	public Decimal personasD { get; set; }
	public Decimal vehiculosD { get; set; }
	public Decimal cargasD { get; set; }
	public Decimal sinAcomodacionD { get; set; }
	public String uuid { get; set; }
	public String[] tipoVehiculos { get; set; }
	public String[] marcas { get; set; }
	public String[] modelos { get; set; }
	public String[] modelAlto { get; set; }
	public String[] modelAncho { get; set; }
	public String[] modelLargo { get; set; }
	public String[] modelTipoMaestro { get; set; }
	public String[] portaEquipaje { get; set; }
	public String[] portaBicicleta { get; set; }
	public String[] carrosArrastre { get; set; }
	public String[] largoCarros { get; set; }
	public String[] mnTipos { get; set; }
	public String[] mnAltos { get; set; }
	public String[] mnAnchos { get; set; }
	public String[] mnLargos { get; set; }
	public String[] cmFactu { get; set; }
	public String[] cmTipos { get; set; }
	public String[] cmTaras { get; set; }
	public String[] cmCargas { get; set; }
	public String[] cmAltos { get; set; }
	public String[] cmAnchos { get; set; }
	public String[] cmLargos { get; set; }
	public Set<capacidadNave> capacidades { get; set; }
	public String jsonText { get; set; }
	public class capacidadNave{
		public String id { get; set; }
		public String idReal { get; set; }
		public String nombre { get; set; }
		public String ubicacion { get; set; }
		public Decimal capacidad { get; set; }
		public Decimal capacidadDisponible { get; set; }
		public String unidadMedida { get; set; }
		public String itinerario { get; set; }
		public String categoria { get; set; }
		public capacidadNave(String n, String u, Decimal c, Decimal cD, String um, String i, String idR, String cAt){
			id = n+u+String.valueOf(c)+um+cAt+idR;
			idReal = idR;
			nombre = n;
			ubicacion = u;
			capacidad = c;
			capacidadDisponible = cD;
			unidadMedida = um;
			itinerario = i;
			categoria = cAt;
		}
	}
	
	public NAV_Reservas(){
	}

	public PageReference loadData(){
		//numReserva = numero incremental por fecha hora
		List<String> orden = new List<String>();
		List<String> ordenM = new List<String>();
		List<String> tiposM = new List<String>();
		List<String> tiposC = new List<String>();
		List<String> navesO = new List<String>();
		origenes = new Set<String>();
		marcasS = new Set<String>();
		tipoM = new Set<String>();
		tipoC = new Set<String>();
		naves = new Set<String>();
		List<OrigenDestino__c> oDs = [SELECT Origen__r.Name, Destino__r.Name FROM OrigenDestino__c];
		for(OrigenDestino__c oD : oDs){
			orden.add(oD.Origen__r.Name);
			orden.add(oD.Destino__r.Name);
		}
		orden.sort();
		origenes.addAll(orden);
		List<Maestro_Vehiculos_Menores__c> vM = [SELECT Marca__c FROM Maestro_Vehiculos_Menores__c];
		for(Maestro_Vehiculos_Menores__c men : vM){
			ordenM.add(men.Marca__c);
		}
		ordenM.sort();
		marcasS.addAll(ordenM);
		List<Tipo_Vehiculos__mdt> tVs = [SELECT MasterLabel FROM Tipo_Vehiculos__mdt WHERE Tipo_Vehiculo__c = 'Motorhome/Bus'];
		for(Tipo_Vehiculos__mdt tV : tVs){
			tiposM.add(tV.MasterLabel);
		}
		tiposM.sort();
		tipoM.addAll(tiposM);
		List<Tipo_Vehiculos__mdt> tVs2 = [SELECT MasterLabel FROM Tipo_Vehiculos__mdt WHERE Tipo_Vehiculo__c = 'Camiones/Máquinas'];
		for(Tipo_Vehiculos__mdt tV : tVs2){
			tiposC.add(tV.MasterLabel);
		}
		tiposC.sort();
		tipoC.addAll(tiposC);
		List<Mantenedor_Nave__c> nV = [SELECT Name FROM Mantenedor_Nave__c];
		for(Mantenedor_Nave__c mN : nV){
			//Blanker
			if(mN.Name != 'AGIOS' && mN.Name != 'JACAF' && mN.Name != 'QUEULAT' && mN.Name != 'KATAIK' && mN.Name != 'KOTAIX')
			{ navesO.add('ARRIENDO'); } 
			else { navesO.add(mN.Name); } 
		}
		navesO.sort();
		naves.addAll(navesO);
		return null;
	}
	public PageReference getData(){
		try{
			String[] dias = new String[]{'','Lun','Mar','Mié','Jue','Vie','Sáb','Dom'};
			String pagina = ApexPages.currentPage().getParameters().get('pa');
			Id rTButaca = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
			Id rTButacaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
			Id rTPista = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
			Id rTPistaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
			Id rTCarga = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId();
			Id rTCargaC = Schema.SObjectType.Capacidad_Tramo__c.getRecordTypeInfosByName().get('Carga').getRecordTypeId();
			Id rTBicicleta = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId();
			switch on pagina {
				when '0' {
					String origen = ApexPages.currentPage().getParameters().get('origen');
					destinos = new Set<String>();
					Map<Id, Decimal> secuenciasMap = new Map<Id, Decimal>();
					List<Escalas_Itinerario__c> escalas = [SELECT Id, Puerto_Destino__r.Name, Secuencia__c, Itinerario__c
														FROM Escalas_Itinerario__c 
														WHERE Puerto_Embarque__r.Name =: origen
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
					jsonText = '{ "destinos": [""';
					for(String des : destinos){
						if(des != '--'){
							jsonText = jsonText + ',"'+des+'"';
						}
					}
					jsonText = jsonText + ']}';
				}
				when 'people'{
					String identificador = ApexPages.currentPage().getParameters().get('id');
					Boolean esResidente = false;
					jsonText = '{ "Persona": {';
					try{
						Account acc = [SELECT Id, LastName, FirstName, PersonBirthdate, Phone, Sexo__pc, PersonEmail,
										Identificacion__c, Tipo_de_identificacion__c, Discapacidad__pc, IsPersonAccount
									FROM Account
									WHERE Identificacion__c =: identificador.replace('k','K').toUpperCase()];
						if(acc.IsPersonAccount){
							jsonText = jsonText + '"Nombre":"'+acc.FirstName+'",';
							jsonText = jsonText + '"Apellido":"'+acc.LastName+'",';
							jsonText = jsonText + '"Telefono":"'+acc.Phone+'",';
							jsonText = jsonText + '"Sexo":"'+acc.Sexo__pc+'",';
							jsonText = jsonText + '"Email":"'+acc.PersonEmail+'",';
							jsonText = jsonText + '"FechaNacimiento":"'+acc.PersonBirthdate+'",';
							jsonText = jsonText + '"Discapacitado":"'+acc.Discapacidad__pc+'", ';
							try{
								Residente__c resi = [SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
													Comuna__c, N_Certificado__c, Fecha_Certificado__c 
													FROM Residente__c 
													WHERE Identificacion__c =: identificador.replace('k','K').toUpperCase()];
								if(resi.Id != null){
									esResidente = true;
								}
							}catch(Exception exR){
								esResidente = false;
							}
							jsonText = jsonText + '"Residente":"'+esResidente+'"';
						}else{
							jsonText = jsonText + '"Empresa":true';
						}
					}catch(Exception ex){
						try{
							Residente__c resi = [SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
												Comuna__c, N_Certificado__c, Fecha_Certificado__c
												FROM Residente__c 
												WHERE Identificacion__c =: identificador.replace('k','K').toUpperCase()];
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
				}
				when 'vehicle'{
					String patente = ApexPages.currentPage().getParameters().get('pat');
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
				}
				when 'x'{
					String marca = ApexPages.currentPage().getParameters().get('m');
					List<String> ordenM = new List<String>();
					modelosS = new Set<String>();
					List<Maestro_Vehiculos_Menores__c> vM = [SELECT Modelo__c, Largo__c, Alto__c, Tipo_de_Vehiculo__c 
															FROM Maestro_Vehiculos_Menores__c 
															WHERE Marca__c =: marca];
					for(Maestro_Vehiculos_Menores__c men : vM){
						ordenM.add(men.Modelo__c+'_'+men.Largo__c+'_'+men.Alto__c+'_'+men.Tipo_de_Vehiculo__c);
					}
					ordenM.sort();
					modelosS.addAll(ordenM);
					jsonText = '{ "modelos": [{"nombre":" ","largo":"0","alto":"0","tipoMaestro":"0"}';
					for(String mod : modelosS){
						String[] m = mod.split('_');
						jsonText = jsonText + ',{"nombre":"'+m[0]+'","largo":"'+m[1]+'","alto":"'+m[2]+'","tipoMaestro":"'+m[3]+'"}';
					}
					jsonText = jsonText + ']}';
				}
				when '1' {
					fecha = ApexPages.currentPage().getParameters().get('f').split('/');
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
					personas = ApexPages.currentPage().getParameters().get('p');
					vehiculos = ApexPages.currentPage().getParameters().get('v');
					cargasD = Decimal.valueOf(ApexPages.currentPage().getParameters().get('c'));
					sinAcomodacionD = Decimal.valueOf(ApexPages.currentPage().getParameters().get('sA'));
					tipoVehiculos = ApexPages.currentPage().getParameters().get('t').split(',');
					marcas = ApexPages.currentPage().getParameters().get('m').split(',');
					modelos = ApexPages.currentPage().getParameters().get('mo').split(',');
					modelAlto = ApexPages.currentPage().getParameters().get('vmal').split(',');
					modelLargo = ApexPages.currentPage().getParameters().get('vmla').split(',');
					modelTipoMaestro = ApexPages.currentPage().getParameters().get('vmtm').split(',');
					portaEquipaje = ApexPages.currentPage().getParameters().get('pe').split(',');
					portaBicicleta = ApexPages.currentPage().getParameters().get('pb').split(',');
					carrosArrastre = ApexPages.currentPage().getParameters().get('ca').split(',');
					largoCarros = ApexPages.currentPage().getParameters().get('lc').split(',');
					mnTipos = ApexPages.currentPage().getParameters().get('mTi').split(',');
					mnAltos = ApexPages.currentPage().getParameters().get('mAl').split(',');
					mnAnchos = ApexPages.currentPage().getParameters().get('mAn').split(',');
					mnLargos = ApexPages.currentPage().getParameters().get('mLa').split(',');
					cmFactu = ApexPages.currentPage().getParameters().get('cmFa').split(',');
					cmTipos = ApexPages.currentPage().getParameters().get('cmTi').split(',');
					cmTaras = ApexPages.currentPage().getParameters().get('cmTa').split(',');
					cmCargas = ApexPages.currentPage().getParameters().get('cmCa').split(',');
					cmAltos = ApexPages.currentPage().getParameters().get('cmAl').split(',');
					cmAnchos = ApexPages.currentPage().getParameters().get('cmAn').split(',');
					cmLargos = ApexPages.currentPage().getParameters().get('cmLa').split(',');
					Decimal maxAlto = 0;
					Boolean addAlto = false;
					System.debug(modelAlto);
					if(modelAlto.size() > 0){
						for(Integer i=0; i<modelAlto.size(); i++){
							Decimal altoVehiculo = 0;
							if(modelAlto[i].trim() != ''){
								if(Boolean.valueOf(portaEquipaje[i].trim()) == true){
									altoVehiculo = Decimal.valueOf(modelAlto[i]) + 1;
								}else{
									altoVehiculo = Decimal.valueOf(modelAlto[i]);
								}
								if(maxAlto < altoVehiculo){
									maxAlto = altoVehiculo;
								}
							}
						}
					}
					System.debug(mnAltos);
					if(mnAltos.size() > 0){
						for(String a : mnAltos){
							if(a.trim() != ''){
								if(maxAlto < Decimal.valueOf(a)){
									maxAlto = Decimal.valueOf(a);
								}
							}
						}
					}
					System.debug(cmAltos);
					if(cmAltos.size() > 0){
						for(String a : cmAltos){
							if(a.trim() != ''){
								if(maxAlto < Decimal.valueOf(a)){
									maxAlto = Decimal.valueOf(a);
								}
							}
						}
					}
					if(maxAlto > 0){
						addAlto = true;
					}
					Datetime fechaZarpe = Datetime.newInstance(Integer.valueOf(fecha[2]), Integer.valueOf(fecha[1]), Integer.valueOf(fecha[0]), 0, 0, 0);
					System.debug('Fecha Zarpe: '+fechaZarpe);
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
																AND Itinerario__r.Estado__c = 'Disponible para venta'
																AND Hacer_Escala__c = true
															ORDER BY Itinerario__r.Fecha_de_Viaje__c, Secuencia__c
															LIMIT 10];
					System.debug('Numero de itinerarios: '+itinerarios.size());
					jsonText = '{ "itinerarios": [';
					for(Escalas_Itinerario__c pI : itinerarios){
						Decimal carga = 0.0; String cargaIds = '[';
						Decimal pista = 0; String pistaIds = '[';
						Integer butaca = 0; String butacaIds = '[';
						Decimal sinAcomodacion = 0; String sinAcomodacionIds = '[';
						//Manejo de Capacidades
						List<Capacidad_Tramo__c> capacidades = new List<Capacidad_Tramo__c>();
						List<Capacidad_Tramo__c> capPrimerTramo = new List<Capacidad_Tramo__c>();
						List<Capacidad_Tramo__c> capPrimerTramoP = new List<Capacidad_Tramo__c>();
						List<Capacidad_Tramo__c> capPrimerTramoV = new List<Capacidad_Tramo__c>();
						if(addAlto){
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
						Date fechaInicio, fechaFin;
						Time horaInicio, horaFin;
						String fechaLinda = '';
						String horaLinda = '';
						if(secuenciaFinal >= pI.Secuencia__c){
							List<Capacidad_Tramo__c> capRestantesV = new List<Capacidad_Tramo__c>();
							List<Capacidad_Tramo__c> capRestantesP = new List<Capacidad_Tramo__c>();
							List<Capacidad_Tramo__c> capRestantes = new List<Capacidad_Tramo__c>();
							if(addAlto){
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
							//Todo tipo de registro distinto a Pista: Butacas y Pallets + Sin Acomodación
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
								capExistente.put(String.valueOf(cP.Numero__c)+String.valueOf(cP.RecordTypeId)+String.valueOf(cP.Categoria__c), cP);
								//if(cP != null){
								//	capacidades.add(cP);
									/* Manejo de conteos en otro lugar
									if(cP.RecordTypeId == rTPistaC){
										//pistaIds = pistaIds + cP.Id + ',';
										pista = pista + Integer.valueOf(cP.Capacidad_Disponible__c);
									}else if(cP.RecordTypeId == rTButacaC){
										//butacaIds = butacaIds + cP.Id + ',';
										butaca = butaca + Integer.valueOf(cP.Capacidad_Disponible__c);
									}else if(cP.RecordTypeId == rTCargaC){
										//cargaIds = cargaIds + cP.Id + ',';
										carga = carga + cP.Capacidad_Disponible__c;
									}
									*/
								//}
							}
							if(capRestantes.size() > 0){
								for(Capacidad_Tramo__c cR : capRestantes){
									String code = String.valueOf(cR.Numero__c)+String.valueOf(cR.RecordTypeId)+String.valueOf(cR.Categoria__c);
									Capacidad_Tramo__c cP = capExistente.get(code);
									if(cP != null){
										Decimal capReal = 0, capRealEvaluable = 0;
										capReal = cP.Ancho__c;
										capRealEvaluable = cR.Capacidad__c - cR.Capacidad_Comprometida__c;
										if(capRealEvaluable < capReal){
											cP.Ancho__c = capRealEvaluable;
											//cP.Capacidad_Comprometida__c = 0;
											/*
											if(cR.Capacidad_Disponible__c == 0){
												if(cP.RecordTypeId == rTPistaC){
													pista = 0;
												}else if(cP.RecordTypeId == rTButacaC){
													butaca = butaca - 1;
												}else if(cP.RecordTypeId == rTCargaC){
													carga = 0;
												}
											}
											*/
										}
									}
								}
							}
							System.debug('Para contabilizar: ');
							for( Capacidad_Tramo__c cT : capExistente.values()){
								if(cT.RecordTypeId == rTPistaC){
									//System.debug(cT);
									pista = pista + (cT.Ancho__c);
								}else if(cT.RecordTypeId == rTButacaC){
									System.debug('Butaca en revision: ');
									System.debug(cT);
									if(cT.Categoria__c == 'Sin acomodacion'){
										sinAcomodacion = sinAcomodacion + (cT.Ancho__c);
									}else{
										butaca = butaca + Integer.valueOf(cT.Ancho__c);
									}
								}else if(cT.RecordTypeId == rTCargaC){
									carga = carga + (cT.Ancho__c);
								}
							}
							//if(cargaIds.right(1) == ','){
							//	cargaIds = cargaIds.substring(0,cargaIds.length()-1);
							//}
							/*
							if(sinAcomodacionIds.right(1) == ','){
								sinAcomodacionIds = sinAcomodacionIds.substring(0,sinAcomodacionIds.length()-1);
							}
							*/
							//if(pistaIds.right(1) == ','){
							//	pistaIds = pistaIds.substring(0,pistaIds.length()-1);
							//}
							//if(butacaIds.right(1) == ','){
							//	butacaIds = butacaIds.substring(0,butacaIds.length()-1);
							//}
							//cargaIds = cargaIds + ']';
							//pistaIds = pistaIds + ']';
							//butacaIds = butacaIds + ']';
							//sinAcomodacionIds = sinAcomodacionIds + ']';
							List<Escalas_Itinerario__c> viajeDetalle = [SELECT Inicio_Embarque__c, Secuencia__c, Salida__c, ETA_Puerto_Destino__c
																		FROM Escalas_Itinerario__c
																		WHERE Itinerario__c =: pI.Itinerario__c
																			AND Secuencia__c <=: secuenciaFinal
																			AND Hacer_Escala__c = true
																			ORDER BY Secuencia__c ASC];
							fechaInicio = pI.Salida__c.date();
							horaInicio = pI.Salida__c.time();
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
							fechaLinda = zarpeDia+' '+fechaInicio.day()+', '+fechaInicio.month();
							Time zarpeH = pI.Salida__c.time();
							horaLinda = '';
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
						if(fechaInicio != null && fechaFin != null){
							jsonText = jsonText + '{ "Id": "'+pI.Id+'",';
							jsonText = jsonText + '"Nombre":"'+pI.Itinerario__r.Name+'",';
							jsonText = jsonText + '"Itinerario":"'+pI.Itinerario__c+'",';
							jsonText = jsonText + '"Tipo":"'+pI.Itinerario__r.RUTA__c+'",';
							jsonText = jsonText + '"CapacidadCarga":"'+pI.Itinerario__r.Nombre_de_la_Nave__r.Carga_Maxima_Vehiculos__c+'",';
							jsonText = jsonText + '"Fecha":"'+fechaLinda+'", ';
							jsonText = jsonText + '"FechaOrigen":"'+fechaInicio.format()+'", ';
							jsonText = jsonText + '"TiempoViaje":"'+hours+'", ';
							jsonText = jsonText + '"FechaDestino":"'+fechaFin.format()+'", ';
							jsonText = jsonText + '"Hora":"'+horaLinda+'", ';
							jsonText = jsonText + '"HoraOrigen":"'+horaInicio+'", ';
							jsonText = jsonText + '"HoraDestino":"'+horaFin+'", ';
							jsonText = jsonText + '"Escalas":"'+escalas+'", ';
							jsonText = jsonText + '"Nave":"'+pI.Itinerario__r.Nombre_de_la_Nave__r.Name +'",';
							jsonText = jsonText + '"Personas":"'+butaca+'",';
							//jsonText = jsonText + '"PersonasIds":"'+butacaIds+'",';
							if(pista < 0){
								pista = 0;
							}
							jsonText = jsonText + '"Vehiculos":"'+pista+'",';
							//jsonText = jsonText + '"VehiculosIds":"'+pistaIds+'",';
							jsonText = jsonText + '"Cargas":"'+carga+'",';
							//jsonText = jsonText + '"CargasIds":"'+cargaIds+'",';
							jsonText = jsonText + '"SinAcomodacion":"'+Integer.valueOf(sinAcomodacion)+'",';
							jsonText = jsonText + '"FechaItinerario":"'+fechaInicio.format()+'"},';
						}
					}
					if(jsonText.contains(',')){
						jsonText = jsonText.substring(0,jsonText.length()-1);
					}
					jsonText = jsonText + ']}';
				}
				when '2'{
					String itinerario = ApexPages.currentPage().getParameters().get('i');
					String itinerarId = ApexPages.currentPage().getParameters().get('iid');
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String itinerarFO = ApexPages.currentPage().getParameters().get('ifo');
					String fechaItinerario = ApexPages.currentPage().getParameters().get('fi');
					String reservaId = '';
					//Datos para reserva
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
					personasD = Decimal.valueOf(ApexPages.currentPage().getParameters().get('p'));
					vehiculosD = Decimal.valueOf(ApexPages.currentPage().getParameters().get('v'));
					cargasD = Decimal.valueOf(ApexPages.currentPage().getParameters().get('c'));
					sinAcomodacionD = Decimal.valueOf(ApexPages.currentPage().getParameters().get('sA'));
					System.debug(personasD);
					System.debug(vehiculosD);
					System.debug(cargasD);
					System.debug(sinAcomodacionD);
					tipoVehiculos = ApexPages.currentPage().getParameters().get('t').split(',');
					marcas = ApexPages.currentPage().getParameters().get('m').split(',');
					modelos = ApexPages.currentPage().getParameters().get('mo').split(',');
					modelAlto = ApexPages.currentPage().getParameters().get('vmal').split(',');
					modelLargo = ApexPages.currentPage().getParameters().get('vmla').split(',');
					modelTipoMaestro = ApexPages.currentPage().getParameters().get('vmtm').split(',');
					portaEquipaje = ApexPages.currentPage().getParameters().get('pe').split(',');
					portaBicicleta = ApexPages.currentPage().getParameters().get('pb').split(',');
					carrosArrastre = ApexPages.currentPage().getParameters().get('ca').split(',');
					largoCarros = ApexPages.currentPage().getParameters().get('lc').split(',');
					mnTipos = ApexPages.currentPage().getParameters().get('mTi').split(',');
					mnAltos = ApexPages.currentPage().getParameters().get('mAl').split(',');
					mnAnchos = ApexPages.currentPage().getParameters().get('mAn').split(',');
					mnLargos = ApexPages.currentPage().getParameters().get('mLa').split(',');
					cmFactu = ApexPages.currentPage().getParameters().get('cmFa').split(',');
					cmTipos = ApexPages.currentPage().getParameters().get('cmTi').split(',');
					cmTaras = ApexPages.currentPage().getParameters().get('cmTa').split(',');
					cmCargas = ApexPages.currentPage().getParameters().get('cmCa').split(',');
					cmAltos = ApexPages.currentPage().getParameters().get('cmAl').split(',');
					cmAnchos = ApexPages.currentPage().getParameters().get('cmAn').split(',');
					cmLargos = ApexPages.currentPage().getParameters().get('cmLa').split(',');
					List<Detalle_Reserva__c> preReservas = new List<Detalle_Reserva__c>();
					try{
						Id pOrigen = [SELECT Id FROM Puerto__c WHERE Name =: origen LIMIT 1].Id;
						Id pDestino = [SELECT Id FROM Puerto__c WHERE Name =: destino LIMIT 1].Id;
						//Transform date
						String[] fOrigen = itinerarFO.split('/');
						Reserva__c reserva = new Reserva__c();
						try{
							reserva = [SELECT Itinerario_asociado__c, Canal_de_Venta__c, Tipo_de_Reserva__c, Sentido_Viaje__c, Fecha_Viaje__c,
										Fecha_de_Reserva__c, Estado_de_Reserva__c, Cantidad_de_Pasajeros__c, Cantidad_de_Vehiculos__c,
										Puerto_DESTINO__c, Puerto_ORIGEN__c, UUID__c
									FROM Reserva__c
									WHERE UUID__c =: uuid];
							reserva.Itinerario_asociado__c = itinerario;
							reserva.Canal_de_Venta__c = 'Presencial';
							reserva.Tipo_de_Reserva__c = 'General';
							reserva.Sentido_Viaje__c = 'Ida';
							reserva.Fecha_Viaje__c = Date.newInstance(Integer.valueOf(fOrigen[2]),Integer.valueOf(fOrigen[1]),Integer.valueOf(fOrigen[0]));
							reserva.Fecha_Hora_de_Viaje__c = [SELECT Salida__c FROM Escalas_Itinerario__c WHERE Puerto_Embarque__r.Name =: origen AND Itinerario__c =: itinerario AND Hacer_Escala__c = true].Salida__c;
							reserva.Fecha_de_Reserva__c = Date.today();
							reserva.Estado_de_Reserva__c = 'Creada';
							reserva.Cantidad_de_Pasajeros__c = personasD;
							reserva.Cantidad_de_Vehiculos__c = vehiculosD;
							reserva.Puerto_DESTINO__c = pDestino;
							reserva.Puerto_ORIGEN__c = pOrigen;
							reserva.UUID__c = uuid;
							update reserva;
							System.debug('Reserva actualizada');
						}catch(Exception uId){
							reserva.Itinerario_asociado__c = itinerario;
							reserva.Canal_de_Venta__c = 'Presencial';
							reserva.Tipo_de_Reserva__c = 'General';
							reserva.Sentido_Viaje__c = 'Ida';
							reserva.Fecha_Viaje__c = Date.newInstance(Integer.valueOf(fOrigen[2]),Integer.valueOf(fOrigen[1]),Integer.valueOf(fOrigen[0]));
							reserva.Fecha_Hora_de_Viaje__c = [SELECT Salida__c FROM Escalas_Itinerario__c WHERE Puerto_Embarque__r.Name =: origen AND Itinerario__c =: itinerario AND Hacer_Escala__c = true].Salida__c;
							reserva.Fecha_de_Reserva__c = Date.today();
							reserva.Estado_de_Reserva__c = 'Creada';
							reserva.Cantidad_de_Pasajeros__c = personasD;
							reserva.Cantidad_de_Vehiculos__c = vehiculosD;
							reserva.Puerto_DESTINO__c = pDestino;
							reserva.Puerto_ORIGEN__c = pOrigen;
							reserva.UUID__c = uuid;
							insert reserva;
							System.debug('Reserva nueva');
						}
						reservaId = reserva.Id;
						List<Detalle_Reserva__c> pReservas = [SELECT Id FROM Detalle_Reserva__c WHERE Reserva__r.UUID__c =: uuid];
						delete pReservas;
						if(personasD > 0){
							for(Integer i = 1; i <= personasD; i++){ 
								Detalle_Reserva__c pers = new Detalle_Reserva__c();
								pers.Reserva__c = reserva.Id;
								pers.Capacidad_Comprometida__c = 1;
								pers.Unidad_de_medida__c = 'Persona';
								pers.Ubicacion__c = 'Salón';
								pers.RecordTypeId = rTButaca;
								preReservas.add(pers);
								System.debug(pers);
							}
						}
						if(sinAcomodacionD > 0){
							for(Integer i = 1; i <= sinAcomodacionD; i++){ 
								Detalle_Reserva__c sinAco = new Detalle_Reserva__c();
								sinAco.Reserva__c = reserva.Id;
								sinAco.Numero__c = 'SA'+i;
								sinAco.Ubicacion__c = 'Salón';
								sinAco.Capacidad_Comprometida__c = 1;
								sinAco.Unidad_de_medida__c = 'Persona';
								sinAco.RecordTypeId = rTButaca;
								sinAco.Sin_Acomodacion__c = true;
								preReservas.add(sinAco);
								System.debug(sinAco);
							}
						}
						if(vehiculosD > 0){
							for(Integer v = 0; v < vehiculosD; v++){
								System.debug('V: '+v);
								System.debug('Tipo de vehiculo: '+tipoVehiculos[v]);
								System.debug('MN Tipos: '+mnTipos[v]);
								System.debug('CM Tipos: '+cmTipos[v]);
								Detalle_Reserva__c vehi = new Detalle_Reserva__c();
								vehi.Reserva__c = reserva.Id;
								if(tipoVehiculos[v] == 'Motocicleta'){
									vehi.Categoria_de_Vehiculo__c = 'Motocicleta';
									vehi.Tipo_de_Vehiculo__c = 'Motocicleta';
									vehi.Capacidad_Comprometida__c = 2;
									vehi.RecordTypeId = rTPista;
								}else if(tipoVehiculos[v] == 'Vehiculo Menor'){
									vehi.Alto__c = Decimal.valueOf(modelAlto[v]);
									vehi.Largo__c = Decimal.valueOf(modelLargo[v]);
									vehi.Ancho__c = 2.5;
									vehi.Marca__c = marcas[v];
									List<Maestro_Vehiculos_Menores__c> resultados = [SELECT Peso__c 
                                                FROM Maestro_Vehiculos_Menores__c 
                                                WHERE Marca__c = :marcas[v]
                                                AND Modelo__c  = :modelos[v] LIMIT 1];
                                    if (!resultados.isEmpty()) {
                                        Decimal valorPeso = resultados[0].Peso__c;
                                        vehi.Tara__c = valorPeso;
                                    }
									vehi.Modelo__c = modelos[v];
									vehi.Categoria_de_Vehiculo__c = 'Vehículo Menor';
									Decimal capComp = Decimal.valueOf(modelLargo[v]);
									vehi.Tipo_de_Vehiculo__c = modelTipoMaestro[v];
									if(portaBicicleta[v] == '1'){
										vehi.Porta_Bicicleta__c = true;
										vehi.ML_Portabicicleta__c = 1;
										capComp = capComp + 1;
									}
									if(portaEquipaje[v] == '1'){
										vehi.Porta_Equipaje__c = true;
										vehi.Alto__c = Decimal.valueOf(modelAlto[v]) + 1;
									}
									if(carrosArrastre[v] == '1'){
										vehi.Carro_Arrastre__c = true;
										vehi.Cantidad_de_Metros__c = Decimal.valueOf(largoCarros[v]);
										capComp = capComp + Decimal.valueOf(largoCarros[v]);
									}
									vehi.Capacidad_Comprometida__c = capComp;
									vehi.RecordTypeId = rTPista;
								}else if(tipoVehiculos[v] == 'Motorhome/Bus'){
									vehi.Categoria_de_Vehiculo__c = 'Bus y Motorhome';
									vehi.Tipo_de_Vehiculo__c = mnTipos[v];
									vehi.Alto__c = Decimal.valueOf(mnAltos[v]);
									vehi.Ancho__c = Decimal.valueOf(mnAnchos[v]);
									vehi.Largo__c = Decimal.valueOf(mnLargos[v]);
									vehi.Cantidad_de_Metros__c = Decimal.valueOf(mnLargos[v]);
									vehi.Capacidad_Comprometida__c = Decimal.valueOf(mnLargos[v]);
									vehi.RecordTypeId = rTPista;
								}else if(tipoVehiculos[v] == 'Camiones/Maquinas'){
									vehi.Categoria_de_Vehiculo__c = 'Camion y Maquinaria';
									vehi.Tipo_de_Vehiculo__c = cmTipos[v];
									vehi.Tara__c = Decimal.valueOf(cmTaras[v]);
									vehi.Alto__c = Decimal.valueOf(cmAltos[v]);
									vehi.Ancho__c = Decimal.valueOf(cmAnchos[v]);
									vehi.Largo__c = Decimal.valueOf(cmLargos[v]);
									vehi.Cantidad_de_Metros__c = Decimal.valueOf(cmLargos[v]);
									vehi.Capacidad_Comprometida__c = Decimal.valueOf(cmLargos[v]);
									vehi.Carga_Veh_culo__c = Decimal.valueOf(cmCargas[v]);
									try{
										vehi.Texto_Facturacion__c = cmFactu[v];
									}catch(Exception factEx){
										System.debug('No tiene texto de facturación.');
									}
									vehi.RecordTypeId = rTPista;
								}else if(tipoVehiculos[v] == 'Bicicleta'){
									vehi.Categoria_de_Vehiculo__c = 'Bicicleta';
									vehi.Tipo_de_Vehiculo__c = 'Bicicleta';
									vehi.RecordTypeId = rTBicicleta;
								}
								vehi.Numero__c = String.valueOf(v+1);
								System.debug(vehi);
								preReservas.add(vehi);
							}
						}
						if(cargasD > 0){
							Detalle_Reserva__c carg = new Detalle_Reserva__c();
							carg.Reserva__c = reserva.Id;
							carg.Ubicacion__c = '';
							carg.Capacidad_Comprometida__c = cargasD;
							carg.Unidad_de_medida__c = 'Pallet';
							carg.RecordTypeId = rTCarga;
							
							System.debug(carg);
							preReservas.add(carg);
						}
						//Revisar si existen cuentas 
						List<Capacidad_Tramo_Detalle_Reserva__c> capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
						if(preReservas.size() > 0){
							insert preReservas;
							//Revisar Capacidades y actualizar detalle reservas
							//Obtener inicio y término de escalas
							Decimal secuenciaInicial = [SELECT Secuencia__c 
														FROM Escalas_Itinerario__c 
														WHERE Puerto_Embarque__r.Name =: origen
															AND Itinerario__c =: itinerario
															AND Hacer_Escala__c = true
														LIMIT 1].Secuencia__c;
							Decimal secuenciaFinal = [SELECT Secuencia__c 
														FROM Escalas_Itinerario__c 
														WHERE Puerto_Embarque__r.Name =: destino
														AND Itinerario__c =: itinerario
														AND Hacer_Escala__c = true
													  LIMIT 1].Secuencia__c;
							//Escalas dentro de la secuencia
							Set<Id> escalasACubrir = new Set<Id>();
							Set<Id> capacidadOtorgada = new Set<Id>();
							List<Escalas_Itinerario__c> escalXX = [SELECT Id
																	FROM Escalas_Itinerario__c
																	WHERE Itinerario__c =: itinerario
																	AND Hacer_Escala__c = true
																	AND Secuencia__c >=: secuenciaInicial AND Secuencia__c <: secuenciaFinal];
							Map<Id,Capacidad_Tramo__c> capPistas;
							Map<String, Decimal> mapEscalas = new Map<String, Decimal>();
							Map<Id,Capacidad_Tramo__c> capButacas;
							Map<Id,Capacidad_Tramo__c> capButSinAco;
							if(vehiculosD > 0){
								//Nueva estiba de vehiculos en pistas
								capPistas = new Map<Id,Capacidad_Tramo__c>([
									SELECT Id, Ubicacion__c, Alto__c, Capacidad_Disponible__c, Escala_Itinerario__c, Numero__c, Categoria__c
									FROM Capacidad_Tramo__c 
									WHERE Escala_Itinerario__c IN: escalXX
										AND RecordTypeId =: rTPistaC
									ORDER BY Numero__c ASC
								]);
								//Generar espacio por escala + numero
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
							}
							if(personasD > 0){
								capButacas = new Map<Id,Capacidad_Tramo__c>([
									SELECT Id, Numero__c, Escala_Itinerario__c, Categoria__c, Capacidad_Disponible__c
									FROM Capacidad_Tramo__c
									WHERE Escala_itinerario__c IN: escalXX
										AND RecordTypeId =: rTButacaC
										AND Categoria__c != 'Sin acomodacion'
										AND Capacidad_Disponible__c > 0
								]);
							}
							if(sinAcomodacionD > 0){
								capButSinAco = new Map<Id,Capacidad_Tramo__c>([
									SELECT Id, Numero__c, Escala_Itinerario__c, Categoria__c, Capacidad_Disponible__c
									FROM Capacidad_Tramo__c
									WHERE Escala_itinerario__c IN: escalXX
										AND RecordTypeId =: rTButacaC
										AND Categoria__c = 'Sin acomodacion'
										AND Capacidad_Disponible__c > 0
								]);
							}
							System.debug('Secuencia Inicial: '+secuenciaInicial);
							System.debug('Secuencia Final: '+secuenciaFinal);
							System.debug('escalXX: '+escalXX);
							System.debug('rTPista: '+rTPista);
							Integer autos = 0, conAsiento = 0, sinAsiento = 0, otro = 0;
							System.debug('Prereservas: '+preReservas.size());
							for(Detalle_Reserva__c dResB : preReservas){
								Decimal totalMetros = 0;
								escalasACubrir = new Set<Id>();
								for(Escalas_Itinerario__c escala : escalXX){
									escalasACubrir.add(escala.Id);
								}
								if(dResB.RecordTypeId == rTPista && autos <= vehiculosD){
									autos = autos + 1;
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
								}else if(dResB.RecordTypeId == rTButaca && dResB.Sin_Acomodacion__c == true && sinAsiento <= sinAcomodacionD){
									System.debug('Es sin Acomodacion');
									System.debug(capButSinAco);
									System.debug(escalasACubrir);
									sinAsiento = sinAsiento + 1;
									for(Capacidad_Tramo__c cap : capButSinAco.values()){
										System.debug('escala itinerario: '+cap.Escala_Itinerario__c);
										if(escalasACubrir.contains(cap.Escala_Itinerario__c)){
											escalasACubrir.remove(cap.Escala_Itinerario__c);
											Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
											String codUnico = cap.Id+''+dResB.Id;
											capNew.Capacidad_Tramo__c = cap.Id;
											capNew.Detalle_Reserva__c = dResB.Id;
											capNew.Identificador__c = codUnico;
											capNew.Capacidad_Comprometida_en_Reserva__c = 1;//dResB.Capacidad_Comprometida__c;
											capToCreate.add(capNew);
										}
									}
								}else if(dResB.RecordTypeId == rTButaca && conAsiento < personasD){
									conAsiento = conAsiento + 1;
									for(Capacidad_Tramo__c cap : capButacas.values()){
										if(escalasACubrir.contains(cap.Escala_Itinerario__c)){
											capButacas.remove(cap.Id);
											escalasACubrir.remove(cap.Escala_Itinerario__c);
											Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
											String codUnico = cap.Id+''+dResB.Id;
											capNew.Capacidad_Tramo__c = cap.Id;
											capNew.Detalle_Reserva__c = dResB.Id;
											capNew.Identificador__c = codUnico;
											capNew.Capacidad_Comprometida_en_Reserva__c = 1;// dResB.Capacidad_Comprometida__c;
											capToCreate.add(capNew);
										}
									}
								}else{
									otro = otro + 1;
									System.debug('Datos de Otro:');
									System.debug('RecordTypeId = '+dResB.RecordTypeId);
									System.debug('Capacidad_Comprometida__c = '+dResB.Capacidad_Comprometida__c);
									System.debug('autos <= vehiculosD ('+autos+' <= '+vehiculosD+')');
								}
							}
							System.debug('Sin Asiento: '+sinAsiento);
							System.debug('Con Asiento: '+conAsiento);
							System.debug('Auto: '+autos);
							System.debug('Otro: '+otro);
							//Unir Capacidades
							if(capToCreate.size() > 0){
								try{
									Database.SaveResult[] resInserts = Database.insert(capToCreate, false);
									Boolean error = false;
									for(Database.SaveResult rR : resInserts){
										System.debug(rR);
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
									if(error){
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
									}else{
										jsonText = '{ "estado": "nook", "id": "2", "nombre": "Error", "mensaje": "No se pudo asociar la capacidad" }';
									}
								}
								capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
							}
						}else{
							System.debug('No hay pre reservas para ingresar.');
						}
					}catch(Exception ex){
						System.debug('Error');
						System.debug('Tipo de excepción: ' + ex.getTypeName());
						System.debug('Mensaje: ' + ex.getMessage());
						System.debug('Causa: ' + ex.getCause());
						System.debug('Línea: ' + ex.getLineNumber());
						System.debug('Traza: ' + ex.getStackTraceString());
						//jsonText = '{ "mensaje": "No se pudo generar la capacidad", "estado": false, "indicador": 2, "tipo": "capacidad"}';
					}
					//Obtener capacidades de la nave
					/*
					List<Capacidad_Tramo__c> capTramos = [SELECT Id, Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Disponible__c, 
															Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c, 
															No_disponible_Venta__c, Numero__c, Ubicacion__c, Unidad_de_medida__c,
															Escala_itinerario__r.Itinerario__c
														FROM Capacidad_Tramo__c
														WHERE Escala_itinerario__r.Itinerario__c =: itinerario
														ORDER BY Numero__c, RecordTypeId ASC];
					capacidades = new Set<capacidadNave>();
					Map<String, capacidadNave> capFull = new Map<String, capacidadNave>();
					for(Capacidad_Tramo__c cap : capTramos){
						capacidadNave cN = new capacidadNave(cap.Numero__c, cap.Ubicacion__c, cap.Capacidad__c, cap.Capacidad_Disponible__c, cap.Unidad_de_medida__c, cap.Escala_itinerario__r.Itinerario__c, cap.Id);
						capFull.put(cap.Numero__c+cap.Ubicacion__c+String.valueOf(cap.Capacidad__c)+cap.Unidad_de_medida__c, cN);
					}
					for(capacidadNave cN : capFull.values()){
						capacidades.add(cN);
					}
					*/
					//Manejo de Capacidades
					capacidades = new Set<capacidadNave>();
					Map<String, capacidadNave> capFull = new Map<String, capacidadNave>();
					List<Capacidad_Tramo__c> capacidadesTramos = new List<Capacidad_Tramo__c>();
					Map<String, Capacidad_Tramo__c> capacidadesTramosMap = new Map<String,Capacidad_Tramo__c>();
					List<Capacidad_Tramo__c> capPrimerTramo = new List<Capacidad_Tramo__c>();
					List<Capacidad_Tramo__c> capRestantes = new List<Capacidad_Tramo__c>();
					//Obtener inicio y término de escalas
					Decimal secuenciaInicial = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: origen 
													AND Itinerario__c =: itinerario
													AND Hacer_Escala__c = true].Secuencia__c;
					Decimal secuenciaFinal = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: destino 
												AND Itinerario__c =: itinerario
												AND Hacer_Escala__c = true].Secuencia__c;
					capPrimerTramo = [SELECT Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
										Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
										No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c,
										Escala_itinerario__r.Itinerario__c
										FROM Capacidad_Tramo__c
										WHERE Escala_itinerario__r.Itinerario__c =: itinerario
											AND RecordTypeId =: rTButacaC
											AND Escala_itinerario__r.Secuencia__c =: secuenciaInicial];
					if(secuenciaInicial < secuenciaFinal){
						capRestantes = [SELECT Alto__c, Ancho__c, Canal_Web__c, Capacidad__c, Capacidad_Comprometida__c,
											Capacidad_Disponible__c, Name, Categoria__c, Cupo_Venta_Local__c, Escala_itinerario__c,
											No_disponible_Venta__c, Numero__c, RecordTypeId, Ubicacion__c, Unidad_de_medida__c,
											Escala_itinerario__r.Itinerario__c
										FROM Capacidad_Tramo__c
										WHERE Escala_itinerario__r.Itinerario__c =: itinerario
											AND Escala_itinerario__r.Secuencia__c >: secuenciaInicial
											AND Escala_itinerario__r.Secuencia__c <: secuenciaFinal
											AND RecordTypeId =: rTButacaC];
					}
					if(capPrimerTramo.size() > 0 && capRestantes.size() > 0){
						for(Capacidad_Tramo__c cap : capPrimerTramo){
							String code = codigoCapacidad(cap);
							if(cap.Capacidad_Disponible__c > 0){
								capacidadesTramosMap.put(code, cap);
							}
						}
						Set<String> capToRemove = new Set<String>();
						for(Capacidad_Tramo__c cap : capRestantes){
							String code = codigoCapacidad(cap);
							System.debug('Codigo a validar: '+code);
							Capacidad_Tramo__c capExiste = capacidadesTramosMap.get(code);
							if(capExiste != null){
								if(cap.Capacidad_Disponible__c > 0){
									System.debug('Existe y tiene capacidad!');
									capacidadNave cN = new capacidadNave(cap.Numero__c, cap.Ubicacion__c, cap.Capacidad__c, cap.Capacidad_Disponible__c, cap.Unidad_de_medida__c, cap.Escala_itinerario__r.Itinerario__c, cap.Id, cap.Categoria__c);
									capFull.put(code, cN);
								}else{
									System.debug('Existe y no tiene capacidad!');
									capToRemove.add(code);
								}
							}else{
								System.debug('No existe');
							}
						}
						System.debug('Capacidades encontradas: '+capFull.keySet().size());
						System.debug('Capacidades para eliminar: '+capToRemove.size());
						capFull.keySet().removeAll(capToRemove);
						System.debug('Capacidades encontradas despues de eliminar: '+capFull.keySet().size());
						for(capacidadNave cN : capFull.values()){
							capacidades.add(cN);
						}
					}else if(capPrimerTramo.size() > 0){
						for(Capacidad_Tramo__c cap : capPrimerTramo){
							String code = codigoCapacidad(cap);
							capacidadNave cN = new capacidadNave(cap.Numero__c, cap.Ubicacion__c, cap.Capacidad__c, cap.Capacidad_Disponible__c, cap.Unidad_de_medida__c, cap.Escala_itinerario__r.Itinerario__c, cap.Id, cap.Categoria__c);
							capFull.put(code, cN);
						}
						for(capacidadNave cN : capFull.values()){
							capacidades.add(cN);
						}
					}
					jsonText = '{ "Capacidad": [';
					if(capacidades.size() > 0){
						for(capacidadNave cNave : capacidades){
							jsonText = jsonText + '{ "capId":"'+cNave.idReal+'",';
							jsonText = jsonText + '"capacidad":"'+cNave.capacidad+'",';
							jsonText = jsonText + '"capacidadDisponible":"'+cNave.capacidadDisponible+'",';
							jsonText = jsonText + '"numero":"'+cNave.nombre+'",';
							jsonText = jsonText + '"unidadMedida":"'+cNave.unidadMedida+'", ';
							jsonText = jsonText + '"itinerario":"'+cNave.itinerario+'", ';
							if(cNave.categoria == 'Sin acomodacion'){
								jsonText = jsonText + '"tipoRegistro":"SinAcomodacion" },';
							}else{
								jsonText = jsonText + '"tipoRegistro":"Butaca" },';
							}
						}
						String lastCharacter = jsonText.right(1);
						if(lastCharacter == ','){
							jsonText = jsonText.substring(0,jsonText.length()-1);
						}
					}else{
						System.debug('No hay capacidades por aca');
					}
					jsonText = jsonText + '], "ReservaId": "'+reservaId+'",';
					jsonText = jsonText + ' "ResDetalle": [';
					if(preReservas.size() > 0){
						for(Detalle_Reserva__c dpRes : preReservas){
							jsonText = jsonText + '{ "Id":"'+dpRes.Id+'",';
							jsonText = jsonText + '"TipoRegistroId":"'+dpRes.RecordTypeId+'" },';
						}
						String lastCharacter = jsonText.right(1);
						if(lastCharacter == ','){
							jsonText = jsonText.substring(0,jsonText.length()-1);
						}
					}
					jsonText = jsonText + ']}';
				}
				when '2a'{
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String butacas = ApexPages.currentPage().getParameters().get('butacas');
					String itinerario = ApexPages.currentPage().getParameters().get('i');
					String tipo = ApexPages.currentPage().getParameters().get('t');
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
                    String paramValueIdaVuelta = ApexPages.currentPage().getParameters().get('valueIdaVuelta');
					Boolean boolIdaVuelta = (paramValueIdaVuelta == 'true');
					System.debug('line valor ida vuelta 1156 '+ paramValueIdaVuelta);
					String[] butacasA = new String[]{};
					if(butacas.contains(',')){ butacasA = butacas.split(','); }else{ butacasA.add(butacas); }
					List<Detalle_Reserva__c> toUpdate = new List<Detalle_Reserva__c>();
					List<Capacidad_Tramo_Detalle_Reserva__c> capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
					List<Detalle_Reserva__c> dRes = [SELECT Id, Numero__c, Sin_Acomodacion__c, Ida_Vuelta__c, Reserva__r.Ruta__c
													FROM Detalle_Reserva__c
													WHERE Reserva__r.UUID__c =: uuid
														AND RecordTypeId =: rtButaca
														AND Sin_Acomodacion__c = false];
					Integer index = 0;
					for(Detalle_Reserva__c dR : dRes){
						System.debug(dR);
						dR.Numero__c = butacasA[index];	
                        if(dR.Reserva__r.Ruta__c.contains('Juan Fernandez') || dR.Reserva__r.Ruta__c.contains('Selkirk') ){
                           dR.Ida_Vuelta__c = boolIdaVuelta;
                        }
						toUpdate.add(dR);
						index++;
					}
					if(index == 0){
						jsonText = '{ "Actualizacion": "ok"}';
					}else{
						//Revisar Capacidades y actualizar detalle reservas
						//Obtener inicio y término de escalas
						Decimal secuenciaInicial = [SELECT Secuencia__c 
													FROM Escalas_Itinerario__c 
													WHERE Puerto_Embarque__r.Name =: origen 
														AND Itinerario__c =: itinerario
														AND Hacer_Escala__c = true].Secuencia__c;
						Decimal secuenciaFinal = [SELECT Secuencia__c 
													FROM Escalas_Itinerario__c 
													WHERE Puerto_Embarque__r.Name =: destino 
													AND Itinerario__c =: itinerario
													AND Hacer_Escala__c = true].Secuencia__c;
						//Escalas dentro de la secuencia
						List<Escalas_Itinerario__c> escalXX = [SELECT Id
																FROM Escalas_Itinerario__c
																WHERE Itinerario__c =: itinerario
																AND Hacer_Escala__c = true
																AND Secuencia__c >=: secuenciaInicial AND Secuencia__c <: secuenciaFinal];
						if(toUpdate.size() > 0){
							update toUpdate;
							//Revisar capacidades anteriores
							try{
								List<Capacidad_Tramo_Detalle_Reserva__c> capAnteriores = new List<Capacidad_Tramo_Detalle_Reserva__c>();
								List<Capacidad_Tramo_Detalle_Reserva__c> capReservasAnt = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c
																						FROM Capacidad_Tramo_Detalle_Reserva__c
																						WHERE Capacidad_Tramo__r.Escala_itinerario__c IN: escalXX
																						AND Capacidad_Tramo__r.RecordTypeId =: rTButacaC
																						AND Detalle_Reserva__c IN : toUpdate];
								if(capReservasAnt.size() > 0){
									for(Capacidad_Tramo_Detalle_Reserva__c cDR : capReservasAnt){
										cDR.Capacidad_Liberada__c = true;
										cDR.Causa_Liberacion__c = 'Cambio de butaca';
										capAnteriores.add(cDR);
									}
									if(capAnteriores.size() > 0){
										update capAnteriores;
									}
								}
							}catch(Exception ex){
								System.debug('No existen capacidades anteriores');
							}
							for(Detalle_Reserva__c dResB : toUpdate){
								if(!dResB.Numero__c.contains('SA')){
									List<Capacidad_Tramo__c> capViaje = [SELECT Id 
																		 FROM Capacidad_Tramo__c
																		 WHERE Escala_itinerario__c IN: escalXX
																			AND Numero__c =: dResB.Numero__c
																			AND RecordTypeId =: rTButacaC];
									for(Capacidad_Tramo__c capToAssign : capViaje){
										Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
										String codUnico = capToAssign.Id+''+dResB.Id;
										capNew.Capacidad_Tramo__c = capToAssign.Id;
										capNew.Detalle_Reserva__c = dResB.Id;
										capNew.Identificador__c = codUnico;
										capNew.Capacidad_Comprometida_en_Reserva__c = 1;
										capToCreate.add(capNew);
									}
								}
							}
						}
						//Unir Capacidades
						if(capToCreate.size() > 0){
							jsonText = '{ "Actualizacion": "ok"}';
							try{
								insert capToCreate;
							}catch(Exception ex){
								String mensaje = ex.getMessage();
								if(mensaje.contains('DUPLICATE_VALUE')){
									System.debug('Error');
									System.debug('Tipo de excepción: ' + ex.getTypeName());
									System.debug('Mensaje: ' + ex.getMessage());
									System.debug('Causa: ' + ex.getCause());
									System.debug('Línea: ' + ex.getLineNumber());
									System.debug('Traza: ' + ex.getStackTraceString());
								}else{
									jsonText = '{ "mensaje": "Las capacidades no estan disponibles", "estado": false, "indicador": 3, "tipo": "capacidad", "causa": "'+ex.getMessage()+'", "linea":"'+ex.getLineNumber()+'", "tipoEx": "'+ex.getTypeName()+'"}';
								}
							}
						}else{
							jsonText = '{ "mensaje": "Las capacidades no estan disponibles", "estado": false, "indicador": 37, "tipo": "capacidad" }';
						}
					}
				}
				when '3' {
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String itinerario = ApexPages.currentPage().getParameters().get('i');
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
					String pArrayDocuF = ApexPages.currentPage().getParameters().get('Ptd');
					String pArrayNDocF = ApexPages.currentPage().getParameters().get('Pdo');
					String pArrayNameF = ApexPages.currentPage().getParameters().get('Pn');
					String pArrayLNamF = ApexPages.currentPage().getParameters().get('Pap');
					String pArrayTeleF = ApexPages.currentPage().getParameters().get('Pt');
					String pArrayEmaiF = ApexPages.currentPage().getParameters().get('Pem');
					String pArrayFNacF = ApexPages.currentPage().getParameters().get('PfN');
					String pArraySexoF = ApexPages.currentPage().getParameters().get('Pg');
					String pArrayDiscF = ApexPages.currentPage().getParameters().get('Pd');
					String pArrayResiF = ApexPages.currentPage().getParameters().get('Pr');
					String pArrayEstuF = ApexPages.currentPage().getParameters().get('Pe');
					String pArrayButaF = ApexPages.currentPage().getParameters().get('Pbut');
					String[] pArrayDocu = new String[]{};
					String[] pArrayNDoc = new String[]{};
					String[] pArrayName = new String[]{};
					String[] pArrayLNam = new String[]{};
					String[] pArrayTele = new String[]{};
					String[] pArrayEmai = new String[]{};
					String[] pArrayFNac = new String[]{};
					String[] pArraySexo = new String[]{};
					String[] pArrayDisc = new String[]{};
					String[] pArrayResi = new String[]{};
					String[] pArrayEstu = new String[]{};
					String[] pArrayButa = new String[]{};
					if(pArrayDocuF.contains(',')){ pArrayDocu = pArrayDocuF.split(','); }else{ pArrayDocu.add(pArrayDocuF.trim()); }
					if(pArrayNDocF.contains(',')){ pArrayNDoc = pArrayNDocF.split(','); }else{ pArrayNDoc.add(pArrayNDocF.trim()); }
					if(pArrayNameF.contains(',')){ pArrayName = pArrayNameF.split(','); }else{ pArrayName.add(pArrayNameF.trim()); }
					if(pArrayLNamF.contains(',')){ pArrayLNam = pArrayLNamF.split(','); }else{ pArrayLNam.add(pArrayLNamF.trim()); }
					if(pArrayTeleF.contains(',')){ pArrayTele = pArrayTeleF.split(','); }else{ pArrayTele.add(pArrayTeleF.trim()); }
					if(pArrayEmaiF.contains(',')){ pArrayEmai = pArrayEmaiF.split(','); }else{ pArrayEmai.add(pArrayEmaiF.trim()); }
					if(pArrayFNacF.contains(',')){ pArrayFNac = pArrayFNacF.split(','); }else{ pArrayFNac.add(pArrayFNacF.trim()); }
					if(pArraySexoF.contains(',')){ pArraySexo = pArraySexoF.split(','); }else{ pArraySexo.add(pArraySexoF.trim()); }
					if(pArrayDiscF.contains(',')){ pArrayDisc = pArrayDiscF.split(','); }else{ pArrayDisc.add(pArrayDiscF.trim()); }
					if(pArrayResiF.contains(',')){ pArrayResi = pArrayResiF.split(','); }else{ pArrayResi.add(pArrayResiF.trim()); }
					if(pArrayEstuF.contains(',')){ pArrayEstu = pArrayEstuF.split(','); }else{ pArrayEstu.add(pArrayEstuF.trim()); }
					if(pArrayButaF.contains(',')){ pArrayButa = pArrayButaF.split(','); }else{ pArrayButa.add(pArrayButaF.trim()); }
					List<Account> inCuentas = new List<Account>();
					List<Account> upCuentas = new List<Account>();
					List<String> identificaciones = new List<String>();
					//Obtener inicio y término de escalas
					Decimal secuenciaInicial = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: origen 
													AND Itinerario__c =: itinerario
													AND Hacer_Escala__c = true].Secuencia__c;
					Decimal secuenciaFinal = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: destino 
												AND Itinerario__c =: itinerario
												AND Hacer_Escala__c = true].Secuencia__c;
					//Escalas dentro de la secuencia
					List<Escalas_Itinerario__c> escalXX = [SELECT Id
															FROM Escalas_Itinerario__c
															WHERE Itinerario__c =: itinerario
															AND Hacer_Escala__c = true
															AND Secuencia__c >=: secuenciaInicial AND Secuencia__c <: secuenciaFinal];
					//Validar si existen identificaciones ya en salesforce
					for(Integer i = 0; i < pArrayDocu.size(); i++){
						pArrayNDoc[i].replace('k','K');
						identificaciones.add(pArrayNDoc[i].replace('k','K').toUpperCase());
					}
					Map<String,Account> oldCuentas = new Map<String, Account>();
					List<Account> oAcc = [SELECT Id, FirstName, LastName, Identificacion__c, Sexo__pc, 
											PersonBirthdate, Tipo_de_Identificacion__c, Phone, PersonEmail
										FROM Account
										WHERE Identificacion__c IN: identificaciones
											AND IsPersonAccount = true];
					for(Account oA : oAcc){
						oldCuentas.put(oA.Identificacion__c, oA);
					}
					//Revisar si existen cuentas 
					List<Capacidad_Tramo_Detalle_Reserva__c> capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
					//Map<String, Detalle_Reserva__c> bDetalleMap = new Map<String, Detalle_Reserva__c>();
					List<Detalle_Reserva__c> detallesReservas = new List<Detalle_Reserva__c>();
					if(oldCuentas.size() > 0){
						for(Integer i = 0; i < pArrayDocu.size(); i++){
							Account oAx = oldCuentas.get(pArrayNDoc[i].replace('k','K').toUpperCase());
							System.debug(pArrayFNac[i]);
							String[] fecNacFull = pArrayFNac[i].split('/');
							Date fechaNac = Date.newInstance(Integer.valueOf(fecNacFull[2]),Integer.valueOf(fecNacFull[1]),Integer.valueOf(fecNacFull[0]));
							System.debug(fechaNac);
							if(oAx != null){
								oAx.FirstName = pArrayName[i];
								oAx.LastName = pArrayLNam[i];
								oAx.Identificacion__c = pArrayNDoc[i].replace('k','K').toUpperCase();
								oAx.PersonBirthdate = Date.valueOf(fechaNac);
								oAx.Tipo_de_identificacion__c = pArrayDocu[i];
								if(pArrayEmai[i] != 'x' && pArrayEmai[i] != 'null'){
									oAx.PersonEmail = pArrayEmai[i];
								}
								if(pArrayTele[i] != 'null'){
									oAx.Phone = formatTelefono(pArrayTele[i]);
								}
								if(pArraySexo[i] == 'Masculino'){
									oAx.Sexo__pc = 'M';
								}else if(pArraySexo[i] == 'Femenino'){
									oAx.Sexo__pc = 'F';
								}
								upCuentas.add(oAx);
								Detalle_Reserva__c dResX;
								dResX = [SELECT Id, Nombre_Pasajero__c, Doc_Identificacion_Pasajero__c, Tipo_de_identificacion__c, Estudiante__c,
											Residente__c, Numero__c
											FROM Detalle_Reserva__c
											WHERE Reserva__r.UUID__c =: uuid
											AND Numero__c =: pArrayButa[i]
											AND RecordTypeId =: rTButaca
											LIMIT 1];
								dResX.Nombre_Pasajero__c = oAx.Id;
								dResX.Doc_Identificacion_Pasajero__c = pArrayNDoc[i].replace('k','K').toUpperCase();
								dResX.Tipo_de_identificacion__c = pArrayDocu[i];
								dResX.Estudiante__c = Boolean.valueOf(pArrayEstu[i]);
								dResX.Residente__c = Boolean.valueOf(pArrayResi[i]);
								detallesReservas.add(dResX);
								//bDetalleMap.put(dResX.Numero__c, dResX);
							}else{
								Account cuenta = new Account();
								cuenta.FirstName = pArrayName[i];
								cuenta.LastName = pArrayLNam[i];
								cuenta.Identificacion__c = pArrayNDoc[i].replace('k','K').toUpperCase();
								cuenta.PersonBirthdate = Date.valueOf(fechaNac);
								cuenta.Tipo_de_identificacion__c = pArrayDocu[i];
								if(pArrayEmai[i] != 'x' && pArrayEmai[i] != 'null'){
									cuenta.PersonEmail = pArrayEmai[i];
								}else{
									cuenta.PersonEmail = '';
								}
								if(pArraySexo[i] == 'Masculino'){
									cuenta.Sexo__pc = 'M';
								}else if(pArraySexo[i] == 'Femenino'){
									cuenta.Sexo__pc = 'F';
								}
								if(pArrayTele[i] != 'null'){
									cuenta.Phone = formatTelefono(pArrayTele[i]);
								}
								try{
									insert cuenta;
								}catch(Exception exCuRe){
									jsonText = '{ "mensaje": "No se pudo generar la cuenta", "estado": false, "indicador": 4, "tipo": "cuenta"}';
								}
								inCuentas.add(cuenta);
								Detalle_Reserva__c dResX;
								dResX = [SELECT Id, Nombre_Pasajero__c, Doc_Identificacion_Pasajero__c, Tipo_de_identificacion__c, Estudiante__c,
											Residente__c, Numero__c
											FROM Detalle_Reserva__c
											WHERE Reserva__r.UUID__c =: uuid
											AND Numero__c =: pArrayButa[i]
											AND RecordTypeId =: rTButaca
											LIMIT 1];
								dResX.Nombre_Pasajero__c = cuenta.Id;
								dResX.Doc_Identificacion_Pasajero__c = pArrayNDoc[i].replace('k','K').toUpperCase();
								dResX.Tipo_de_identificacion__c = pArrayDocu[i];
								dResX.Estudiante__c = Boolean.valueOf(pArrayEstu[i]);
								dResX.Residente__c = Boolean.valueOf(pArrayResi[i]);
								detallesReservas.add(dResX);
								//bDetalleMap.put(dResX.Numero__c, dResX);
							}
						}
					//Si no existen cuentas, se deben crear
					}else{
						for(Integer i = 0; i < pArrayDocu.size(); i++){
							String[] fecNacFull = pArrayFNac[i].split('/');
							Date fechaNac = Date.newInstance(Integer.valueOf(fecNacFull[2]),Integer.valueOf(fecNacFull[1]),Integer.valueOf(fecNacFull[0]));
							System.debug(fechaNac);
							Account cuenta = new Account();
							cuenta.FirstName = pArrayName[i];
							cuenta.LastName = pArrayLNam[i];
							cuenta.Identificacion__c = pArrayNDoc[i].replace('k','K').toUpperCase();
							cuenta.PersonBirthdate = Date.valueOf(fechaNac);
							cuenta.Tipo_de_identificacion__c = pArrayDocu[i];
							if(pArrayEmai[i] != 'x' && pArrayEmai[i] != 'null'){
								cuenta.PersonEmail = pArrayEmai[i];
							}else{
								cuenta.PersonEmail = '';
							}
							if(pArraySexo[i] == 'Masculino'){
								cuenta.Sexo__pc = 'M';
							}else if(pArraySexo[i] == 'Femenino'){
								cuenta.Sexo__pc = 'F';
							}
							if(pArrayTele[i] != 'null'){
								cuenta.Phone = formatTelefono(pArrayTele[i]);
							}
							try{
								insert cuenta;
							}catch(Exception exCuRe){
								jsonText = '{ "mensaje": "No se pudo generar la cuenta", "estado": false, "indicador": 5, "tipo": "cuenta"}';
							}
							inCuentas.add(cuenta);
							Detalle_Reserva__c dResX;
							dResX = [SELECT Id, Nombre_Pasajero__c, Doc_Identificacion_Pasajero__c, Tipo_de_identificacion__c, Estudiante__c,
										Residente__c, Numero__c
										FROM Detalle_Reserva__c
										WHERE Reserva__r.UUID__c =: uuid
										AND Numero__c =: pArrayButa[i]
										AND RecordTypeId =: rTButaca
										LIMIT 1];
							dResX.Nombre_Pasajero__c = cuenta.Id;
							dResX.Doc_Identificacion_Pasajero__c = pArrayNDoc[i].replace('k','K').toUpperCase();
							dResX.Tipo_de_identificacion__c = pArrayDocu[i];
							dResX.Estudiante__c = Boolean.valueOf(pArrayEstu[i]);
							dResX.Residente__c = Boolean.valueOf(pArrayResi[i]);
							detallesReservas.add(dResX);
							//bDetalleMap.put(dResX.Numero__c, dResX);
						}
					}
					//Insertar o Actualizar cuentas
					jsonText = '{ "Resultados": {';
					if(inCuentas.size() > 0){
						jsonText = jsonText + '"Creaciones":"'+inCuentas.size()+'",';
					}
					if(upCuentas.size() > 0){
						update upCuentas;
						jsonText = jsonText + '"Actualizaciones":"'+upCuentas.size()+'"';
					}
					String lastCharacter = jsonText.right(1);
					if(lastCharacter == ','){
						jsonText = jsonText.substring(0,jsonText.length()-1);
					}
					jsonText = jsonText + '}}';
					//Revisar Capacidades y actualizar detalle reservas
					if(detallesReservas.size() > 0){
						update detallesReservas;
						/*Revisar capacidades anteriores
						try{
							List<Capacidad_Tramo_Detalle_Reserva__c> capAnteriores = new List<Capacidad_Tramo_Detalle_Reserva__c>();
							List<Capacidad_Tramo_Detalle_Reserva__c> capReservasAnt = [SELECT Id, Capacidad_Liberada__c, Causa_Liberacion__c
																					FROM Capacidad_Tramo_Detalle_Reserva__c
																					WHERE Capacidad_Tramo__r.Escala_itinerario__c IN: escalXX
																					AND Capacidad_Tramo__r.RecordTypeId =: rTButacaC];
							if(capReservasAnt.size() > 0){
								for(Capacidad_Tramo_Detalle_Reserva__c cDR : capReservasAnt){
									cDR.Capacidad_Liberada__c = true;
									cDR.Causa_Liberacion__c = 'Cambio de butaca';
									capAnteriores.add(cDR);
								}
								if(capAnteriores.size() > 0){
									update capAnteriores;
								}
							}
						}catch(Exception ex){
							System.debug('No existen capacidades anteriores');
						}
						*/
						for(Detalle_Reserva__c dResB : detallesReservas){
							System.debug('Lista Escalas: ');
							System.debug(escalXX);
							System.debug('Numero: ');
							System.debug(dResB.Numero__c);
							System.debug('RecordType Butaca: ');
							System.debug(rTButacaC);
							List<Capacidad_Tramo__c> capViaje;
							capViaje = [SELECT Id 
										FROM Capacidad_Tramo__c
										WHERE Escala_itinerario__c IN: escalXX
											AND Numero__c =: dResB.Numero__c
											AND RecordTypeId =: rTButacaC];
							for(Capacidad_Tramo__c capToAssign : capViaje){
								Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
								String codUnico = capToAssign.Id+''+dResB.Id;
								capNew.Capacidad_Tramo__c = capToAssign.Id;
								capNew.Detalle_Reserva__c = dResB.Id;
								capNew.Identificador__c = codUnico;
								capNew.Capacidad_Comprometida_en_Reserva__c = 1;
								capToCreate.add(capNew);
							}
						}
					}
					//Unir Capacidades
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
											jsonText = '{ "mensaje": "Las capacidades no estan disponibles", "estado": false, "indicador": 67, "tipo": "capacidad", "json":"'+dataR+'"}';
										}
									}
								}
							}
							if(!error){
								//insert capToCreate;
								if(detallesReservas.size() > 0){
									update detallesReservas;
									jsonText = '{ "exitoso": "Registros actualizados", "etapa": "1p" }';
								}else{
									jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar p." }';
								}
							}else{
								jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar 2p." }';
							}
						}catch(Exception ex){
							String mensaje = ex.getMessage();
							if(mensaje.contains('DUPLICATE_VALUE')){
								System.debug('Error');
								System.debug('Tipo de excepción: ' + ex.getTypeName());
								System.debug('Mensaje: ' + ex.getMessage());
								System.debug('Causa: ' + ex.getCause());
								System.debug('Línea: ' + ex.getLineNumber());
								System.debug('Traza: ' + ex.getStackTraceString());
								if(detallesReservas.size() > 0){
									update detallesReservas;
									jsonText = '{ "exitoso": "Registros actualizados", "etapa": "1" }';
								}else{
									jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar." }';
								}
							}else{
								jsonText = '{ "mensaje": "No se pudo generar la capacidad", "estado": false, "indicador": 6, "tipo": "capacidad", "causa": "'+ex.getMessage()+'", "linea":"'+ex.getLineNumber()+'", "tipoEx": "'+ex.getTypeName()+'"}';
							}
						}
						/*
						try{
							insert capToCreate;
						}catch(Exception ex){
							String mensaje = ex.getMessage();
							if(mensaje.contains('DUPLICATE_VALUE')){
								System.debug('Error');
								System.debug('Tipo de excepción: ' + ex.getTypeName());
								System.debug('Mensaje: ' + ex.getMessage());
								System.debug('Causa: ' + ex.getCause());
								System.debug('Línea: ' + ex.getLineNumber());
								System.debug('Traza: ' + ex.getStackTraceString());
							}else{
								jsonText = '{ "mensaje": "Las capacidades no estan disponibles", "estado": false, "indicador": 6, "tipo": "capacidad", "causa": "'+ex.getMessage()+'", "linea":"'+ex.getLineNumber()+'", "tipoEx": "'+ex.getTypeName()+'"}';
							}
						}
						*/
					}
				}
				when '4' {
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String itinerario = ApexPages.currentPage().getParameters().get('i');
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
					String AyIdVeF = ApexPages.currentPage().getParameters().get('AyIdVe');
					String AyPateF = ApexPages.currentPage().getParameters().get('AyPate');
					String AyCondF = ApexPages.currentPage().getParameters().get('AyCond');
					String AyNEmpF = ApexPages.currentPage().getParameters().get('AyNEmp');
					String AEDocuF = ApexPages.currentPage().getParameters().get('AEDocu');
					String AENDocF = ApexPages.currentPage().getParameters().get('AENDoc');
					String AENameF = ApexPages.currentPage().getParameters().get('AEName');
					String AEApelF = ApexPages.currentPage().getParameters().get('AEApel');
					String AETeleF = ApexPages.currentPage().getParameters().get('AETele');
					String ARDocuF = ApexPages.currentPage().getParameters().get('ARDocu');
					String ARNDocF = ApexPages.currentPage().getParameters().get('ARNDoc');
					String ARNameF = ApexPages.currentPage().getParameters().get('ARName');
					String ARApelF = ApexPages.currentPage().getParameters().get('ARApel');
					String ARTeleF = ApexPages.currentPage().getParameters().get('ARTele');
					String[] AyIdVe = new String[]{};
					String[] AyPate = new String[]{};
					String[] AyCond = new String[]{};
					String[] AyNEmp = new String[]{};
					String[] AEDocu = new String[]{};
					String[] AENDoc = new String[]{};
					String[] AEName = new String[]{};
					String[] AEApel = new String[]{};
					String[] AETele = new String[]{};
					String[] ARDocu = new String[]{};
					String[] ARNDoc = new String[]{};
					String[] ARName = new String[]{};
					String[] ARApel = new String[]{};
					String[] ARTele = new String[]{};
					if(AyIdVeF.contains(',')){ AyIdVe = AyIdVeF.split(','); }else{ AyIdVe.add(AyIdVeF); }
					if(AyPateF.contains(',')){ AyPate = AyPateF.split(','); }else{ AyPate.add(AyPateF); }
					if(AyCondF.contains(',')){ AyCond = AyCondF.split(','); }else{ AyCond.add(AyCondF); }
					if(AyNEmpF.contains(',')){ AyNEmp = AyNEmpF.split(','); }else{ AyNEmp.add(AyNEmpF); }
					if(AEDocuF.contains(',')){ AEDocu = AEDocuF.split(','); }else{ AEDocu.add(AEDocuF); }
					if(AENDocF.contains(',')){ AENDoc = AENDocF.split(','); }else{ AENDoc.add(AENDocF); }
					if(AENameF.contains(',')){ AEName = AENameF.split(','); }else{ AEName.add(AENameF); }
					if(AEApelF.contains(',')){ AEApel = AEApelF.split(','); }else{ AEApel.add(AEApelF); }
					if(AETeleF.contains(',')){ AETele = AETeleF.split(','); }else{ AETele.add(AETeleF); }
					if(ARDocuF.contains(',')){ ARDocu = ARDocuF.split(','); }else{ ARDocu.add(ARDocuF); }
					if(ARNDocF.contains(',')){ ARNDoc = ARNDocF.split(','); }else{ ARNDoc.add(ARNDocF); }
					if(ARNameF.contains(',')){ ARName = ARNameF.split(','); }else{ ARName.add(ARNameF); }
					if(ARApelF.contains(',')){ ARApel = ARApelF.split(','); }else{ ARApel.add(ARApelF); }
					if(ARTeleF.contains(',')){ ARTele = ARTeleF.split(','); }else{ ARTele.add(ARTeleF); }
					//Actualizar detalles reserva
					//Obtener inicio y término de escalas
					Decimal secuenciaInicial = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: origen 
													AND Itinerario__c =: itinerario
													AND Hacer_Escala__c = true].Secuencia__c;
					Decimal secuenciaFinal = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: destino 
												AND Itinerario__c =: itinerario
												AND Hacer_Escala__c = true].Secuencia__c;
					//Escalas dentro de la secuencia
					List<Escalas_Itinerario__c> escalXX = [SELECT Id
															FROM Escalas_Itinerario__c
															WHERE Itinerario__c =: itinerario
															AND Hacer_Escala__c = true
															AND Secuencia__c >=: secuenciaInicial AND Secuencia__c <: secuenciaFinal];
					List<Capacidad_Tramo_Detalle_Reserva__c> capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
					List<Detalle_Reserva__c> detallesReservas = new List<Detalle_Reserva__c>();
					//Actualizar detalles reserva
					for(Integer i = 0; i < AyIdVe.size(); i++){
						String[] idVh = AyIdVe[i].split('_');
						Account cuentaEntrega = new Account();
						Account cuentaRecibe = new Account();
						Id cuentaConductorId;
						if(AyCond[i] == 'Sin Conductor'){
							//Crear o buscar cuentas de personas asociadas (retiro y entrega)
							//Cuenta Quien entrega
							try{
								cuentaEntrega = [SELECT Id, FirstName, LastName, Identificacion__c, Sexo__pc, 
												PersonBirthdate, Tipo_de_Identificacion__c, Phone, PersonEmail
												FROM Account
												WHERE Identificacion__c =: AENDoc[i].replace('k','K').toUpperCase()
													AND IsPersonAccount = true
												LIMIT 1];
								cuentaEntrega.FirstName = AEName[i];
								cuentaEntrega.LastName = AEApel[i];
								cuentaEntrega.Phone = formatTelefono(AETele[i]);
								update cuentaEntrega;
							}catch(Exception ex){
								cuentaEntrega.Tipo_de_identificacion__c = AEDocu[i];
								cuentaEntrega.Identificacion__c = AENDoc[i].replace('k','K').toUpperCase();
								cuentaEntrega.FirstName = AEName[i];
								cuentaEntrega.LastName = AEApel[i];
								cuentaEntrega.Phone = formatTelefono(AETele[i]);
								try{
									insert cuentaEntrega;
								}catch(Exception exCuRe){
									jsonText = '{ "mensaje": "No se pudo generar la cuenta", "estado": false, "indicador": 7, "tipo": "cuenta"}';
								}
							}
							//Cuenta quien recibe
							try{
								cuentaRecibe = [SELECT Id, FirstName, LastName, Identificacion__c, Sexo__pc, 
												PersonBirthdate, Tipo_de_Identificacion__c, Phone, PersonEmail
												FROM Account
												WHERE Identificacion__c =: ARNDoc[i].replace('k','K').toUpperCase()
													AND IsPersonAccount = true
												LIMIT 1];
								cuentaRecibe.FirstName = ARName[i];
								cuentaRecibe.LastName = ARApel[i];
								cuentaRecibe.Phone = formatTelefono(ARTele[i]);
								update cuentaRecibe;
							}catch(Exception ex){
								cuentaRecibe.Tipo_de_identificacion__c = ARDocu[i];
								cuentaRecibe.Identificacion__c = ARNDoc[i].replace('k','K').toUpperCase();
								cuentaRecibe.FirstName = ARName[i];
								cuentaRecibe.LastName = ARApel[i];
								cuentaRecibe.Phone = formatTelefono(ARTele[i]);
								try{
									insert cuentaRecibe;
								}catch(Exception exCuRe){
									jsonText = '{ "mensaje": "No se pudo generar la cuenta", "estado": false, "indicador": 8, "tipo": "cuenta"}';
								}
							}
							Detalle_Reserva__c dResX = [SELECT Id, Persona_que_entrega__c, Persona_que_retira__c, Placa_Patente_Vehiculo__c,Residente__c,
															Capacidad_Comprometida__c, Alto__c
														FROM Detalle_Reserva__c
														WHERE Reserva__r.UUID__c =: uuid
														AND Numero__c =: idVh[1]
														AND RecordTypeId =: rTPista
														LIMIT 1];
							dResX.Persona_que_entrega__c = cuentaEntrega.Id;
							dResX.Persona_que_retira__c = cuentaRecibe.Id;
							dResX.Placa_Patente_Vehiculo__c = AyPate[i];
                    List<Residente__c> resList = [ SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
                                                           Comuna__c, N_Certificado__c, Fecha_Certificado__c
                                                    FROM Residente__c 
                                                    WHERE Identificacion__c = :cuentaEntrega.Identificacion__c.replace('k','K').toUpperCase()
                                                    LIMIT 1
                    ];
                    if(!resList.isEmpty()){
                        dResX.Residente__c = true;
                    } else {
                        dResX.Residente__c = false;
                    }
							detallesReservas.add(dResX);
						}else{
							List<Detalle_Reserva__c> dPas = new List<Detalle_Reserva__c>();
							//Asociar a cuenta de pasajero sólo si es vehiculo menor
							System.debug('RCG - Tipo Vehículo-->'+idVh[0]);
							if(idVh[0] == 'Vehiculo Menor' || idVh[0] == 'Motorhome/Bus'){
								List<Detalle_Reserva__c> updDRList = new List<Detalle_Reserva__c>();
								Boolean conductorResidente = false;
								dPas = [SELECT Id, Nombre_Pasajero__c, Conductor__c, Capacidad_Comprometida__c, Alto__c, Tarificar__c, Nombre_Pasajero__r.Identificacion__c, Acompanante__c, Residente__c
										FROM Detalle_Reserva__c
										WHERE Reserva__r.UUID__c =: uuid											
											AND RecordTypeId =: rTButaca];
										System.debug('uuid-->'+uuid);
										System.debug('rTButaca-->'+rTButaca);
										
										for(Detalle_Reserva__c detItem: dPas){
											System.debug('detItem-->'+detItem);
											if(detItem.Nombre_Pasajero__r.Identificacion__c == AyCond[i].replace('k','K').toUpperCase()){
												detItem.Conductor__c = true;
												detItem.Acompanante__c = false;
												detItem.Tarificar__c = true;
												cuentaConductorId = detItem.Id;
												conductorResidente = detItem.Residente__c;
											}else{
												if(!detItem.Conductor__c){
													detItem.Conductor__c = false;
													detItem.Acompanante__c = true;
													detItem.Tarificar__c = true;
												}
											}
											updDRList.add(detItem);
										}
								update updDRList;

								Detalle_Reserva__c dResX = [SELECT Id, Placa_Patente_Vehiculo__c, Residente__c, Capacidad_Comprometida__c, Alto__c, Detalle_Reserva_Conductor__c, Tarificar__c
															FROM Detalle_Reserva__c
															WHERE Reserva__r.UUID__c =: uuid
															AND Numero__c =: idVh[1]
															AND RecordTypeId =: rTPista
															LIMIT 1];
								dResX.Detalle_Reserva_Conductor__c = cuentaConductorId;
								dResX.Placa_Patente_Vehiculo__c = AyPate[i];
								dResX.Residente__c = conductorResidente;
								dResX.Tarificar__c = true;
								detallesReservas.add(dResX);
							}else if(idVh[0] == 'Bicicleta'){
								dPas = [SELECT Id, Nombre_Pasajero__c, Conductor__c, Capacidad_Comprometida__c, Alto__c
										FROM Detalle_Reserva__c
										WHERE Reserva__r.UUID__c =: uuid
											AND Nombre_Pasajero__r.Identificacion__c =: AyCond[i].replace('k','K').toUpperCase()
											AND RecordTypeId =: rTButaca
										LIMIT 1];
								cuentaConductorId = dPas[0].Id;
								Detalle_Reserva__c dResX = [SELECT Id, Placa_Patente_Vehiculo__c, Capacidad_Comprometida__c, Alto__c, Detalle_Reserva_Conductor__c, Tarificar__c
															FROM Detalle_Reserva__c
															WHERE Reserva__r.UUID__c =: uuid
															AND Numero__c =: idVh[1]
															AND RecordTypeId =: rTBicicleta
															LIMIT 1];
								dResX.Detalle_Reserva_Conductor__c = cuentaConductorId;
								dResX.Tarificar__c = true;
								detallesReservas.add(dResX);
							}else{
								dPas = [SELECT Id, Nombre_Pasajero__c, Conductor__c, Capacidad_Comprometida__c, Alto__c, Residente__c
										FROM Detalle_Reserva__c
										WHERE Reserva__r.UUID__c =: uuid
											AND Nombre_Pasajero__r.Identificacion__c =: AyCond[i].replace('k','K').toUpperCase()
											AND RecordTypeId =: rTButaca
										LIMIT 1];
								cuentaConductorId = dPas[0].Id;
								Detalle_Reserva__c dResX = [SELECT Id, Placa_Patente_Vehiculo__c, Capacidad_Comprometida__c, Alto__c, Detalle_Reserva_Conductor__c, Tarificar__c, Residente__c
															FROM Detalle_Reserva__c
															WHERE Reserva__r.UUID__c =: uuid
															AND Numero__c =: idVh[1]
															AND RecordTypeId =: rTPista
															LIMIT 1];
								dResX.Detalle_Reserva_Conductor__c = cuentaConductorId;
								dResX.Residente__c = dPas[0].Residente__c;
								dResX.Placa_Patente_Vehiculo__c = AyPate[i];
								dResX.Tarificar__c = true;
								detallesReservas.add(dResX);
							}
						}
					}
					//Revisar Capacidades y actualizar detalle reservas
					if(detallesReservas.size() > 0){
						System.debug('escalXX: '+escalXX);
						System.debug('rTPista: '+rTPista);
						Boolean masCapacidad = false;
						for(Detalle_Reserva__c dResB : detallesReservas){
							System.debug('Alto__c: '+dResB.Alto__c);
							System.debug('Capacidad_Comprometida__c: '+dResB.Capacidad_Comprometida__c);
							if(dResB.Alto__c != null && dResB.Capacidad_Comprometida__c != null){
								List<Capacidad_Tramo__c> capViaje = [SELECT Id, Numero__c, Ubicacion__c, Capacidad_Disponible__c 
																	FROM Capacidad_Tramo__c
																	WHERE Escala_itinerario__c IN: escalXX
																		AND RecordTypeId =: rTPistaC
																		AND Alto__c >=: dResB.Alto__c
																	ORDER BY Numero__c ASC];
								/*
								List<Capacidad_Tramo__c> capViaje = [SELECT Id, Ubicacion__c
														FROM Capacidad_Tramo__c
														WHERE Escala_Itinerario__c IN: escalXX
														AND RecordTypeId =: rTPistaC
														AND Numero__c =: capViaje1.Numero__c];
								*/
								String ubicacion = '';
								Decimal capRestante = 0.0;
								Decimal capNecesitada = dResB.Capacidad_Comprometida__c;
								for(Capacidad_Tramo__c capToAssign : capViaje){
									capNecesitada = capNecesitada - capToAssign.Capacidad_Disponible__c;
									ubicacion = capToAssign.Ubicacion__c;
									if(masCapacidad){
										System.debug('Capacidad Restante: '+capRestante);
										Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
										String codUnico = capToAssign.Id+''+dResB.Id;
										capNew.Capacidad_Tramo__c = capToAssign.Id;
										capNew.Detalle_Reserva__c = dResB.Id;
										capNew.Identificador__c = codUnico;
										capNew.Capacidad_Comprometida_en_Reserva__c = 1;
										capToCreate.add(capNew);
										if(capNecesitada <= 0){
											masCapacidad = false;
										}
									}
								}
								dResB.Ubicacion__c = ubicacion;
							}
						}
						//update detallesReservas;
					}
					//Unir Capacidades
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
											jsonText = '{ "mensaje": "Las capacidades no estan disponibles", "estado": false, "indicador": 6, "tipo": "capacidad", "json":"'+dataR+'"}';
										}
									}
								}
							}
							if(!error){
								//insert capToCreate;
								if(detallesReservas.size() > 0){
									update detallesReservas;
									jsonText = '{ "exitoso": "Registros actualizados", "etapa": "1" }';
								}else{
									jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar." }';
								}
							}else{
								jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar 2." }';
							}
						}catch(Exception ex){
							String mensaje = ex.getMessage();
							if(mensaje.contains('DUPLICATE_VALUE')){
								System.debug('Error');
								System.debug('Tipo de excepción: ' + ex.getTypeName());
								System.debug('Mensaje: ' + ex.getMessage());
								System.debug('Causa: ' + ex.getCause());
								System.debug('Línea: ' + ex.getLineNumber());
								System.debug('Traza: ' + ex.getStackTraceString());
								if(detallesReservas.size() > 0){
									update detallesReservas;
									jsonText = '{ "exitoso": "Registros actualizados", "etapa": "1" }';
								}else{
									jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar." }';
								}
							}else{
								jsonText = '{ "mensaje": "No se pudo generar la capacidad", "estado": false, "indicador": 9, "tipo": "capacidad", "causa": "'+ex.getMessage()+'", "linea":"'+ex.getLineNumber()+'", "tipoEx": "'+ex.getTypeName()+'"}';
							}
						}
					}else{
						if(detallesReservas.size() > 0){
							update detallesReservas;
							jsonText = '{ "exitoso": "Registros actualizados", "etapa": "2" }';
						}else{
							jsonText = '{ "exitoso": "error", "msg": "No existen datos para guardar." }';
						}
					}
				}
				 when '4a'{
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String itinerario = ApexPages.currentPage().getParameters().get('i');
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
					List<Detalle_Reserva__c> detVehiculos = [SELECT Id, Tarificar__c
														FROM Detalle_Reserva__c
														WHERE (RecordTypeId =: rTPista)
															AND Reserva__r.UUID__c =: uuid];
					for(Detalle_Reserva__c dVeh : detVehiculos){
						dVeh.Tarificar__c = true;
					}
					update detVehiculos;
					detVehiculos = [SELECT Tarificacion_validada__c
									FROM Detalle_Reserva__c
									WHERE (RecordTypeId =: rTPista)
										AND Reserva__r.UUID__c =: uuid];
					jsonText = '{ "reserva": {';
					jsonText = jsonText + ' "vehiculos": [';
					for(Detalle_Reserva__c dRe : detVehiculos){
						jsonText = jsonText + '{';
						jsonText = jsonText + '"tarifaExistente": '+dRe.Tarificacion_validada__c+'';
						jsonText = jsonText + '},';
					}
					String lastCharacter = jsonText.right(1);
					if(lastCharacter == ','){
						jsonText = jsonText.substring(0,jsonText.length()-1);
					}
					jsonText = jsonText + ']}}';
				}
				when '5' {
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String itinerario = ApexPages.currentPage().getParameters().get('i');
					origen = ApexPages.currentPage().getParameters().get('o');
					destino = ApexPages.currentPage().getParameters().get('d');
					String carga = ApexPages.currentPage().getParameters().get('carga');
					String cEDoc = ApexPages.currentPage().getParameters().get('cEDoc');
					String cENdo = ApexPages.currentPage().getParameters().get('cENdo');
					String cENam = ApexPages.currentPage().getParameters().get('cENam');
					String cEApe = ApexPages.currentPage().getParameters().get('cEApe');
					String cETel = ApexPages.currentPage().getParameters().get('cETel');
					String cRDoc = ApexPages.currentPage().getParameters().get('cRDoc');
					String cRNdo = ApexPages.currentPage().getParameters().get('cRNdo');
					String cRNam = ApexPages.currentPage().getParameters().get('cRNam');
					String cRApe = ApexPages.currentPage().getParameters().get('cRApe');
					String cRTel = ApexPages.currentPage().getParameters().get('cRTel');
					String cObse = ApexPages.currentPage().getParameters().get('cObse');
					//Actualizar detalles reserva
					//Obtener inicio y término de escalas
					Decimal secuenciaInicial = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: origen 
													AND Itinerario__c =: itinerario
													AND Hacer_Escala__c = true].Secuencia__c;
					Decimal secuenciaFinal = [SELECT Secuencia__c 
												FROM Escalas_Itinerario__c 
												WHERE Puerto_Embarque__r.Name =: destino 
												AND Itinerario__c =: itinerario
												AND Hacer_Escala__c = true].Secuencia__c;
					//Escalas dentro de la secuencia
					List<Escalas_Itinerario__c> escalXX = [SELECT Id
															FROM Escalas_Itinerario__c
															WHERE Itinerario__c =: itinerario
															AND Hacer_Escala__c = true
															AND Secuencia__c >=: secuenciaInicial AND Secuencia__c <: secuenciaFinal];
					List<Capacidad_Tramo_Detalle_Reserva__c> capToCreate = new List<Capacidad_Tramo_Detalle_Reserva__c>();
					//Crear o buscar cuentas de personas asociadas (retiro y entrega)
					Account cuentaEntrega = new Account();
					Account cuentaRecibe = new Account();
					//Cuenta quien entrega
					try{
						cuentaEntrega = [SELECT Id, FirstName, LastName, Identificacion__c, Sexo__pc, 
											PersonBirthdate, Tipo_de_Identificacion__c, Phone, PersonEmail
											FROM Account
											WHERE Identificacion__c =: cENdo.replace('k','K').toUpperCase()
												AND IsPersonAccount = true
											LIMIT 1];
						cuentaEntrega.FirstName = cENam;
						cuentaEntrega.LastName = cEApe;
						cuentaEntrega.Phone = formatTelefono(cETel);
						update cuentaEntrega;
					}catch(Exception ex){
						cuentaEntrega.Tipo_de_identificacion__c = cEDoc;
						cuentaEntrega.Identificacion__c = cENdo.replace('k','K').toUpperCase();
						cuentaEntrega.FirstName = cENam;
						cuentaEntrega.LastName = cEApe;
						cuentaEntrega.Phone = formatTelefono(cETel);
						try{
							insert cuentaEntrega;
						}catch(Exception exCuRe){
							jsonText = '{ "mensaje": "No se pudo generar la cuenta", "estado": false, "indicador": 10, "tipo": "cuenta"}';
						}
					}
					//Cuenta quien recibe
					try{
						cuentaRecibe = [SELECT Id, FirstName, LastName, Identificacion__c, Sexo__pc, 
											PersonBirthdate, Tipo_de_Identificacion__c, Phone, PersonEmail
										FROM Account
										WHERE Identificacion__c =: cRNdo.replace('k','K').toUpperCase()
											AND IsPersonAccount = true
										LIMIT 1];
						cuentaRecibe.FirstName = cRNam;
						cuentaRecibe.LastName = cRApe;
						cuentaRecibe.Phone = formatTelefono(cRTel);
						update cuentaRecibe;
					}catch(Exception ex){
						cuentaRecibe.Tipo_de_identificacion__c = cRDoc;
						cuentaRecibe.Identificacion__c = cRNdo.replace('k','K').toUpperCase();
						cuentaRecibe.FirstName = cRNam;
						cuentaRecibe.LastName = cRApe;
						cuentaRecibe.Phone = formatTelefono(cRTel);
						try{
							insert cuentaRecibe;
						}catch(Exception exCuRe){
							jsonText = '{ "mensaje": "No se pudo generar la cuenta", "estado": false, "indicador": 11, "tipo": "cuenta"}';
						}
					}
					//Actualizar detalle reserva
					Detalle_Reserva__c dResX = [SELECT Id, Persona_que_entrega__c, Persona_que_retira__c, Tipo_de_Carga__c, Tarificar__c,Residente__c
												FROM Detalle_Reserva__c
												WHERE Reserva__r.UUID__c =: uuid
												AND RecordTypeId =: rTCarga
												LIMIT 1];
					dResX.Persona_que_entrega__c = cuentaEntrega.Id;
					dResX.Persona_que_retira__c = cuentaRecibe.Id;
					dResX.Tipo_de_Carga__c = cObse;
                    List<Residente__c> resList = [ SELECT Id, Name, Identificacion__c, Nombre_del_Residente__c, Tipo_Identificacion__c, 
                                                           Comuna__c, N_Certificado__c, Fecha_Certificado__c
                                                    FROM Residente__c 
                                                    WHERE Identificacion__c = :cuentaEntrega.Identificacion__c.replace('k','K').toUpperCase()
                                                    LIMIT 1
                    ];
                    if(!resList.isEmpty()){
                        dResX.Residente__c = true;
                    } else {
                        dResX.Residente__c = false;
                    }
					dResX.Tarificar__c = true;
					update dResX;
					//Revisar Capacidades y actualizar detalle reservas
					List<Capacidad_Tramo__c> capViaje = [SELECT Id 
														FROM Capacidad_Tramo__c
														WHERE Escala_itinerario__c IN: escalXX
														AND RecordTypeId =: rTCargaC];
					for(Capacidad_Tramo__c capToAssign : capViaje){
						Capacidad_Tramo_Detalle_Reserva__c capNew = new Capacidad_Tramo_Detalle_Reserva__c();
						String codUnico = capToAssign.Id+''+dResX.Id;
						capNew.Capacidad_Tramo__c = capToAssign.Id;
						capNew.Detalle_Reserva__c = dResX.Id;
						capNew.Identificador__c = codUnico;
						capNew.Capacidad_Comprometida_en_Reserva__c = Decimal.valueOf(carga);
						capToCreate.add(capNew);
					}
					//Unir Capacidades
					if(capToCreate.size() > 0){
						try{
							insert capToCreate;
							jsonText = '{ "exitoso": "Registros creados" }';
						}catch(Exception ex){
							String mensaje = ex.getMessage();
							if(mensaje.contains('DUPLICATE_VALUE')){
								System.debug('Error');
								System.debug('Tipo de excepción: ' + ex.getTypeName());
								System.debug('Mensaje: ' + ex.getMessage());
								System.debug('Causa: ' + ex.getCause());
								System.debug('Línea: ' + ex.getLineNumber());
								System.debug('Traza: ' + ex.getStackTraceString());
							}else{
								jsonText = '{ "mensaje": "Las capacidades no estan disponibles", "estado": false, "indicador": 12, "tipo": "capacidad", "causa": "'+ex.getMessage()+'", "linea":"'+ex.getLineNumber()+'", "tipoEx": "'+ex.getTypeName()+'"}';
							}
						}
					}
				}
				when '6' {
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					Boolean tarifaExiste = false;
					List<Detalle_Reserva__c> detFull = [SELECT Id, Tarificar__c FROM Detalle_Reserva__c WHERE Reserva__r.UUID__c =: uuid];
					for(Detalle_Reserva__c dFu : detFull){
						dFu.Tarificar__c = true;
						update dFu;
					}
					//update detFull;
					List<Detalle_Reserva__c> detPeople = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
															Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
															Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, Acompanante__c,
															Tarificacion_validada__c
														FROM Detalle_Reserva__c
														WHERE RecordTypeId =: rTButaca
															AND Reserva__r.UUID__c =: uuid
															AND Sin_acomodacion__c = false];
					List<Detalle_Reserva__c> detSinAcomodacion = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
																	Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
																	Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, 
																	Tarificacion_validada__c
																 FROM Detalle_Reserva__c
																 WHERE RecordTypeId =: rTButaca
																	 AND Reserva__r.UUID__c =: uuid
																	 AND Sin_acomodacion__c = true];
					List<Detalle_Reserva__c> detVehiculos = [SELECT Id, Placa_Patente_Vehiculo__c, Categoria_de_Vehiculo__c, Tipo_de_Vehiculo__c, Carro_Arrastre__c, 
															Porta_Equipaje__c, Porta_Bicicleta__c, Capacidad_Comprometida__c, Valor_Veh_culo_DR__c,
															Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Detalle_Reserva__c, Valor_ML_DR__c, 
															Tarificacion_validada__c
														FROM Detalle_Reserva__c
														WHERE (RecordTypeId =: rTPista OR RecordTypeId =: rTBicicleta)
															AND Reserva__r.UUID__c =: uuid];
					List<Detalle_Reserva__c> detCargas = [SELECT Id, Capacidad_Comprometida__c, Persona_que_entrega__r.Name, Persona_que_retira__r.Name,
															Persona_que_entrega__r.Identificacion__c, Persona_que_retira__r.Identificacion__c,
															Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Carga_DR__c, Valor_Detalle_Reserva__c, 
															Tarificacion_validada__c
														FROM Detalle_Reserva__c
														WHERE RecordTypeId =: rTCarga
															AND Reserva__r.UUID__c =: uuid];
					jsonText = '{ "reserva": {';
					jsonText = jsonText + ' "pasajeros": [';
					for(Detalle_Reserva__c dRe : detPeople){
						jsonText = jsonText + '{';
						jsonText = jsonText + '"identificacion":"'+dRe.Doc_Identificacion_Pasajero__c+'",';
						jsonText = jsonText + '"nombre":"'+dRe.Nombre_Pasajero__r.Name+'",';
						jsonText = jsonText + '"numero":"'+dRe.Numero__c+'",';
						jsonText = jsonText + '"conductor":'+dRe.Conductor__c+',';
						jsonText = jsonText + '"acompanante":'+dRe.Acompanante__c+',';
						jsonText = jsonText + '"estudiante":'+dRe.Estudiante__c+',';
						jsonText = jsonText + '"residente":'+dRe.Residente__c+',';
						jsonText = jsonText + '"discapacitado":'+dRe.Nombre_Pasajero__r.Discapacidad__pc+',';
						Decimal tasa = 0;
						if(dRe.Tasa_Desembarque__c > 0){
							tasa = tasa + dRe.Tasa_Desembarque__c;
						}
						if(dRe.Tasa_Embarque__c > 0){
							tasa = tasa + dRe.Tasa_Embarque__c;
						}
						String tasaTexto = '';
						tasaTexto = formatDecimal(tasa, 0);
						jsonText = jsonText + '"tasaEmbarque":"'+tasaTexto+'",';
						jsonText = jsonText + '"tasaEmbarqueReal":"'+tasa+'",';
						String trasladoTexto = '';
						trasladoTexto = formatDecimal(dRe.Valor_Pasajero_DR__c, 0);
						jsonText = jsonText + '"traslado":"'+trasladoTexto+'",';
						jsonText = jsonText + '"trasladoReal":"'+dRe.Valor_Pasajero_DR__c+'",';
						String pasajeTexto = '';
						pasajeTexto = formatDecimal(dRe.Valor_Detalle_Reserva__c, 0);
						jsonText = jsonText + '"pasaje":"'+pasajeTexto+'",';
						jsonText = jsonText + '"pasajeReal":"'+dRe.Valor_Detalle_Reserva__c+'",';
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
						String tasaTexto = '';
						tasaTexto = formatDecimal(tasa, 0);
						jsonText = jsonText + '"tasaEmbarque":"'+tasaTexto+'",';
						jsonText = jsonText + '"tasaEmbarqueReal":"'+tasa+'",';
						Decimal valorTraslado = 0;
						if(dRe.Valor_ML_DR__c > 0){
							valorTraslado = valorTraslado + dRe.Valor_ML_DR__c;
						}
						if(dRe.Valor_Veh_culo_DR__c > 0){
							valorTraslado = valorTraslado + dRe.Valor_Veh_culo_DR__c;
						}
						String trasladoTexto = '';
						trasladoTexto = formatDecimal(valorTraslado, 0);
						jsonText = jsonText + '"traslado":"'+trasladoTexto+'",';
						jsonText = jsonText + '"trasladoReal":"'+valorTraslado+'",';
						String pasajeTexto = '';
						pasajeTexto = formatDecimal(dRe.Valor_Detalle_Reserva__c, 0);
						jsonText = jsonText + '"pasaje":"'+pasajeTexto+'",';
						jsonText = jsonText + '"pasajeReal":"'+dRe.Valor_Detalle_Reserva__c+'",';
						tarifaExiste = dRe.Tarificacion_validada__c;
						jsonText = jsonText + '"tarifaExistente": '+tarifaExiste+'';
						jsonText = jsonText + '},';
					}
					lastCharacter = jsonText.right(1);
					if(lastCharacter == ','){
						jsonText = jsonText.substring(0,jsonText.length()-1);
					}
					jsonText = jsonText + '], "sinAcomodacion": [';
					for(Detalle_Reserva__c dRe : detSinAcomodacion){
						jsonText = jsonText + '{';
						jsonText = jsonText + '"identificacion":"'+dRe.Doc_Identificacion_Pasajero__c+'",';
						jsonText = jsonText + '"nombre":"'+dRe.Nombre_Pasajero__r.Name+'",';
						jsonText = jsonText + '"numero":"'+dRe.Numero__c+'",';
						jsonText = jsonText + '"conductor":'+dRe.Conductor__c+',';
						jsonText = jsonText + '"estudiante":'+dRe.Estudiante__c+',';
						jsonText = jsonText + '"residente":'+dRe.Residente__c+',';
						jsonText = jsonText + '"discapacitado":'+dRe.Nombre_Pasajero__r.Discapacidad__pc+',';
						Decimal tasa = 0;
						if(dRe.Tasa_Desembarque__c > 0){
							tasa = tasa + dRe.Tasa_Desembarque__c;
						}
						if(dRe.Tasa_Embarque__c > 0){
							tasa = tasa + dRe.Tasa_Embarque__c;
						}
						String tasaTexto = '';
						tasaTexto = formatDecimal(tasa, 0);
						jsonText = jsonText + '"tasaEmbarque":"'+tasaTexto+'",';
						jsonText = jsonText + '"tasaEmbarqueReal":"'+tasa+'",';
						String trasladoTexto = '';
						trasladoTexto = formatDecimal(dRe.Valor_Pasajero_DR__c, 0);
						jsonText = jsonText + '"traslado":"'+trasladoTexto+'",';
						jsonText = jsonText + '"trasladoReal":"'+dRe.Valor_Pasajero_DR__c+'",';
						String pasajeTexto = '';
						pasajeTexto = formatDecimal(dRe.Valor_Detalle_Reserva__c, 0);
						jsonText = jsonText + '"pasaje":"'+pasajeTexto+'",';
						jsonText = jsonText + '"pasajeReal":"'+dRe.Valor_Detalle_Reserva__c+'",';
						tarifaExiste = dRe.Tarificacion_validada__c;
						jsonText = jsonText + '"tarifaExistente": '+tarifaExiste+'';
						jsonText = jsonText + '},';
					}
					lastCharacter = jsonText.right(1);
					if(lastCharacter == ','){
						jsonText = jsonText.substring(0,jsonText.length()-1);
					}
					jsonText = jsonText + '], "carga": {';
					for(Detalle_Reserva__c dCa : detCargas){
						jsonText = jsonText + '"pallets":"'+dCa.Capacidad_Comprometida__c+'",';
						jsonText = jsonText + '"nombreentrega":"'+dCa.Persona_que_entrega__r.Name+'",';
						jsonText = jsonText + '"nombreretira":"'+dCa.Persona_que_retira__r.Name+'",';
						jsonText = jsonText + '"rutentrega":"'+dCa.Persona_que_entrega__r.Identificacion__c+'",';
						jsonText = jsonText + '"rutretira":"'+dCa.Persona_que_retira__r.Identificacion__c+'",';
						Decimal tasa = 0;
						if(dCa.Tasa_Desembarque__c > 0){
							tasa = tasa + dCa.Tasa_Desembarque__c;
						}
						if(dCa.Tasa_Embarque__c > 0){
							tasa = tasa + dCa.Tasa_Embarque__c;
						}
						String tasaTexto = '';
						tasaTexto = formatDecimal(tasa, 0);
						jsonText = jsonText + '"tasaEmbarque":"'+tasaTexto+'",';
						jsonText = jsonText + '"tasaEmbarqueReal":"'+tasa+'",';
						String trasladoTexto = '';
						trasladoTexto = formatDecimal(dCa.Valor_Carga_DR__c, 0);
						jsonText = jsonText + '"traslado":"'+trasladoTexto+'",';
						jsonText = jsonText + '"trasladoReal":"'+dCa.Valor_Carga_DR__c+'",';
						String pasajeTexto = '';
						pasajeTexto = formatDecimal(dCa.Valor_Detalle_Reserva__c, 0);
						jsonText = jsonText + '"pasaje":"'+pasajeTexto+'",';
						jsonText = jsonText + '"pasajeReal":"'+dCa.Valor_Detalle_Reserva__c+'",';
						tarifaExiste = dCa.Tarificacion_validada__c;
						jsonText = jsonText + '"tarifaExistente": '+tarifaExiste+'';
					}
					jsonText = jsonText + ' }}}';
				}
				when '7'{
					String uuid = ApexPages.currentPage().getParameters().get('uuid');
					String jsonText = '';
					List<Reserva__c> reservas = [SELECT Id, Estado_de_Reserva__c, UUID__c FROM Reserva__c WHERE UUID__c =:uuid];
					if(reservas.size() > 0){
						for(Reserva__c resX : reservas){
							resX.Estado_de_Reserva__c = 'Anulada';
							resX.UUID__c = resX.UUID__c + 'AG';
						}
						update reservas;
						jsonText = '{ "estado": "ok", "mensaje": "Reserva anulada." }';
					}else{
						jsonText = '{ "estado": "error", "mensaje": "No existe la reserva." }';
					}
				}
			}
		}catch(Exception exMaster){
			String jsonText = '{ "estado": "error", "mensaje": "Problemas en el proceso, valide con un administrador" }';
			String uuid = ApexPages.currentPage().getParameters().get('uuid');
			List<Reserva__c> reservas = [SELECT Id, Mensajes_Sistema__c FROM Reserva__c WHERE UUID__c =:uuid];
			if(reservas.size() > 0){
				String message = System.today().format() + ' Error: [ Tipo de excepción: ' + exMaster.getTypeName()
								+ ' | Mensaje: ' + exMaster.getMessage()
								+ ' | Causa: ' + exMaster.getCause()
								+ ' | Línea: ' + exMaster.getLineNumber()
								+ ' | Traza: ' + exMaster.getStackTraceString() +' ] <br />';
				for(Reserva__c resX : reservas){
					resX.Mensajes_Sistema__c = message + ' ' + resX.Mensajes_Sistema__c;
				}
				update reservas;
			}
			System.debug(exMaster);
		}
		return null;
	}
	public String formatTelefono(String telefono){
		String toReturn = '';
		if(telefono != ''){
			if(telefono.length() < 8){
				telefono = '22'+telefono;
			}
			if(telefono.trim().startsWith('56')){
				toReturn = '+'+telefono.trim();
			}else if(!telefono.trim().startsWith('+56')){
				toReturn = '+56'+telefono.trim();
			}else{
				toReturn = telefono.trim();
			}
		}		
		return toReturn;
	}
    //Funcion para formatear un numero
    public static String formatDecimal(Decimal value, Integer scale) {
        String retval = '';
        if(value != null) {
            if(scale == null) {
                scale = value.scale();
            }
            retval = value.format();
            if(scale <= 0) {
                retval = Decimal.valueOf(value.round()).format().replace(',','.');
            }else if(scale > 0 && scale <= 18){
                Long modulus = Long.valueOf('1000000000000000000'.left(scale+1));
                Long msd = (Math.abs(value)*modulus).round();
                Long lsd = Math.mod(msd,modulus);
                msd = ((value > 0)?(msd - lsd):(lsd - msd))/modulus;
                retval = Decimal.valueOf(msd).format().replace(',','.')+','+(String.valueOf(modulus+lsd).substring(1));
            }
        }
        return retval;
    }
    //Funcion para generar un código con la capacidad
    public static String codigoCapacidad(Capacidad_Tramo__c cap){
		String codeValue = '';
		if(cap.Numero__c != null){
			codeValue = String.valueOf(cap.Numero__c);
		}
		if(cap.Ubicacion__c != null){
			codeValue = codeValue + String.valueOf(cap.Ubicacion__c);
		}
		if(cap.Capacidad__c != null){
			codeValue = codeValue + String.valueOf(cap.Capacidad__c);
		}
		if(cap.Unidad_de_medida__c != null){
			codeValue = codeValue + String.valueOf(cap.Unidad_de_medida__c);
		}
		if(cap.Categoria__c != null){
			codeValue = codeValue + String.valueOf(cap.Categoria__c);
		}
		//codeValue = codeValue + cap.Id;
        return codeValue;
    }
}