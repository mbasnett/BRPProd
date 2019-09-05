@isTest
private class NewstarHomeInfoApiTest {
    /**
     * Returns a list of home info objects for a specific subdivision.
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
        NewstarHomeInfoApi api;
        NewstarPagedResultHomeInfo response;
        NewstarPagedResultHomeInfo expectedResponse;
        String js = '';

        api = new NewstarHomeInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultHomeInfo.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultHomeInfo.getExample();
        response = (NewstarPagedResultHomeInfo) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}