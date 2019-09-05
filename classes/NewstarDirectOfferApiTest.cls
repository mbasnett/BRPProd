@isTest
private class NewstarDirectOfferApiTest {
    /**
     * Resets a previously created NEWSTAR Sales direct offer.
     *
     * 
     */
    @isTest
    private static void callDeleteTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarDirectOfferApi api;
        NewstarOperationResult response;
        NewstarOperationResult expectedResponse;
        String js = '';

        api = new NewstarDirectOfferApi(new NewstarClient());

        js = JSON.serialize(NewstarOperationResult.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarOperationResult.getExample();
        response = (NewstarOperationResult) api.callDelete(params);
        System.assertEquals(expectedResponse, response);
    }

    /**
     * Creates a NEWSTAR Sales Direct Offer (Contract Ready) for the specified customer, subdivision, lot and model combination.
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
        NewstarDirectOfferApi api;
        NewstarDirectOffer response;
        NewstarDirectOffer expectedResponse;
        String js = '';

        api = new NewstarDirectOfferApi(new NewstarClient());

        js = JSON.serialize(NewstarDirectOffer.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarDirectOffer.getExample();
        response = (NewstarDirectOffer) api.post(params);
        System.assertEquals(expectedResponse, response);
    }
}