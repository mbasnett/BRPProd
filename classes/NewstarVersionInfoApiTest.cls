@isTest
private class NewstarVersionInfoApiTest {
    /**
     * Returns the API version information.
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
        NewstarVersionInfoApi api;
        NewstarApiVersionInfo response;
        NewstarApiVersionInfo expectedResponse;
        String js = '';

        api = new NewstarVersionInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarApiVersionInfo.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarApiVersionInfo.getExample();
        response = (NewstarApiVersionInfo) api.get();
        System.assertEquals(expectedResponse, response);
    }
}