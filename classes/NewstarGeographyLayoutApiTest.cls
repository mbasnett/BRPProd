@isTest
private class NewstarGeographyLayoutApiTest {
    /**
     * Returns a list of the available NEWSTAR Sales countries and their child state/province records as defined by the builder.
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
        NewstarGeographyLayoutApi api;
        NewstarPagedResultCountry response;
        NewstarPagedResultCountry expectedResponse;
        String js = '';

        api = new NewstarGeographyLayoutApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultCountry.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultCountry.getExample();
        response = (NewstarPagedResultCountry) api.get();
        System.assertEquals(expectedResponse, response);
    }
}