@isTest
private class NewstarQuoteApiTest {
    /**
     * Resets a previously created NEWSTAR Sales quote-type selection.
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
        NewstarQuoteApi api;
        NewstarOperationResult response;
        NewstarOperationResult expectedResponse;
        String js = '';

        api = new NewstarQuoteApi(new NewstarClient());

        js = JSON.serialize(NewstarOperationResult.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarOperationResult.getExample();
        response = (NewstarOperationResult) api.callDelete(params);
        System.assertEquals(expectedResponse, response);
    }

    /**
     * Creates a NEWSTAR Sales quote-type selection for the specified customer, subdivision, lot and model combination.
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
        NewstarQuoteApi api;
        NewstarQuote response;
        NewstarQuote expectedResponse;
        String js = '';

        api = new NewstarQuoteApi(new NewstarClient());

        js = JSON.serialize(NewstarQuote.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarQuote.getExample();
        response = (NewstarQuote) api.post(params);
        System.assertEquals(expectedResponse, response);
    }
}