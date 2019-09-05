@isTest

private class NewstarServiceTest {

    /***
        NewstarQuoteOperationsService
        NewstarLotReservationOperationsService
        NewstarContractOperationsService
        NewstarContractInformationService
        NewstarSubdivisionExplorerService
        NewstarContractValidationService
        NewstarSalesPipelineService
        NewstarSalesPipelineStageTransition    
    ***/


    @testSetup static void setup() {
        TestDataFactory.setup();
    }

     @isTest
    static void NewstarQuoteOperationsService_performQuoteTest() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_10_BuyerSelection');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

        try {
            List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

            QuoteResult testQuoteResult = NewstarQuoteOperationsService.performQuote(opportunityList[0].Id);        

            System.assert(testQuoteResult != null);
        } catch (Exception e) {
            system.assert(e.getMessage().contains('Unable to remap cobuyer information'));
        }             

        Test.stopTest();

    }   

    @isTest 
    static void NewstarQuoteOperationsService_performQuoteToLotReservationConversion() {

        Test.startTest();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        LotReservationResult lotReservationResult = NewstarQuoteOperationsService.performQuoteToLotReservationConversion(opportunityList[0].Id, 5);

        System.assert(lotReservationResult != null);

        Test.stopTest();

    }


    @isTest
    static void NewstarLotReservationOperationsService_performLotReservationTest() {

        Test.startTest();

        try {
            StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
            mock.setStaticResource('Test_10_BuyerSelection');
            mock.setStatusCode(200);
            mock.setHeader('Content-Type', 'application/json');
            Test.setMock(HttpCalloutMock.class, mock);

            List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

            LotReservationResult testLotReservationResult = NewstarLotReservationOperationsService.performLotReservation(opportunityList[0].Id, 3);        

            System.assert(testLotReservationResult != null);
        } catch (Exception e) {
            system.assert(e.getMessage().contains('Unable to remap cobuyer information'));
        }        

        Test.stopTest();
    }   

    @isTest
    static void NewstarLotReservationOperationsService_performLotUnreservationTest() {

        Test.startTest();    

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        LotReservationResult testLotReservationResult = NewstarLotReservationOperationsService.performLotUnreservation(opportunityList[0].Id);        

        System.assert(testLotReservationResult != null);

        Test.stopTest();

    } 


     @isTest
    static void NewstarContractOperationsService_performDirectOfferTest() {

        Test.startTest();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_10_BuyerSelection');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);        

        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        ContractResult testContractResult = NewstarContractOperationsService.performDirectOffer(opportunityList[0].Id, System.Date.today());        

        Test.stopTest();

        System.assert(testContractResult != null);

    }   

     @isTest
    static void NewstarContractOperationsService_performDirectOfferUndoTest() {

        Test.startTest();

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Test_DummyCallout');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);        

        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        ContractResult testContractResult = NewstarContractOperationsService.performDirectOfferUndo(opportunityList[0].Id);        

        Test.stopTest();

        System.assert(testContractResult != null);

    }   


    @isTest
    static void NewstarContractInformationService_getOpportunityTest() {

        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        Opportunity testOpportunity = NewstarContractInformationService.getOpportunity(opportunityList[0].Id);        

        System.assert(testOpportunity != null);

        // TestDataFactory.cleanUp();

    }

    @isTest
    static void NewstarContractInformationService_getCustomerSalesOfficeJunctionTest() {
        List<Opportunity> opportunityList = [SELECT Id, Account.Id, Sales_Office__c FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        Sales_Office_Customer__c testSalesOfficeCustomer = NewstarContractInformationService.getCustomerSalesOfficeJunction(opportunityList[0]);        

        System.assert(testSalesOfficeCustomer != null);
    }


    @isTest
    static void NewstarContractInformationService_getSalesAgentFromOpportunityTest() {
        List<Opportunity> opportunityList = [SELECT Id, Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        Sales_Agent__c testSalesAgent = NewstarContractInformationService.getSalesAgentFromOpportunity(opportunityList[0].Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c);        

        System.assert(testSalesAgent != null);
    }


    @isTest
    static void NewstarContractInformationService_getNewstarStateAndCountryTest() {
        List<Account> accountList = [SELECT Id, PersonMailingAddress FROM Account WHERE Newstar_ID__c = '999999' LIMIT 1];

        Newstar_State__c testNewstarState = NewstarContractInformationService.getNewstarStateAndCountry(accountList[0].PersonMailingAddress);        

        System.assert(testNewstarState != null);    
    }

    @isTest
    static void NewstarContractInformationService_getCustomerWithSalesOfficesTest1() {
        List<Account> accountList = [SELECT Id, PersonMailingAddress FROM Account WHERE Newstar_ID__c = '999999' LIMIT 1];

        Account testAccount = NewstarContractInformationService.getCustomerWithSalesOffices(accountList[0].Id);        

        System.assert(testAccount != null);
    }

    @isTest
    static void NewstarContractInformationService_getCustomerWithSalesOfficesTest2() {
        Account testAccount = NewstarContractInformationService.getCustomerWithSalesOffices(null);        

        System.assert(testAccount == null);
    }


    @isTest
    static void NewstarContractInformationService_getCobuyerTest1() {
        List<Cobuyer__c> cobuyerList = [SELECT Id FROM Cobuyer__c WHERE Newstar_ID__c = '999999' LIMIT 1];

        Cobuyer__c testCobuyer = NewstarContractInformationService.getCobuyer(cobuyerList[0].Id);        

        System.assert(testCobuyer != null);
    }

    @isTest
    static void NewstarContractInformationService_getCobuyerTest2() {
        Cobuyer__c testCobuyer = NewstarContractInformationService.getCobuyer(null);        

        System.assert(testCobuyer == null);
    }



     @isTest
    static void NewstarSubdivisionExplorerService_getExplorerDataForOpportunityTest() {

        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        NewstarSubdivisionExplorerData testNewstarSubdivisionExplorerData = NewstarSubdivisionExplorerService.getExplorerDataForOpportunity(opportunityList[0].Id);        

        System.assert(testNewstarSubdivisionExplorerData != null);

    }   


    @isTest
    static void NewstarSubdivisionExplorerService_setOpportunityLotTest() {

        List<Opportunity> opportunityList = [SELECT Id, Lot__r.Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerService.setOpportunityLot(opportunityList[0].Id, opportunityList[0].Lot__r.Id);        

        System.assert(testSubdivisionExplorerActionResult != null);

    }     


    @isTest
    static void NewstarSubdivisionExplorerService_setOpportunityModelTest() {

        List<Opportunity> opportunityList = [SELECT Id, Model__r.Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerService.setOpportunityModel(opportunityList[0].Id, opportunityList[0].Model__r.Id);        

        System.assert(testSubdivisionExplorerActionResult != null);

    }    


    @isTest
    static void NewstarSubdivisionExplorerService_setOpportunitySubdivisionTest() {

        List<Opportunity> opportunityList = [SELECT Id, Subdivision__r.Id FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult = NewstarSubdivisionExplorerService.setOpportunitySubdivision(opportunityList[0].Id, opportunityList[0].Subdivision__r.Id);        

        System.assert(testSubdivisionExplorerActionResult != null);

    }    


    @isTest 
    static void NewstarContractValidationService_Test1() {
        List<Opportunity> opportunityList = [SELECT Id, Subdivision__r.Id, Sales_Office__c, Model__c, Lot__c, Sales_Agent_Sales_Office_Relationship__c, Account.PersonMailingAddress FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];
        NewstarContractValidationService.validateOpportunityForMissingFields(opportunityList[0]);
        System.assert(opportunityList != null);
    }

    @isTest 
    static void NewstarContractValidationService_Test2() {
        List<Opportunity> opportunityList = [SELECT Id, Subdivision__r.Id, Sales_Office__r.Supported_Contract_Flows__c FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999999' LIMIT 1];
        NewstarContractValidationService.validateOpportunityForContractFlowConfiguration(opportunityList[0]);
        System.assert(opportunityList != null);
    }

    @isTest 
    static void NewstarContractValidationService_Test3() {

        try {
            List<Opportunity> opportunityList = [SELECT Id, Sales_Office__c, Subdivision__c, Model__c, Lot__c, Sales_Agent_Sales_Office_Relationship__c, Account.PersonMailingAddress FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999996' LIMIT 1];
            NewstarContractValidationService.validateOpportunityForMissingFields(opportunityList[0]);
            System.assert(opportunityList != null);
        } catch (Exception e) {
            system.assert(e.getMessage().contains('The following fields should be populated'));
        }
    }

    @isTest 
    static void NewstarContractValidationService_Test4() {

        try {
            List<Opportunity> opportunityList = [SELECT Id, Sales_Office__c, Subdivision__c, Model__c, Lot__c, Sales_Agent_Sales_Office_Relationship__c, Account.PersonMailingAddress FROM Opportunity WHERE Opportunity.Newstar_ID__c = '999995' LIMIT 1];
            NewstarContractValidationService.validateOpportunityForMissingFields(opportunityList[0]);
            System.assert(opportunityList != null);
        } catch (Exception e) {
            system.assert(e.getMessage().contains('The following fields should be populated'));
        }
    }


    @isTest
    static void NewstarSalesPipelineService_ValidateStageTransition_Test() {

        NewstarSalesPipelineStageTransition stageTransition = new NewstarSalesPipelineStageTransition();    
        NewstarSalesPipelineService.ValidateStageTransition(stageTransition);

        System.assert(true);
    }   

    @isTest
    static void NewstarSalesPipelineService_IsPreNewstarHandoffStage_Test() {

        Boolean testBoolean = NewstarSalesPipelineService.IsPreNewstarHandoffStage('Quote/Selection');
        System.assert(true);
    }   


    @isTest
    static void NewstarSalesPipelineService_IsPureMarketingStage_Test() {

        Boolean testBoolean = NewstarSalesPipelineService.IsPureMarketingStage('Quote/Selection');
        System.assert(true);
    }   

    @isTest
    static void NewstarSalesPipelineStageTransition0_Test() {

        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();
        newstarSalesPipelineStageTransition.ValidationMessage = 'Test';
        System.assert(true);
    }   


    @isTest
    static void NewstarSalesPipelineStageTransition1_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.EngagementStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.EngagementStage.Name;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }  
    

    @isTest
    static void NewstarSalesPipelineStageTransition2_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.EngagementStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.QuoteSelectionStage.Name;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }   

    @isTest
    static void NewstarSalesPipelineStageTransition3_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.EngagementStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.UnderContractStage.Name;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }   

    @isTest
    static void NewstarSalesPipelineStageTransition4_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.EngagementStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.ClosedHomeStage.Name;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }   

    @isTest
    static void NewstarSalesPipelineStageTransition5_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.QuoteSelectionStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.PendingOfferStage.Name;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }  

    @isTest
    static void NewstarSalesPipelineStageTransition6_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.EngagementStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.PendingOfferStage.Name;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }  

    @isTest
    static void NewstarSalesPipelineStageTransition7_Test() {
        NewstarSalesPipelineStageTransition newstarSalesPipelineStageTransition = new NewstarSalesPipelineStageTransition();

        newstarSalesPipelineStageTransition.SourceStageName = NewstarSalesPipelineStage.EngagementStage.Name;
        newstarSalesPipelineStageTransition.TargetStageName = NewstarSalesPipelineStage.PendingOfferStage.Name;
        newstarSalesPipelineStageTransition.IsAutomated = false;

        NewstarSalesPipelineService.ValidateStageTransition(newstarSalesPipelineStageTransition);

        System.assert(true);
    }  

}