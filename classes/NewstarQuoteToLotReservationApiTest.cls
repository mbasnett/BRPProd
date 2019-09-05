@isTest
private class NewstarQuoteToLotReservationApiTest {
    /**
     * Converts a previously submitted customer quote to a lot reservation.
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
        NewstarQuoteToLotReservationApi api;
        NewstarQuoteToLotReservation response;
        NewstarQuoteToLotReservation expectedResponse;
        String js = '';

        api = new NewstarQuoteToLotReservationApi(new NewstarClient());

        js = JSON.serialize(NewstarQuoteToLotReservation.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarQuoteToLotReservation.getExample();
        response = (NewstarQuoteToLotReservation) api.post(params);
        System.assertEquals(expectedResponse, response);
    }
}