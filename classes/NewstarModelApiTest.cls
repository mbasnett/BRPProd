@isTest
private class NewstarModelApiTest {
    /**
     * Returns a list of floorplan models available for sale in a specific NEWSTAR Sales subdivision.
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
        NewstarModelApi api;
        NewstarPagedResultModel response;
        NewstarPagedResultModel expectedResponse;
        String js = '';

        api = new NewstarModelApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultModel.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultModel.getExample();
        response = (NewstarPagedResultModel) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}