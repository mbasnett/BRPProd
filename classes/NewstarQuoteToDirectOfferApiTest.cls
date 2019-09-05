@isTest
private class NewstarQuoteToDirectOfferApiTest {
    /**
     * Converts a previously submitted customer quote to a direct offer.
     *
     * 
     */
    @isTest
    private static void postTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarQuoteToDirectOfferApi api;
        NewstarQuoteToDirectOffer response;
        NewstarQuoteToDirectOffer expectedResponse;
        String js = '';

        api = new NewstarQuoteToDirectOfferApi(new NewstarClient());

        js = JSON.serialize(NewstarQuoteToDirectOffer.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarQuoteToDirectOffer.getExample();
        response = (NewstarQuoteToDirectOffer) api.post(params);
        System.assertEquals(expectedResponse, response);
    }
}