@isTest

private class NewstarMasterDataPullSchedulableTest {

    @testSetup static void setup() {
        TestDataFactory.setup();
    }

/*** 
    public static HttpResponse getInfoFromExternalService(String endpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }

    @isTest
    static void MultiStaticTest() {
        String domainUrl='callout:Constellation_SFDC_Integration_API';

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/GeographyLayout', 'Test_01_Geography');
        multimock.setStaticResource(domainUrl + '/api/SalesAgent', 'Test_02_SalesAgent');
        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);       
        
        HTTPResponse res = getInfoFromExternalService(domainUrl + '/token');
        System.debug(res.getBody());

        HTTPResponse res2 = getInfoFromExternalService(domainUrl + '/api/GeographyLayout');
        System.debug(res2.getBody());

        HTTPResponse res3 = getInfoFromExternalService(domainUrl + '/api/SalesAgent');
        System.debug(res3.getBody());
    }
***/

/*
    @isTest
    static void MasterdataPullTest() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/GeographyLayout', 'Test_01_Geography');
        multimock.setStaticResource(domainUrl + '/api/SalesAgent', 'Test_02_SalesAgent');
        multimock.setStaticResource(domainUrl + '/api/SalesOffice', 'Test_03_SalesOffice');
        multimock.setStaticResource(domainUrl + '/api/Subdivision?includeInactive=true', 'Test_04_Subdivision');
        multimock.setStaticResource(domainUrl + '/api/Model?subdivisionId=999999', 'Test_05_Model');
        multimock.setStaticResource(domainUrl + '/api/Lot?subdivisionId=999999', 'Test_06_Lot');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);


        Test.startTest();

        MasterdataPull sh1 = new MasterdataPull();

        String sch = '0 0 23 * * ?';
        system.schedule('Test Masterdata Pull', sch, sh1);

        Test.stopTest();

        System.assert(sh1 != null);

    }   
*/

/*
    @isTest
    static void NewstarMasterDataPullSchedulableTest() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/GeographyLayout', 'Test_01_Geography');
        multimock.setStaticResource(domainUrl + '/api/SalesAgent', 'Test_02_SalesAgent');
        multimock.setStaticResource(domainUrl + '/api/SalesOffice', 'Test_03_SalesOffice');
        multimock.setStaticResource(domainUrl + '/api/Subdivision?includeInactive=true', 'Test_04_Subdivision');
        multimock.setStaticResource(domainUrl + '/api/Model?subdivisionId=999999', 'Test_05_Model');
        multimock.setStaticResource(domainUrl + '/api/Lot?subdivisionId=999999', 'Test_06_Lot');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);


        Test.startTest();

        NewstarMasterDataPullSchedulable sh1 = new NewstarMasterDataPullSchedulable();

        String sch = '0 0 23 * * ?';
        system.schedule('Test Masterdata Pull', sch, sh1);

        Test.stopTest();

        System.assert(sh1 != null);

    }   
*/

    @isTest
    static void PullNewstarBatchTest() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/GeographyLayout', 'Test_01_Geography');
        multimock.setStaticResource(domainUrl + '/api/SalesAgent', 'Test_02_SalesAgent');
        multimock.setStaticResource(domainUrl + '/api/SalesOffice', 'Test_03_SalesOffice');
        multimock.setStaticResource(domainUrl + '/api/Subdivision?includeInactive=true', 'Test_04_Subdivision');
        multimock.setStaticResource(domainUrl + '/api/Model?subdivisionId=999999', 'Test_05_Model');
        multimock.setStaticResource(domainUrl + '/api/Lot?subdivisionId=999999', 'Test_06_Lot');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);


        Test.startTest();


        StaticResourceCalloutMock mockToken = new StaticResourceCalloutMock();
        mockToken.setStaticResource('Test_00_Token');
        mockToken.setStatusCode(200);
        mockToken.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mockToken);        

        NewstarClient newstarClient = NewstarApiService.getAuthenticatedClient();


        PullNewstarGeographyLayoutBatch objGL1 = new PullNewstarGeographyLayoutBatch();
        PullNewstarGeographyLayoutBatch objGL2 = new PullNewstarGeographyLayoutBatch(newstarClient);

        PullNewstarSalesAgentsBatch objSA1 = new PullNewstarSalesAgentsBatch();
        PullNewstarSalesAgentsBatch objSA2 = new PullNewstarSalesAgentsBatch(newstarClient);

        PullNewstarSalesOfficesBatch objSO1 = new PullNewstarSalesOfficesBatch();
        PullNewstarSalesOfficesBatch objSO2 = new PullNewstarSalesOfficesBatch(newstarClient);

        PullNewstarSubdivisionsBatch objSD1 = new PullNewstarSubdivisionsBatch();
        PullNewstarSubdivisionsBatch objSD2 = new PullNewstarSubdivisionsBatch(newstarClient);

        PullNewstarSubdivisionModelsBatch objSM1 = new PullNewstarSubdivisionModelsBatch();
        PullNewstarSubdivisionModelsBatch objSM2 = new PullNewstarSubdivisionModelsBatch(newstarClient);

        PullNewstarSubdivisionLotsBatch objSL1 = new PullNewstarSubdivisionLotsBatch();
        PullNewstarSubdivisionLotsBatch objSL2 = new PullNewstarSubdivisionLotsBatch(newstarClient);

        RefreshOpportunityPricesBatch objROP = new RefreshOpportunityPricesBatch();

        Test.stopTest();

        System.assert(true);

    }   


}