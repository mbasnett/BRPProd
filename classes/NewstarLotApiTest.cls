@isTest
private class NewstarLotApiTest {
    /**
     * Returns a list of available lots in the specified NEWSTAR Sales subdivision.
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
        NewstarLotApi api;
        NewstarPagedResultLot response;
        NewstarPagedResultLot expectedResponse;
        String js = '';

        api = new NewstarLotApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultLot.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultLot.getExample();
        response = (NewstarPagedResultLot) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}