@isTest
private class NewstarRealEstateAgencyApiTest {
    /**
     * Creates a real estate agency in NEWSTAR Sales.
     *
     * 
     */
    @isTest
    private static void postTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarRealEstateAgencyApi api;
        NewstarRealEstateAgency response;
        NewstarRealEstateAgency expectedResponse;
        String js = '';

        api = new NewstarRealEstateAgencyApi(new NewstarClient());

        js = JSON.serialize(NewstarRealEstateAgency.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarRealEstateAgency.getExample();
        response = (NewstarRealEstateAgency) api.post(params);
        System.assertEquals(expectedResponse, response);
    }

    /**
     * Updates the specified real estate agency in NEWSTAR Sales.
     *
     * 
     */
    @isTest
    private static void putTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarRealEstateAgencyApi api;
        NewstarRealEstateAgency response;
        NewstarRealEstateAgency expectedResponse;
        String js = '';

        api = new NewstarRealEstateAgencyApi(new NewstarClient());

        js = JSON.serialize(NewstarRealEstateAgency.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarRealEstateAgency.getExample();
        response = (NewstarRealEstateAgency) api.put(params);
        System.assertEquals(expectedResponse, response);
    }
}