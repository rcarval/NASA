@isTest
global class NAV_EnviarClienteBSale_Mock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String body = '{\n';
        body+='    "href":"https://api.bsale.cl/v1/clients/24697.json",\n';
        body+='    "id":24697,\n';
        body+='    "firstName":"Dummy",\n';
        body+='    "lastName":"User",\n';
        body+='    "email":"rlopez@nectia.com",\n';
        body+='    "code":"17375869-3",\n';
        body+='    "phone":"996455435",\n';
        body+='    "company":null,\n';
        body+='    "note":null,\n';
        body+='    "facebook":null,\n';
        body+='    "twitter":null,\n';
        body+='    "hasCredit":1,\n';
        body+='    "maxCredit":1000000.0,\n';
        body+='    "state":0,\n';
        body+='    "activity":"Sin Giro",\n';
        body+='    "city":"Dummy",\n';
        body+='    "municipality":"Dummy municipality",\n';
        body+='    "address":"Dummy Street 123456",\n';
        body+='    "companyOrPerson":0,\n';
        body+='    "accumulatePoints":1,\n';
        body+='    "points":0.0,\n';
        body+='    "pointsUpdated":"",\n';
        body+='    "sendDte":0,\n';
        body+='    "isForeigner":0,\n';
        body+='    "prestashopClienId":0,\n';
        body+='    "createdAt":1646918367,\n';
        body+='    "updatedAt":1647348232,\n';
        body+='    "contacts":{\n';
        body+='       "href":"https://api.bsale.cl/v1/clients/24697/contacts.json"\n';
        body+='    },\n';
        body+='    "attributes":{\n';
        body+='       "href":"https://api.bsale.cl/v1/clients/24697/attributes.json"\n';
        body+='    },\n';
        body+='    "addresses":{\n';
        body+='       "href":"https://api.bsale.cl/v1/clients/24697/addresses.json"\n';
        body+='    }\n';
        body+='}\n';
        res.setBody(body);
        res.setStatusCode(200);
        return res;
    }
}