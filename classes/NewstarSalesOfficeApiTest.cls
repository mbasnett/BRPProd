@isTest
private class NewstarSalesOfficeApiTest {
    /**
     * Returns the list of the available NEWSTAR Sales sales offices.
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
        NewstarSalesOfficeApi api;
        NewstarPagedResultSalesOffice response;
        NewstarPagedResultSalesOffice expectedResponse;
        String js = '';

        api = new NewstarSalesOfficeApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultSalesOffice.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultSalesOffice.getExample();
        response = (NewstarPagedResultSalesOffice) api.get();
        System.assertEquals(expectedResponse, response);
    }
}