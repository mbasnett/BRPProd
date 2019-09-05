@isTest
private class NewstarHomeOptionInfoApiTest {
    /**
     * Returns a list of options (standards, upgrades, custom options) for the specified customer contract.
     *
     * The result set specifically excludes special-purpose products representing the base model itself or its swing configurations.
     */
    @isTest
    private static void getTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarHomeOptionInfoApi api;
        NewstarPagedResultHomeOptionInfo response;
        NewstarPagedResultHomeOptionInfo expectedResponse;
        String js = '';

        api = new NewstarHomeOptionInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultHomeOptionInfo.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultHomeOptionInfo.getExample();
        response = (NewstarPagedResultHomeOptionInfo) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}