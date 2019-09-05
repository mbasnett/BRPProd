@isTest
private class NewstarContingenciesUpdateBundleApiTest {
    /**
     * Updates contingencies associated with a given NEWSTAR Sales lot reservation/contract.
     *
     * 
     */
    @isTest
    private static void putTest() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        Test.setMock(HttpCalloutMock.class, new OASResponseMock(res));

      
        Map<String, Object> params = new Map<String, Object>();

        NewstarClient client;
        NewstarContingenciesUpdateBundleApi api;
        NewstarContingenciesUpdateBundle response;
        NewstarContingenciesUpdateBundle expectedResponse;
        String js = '';

        api = new NewstarContingenciesUpdateBundleApi(new NewstarClient());

        js = JSON.serialize(NewstarContingenciesUpdateBundle.getExample());
        res.setHeader('Content-Type', 'application/json');
        res.setBody(js);
        expectedResponse = NewstarContingenciesUpdateBundle.getExample();
        response = (NewstarContingenciesUpdateBundle) api.put(params);
        System.assertEquals(expectedResponse, response);
    }
}