/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Esteban Flores (EFR)
Proyecto: Naviera Austral
Descripción: Clase para pagina de resumen de reservas
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     10-01-2022   EFR      Creación de la Clase.
2.0		17-01-2023	 EFR	  Agregar datos de ejecutivo.
***********************************************************************************/
public class NAV_ResumenVFController  {
	public Id iReserva { get; set; }
	public String contacto { get; set; }
	public String identificacionContacto { get; set; }
	public String tipoIdentificacionContacto { get; set; }
	public String origen { get; set; }
	public String destino { get; set; }
	public String ruta { get; set; }
	public String nave { get; set; }
	public String fechaHora { get; set; }
	public String fechaReserva { get; set; }
	public String codigoReserva { get; set; }
	public String total { get; set; }
	public String corteTabla { get; set; }
	public String eAgencia { get; set; }
	public String eNombre { get; set; }
	public String eCorreo { get; set; }
	public String eTelefono { get; set; }
	public List<Detalle_Reserva__c> rPersonas{ get; set; }
	public List<Detalle_Reserva__c> rSinAcomodacion{ get; set; }
	public List<Detalle_Reserva__c> rVehiculos{ get; set; }
	public List<Detalle_Reserva__c> rCargas{ get; set; }
	public List<Detalle_Reserva__c> rTransbordos { get; set; }
	public NAV_ResumenVFController(ApexPages.StandardController sCtrl){
		iReserva = ApexPages.CurrentPage().getParameters().get('id');
		Schema.DescribeFieldResult sucursalDatos = User.Sucursal__c.getDescribe();
		List<Schema.PicklistEntry> sucursalValor = sucursalDatos.getPicklistValues();
		Id rTButaca = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
		Id rTPista = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
		Id rTCarga = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId();
		Id rTBicicleta = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId();
		Id rTButacaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca Lectura').getRecordTypeId();
		Id rTPistaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista Lectura').getRecordTypeId();
		Id rTCargaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet Lectura').getRecordTypeId();
		Id rTBicicletaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas Lectura').getRecordTypeId();
		Id rTTransbordo = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Venta Cruzada').getRecordTypeId();
		Reserva__c reservaData = [SELECT ORIGEN_DESTINO__c, Ruta_Nave__c, Fecha_Hora_de_Viaje__c, Total_reserva__c, Expiracion__c, Fecha_de_Reserva__c,
									Contacto_Reserva__r.Name, Contacto_Reserva__r.Identificacion__c, Contacto_Reserva__r.Tipo_de_Identificacion__c,
									Puerto_ORIGEN__r.Name, Puerto_DESTINO__r.Name, Itinerario_asociado__r.Nave__c, Itinerario_asociado__r.Nombre_Ruta__r.Name,
									CreatedBy.Name, CreatedBy.Email, CreatedBy.Sucursal__c, CreatedBy.Phone, Codigo_Reserva__c
								  FROM Reserva__c 
								  WHERE Id =: iReserva];
		contacto = reservaData.Contacto_Reserva__r.Name;
		identificacionContacto = reservaData.Contacto_Reserva__r.Identificacion__c;
		tipoIdentificacionContacto = reservaData.Contacto_Reserva__r.Tipo_de_Identificacion__c;
		origen = reservaData.Puerto_ORIGEN__r.Name;
		destino = reservaData.Puerto_DESTINO__r.Name;
		ruta = reservaData.Itinerario_asociado__r.Nombre_Ruta__r.Name;
		nave = reservaData.Itinerario_asociado__r.Nave__c;
		fechaHora = reservaData.Fecha_Hora_de_Viaje__c.format();
		total = FormatMonto(String.valueOf(reservaData.Total_reserva__c));
		//expiracion = reservaData.Expiracion__c.format();
		codigoReserva = reservaData.Codigo_Reserva__c;
		fechaReserva = reservaData.Fecha_de_Reserva__c.format();
		for( Schema.PicklistEntry sV : sucursalValor) {
			if(sV.getValue() == reservaData.CreatedBy.Sucursal__c){
				eAgencia = sV.getLabel();
			}
		}
		eNombre = reservaData.CreatedBy.Name;
		eCorreo = reservaData.CreatedBy.Email;
		eTelefono = reservaData.CreatedBy.Phone;
		corteTabla = '</table><table width="100%" class="tablaCompleta" cellpading="0" cellspacing="0" style="page-break-before:always;">';
		rPersonas = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
						Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
						Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, 
						Tarificacion_validada__c
					 FROM Detalle_Reserva__c
					 WHERE Reserva__c =: iReserva
					 	AND (RecordTypeId =: rTButaca OR RecordTypeId =: rTButacaL)
						AND Item_Anulado__c = false
						AND Sin_Acomodacion__c = false];
		rSinAcomodacion = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
							Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
							Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, 
							Tarificacion_validada__c
						   FROM Detalle_Reserva__c
						   WHERE Reserva__c =: iReserva
							AND (RecordTypeId =: rTButaca OR RecordTypeId =: rTButacaL)
							AND Item_Anulado__c = false
							AND Sin_Acomodacion__c = true];
		rVehiculos = [SELECT Id, Placa_Patente_Vehiculo__c, Categoria_de_Vehiculo__c, Tipo_de_Vehiculo__c, Carro_Arrastre__c, 
						Porta_Equipaje__c, Porta_Bicicleta__c, Capacidad_Comprometida__c, Valor_Veh_culo_DR__c,
						Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Detalle_Reserva__c, Valor_ML_DR__c, 
						Tarificacion_validada__c
					  FROM Detalle_Reserva__c
					  WHERE Reserva__c =: iReserva 
					  	AND (RecordTypeId =: rTPista OR RecordTypeId =: rTBicicleta OR RecordTypeId =: rTPistaL OR RecordTypeId =: rTBicicletaL)
						AND Item_Anulado__c = false];
		rCargas = [SELECT Id, Capacidad_Comprometida__c, Persona_que_entrega__r.Name, Persona_que_retira__r.Name,
					Persona_que_entrega__r.Identificacion__c, Persona_que_retira__r.Identificacion__c,
					Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Carga_DR__c, Valor_Detalle_Reserva__c, 
					Tarificacion_validada__c
				   FROM Detalle_Reserva__c
				   WHERE Reserva__c =: iReserva
				   	AND (RecordTypeId =: rTCarga OR RecordTypeId =: rTCargaL)
					AND Item_Anulado__c = false];
		rTransbordos = [SELECT Id, Cantidad__c, VCLugar__c, VCMateria__c, VCProveedor__c, VCTipo__c, 
					VC_Valor_Bruto__c, VC_Valor_Neto__c, Valor_Detalle_Reserva__c, 
					Tarificacion_validada__c
					FROM Detalle_Reserva__c
					WHERE Reserva__c =: iReserva
						AND (RecordTypeId =: rTTransbordo)
						AND Item_Anulado__c = false];
		reviewData(rPersonas, rVehiculos, rCargas, rTransbordos, rSinAcomodacion);
	}
	public NAV_ResumenVFController(String idRes){
		iReserva = idRes;
		Schema.DescribeFieldResult sucursalDatos = User.Sucursal__c.getDescribe();
		List<Schema.PicklistEntry> sucursalValor = sucursalDatos.getPicklistValues();
		Id rTButaca = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca').getRecordTypeId();
		Id rTPista = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista').getRecordTypeId();
		Id rTCarga = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet').getRecordTypeId();
		Id rTBicicleta = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas').getRecordTypeId();
		Id rTButacaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Butaca Lectura').getRecordTypeId();
		Id rTPistaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pista Lectura').getRecordTypeId();
		Id rTCargaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Pallet Lectura').getRecordTypeId();
		Id rTBicicletaL = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Bicicletas Lectura').getRecordTypeId();
		Id rTTransbordo = Schema.SObjectType.Detalle_Reserva__c.getRecordTypeInfosByName().get('Venta Cruzada').getRecordTypeId();
		Reserva__c reservaData = [SELECT ORIGEN_DESTINO__c, Ruta_Nave__c, Fecha_Hora_de_Viaje__c, Total_reserva__c, Expiracion__c, Fecha_de_Reserva__c,
									Contacto_Reserva__r.Name, Contacto_Reserva__r.Identificacion__c, Contacto_Reserva__r.Tipo_de_Identificacion__c,
									Puerto_ORIGEN__r.Name, Puerto_DESTINO__r.Name, Itinerario_asociado__r.Nave__c, Itinerario_asociado__r.Nombre_Ruta__r.Name,
									CreatedBy.Name, CreatedBy.Email, CreatedBy.Sucursal__c, CreatedBy.Phone, Codigo_Reserva__c
								  FROM Reserva__c 
								  WHERE Id =: iReserva];
		contacto = reservaData.Contacto_Reserva__r.Name;
		identificacionContacto = reservaData.Contacto_Reserva__r.Identificacion__c;
		tipoIdentificacionContacto = reservaData.Contacto_Reserva__r.Tipo_de_Identificacion__c;
		origen = reservaData.Puerto_ORIGEN__r.Name;
		destino = reservaData.Puerto_DESTINO__r.Name;
		ruta = reservaData.Itinerario_asociado__r.Nombre_Ruta__r.Name;
		nave = reservaData.Itinerario_asociado__r.Nave__c;
		fechaHora = reservaData.Fecha_Hora_de_Viaje__c.format();
		total = FormatMonto(String.valueOf(reservaData.Total_reserva__c));
		//expiracion = reservaData.Expiracion__c.format();
		codigoReserva = reservaData.Codigo_Reserva__c;
		fechaReserva = reservaData.Fecha_de_Reserva__c.format();
		for( Schema.PicklistEntry sV : sucursalValor) {
			if(sV.getValue() == reservaData.CreatedBy.Sucursal__c){
				eAgencia = sV.getLabel();
			}
		}
		eNombre = reservaData.CreatedBy.Name;
		eCorreo = reservaData.CreatedBy.Email;
		eTelefono = reservaData.CreatedBy.Phone;
		rPersonas = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
						Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
						Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, 
						Tarificacion_validada__c
					 FROM Detalle_Reserva__c
					 WHERE Reserva__c =: iReserva
					 	AND (RecordTypeId =: rTButaca OR RecordTypeId =: rTButacaL)
						AND Item_Anulado__c = false
						AND Sin_Acomodacion__c = false];
		rSinAcomodacion = [SELECT Id, Doc_Identificacion_Pasajero__c, Nombre_Pasajero__r.Name, Numero__c, Conductor__c, Estudiante__c, 
							Residente__c, Nombre_Pasajero__r.Discapacidad__pc, Tasa_Desembarque__c, Tasa_Embarque__c, 
							Valor_Pasajero_DR__c, Valor_Detalle_Reserva__c, 
							Tarificacion_validada__c
						   FROM Detalle_Reserva__c
						   WHERE Reserva__c =: iReserva
							AND (RecordTypeId =: rTButaca OR RecordTypeId =: rTButacaL)
							AND Item_Anulado__c = false
							AND Sin_Acomodacion__c = true];
		rVehiculos = [SELECT Id, Placa_Patente_Vehiculo__c, Categoria_de_Vehiculo__c, Tipo_de_Vehiculo__c, Carro_Arrastre__c, 
						Porta_Equipaje__c, Porta_Bicicleta__c, Capacidad_Comprometida__c, Valor_Veh_culo_DR__c,
						Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Detalle_Reserva__c, Valor_ML_DR__c, 
						Tarificacion_validada__c
					  FROM Detalle_Reserva__c
					  WHERE Reserva__c =: iReserva 
					  	AND (RecordTypeId =: rTPista OR RecordTypeId =: rTBicicleta OR RecordTypeId =: rTPistaL OR RecordTypeId =: rTBicicletaL)
						AND Item_Anulado__c = false];
		rCargas = [SELECT Id, Capacidad_Comprometida__c, Persona_que_entrega__r.Name, Persona_que_retira__r.Name,
					Persona_que_entrega__r.Identificacion__c, Persona_que_retira__r.Identificacion__c,
					Tasa_Desembarque__c, Tasa_Embarque__c, Valor_Carga_DR__c, Valor_Detalle_Reserva__c, 
					Tarificacion_validada__c
				   FROM Detalle_Reserva__c
				   WHERE Reserva__c =: iReserva
				   	AND (RecordTypeId =: rTCarga OR RecordTypeId =: rTCargaL)
					AND Item_Anulado__c = false];
		rTransbordos = [SELECT Id, Cantidad__c, VCLugar__c, VCMateria__c, VCProveedor__c, VCTipo__c, 
					VC_Valor_Bruto__c, VC_Valor_Neto__c, Valor_Detalle_Reserva__c, 
					Tarificacion_validada__c
					FROM Detalle_Reserva__c
					WHERE Reserva__c =: iReserva
						AND (RecordTypeId =: rTTransbordo)
						AND Item_Anulado__c = false];
		reviewData(rPersonas, rVehiculos, rCargas, rTransbordos, rSinAcomodacion);
	}
	public void reviewData(List<Detalle_Reserva__c> rPersonas, List<Detalle_Reserva__c> rVehiculos, List<Detalle_Reserva__c> rCargas, List<Detalle_Reserva__c> rTransbordos, List<Detalle_Reserva__c> rSinAcomodacion){
		Boolean tarifaExiste = false;
		if(rPersonas.size() > 0){
			for(Detalle_Reserva__c rPer : rPersonas){
				rPer.Parametro_Tarifa__c = String.valueOf(rPer.Tarificacion_validada__c);
			}
		}
		if(rVehiculos.size() > 0){
			for(Detalle_Reserva__c rPer : rVehiculos){
				rPer.Parametro_Tarifa__c = String.valueOf(rPer.Tarificacion_validada__c);
			}
		}
		if(rCargas.size() > 0){
			for(Detalle_Reserva__c rPer : rCargas){
				rPer.Parametro_Tarifa__c = String.valueOf(rPer.Tarificacion_validada__c);
			}
		}
		if(rTransbordos.size() > 0){
			for(Detalle_Reserva__c rTra : rTransbordos){
				rTra.Parametro_Tarifa__c = String.valueOf(rTra.Tarificacion_validada__c);
			}
		}
		if(rSinAcomodacion.size() > 0){
			for(Detalle_Reserva__c rSAc : rSinAcomodacion){
				rSAc.Parametro_Tarifa__c = String.valueOf(rSAc.Tarificacion_validada__c);
			}
		}
	}
    public String FormatMonto(String monto){
		String num = monto;
		Integer c = num.length() - 1;
		Integer cont = 0;
		Integer i = 0;
		Integer j = 1;
		String mun = num.reverse();
		String[] arrmun = mun.split('');
		String var = '';
		while(i < c){
			var = var+arrmun[i];
			i++;
			if(i == 3*j){
				var = var+'.';
				j++;
			}
		}
		var = var+arrmun[c];
		monto = var.reverse();
		return monto;
    }
}