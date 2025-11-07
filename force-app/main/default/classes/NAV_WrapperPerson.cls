public class NAV_WrapperPerson  {
	public String reservation;
	public String seat;
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
	public static NAV_WrapperPerson parse(String json){
		return (NAV_WrapperPerson) System.JSON.deserialize(json, NAV_WrapperPerson.class);
	}
}