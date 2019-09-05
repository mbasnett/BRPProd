@isTest
private class NewstarCoBuyerApiTest {
    /**
     * Creates a new cobuyer in NEWSTAR Sales for the specified existing lot reservation.
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
        NewstarCoBuyerApi api;
        NewstarCoBuyer response;
        NewstarCoBuyer expectedResponse;
        String js = '';

        api = new NewstarCoBuyerApi(new NewstarClient());

        js = JSON.serialize(NewstarCoBuyer.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarCoBuyer.getExample();
        response = (NewstarCoBuyer) api.post(params);
        System.assertEquals(expectedResponse, response);
    }

    /**
     * Updates an existing cobuyer record in NEWSTAR Sales.
     *
     * This operation does NOT re-associate the cobuyer with any existing lot reservations.
     */
    @isTest
    private static void putTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarCoBuyerApi api;
        NewstarCoBuyer response;
        NewstarCoBuyer expectedResponse;
        String js = '';

        api = new NewstarCoBuyerApi(new NewstarClient());

        js = JSON.serialize(NewstarCoBuyer.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarCoBuyer.getExample();
        response = (NewstarCoBuyer) api.put(params);
        System.assertEquals(expectedResponse, response);
    }
}