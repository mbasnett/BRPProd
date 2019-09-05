@isTest
private class NewstarSubdivisionApiTest {
    /**
     * Returns a list of the available NEWSTAR Sales subdivisions in a specified sales office.
     *
     * If the sales office ID is not supplied (null), a global list of subdivisions is returned.
     */
    @isTest
    private static void getTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarSubdivisionApi api;
        NewstarPagedResultSubdivision response;
        NewstarPagedResultSubdivision expectedResponse;
        String js = '';

        api = new NewstarSubdivisionApi(new NewstarClient());

        js = JSON.serialize(NewstarPagedResultSubdivision.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarPagedResultSubdivision.getExample();
        response = (NewstarPagedResultSubdivision) api.get(params);
        System.assertEquals(expectedResponse, response);
    }
}