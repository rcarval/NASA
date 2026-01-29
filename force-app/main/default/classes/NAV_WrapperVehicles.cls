/**
 * @description       : 
 * @author            : Esteban Flores
 * @group             : 
 * @last modified on  : 08-08-2022
 * @last modified by  : Esteban Flores
 * @project           : 
**/
public class NAV_WrapperVehicles  {
	public String reservation;
	public String tag;
	public String licensePlate;
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
	public cl_conductor driver;
	public cl_conductor dispatcher;
	public cl_conductor receiver;
	public class cl_conductor{
		public String pName;
		public String pLastname;
		public String pGender;
		public Date pBirthdate;
		public String pDocType;
		public String pDocNum;
		public String pNationality;
		public String pEmail;
		public String pPhone;
		public Boolean pIsDriver;
	}
	public static NAV_WrapperVehicles parse(String json){
		return (NAV_WrapperVehicles) System.JSON.deserialize(json, NAV_WrapperVehicles.class);
	}
}