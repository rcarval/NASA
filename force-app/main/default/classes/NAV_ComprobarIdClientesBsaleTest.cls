/**********************************************************************************
Desarrollado por: Cloud Solutions
Autor: Rodrigo López (RL)
Proyecto: Naviera Austral
Descripción: Clase Test para Clases NAV_ComprobarIdClientesBsaleController
---------------------------------------------------------------------------------
Versión Fecha        Autor    Descripción
---------------------------------------------------------------------------------
1.0     06-02-2023   RL       Creación de la Clase.
***********************************************************************************/

@isTest 
private class NAV_ComprobarIdClientesBsaleTest {
    @TestSetup
	static void setup(){
        Account cuenta1 = new Account(
		  RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cuenta personal').getRecordTypeId(),
		  FirstName = 'Dummy', // Nombre de la cuenta
		  LastName = 'User',
		  Id_Cliente_BSale__c = '1234',
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
			PageReference pref = Page.NAV_ComprobarIdClientesBsaleVF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_ComprobarIdClientesBsaleController controlador = new NAV_ComprobarIdClientesBsaleController(apst);
			controlador.comprobarClienteBSale();
            controlador.redirect();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE Identificacion__c = '8955620-1'];
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}

	//Test Camino Feliz método GET
	@IsTest
	private static void test2(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.setMock(HttpCalloutMock.class, new NAV_ComprobarIdClientesBsaleMock());
		Test.startTest();
		PageReference pref = Page.NAV_ComprobarIdClientesBsaleVF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_ComprobarIdClientesBsaleController controlador = new NAV_ComprobarIdClientesBsaleController(apst);
        NAV_Integraciones_WS.consumirWSClienteBSalePUT(cuenta1.Id);
			controlador.comprobarClienteBSale();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE id =: cuenta1.Id];
			System.debug('TEST ' +cuenta1.Id);
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}
    
    	@IsTest
	private static void test2_1(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.setMock(HttpCalloutMock.class, new NAV_ComprobarIdClientesBsaleMock());
		Test.startTest();
		PageReference pref = Page.NAV_ComprobarIdClientesBsaleVF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_ComprobarIdClientesBsaleController controlador = new NAV_ComprobarIdClientesBsaleController(apst);
        NAV_Integraciones_WS.consumirWSGetClientes(cuenta1.Id);
			controlador.comprobarClienteBSale();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE id =: cuenta1.Id];
			System.debug('TEST ' +cuenta1.Id);
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}

    //Test Error 400
    @IsTest
	private static void test3(){
		Account cuenta1 = [SELECT Id FROM Account WHERE Identificacion__c = '8955620-1'];
		Test.setMock(HttpCalloutMock.class, new NAV_ComprobarIdClientesBsaleError400Mock());
		Test.startTest();
		PageReference pref = Page.NAV_ComprobarIdClientesBsaleVF;
			Test.setCurrentPage(pref);
			pref.getParameters().put('Id', String.valueOf(cuenta1.Id));
			ApexPages.StandardController apst = new ApexPages.StandardController(cuenta1);
			NAV_ComprobarIdClientesBsaleController controlador = new NAV_ComprobarIdClientesBsaleController(apst);
			controlador.comprobarClienteBSale();
			cuenta1 = [SELECT Id, Id_Cliente_BSale__c FROM Account WHERE id =: cuenta1.Id];
			System.debug('TEST ' +cuenta1.Id);
            NAV_Integraciones_WS.consumirWSClienteBSalePUT(cuenta1.Id);
			System.assertEquals(true, cuenta1.Id != null);
		Test.stopTest();
	}   
    
    @IsTest
    private static void test4(){
        NAV_ClientesBSaleJson claseJson = new NAV_ClientesBSaleJson();
        claseJson.count = 1;
        claseJson.limit_Z = 1;
        claseJson.offset = 0;
        claseJson.href = 'test';
        NAV_ClientesBSaleJson.Items items = new NAV_ClientesBSaleJson.Items();
        items.href = 'test';
        items.href = 'test';
	    items.id = 1;
        items.firstName = 'test';
        items.lastName = 'test';
        items.email = 'test';
        items.code = 'test';
        items.phone = 'test';
        items.company = 'test';
        items.note = 'test';
        items.facebook = 'test';
        items.twitter = 'test';
        items.hasCredit = 1;
        items.maxCredit = 1;
        items.state = 1;
        items.activity = 'test';
        items.city = 'test';
        items.commerciallyBlocked = 1;
        items.municipality = 'test';
        items.address = 'test';
        items.companyOrPerson = 1;
        items.accumulatePoints = 1;
        items.points = 1;
        items.pointsUpdated = 'test';
        items.sendDte = 1;
        items.isForeigner = 1;
        items.prestashopClienId = 1;
        //items.createdAt = 1;
        //items.updatedAt = 1;
        claseJson.items = new List<NAV_ClientesBSaleJson.Items>();
        claseJson.items.add(items);
        System.assertEquals(true, claseJson != null);
    }
}