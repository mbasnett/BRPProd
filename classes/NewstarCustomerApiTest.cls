@isTest
private class NewstarCustomerApiTest {
    /**
     * Updates an existing customer record in NEWSTAR Sales.
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
        NewstarCustomerApi api;
        NewstarCustomer response;
        NewstarCustomer expectedResponse;
        String js = '';

        api = new NewstarCustomerApi(new NewstarClient());

        js = JSON.serialize(NewstarCustomer.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarCustomer.getExample();
        response = (NewstarCustomer) api.put(params);
        System.assertEquals(expectedResponse, response);
    }
}