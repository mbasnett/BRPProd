@isTest
private class NewstarRealEstateAgentApiTest {
    /**
     * Creates a real estate agent in NEWSTAR Sales.
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
        NewstarRealEstateAgentApi api;
        NewstarRealEstateAgent response;
        NewstarRealEstateAgent expectedResponse;
        String js = '';

        api = new NewstarRealEstateAgentApi(new NewstarClient());

        js = JSON.serialize(NewstarRealEstateAgent.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarRealEstateAgent.getExample();
        response = (NewstarRealEstateAgent) api.post(params);
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
        NewstarRealEstateAgentApi api;
        NewstarRealEstateAgent response;
        NewstarRealEstateAgent expectedResponse;
        String js = '';

        api = new NewstarRealEstateAgentApi(new NewstarClient());

        js = JSON.serialize(NewstarRealEstateAgent.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarRealEstateAgent.getExample();
        response = (NewstarRealEstateAgent) api.put(params);
        System.assertEquals(expectedResponse, response);
    }
}