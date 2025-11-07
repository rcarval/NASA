/**********************************************************************************
Desarrollado por: Seidor - Salesforce Services
Autor: Rodrigo López
Proyecto: Naviera Austral
Descripción: Clase deserializadora de respuesta del servicio /clients.json múltiples clientes
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     03-02-2023   RL       Creación de la Clase.
***********************************************************************************/

public class NAV_ClientesBSaleJson {
    public class Contacts {
		public String href {get;set;} 
    }
	
	public class Items {
		public String href {get;set;} 
		public Integer id {get;set;} 
		public String firstName {get;set;} 
		public String lastName {get;set;} 
		public String email {get;set;} 
		public String code {get;set;} 
		public String phone {get;set;} 
		public String company {get;set;} 
		public String note {get;set;} 
		public String facebook {get;set;} 
		public String twitter {get;set;} 
		public Integer hasCredit {get;set;} 
		public Double maxCredit {get;set;} 
		public Integer state {get;set;} 
		public String activity {get;set;} 
		public String city {get;set;} 
		public Integer commerciallyBlocked {get;set;} 
		public String municipality {get;set;} 
		public String address {get;set;} 
		public Integer companyOrPerson {get;set;} 
		public Integer accumulatePoints {get;set;} 
		public Double points {get;set;} 
		public String pointsUpdated {get;set;} 
		public Integer sendDte {get;set;} 
		public Integer isForeigner {get;set;} 
		public Integer prestashopClienId {get;set;} 
		//public Integer createdAt {get;set;} 
		//public Integer updatedAt {get;set;} 
		public Contacts contacts {get;set;} 
		public Contacts attributes {get;set;} 
		public Contacts addresses {get;set;} 
    }
	
	public String href {get;set;} 
	public Integer count {get;set;} 
	public Integer limit_Z {get;set;} // in json: limit
	public Integer offset {get;set;} 
	public List<Items> items {get;set;} 
    public String error;

	public static NAV_ClientesBSaleJson parse(String json) {
		return (NAV_ClientesBSaleJson) System.JSON.deserialize(json, NAV_ClientesBSaleJson.class);
	}
}