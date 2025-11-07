/**
 * @description       : 
 * @author            : Esteban Flores
 * @group             : 
 * @last modified on  : 08-08-2022
 * @last modified by  : Esteban Flores
 * @project           : 
**/
public class NAV_WrapperCapacities  {
	public String itinerarie;
	public String roundtrip;
	public Integer people;
	public String departure;
	public String destination;
	//RL -> Campos nuevos para registrar reserva
	public String tripDate;
	public String[] seats;
	public String reservation;
	public cl_arrayVehiculos[] arrayVehicles;
	public class cl_arrayVehiculos{
		public String tag;
		public String category;
		public String brand;
		public String model;
		public Boolean luggageRack;
		public Boolean bikeRack;
		public Boolean pullingCart;
		public Decimal pullingLong;
		public String vehicleType;
		public Decimal vHigh;
		public Decimal vWidth;
		public Decimal vLong;
		public Decimal tare;
		public Decimal load;
	}

	public static NAV_WrapperCapacities parse(String json){
		return (NAV_WrapperCapacities) System.JSON.deserialize(json, NAV_WrapperCapacities.class);
	}
}