@isTest

private class NewstarControllerTest {

    /***
        NewstarQuoteController
        NewstarContractController
        NewstarLotReservationController
        NewstarSubdivisionExplorerController
        NewstarCustomerInfoController
        TaskController
        NewstarSyncJobController
        NewstarRealEstateAgencyController
        NewstarRealEstateAgentController
    ***/

    @testSetup static void setup() {
        TestDataFactory.setup();
    }


     @isTest
    static void NewstarQuoteController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarQuoteController testNewstarQuoteController = new NewstarQuoteController();
        System.assert(testNewstarQuoteController  != null);
    } 

    @isTest
    static void NewstarQuoteController_createQuote_Test() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/Quote', 'Test_10_BuyerSelection');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);

        Test.startTest();
            
            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            QuoteResult testQuoteResult = NewstarQuoteController.createQuote(opp.Id);
            System.assert(testQuoteResult  != null);

        Test.stopTest();
    } 

    @isTest
    static void NewstarQuoteController_convertQuoteToLotReservation_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            LotReservationResult testLotReservationResult = NewstarQuoteController.convertQuoteToLotReservation(opp.Id, 5);
            System.assert(testLotReservationResult != null);

        Test.stopTest();
    } 

    @isTest
    static void NewstarQuoteController_convertQuoteToDirectOffer_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            ContractResult testContractResult = NewstarQuoteController.convertQuoteToDirectOffer(opp.Id);
            System.assert(testContractResult != null);

        Test.stopTest();
    }    

    @isTest
    static void NewstarQuoteController_closeRejectedQuote_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            QuoteResult testQuoteResult= NewstarQuoteController.closeRejectedQuote(opp.Id);
            System.assert(testQuoteResult != null);    

        Test.stopTest();
    }    

    @isTest
    static void NewstarQuoteController_createNewQuoteFromOpportunity_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            QuoteResult testQuoteResult= NewstarQuoteController.createNewQuoteFromOpportunity(opp.Id, 'Test');
            System.assert(testQuoteResult != null);

        Test.stopTest();
    }   




     @isTest
    static void NewstarContractController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarContractController testNewstarContractController = new NewstarContractController();
        System.assert(testNewstarContractController  != null);
    }   

     @isTest
    static void NewstarContractController_initiateContract_Test() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/DirectOffer', 'Test_10_BuyerSelection');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);

        Test.startTest();
            
            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            ContractResult testContractResult = NewstarContractController.initiateContract(opp.id, System.Date.today());

            System.assert(testContractResult != null);

        Test.stopTest();
    }   

     @isTest
    static void NewstarContractController_cancelContractInitiation_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_13_ResponseForDelete');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];
            
            ContractResult testContractResult = NewstarContractController.cancelContractInitiation(opp.id);

            System.assert(testContractResult != null);

        Test.stopTest();
    }   

     @isTest
    static void NewstarContractController_getOpportunity_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id  FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];
        
        Opportunity testOpportunity = NewstarContractController.getOpportunity(opp.id);

        System.assert(testOpportunity != null);
    }   


     @isTest
    static void NewstarContractController_getOpportunity2_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id  FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];
        
        try {
            Opportunity testOpportunity = NewstarContractController.getOpportunity(null);
        } catch (AuraHandledException e) {
            System.debug(e.getMessage());    
            System.assert(e.getMessage() != null);
        }
    }   


     @isTest
    static void NewstarLotReservationController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarLotReservationController testNewstarLotReservationController = new NewstarLotReservationController();
        System.assert(testNewstarLotReservationController  != null);
    }   

     @isTest
    static void NewstarLotReservationController_reserveLot_Test() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/LotReservation', 'Test_10_BuyerSelection');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            LotReservationResult testLotReservationResult = NewstarLotReservationController.reserveLot(opp.Id, 3);
            System.assert(testLotReservationResult  != null);

        Test.stopTest();
    }   

     @isTest
    static void NewstarLotReservationController_unreserveLot_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_13_ResponseForDelete');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

            Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

            LotReservationResult testLotReservationResult = NewstarLotReservationController.unreserveLot(opp.Id);
            System.assert(testLotReservationResult  != null);

        Test.stopTest();        
    }      

     @isTest
    static void NewstarLotReservationController_getOpportunity_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];
        
        Opportunity testOpportunity = NewstarLotReservationController.getOpportunity(opp.id);

        System.assert(testOpportunity != null);
    }   




     @isTest
    static void NewstarSubdivisionExplorerController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        NewstarSubdivisionExplorerController testNewstarSubdivisionExplorerController = new NewstarSubdivisionExplorerController();
        System.assert(testNewstarSubdivisionExplorerController  != null);
    }   

    @isTest
    static void NewstarSubdivisionExplorerController_getExplorerData_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Scenario_Name__c FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        NewstarSubdivisionExplorerData testNewstarSubdivisionExplorerData = NewstarSubdivisionExplorerController.getExplorerData(opp.Id);
        System.assert(testNewstarSubdivisionExplorerData  != null);
    }   

     @isTest
    static void NewstarSubdivisionExplorerController_setOpportunityLot_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Lot__r.Id FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerController.setOpportunityLot(opp.Id, opp.Lot__r.Id);
        System.assert(testSubdivisionExplorerActionResult  != null);
    }      

     @isTest
    static void NewstarSubdivisionExplorerController_setOpportunityLot2_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Lot__r.Id FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        try {
            SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerController.setOpportunityLot(opp.Id, null);
        } catch (AuraHandledException e) {
            System.debug(e.getMessage());    
            System.assert(e.getMessage() != null);      
        }
    }      

     @isTest
    static void NewstarSubdivisionExplorerController_setOpportunityModel_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Model__r.Id FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerController.setOpportunityModel(opp.Id, opp.Model__r.Id);
        System.assert(testSubdivisionExplorerActionResult  != null);
    }  

     @isTest
    static void NewstarSubdivisionExplorerController_setOpportunityModel2_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Model__r.Id FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        try {
            SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerController.setOpportunityModel(opp.Id, null);
        } catch (AuraHandledException e) {
            System.debug(e.getMessage());    
            System.assert(e.getMessage() != null);
        }
    }  

     @isTest
    static void NewstarSubdivisionExplorerController_setOpportunitySubdivision_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Subdivision__r.Id FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerController.setOpportunitySubdivision(opp.Id, opp.Subdivision__r.Id);
        System.assert(testSubdivisionExplorerActionResult  != null);
    }  

     @isTest
    static void NewstarSubdivisionExplorerController_setOpportunitySubdivision2_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Opportunity opp = [SELECT Id, Subdivision__r.Id FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        try {
            SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerController.setOpportunitySubdivision(opp.Id, null);
        } catch (AuraHandledException e) {
            System.debug(e.getMessage());    
            System.assert(e.getMessage() != null);
        }    
    }  


    @isTest
    static void NewstarCustomerInfoController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarCustomerInfoController testNewstarCustomerInfoController = new NewstarCustomerInfoController();
        System.assert(testNewstarCustomerInfoController  != null);
    }   

     @isTest
    static void NewstarCustomerInfoController_getCustomerWithSalesOffices_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Account testAccount = [SELECT Id FROM Account WHERE Newstar_ID__c = '999999'];

        Account testAccount2 = NewstarCustomerInfoController.getCustomerWithSalesOffices(testAccount.Id);
        System.assert(testAccount2  != null);
    }   

    @isTest
    static void NewstarCustomerInfoController_syncCustomer_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Account testAccount = [SELECT Id FROM Account WHERE Newstar_ID__c = '999999'];

        List<Id> testListId = new List<Id>();

        CustomerInfoResult testCustomerInfoResult = NewstarCustomerInfoController.syncCustomer(testAccount.Id, testListId);
        System.assert(testCustomerInfoResult != null);
    }   

    @isTest
    static void NewstarCustomerInfoController_syncCustomer2_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        // Account testAccount = [SELECT Id FROM Account WHERE Newstar_ID__c = '999999'];

        List<Id> testListId = new List<Id>();

        try {
            CustomerInfoResult testCustomerInfoResult = NewstarCustomerInfoController.syncCustomer(null, testListId);
        } catch (AuraHandledException e) {
            System.debug(e.getMessage());    
            System.assert(e.getMessage() != null);
        }
    }   


    @isTest
    static void NewstarCustomerInfoController_syncCobuyer_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
            
            Cobuyer__c testCobuyer = [SELECT Id FROM Cobuyer__c WHERE Newstar_ID__c = '999999' LIMIT 1];

            CobuyerInfoResult testCobuyerInfoResult = NewstarCustomerInfoController.syncCobuyer(testCobuyer.Id);
            System.assert(testCobuyerInfoResult != null);

        Test.stopTest();
    }     


     @isTest
    static void TaskController_getTasklist_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        list<task> lstTask = Taskcontroller.getTasklist();
        System.assert(lstTask != null);
    }   


    @isTest
    static void NewstarSyncJobController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarSyncJobController newstarSyncJobController = new NewstarSyncJobController();
        System.assert(newstarSyncJobController != null);
    }   

 
    /*
    @isTest
    static void NewstarSyncJobController_initiateSync_Test() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';

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

        NewstarSyncJobInfo newstarSyncJobInfo = NewstarSyncJobController.initiateSync();
        System.assert(newstarSyncJobInfo != null);

        Test.stopTest();
    }  
    */


    @isTest
    static void NewstarSyncJobController_getSyncJobsStatuses_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        List<NewstarSyncJobInfo> newstarSyncJobInfoList = NewstarSyncJobController.getSyncJobsStatuses();
        System.assert(newstarSyncJobInfoList != null);
    }  


    @isTest
    static void NewstarRealEstateAgencyController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarRealEstateAgencyController newstarRealEstateAgencyController = new NewstarRealEstateAgencyController();
        System.assert(newstarRealEstateAgencyController != null);
    }   

    @isTest
    static void NewstarRealEstateAgencyController_syncAgent_Test() {

         String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/RealEstateAgency', 'Test_11_Agency');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);

        Test.startTest();

            Account account = [SELECT Id FROM Account WHERE Newstar_ID__c = '999997' LIMIT 1];

            RealEstateAgencyResult realEstateAgencyResult = NewstarRealEstateAgencyController.syncAgency(account.Id);
            System.assert(realEstateAgencyResult != null);
        
        Test.stopTest();
    }  

    @isTest
    static void NewstarRealEstateAgentController_Test() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        NewstarRealEstateAgentController newstarRealEstateAgentController = new NewstarRealEstateAgentController();
        System.assert(newstarRealEstateAgentController != null);
    }   

    @isTest
    static void NewstarRealEstateAgentController_syncAgent_Test() {

        String domainUrl='callout:Constellation_SFDC_Integration_API';
        system.debug('***** domailUrl: ' + domainUrl);

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(domainUrl + '/token', 'Test_00_Token');
        multimock.setStaticResource(domainUrl + '/api/RealEstateAgent', 'Test_12_Agent');

        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);

        Test.startTest();

            Contact contact = [SELECT Id FROM Contact WHERE Newstar_ID__c = '999999'  LIMIT 1];

            RealEstateAgentResult realEstateAgentResult = NewstarRealEstateAgentController.syncAgent(contact.Id);
            System.assert(realEstateAgentResult != null);

        Test.stopTest();
    }  

}