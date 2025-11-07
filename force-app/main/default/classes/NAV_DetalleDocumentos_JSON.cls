public class NAV_DetalleDocumentos_JSON {

	public String href {get;set;} 
	public Integer count {get;set;} 
	public Integer limit_Z {get;set;} // in json: limit
	public Integer offset {get;set;} 
	public List<Items> items {get;set;} 

	public class Items {
		public String href {get;set;} 
		public Integer id {get;set;} 
		public Integer lineNumber {get;set;} 
		public Double quantity {get;set;} 
		public Double netUnitValue {get;set;} 
		public Double totalUnitValue {get;set;} 
		public Double netAmount {get;set;} 
		public Double taxAmount {get;set;} 
		public Double totalAmount {get;set;} 
		public Double netDiscount {get;set;} 
		public Double totalDiscount {get;set;} 
		public Variant variant {get;set;} 
		public String note {get;set;} 
		public Integer relatedDetailId {get;set;} 
	}

	public class Variant {
		public String href {get;set;} 
		public Integer id {get;set;} 
		public String description {get;set;} 
		public String code {get;set;} 
	}
		
	public static NAV_DetalleDocumentos_JSON parse(String json) {
		return (NAV_DetalleDocumentos_JSON) System.JSON.deserialize(json, NAV_DetalleDocumentos_JSON.class);
	}
}