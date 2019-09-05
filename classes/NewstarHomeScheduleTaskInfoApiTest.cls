@isTest
private class NewstarHomeScheduleTaskInfoApiTest {
    /**
     * Returns a list of home construction schedule tasks for a specified contract (deal).
     *
     * Only tasks from the pre-configured task codes list are returned.
     */
    @isTest
    private static void getTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarHomeScheduleTaskInfoApi api;
        NewstarPagedResultHomeScheduleTaskIn response;
        NewstarPagedResultHomeScheduleTaskIn expectedResponse;
        String js = '';

        api = new NewstarHomeScheduleTaskInfoApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultHomeScheduleTaskIn.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultHomeScheduleTaskIn.getExample();
        response = (NewstarPagedResultHomeScheduleTaskIn) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}