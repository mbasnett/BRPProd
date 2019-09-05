@isTest
private class NewstarTokenApiTest {
    /**
     * Authenticates the supplied login credentials and creates an encrypted  bearer token\r\nto be used for invocation of all API operations.
     *
     * 
     */
    @isTest
    private static void createTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(201);
        res.setStatus('Created');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarTokenApi api;
        NewstarLoginToken response;
        NewstarLoginToken expectedResponse;
        String js = '';

        api = new NewstarTokenApi(new NewstarClient());

        js = JSON.serialize(NewstarLoginToken.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarLoginToken.getExample();
        response = (NewstarLoginToken) api.create(params);
        System.assertEquals(expectedResponse, response);
    }
}