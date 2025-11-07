public class NAV_Nota_Credito_JSON {

	public class Office {
		public String href;
		public String id;
	}

	public class Details {
		public String href;
	}

	public String href;
	public Integer id;
	public String code;
	public Integer returnDate;
	public String motive;
	public Integer type;
	public Integer priceAdjustment;
	public Integer editTexts;
	public Double amount;
	public Office office;
	public Office user;
	public Office reference_document;
	public Office credit_note;
	public Details details;
	public String error;
	
	public static NAV_Nota_Credito_JSON parse(String json) {
		return (NAV_Nota_Credito_JSON) System.JSON.deserialize(json, NAV_Nota_Credito_JSON.class);
	}
}