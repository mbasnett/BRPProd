@isTest
private class NewstarRealEstateAgencyInfoApiTest {
    /**
     * Returns a list of real estate agencies - brokerage organizations paid commission by the builder.\r\nsales office.
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
        NewstarRealEstateAgencyInfoApi api;
        NewstarPagedResultRealEstateAgencyIn response;
        NewstarPagedResultRealEstateAgencyIn expectedResponse;
        String js = '';

        api = new NewstarRealEstateAgencyInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultRealEstateAgencyIn.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultRealEstateAgencyIn.getExample();
        response = (NewstarPagedResultRealEstateAgencyIn) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}