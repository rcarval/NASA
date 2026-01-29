public class NAV_WrapperPayments  {
	//START REST
	public String vci;
	public String amount;
	public String buy_order;
	public String session_id;
	public String card_number;
	public String accounting_date;
	public String transaction_date;
	public String authorization_code;
	public String payment_type;
	public String response_code;
	//END REST
	//START SOAP
	public String card_expiration_date;
	public String url_redirection;
	public String shares_number;
	public String commerce_code;
	public String status;
	public String installments_amount;
	public String installments_number;
	public String balance;
	//END SOAP
	public static NAV_WrapperPayments parse(String json){
		return (NAV_WrapperPayments) System.JSON.deserialize(json, NAV_WrapperPayments.class);
	}
}