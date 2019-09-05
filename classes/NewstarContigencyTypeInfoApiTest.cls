@isTest
private class NewstarContigencyTypeInfoApiTest {
    /**
     * Returns a list of the available NEWSTAR Sales contigency types.
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
        NewstarContigencyTypeInfoApi api;
        NewstarPagedResultContigencyTypeInfo response;
        NewstarPagedResultContigencyTypeInfo expectedResponse;
        String js = '';

        api = new NewstarContigencyTypeInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultContigencyTypeInfo.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultContigencyTypeInfo.getExample();
        response = (NewstarPagedResultContigencyTypeInfo) api.get();
        System.assertEquals(expectedResponse, response);
    }
}