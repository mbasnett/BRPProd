@isTest
private class NewstarRealEstateAgentInfoApiTest {
    /**
     * Returns a list of real estate agents - real estate professionals involved in the home sale transactions.\r\nsales office.
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
        NewstarRealEstateAgentInfoApi api;
        NewstarPagedResultRealEstateAgentInf response;
        NewstarPagedResultRealEstateAgentInf expectedResponse;
        String js = '';

        api = new NewstarRealEstateAgentInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultRealEstateAgentInf.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultRealEstateAgentInf.getExample();
        response = (NewstarPagedResultRealEstateAgentInf) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}