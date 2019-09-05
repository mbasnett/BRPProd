@isTest
private class NewstarSalesAgentApiTest {
    /**
     * Returns the list of the available NEWSTAR Sales users.
     *
     * 
     */
    @isTest
    private static void getTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

        NewstarClient client;
        NewstarSalesAgentApi api;
        NewstarPagedResultSalesAgent response;
        NewstarPagedResultSalesAgent expectedResponse;
        String js = '';

        api = new NewstarSalesAgentApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultSalesAgent.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultSalesAgent.getExample();
        response = (NewstarPagedResultSalesAgent) api.get();
        System.assertEquals(expectedResponse, response);
    }
}