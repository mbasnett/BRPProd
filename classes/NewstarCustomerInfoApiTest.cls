@isTest
private class NewstarCustomerInfoApiTest {
    /**
     * Returns a list of prospects, customers under contract and closed customers in the specified\r\nsales office.
     *
     * 
     */
    @isTest
    private static void getTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarCustomerInfoApi api;
        NewstarPagedResultCustomerInfo response;
        NewstarPagedResultCustomerInfo expectedResponse;
        String js = '';

        api = new NewstarCustomerInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultCustomerInfo.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultCustomerInfo.getExample();
        response = (NewstarPagedResultCustomerInfo) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}