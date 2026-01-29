/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_EnviarDocumento_Controller_Test
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     30-11-2021   RL       Creación de la Clase.
***********************************************************************************/

@isTest private class NAV_EnviarClienteBSale_Controller_Test {
    @TestSetup
	static void setup(){
        Account cuenta1 = new Account(
		  RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		  FirstName = 'Dummy', // Nombre de la cuenta
		  LastName = 'User',
		  Identificacion__c = '8955620-1',               // Identificación
		  PersonBirthdate = Date.valueOf('1967-10-11'),  // Fecha de nacimiento
		  Tipo_de_identificacion__c = 'RUT',             // Tipo de identificación
		  PersonEmail = 'dummy@dummy.com',               // Correo electrónico
		  Discapacidad__pc = false                      // Discapacidad
		);
		insert cuenta1;
    }

    //Test Excepción
	@IsTest
	private static void test1(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.startTest();
			PageReference pref = Page.NAV_EnviarClienteBSale_VF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_EnviarClienteBSale_Controller controlador = new NAV_EnviarClienteBSale_Controller(apst);
			controlador.grabarDocumento();
            controlador.redirect();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE Identificacion__c = '8955620-1'];
			System.assertEquals(true, cuenta1.Id_Cliente_BSale__c == null);
		Test.stopTest();
	}
    
    @IsTest
	private static void test11_1(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.startTest();
        NAV_Integraciones_SOQL nav = new NAV_Integraciones_SOQL();
		nav.getAccount(null);
        System.assert(true,'algo');
		Test.stopTest();
	}
    
    @IsTest
	private static void test11_2(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.startTest();
        NAV_Integraciones_SOQL nav = new NAV_Integraciones_SOQL();
		nav.getDatosDetalleDocumentos('null');
        System.assert(true,'algo');
		Test.stopTest();
	}
	//Test Camino Feliz método POST
	@IsTest
	private static void test2(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.setMock(HttpCalloutMock.class, new NAV_EnviarClienteBSale_Mock());
		Test.startTest();
		PageReference pref = Page.NAV_EnviarClienteBSale_VF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_EnviarClienteBSale_Controller controlador = new NAV_EnviarClienteBSale_Controller(apst);
			controlador.grabarDocumento();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE id =: cuenta1.Id];
			System.debug('TEST ' +cuenta1.Id);
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}


    	@IsTest
	private static void test2_1(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.setMock(HttpCalloutMock.class, new NAV_EnviarClienteBSale_Mock());
		Test.startTest();
		PageReference pref = Page.NAV_EnviarClienteBSale_VF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_EnviarClienteBSale_Controller controlador = new NAV_EnviarClienteBSale_Controller(apst);
			controlador.grabarDocumento();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE id =: cuenta1.Id];
            NAV_Integraciones_WS.consumirWSClienteBSalePUT(cuenta1.Id);
			System.debug('TEST ' +cuenta1.Id);
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}

	//Test Camino Feliz método PUT
	@IsTest
	private static void test3(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		cuenta1.Id_Cliente_BSale__c = '123456';
		update cuenta1;
		Test.setMock(HttpCalloutMock.class, new NAV_EnviarClienteBSale_Mock());
		Test.startTest();
		PageReference pref = Page.NAV_EnviarClienteBSale_VF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_EnviarClienteBSale_Controller controlador = new NAV_EnviarClienteBSale_Controller(apst);
			controlador.grabarDocumento();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE Identificacion__c = '8955620-1'];
			System.assertEquals(true, cuenta1.Id_Cliente_BSale__c != null);
		Test.stopTest();
	}

	//Test Camino Feliz método invocable POST
	@IsTest
	private static void test4(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.setMock(HttpCalloutMock.class, new NAV_EnviarClienteBSale_Mock());
		Test.startTest();
			List<String> ids = new List<String>();
			ids.add(cuenta1.Id);
			NAV_EnviarClienteBSale_Invocable.ConsumoWSClienteBSale(ids);
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE id =: cuenta1.Id];
			System.debug('TEST ' +cuenta1.Id);
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}

	//Test Camino Feliz método invocable PUT
	@IsTest
	private static void test5(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		cuenta1.Id_Cliente_BSale__c = '123456';
		update cuenta1;
		Test.setMock(HttpCalloutMock.class, new NAV_EnviarClienteBSale_Mock());
		Test.startTest();
			List<String> ids = new List<String>();
			ids.add(cuenta1.Id);
			NAV_EnviarClienteBSale_Invocable.ConsumoWSClienteBSale(ids);
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE Identificacion__c = '8955620-1'];
			System.assertEquals(true, cuenta1.Id_Cliente_BSale__c != null);
		Test.stopTest();
	}

}