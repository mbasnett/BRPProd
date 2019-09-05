@isTest
private class NewstarLotReservationApiTest {
    /**
     * Resets a previously created NEWSTAR Sales lot reservation.
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
        NewstarLotReservationApi api;
        NewstarOperationResult response;
        NewstarOperationResult expectedResponse;
        String js = '';

        api = new NewstarLotReservationApi(new NewstarClient());

        js = JSON.serialize(NewstarOperationResult.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarOperationResult.getExample();
        response = (NewstarOperationResult) api.callDelete(params);
        System.assertEquals(expectedResponse, response);
    }

    /**
     * Creates a NEWSTAR Sales lot reservation (selection) for the specified customer, subdivision, lot and model combination.
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
        NewstarLotReservationApi api;
        NewstarLotReservation response;
        NewstarLotReservation expectedResponse;
        String js = '';

        api = new NewstarLotReservationApi(new NewstarClient());

        js = JSON.serialize(NewstarLotReservation.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarLotReservation.getExample();
        response = (NewstarLotReservation) api.post(params);
        System.assertEquals(expectedResponse, response);
    }
}