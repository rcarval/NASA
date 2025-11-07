/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Oscar Lobos (OL)
Proyecto: Naviera Austral
Descripción: Clase deserializadora de respuesta del servicio /clients.json
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     10-02-2022   OL       Creación de la Clase.
***********************************************************************************/

public class NAV_ClienteBSale_JSON {

	public Integer companyOrPerson;
	public String address;
	public String lastName;
	public Integer sendDte;
	public String city;
	public Integer state;
	public String twitter;
	public String firstName;
	public Integer id;
	public String municipality;
	public Double maxCredit;
	public Integer accumulatePoints;
	public String note;
	public String phone;
	public Contacts contacts;
	public Integer prestashopClienId;
	public String activity;
	public Integer hasCredit;
	public String facebook;
	public String company;
	public String code;
	public String href;

	public String error;

	public class Contacts {
		public String href;
	}

	
	public static NAV_ClienteBSale_JSON parse(String json) {
		return (NAV_ClienteBSale_JSON) System.JSON.deserialize(json, NAV_ClienteBSale_JSON.class);
	}
}