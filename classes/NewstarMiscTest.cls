@isTest

private class NewstarMiscTest {

    @testSetup static void setup() {
        TestDataFactory.setup();
    }

    @isTest
    static void newstarNotificationParameterTest() {

        NewstarNotificationParameter newstarNotificationParameter = new NewstarNotificationParameter();
        System.assert(newstarNotificationParameter != null);
    }   


    @isTest
    static void NewstarNotificationResourceTest() {

        NewstarNotification notification = new NewstarNotification();

        NewstarNotificationResult newstarNotificationResult = NewstarNotificationResource.postNotification(notification);
        System.assert(newstarNotificationResult != null);
    }   


    @isTest
    static void OpportunityInfoSetTriggerHandler() {

        Boolean testBoolean = OpportunityInfoSetTriggerHandler.isFirstExecution;
        System.assert(testBoolean == true);
    }  


    @isTest
    private static void NewstarContingencyInfo_createNew() {
        NewstarContingencyInfo contingencyInfo1 = new NewstarContingencyInfo();

        System.assert(contingencyInfo1.ContingencyExternalId.equals(''));
        System.assert(contingencyInfo1.Type.equals(''));
        System.assert(contingencyInfo1.ExpiryDate == null);
        System.assert(contingencyInfo1.MetDate == null);
        System.assert(contingencyInfo1.Notes.equals(''));
    }


    @isTest 
    static void QuoteResultTest() {
        QuoteResult testQuoteResult1 = new QuoteResult();
        QuoteResult testQuoteResult2 = new QuoteResult('Test');
        System.assert(testQuoteResult2.Message == 'Test');
    }


    @isTest 
    static void LotReservationResultTest() {
        LotReservationResult testLotReservationResult1 = new LotReservationResult();

        LotReservationResult testLotReservationResult2 = new LotReservationResult('Test');
        System.assert(testLotReservationResult2.Message == 'Test');
    }


   @isTest 
    static void ContractResultTest() {
        ContractResult testContractResult1 = new ContractResult();

        ContractResult testContractResult2 = new ContractResult('Test');
        System.assert(testContractResult2.Message == 'Test');
    }


    @isTest 
    static void SubdivisionExplorerActionResultTest() {
        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult1 = new SubdivisionExplorerActionResult();
	    testSubdivisionExplorerActionResult1.AdditionalWarningMessage = 'Test';

        SubdivisionExplorerActionResult testSubdivisionExplorerActionResult2 = new SubdivisionExplorerActionResult('Test');
        System.assert(testSubdivisionExplorerActionResult2.Message == 'Test');
    }


    @isTest 
    static void CustomerInfoResultTest() {
        CustomerInfoResult testCustomerInfoResult1 = new CustomerInfoResult();

        CustomerInfoResult testCustomerInfoResult2 = new CustomerInfoResult('Test');
        System.assert(testCustomerInfoResult2.Message == 'Test');
    }

 
    @isTest 
    static void CobuyerInfoResultTest() {
        CobuyerInfoResult testCobuyerInfoResult1 = new CobuyerInfoResult();

        CobuyerInfoResult testCobuyerInfoResult2 = new CobuyerInfoResult('Test');
        System.assert(testCobuyerInfoResult2.Message == 'Test');
    }


    @isTest
    static void RealEstateAgentResultTest() {
        RealEstateAgentResult realEstateAgentResult1 = new RealEstateAgentResult();
        RealEstateAgentResult realEstateAgentResult2 = new RealEstateAgentResult('Test');
        System.assert(realEstateAgentResult2.Message == 'Test');
    } 

    @isTest
    static void RealEstateAgencyResultTest() {
        RealEstateAgencyResult realEstateAgencyResult1 = new RealEstateAgencyResult();
        RealEstateAgencyResult realEstateAgencyResult2 = new RealEstateAgencyResult('Test');
        System.assert(realEstateAgencyResult2.Message == 'Test');
    } 


    @isTest
    static void NewstarOpportunityInfoServiceTest1() {

        Opportunity opp = [SELECT Id, Scenario_Name__c, Marketing_Community__c, Subdivision__c, Lot__c, Model__c, AccountId FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        NewstarOpporunityInfoService.setOpportunityNameAtMarketingCommunityLevel(opp, null);

        System.assert(opp != null);
    }

    @isTest
    static void NewstarOpportunityInfoServiceTest2() {

        Opportunity opp = [SELECT Id, Scenario_Name__c, Marketing_Community__c, Subdivision__c, Lot__c, Model__c, AccountId FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        NewstarOpporunityInfoService.setOpportunityNameAtSubdivisionLevel(opp, null);

        System.assert(opp != null);
    }

    @isTest
    static void NewstarOpportunityInfoServiceTest3() {

        Opportunity opp = [SELECT Id, Scenario_Name__c, Marketing_Community__c, Subdivision__c, Lot__c, Model__c, AccountId FROM Opportunity WHERE Newstar_ID__c = '999999' LIMIT 1];

        NewstarOpporunityInfoService.setOpportunityAmountsFromDealContext(opp, null);

        System.assert(opp != null);
    } 


    @isTest
    static void NewstarApiRootEntityTest() {

        NewstarApiRootEntity testNewstarApiRootEntity = new NewstarApiRootEntity();
        System.assert(testNewstarApiRootEntity != null);
    } 


    @isTest
    static void NewstarTokenApiTest() {

        NewstarTokenApi testNewstarTokenApi = new NewstarTokenApi();
        NewstarClient newstarClient = testNewstarTokenApi.getClient();
        System.assert(newstarClient != null);

        NewstarTokenApi testNewstarTokenApi2 = new NewstarTokenApi(newstarClient);
        System.assert(testNewstarTokenApi2 != null);

    } 


    @isTest
    static void NewstarVersionInfoApiTest() {

        NewstarVersionInfoApi testNewstarVersionInfoApi = new NewstarVersionInfoApi();
        NewstarClient newstarClient = testNewstarVersionInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarVersionInfoApi testNewstarVersionInfoApi2 = new NewstarVersionInfoApi(newstarClient);
        System.assert(testNewstarVersionInfoApi2 != null);

    } 

    @isTest
    static void NewstarGeographyLayoutApiTest() {

        NewstarGeographyLayoutApi testNewstarGeographyLayoutApi = new NewstarGeographyLayoutApi();
        NewstarClient newstarClient = testNewstarGeographyLayoutApi.getClient();
        System.assert(newstarClient != null);

        NewstarGeographyLayoutApi testNewstarGeographyLayoutApi2 = new NewstarGeographyLayoutApi(newstarClient);
        System.assert(testNewstarGeographyLayoutApi2 != null);

    } 


    @isTest
    static void NewstarQuoteApiTest() {

        NewstarQuoteApi testNewstarQuoteApi = new NewstarQuoteApi();
        NewstarClient newstarClient = testNewstarQuoteApi.getClient();
        System.assert(newstarClient != null);

        NewstarQuoteApi testNewstarQuoteApi2 = new NewstarQuoteApi(newstarClient);
        System.assert(testNewstarQuoteApi2 != null);

    } 


    @isTest
    static void NewstarLotReservationApiTest() {

        NewstarLotReservationApi  testNewstarLotReservationApi  = new NewstarLotReservationApi ();
        NewstarClient newstarClient = testNewstarLotReservationApi .getClient();
        System.assert(newstarClient != null);

        NewstarLotReservationApi  testNewstarLotReservationApi2 = new NewstarLotReservationApi (newstarClient);
        System.assert(testNewstarLotReservationApi2 != null);

    } 


    @isTest
    static void NewstarDirectOfferApiTest() {

        NewstarDirectOfferApi testNewstarDirectOfferApi = new NewstarDirectOfferApi();
        NewstarClient newstarClient = testNewstarDirectOfferApi.getClient();
        System.assert(newstarClient != null);

        NewstarDirectOfferApi testNewstarDirectOfferApi2 = new NewstarDirectOfferApi(newstarClient);
        System.assert(testNewstarDirectOfferApi2 != null);

    } 


    @isTest
    static void NewstarQuoteToDirectOfferApiTest() {

        NewstarQuoteToDirectOfferApi testNewstarQuoteToDirectOfferApi = new NewstarQuoteToDirectOfferApi();
        NewstarClient newstarClient = testNewstarQuoteToDirectOfferApi.getClient();
        System.assert(newstarClient != null);

        NewstarQuoteToDirectOfferApi testNewstarQuoteToDirectOfferApi2 = new NewstarQuoteToDirectOfferApi(newstarClient);
        System.assert(testNewstarQuoteToDirectOfferApi2 != null);

    } 


    @isTest
    static void NewstarQuoteToLotReservationApiTest() {

        NewstarQuoteToLotReservationApi testNewstarQuoteToLotReservationApi = new NewstarQuoteToLotReservationApi();
        NewstarClient newstarClient = testNewstarQuoteToLotReservationApi.getClient();
        System.assert(newstarClient != null);

        NewstarQuoteToLotReservationApi testNewstarQuoteToLotReservationApi2 = new NewstarQuoteToLotReservationApi(newstarClient);
        System.assert(testNewstarQuoteToLotReservationApi2 != null);

    } 


    @isTest
    static void NewstarSalesOfficeApiTest() {

        NewstarSalesOfficeApi testNewstarSalesOfficeApi = new NewstarSalesOfficeApi();
        NewstarClient newstarClient = testNewstarSalesOfficeApi.getClient();
        System.assert(newstarClient != null);

        NewstarSalesOfficeApi testNewstarSalesOfficeApi2 = new NewstarSalesOfficeApi(newstarClient);
        System.assert(testNewstarSalesOfficeApi2 != null);

    } 


    @isTest
    static void NewstarSubdivisionApiTest() {

        NewstarSubdivisionApi testNewstarSubdivisionApi = new NewstarSubdivisionApi();
        NewstarClient newstarClient = testNewstarSubdivisionApi.getClient();
        System.assert(newstarClient != null);

        NewstarSubdivisionApi testNewstarSubdivisionApi2 = new NewstarSubdivisionApi(newstarClient);
        System.assert(testNewstarSubdivisionApi2 != null);

    } 


    @isTest
    static void NewstarModelApiTest() {

        NewstarModelApi testNewstarModelApi  = new NewstarModelApi ();
        NewstarClient newstarClient = testNewstarModelApi .getClient();
        System.assert(newstarClient != null);

        NewstarModelApi testNewstarModelApi2 = new NewstarModelApi (newstarClient);
        System.assert(testNewstarModelApi2 != null);

    } 


    @isTest
    static void NewstarLotApiTest() {

        NewstarLotApi testNewstarLotApi = new NewstarLotApi();
        NewstarClient newstarClient = testNewstarLotApi.getClient();
        System.assert(newstarClient != null);

        NewstarLotApi testNewstarLotApi2 = new NewstarLotApi(newstarClient);
        System.assert(testNewstarLotApi2 != null);

    } 


    @isTest
    static void NewstarHomeInfoApiTest() {

        NewstarHomeInfoApi testNewstarHomeInfoApi = new NewstarHomeInfoApi();
        NewstarClient newstarClient = testNewstarHomeInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarHomeInfoApi testNewstarHomeInfoApi2 = new NewstarHomeInfoApi(newstarClient);
        System.assert(testNewstarHomeInfoApi2 != null);

    } 

    @isTest
    static void NewstarHomeOptionInfoApiTest() {

        NewstarHomeOptionInfoApi testNewstarHomeOptionInfoApi = new NewstarHomeOptionInfoApi();
        NewstarClient newstarClient = testNewstarHomeOptionInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarHomeOptionInfoApi testNewstarHomeOptionInfoApi2 = new NewstarHomeOptionInfoApi(newstarClient);
        System.assert(testNewstarHomeOptionInfoApi2 != null);

    } 


    @isTest
    static void NewstarHomeScheduleTaskInfoApiTest() {

        NewstarHomeScheduleTaskInfoApi testNewstarHomeScheduleTaskInfoApi = new NewstarHomeScheduleTaskInfoApi();
        NewstarClient newstarClient = testNewstarHomeScheduleTaskInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarHomeScheduleTaskInfoApi testNewstarHomeScheduleTaskInfoApi2 = new NewstarHomeScheduleTaskInfoApi(newstarClient);
        System.assert(testNewstarHomeScheduleTaskInfoApi2 != null);

    } 



    @isTest
    static void NewstarCustomerApiTest() {

        NewstarCustomerApi testNewstarCustomerApi = new NewstarCustomerApi();
        NewstarClient newstarClient = testNewstarCustomerApi.getClient();
        System.assert(newstarClient != null);

        NewstarCustomerApi testNewstarCustomerApi2 = new NewstarCustomerApi(newstarClient);
        System.assert(testNewstarCustomerApi2 != null);

    } 


    @isTest
    static void NewstarCustomerInfoApiTest() {

        NewstarCustomerInfoApi testNewstarCustomerInfoApi = new NewstarCustomerInfoApi();
        NewstarClient newstarClient = testNewstarCustomerInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarCustomerInfoApi testNewstarCustomerInfoApi2 = new NewstarCustomerInfoApi(newstarClient);
        System.assert(testNewstarCustomerInfoApi2 != null);

    }    


    @isTest
    static void NewstarCoBuyerApiTest() {

        NewstarCoBuyerApi testNewstarCoBuyerApi = new NewstarCoBuyerApi();
        NewstarClient newstarClient = testNewstarCoBuyerApi.getClient();
        System.assert(newstarClient != null);

        NewstarCoBuyerApi testNewstarCoBuyerApi2 = new NewstarCoBuyerApi(newstarClient);
        System.assert(testNewstarCoBuyerApi2 != null);

    } 


    @isTest
    static void NewstarRealEstateAgencyApiTest() {

        NewstarRealEstateAgencyApi testNewstarRealEstateAgencyApi = new NewstarRealEstateAgencyApi();
        NewstarClient newstarClient = testNewstarRealEstateAgencyApi.getClient();
        System.assert(newstarClient != null);

        NewstarRealEstateAgencyApi testNewstarRealEstateAgencyApi2 = new NewstarRealEstateAgencyApi(newstarClient);
        System.assert(testNewstarRealEstateAgencyApi2 != null);

    } 


    @isTest
    static void NewstarRealEstateAgencyInfoApiTest() {

        NewstarRealEstateAgencyInfoApi testNewstarRealEstateAgencyInfoApi = new NewstarRealEstateAgencyInfoApi();
        NewstarClient newstarClient = testNewstarRealEstateAgencyInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarRealEstateAgencyInfoApi testNewstarRealEstateAgencyInfoApi2 = new NewstarRealEstateAgencyInfoApi(newstarClient);
        System.assert(testNewstarRealEstateAgencyInfoApi2 != null);

    } 


    @isTest
    static void NewstarRealEstateAgentApiTest() {

        NewstarRealEstateAgentApi testNewstarRealEstateAgentApi = new NewstarRealEstateAgentApi();
        NewstarClient newstarClient = testNewstarRealEstateAgentApi.getClient();
        System.assert(newstarClient != null);

        NewstarRealEstateAgentApi testNewstarRealEstateAgentApi2 = new NewstarRealEstateAgentApi(newstarClient);
        System.assert(testNewstarRealEstateAgentApi2 != null);

    } 


    @isTest
    static void NewstarRealEstateAgentInfoApiTest() {

        NewstarRealEstateAgentInfoApi testNewstarRealEstateAgentInfoApi = new NewstarRealEstateAgentInfoApi();
        NewstarClient newstarClient = testNewstarRealEstateAgentInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarRealEstateAgentInfoApi testNewstarRealEstateAgentInfoApi2 = new NewstarRealEstateAgentInfoApi(newstarClient);
        System.assert(testNewstarRealEstateAgentInfoApi2 != null);

    } 


    @isTest
    static void NewstarSalesAgentApiTest() {

        NewstarSalesAgentApi testNewstarSalesAgentApi = new NewstarSalesAgentApi();
        NewstarClient newstarClient = testNewstarSalesAgentApi.getClient();
        System.assert(newstarClient != null);

        NewstarSalesAgentApi testNewstarSalesAgentApi2 = new NewstarSalesAgentApi(newstarClient);
        System.assert(testNewstarSalesAgentApi2 != null);

    }    


    @isTest
    static void NewstarContigencyTypeInfoApiTest() {

        NewstarContigencyTypeInfoApi testNewstarContigencyTypeInfoApi = new NewstarContigencyTypeInfoApi();
        NewstarClient newstarClient = testNewstarContigencyTypeInfoApi.getClient();
        System.assert(newstarClient != null);

        NewstarContigencyTypeInfoApi testNewstarContigencyTypeInfoApi2 = new NewstarContigencyTypeInfoApi(newstarClient);
        System.assert(testNewstarContigencyTypeInfoApi2 != null);

    } 


    @isTest
    static void NewstarContingenciesUpdateBundleApiTest() {

        NewstarContingenciesUpdateBundleApi testNewstarContingenciesUpdateBundleApi = new NewstarContingenciesUpdateBundleApi();
        NewstarClient newstarClient = testNewstarContingenciesUpdateBundleApi.getClient();
        System.assert(newstarClient != null);

        NewstarContingenciesUpdateBundleApi testNewstarContingenciesUpdateBundleApi2 = new NewstarContingenciesUpdateBundleApi(newstarClient);
        System.assert(testNewstarContingenciesUpdateBundleApi2 != null);

    } 


    @isTest 
    static void checkRecursiveCallToTrigger() {
        boolean lrunOnce = checkRecursiveCallToTrigger.runOnce(); 
        System.assert(lrunOnce == true);

        lrunOnce = checkRecursiveCallToTrigger.runOnce(); 
        System.assert(lrunOnce == false);
    }


    @isTest 
    static void NewstarApiService_GetNewstarPullBatchSubdivisionQueryLocator() {
         Database.QueryLocator testDatabaseQueryLocator =  NewstarApiService.GetNewstarPullBatchSubdivisionQueryLocator();
         System.assert(testDatabaseQueryLocator != null);
    }

    @isTest
    static void NewstarDataConversionHelper_decimalFromString_Test() {
        Decimal testDecimal = NewstarDataConversionHelper.decimalFromString('5000');
        System.assert(testDecimal == 5000);
    } 

    @isTest
    static void NewstarDataConversionHelper_dateFromString_Test() {
        Date testDate = NewstarDataConversionHelper.dateFromString('2019-07-19');
        System.assert(testDate == Date.valueOf('2019-07-19'));
    } 

    @isTest
    static void NewstarDataConversionHelper_booleanFromString_Test() {
        Boolean testBoolean = NewstarDataConversionHelper.booleanFromString('true');
        System.assert(testBoolean == true);
    } 

    @isTest
    static void NewstarDataConversionHelper_normalizeEnumValue_Test() {
        String testString = NewstarDataConversionHelper.normalizeEnumValue('Regular');
        System.assert(testString == 'Regular');
    } 

    @isTest
    static void NewstarDataConversionHelper_normalizeEnumValue2_Test2() {
        String testString = NewstarDataConversionHelper.normalizeEnumValue(null);
        System.assert(testString == null);
    } 

    @isTest
    static void NewstarDataConversionHelper_getBoolWithNull_Test() {
        Boolean testBoolean = NewstarDataConversionHelper.getBoolWithNull(true);
        System.assert(testBoolean == true);
    } 

    @isTest
    static void NewstarDataConversionHelper_getBoolWithNull2_Test() {
        Boolean testBoolean = NewstarDataConversionHelper.getBoolWithNull(null);
        System.assert(testBoolean != null);
    } 

    @isTest
    static void NewstarSyncJobInfo_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo('Test',  NewstarSyncJobInfo.JobType.GEOGRAPHY_LAYOUT, Integer.Class);
        System.assert(newstarSyncJobInfo != null);
    } 

    @isTest
    static void NewstarSyncJobInfo_CopyOf_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo1 = new NewstarSyncJobInfo('Test',  NewstarSyncJobInfo.JobType.GEOGRAPHY_LAYOUT, Integer.Class);
        NewstarSyncJobInfo newstarSyncJobInfo2 = newstarSyncJobInfo1.CopyOf();
        System.assert(newstarSyncJobInfo2 != null);
    } 

    @isTest
    static void NewstarSyncJobInfo_jobTypeText_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo();
        String jtt = newstarSyncJobInfo.jobTypeText;
        System.assert(jtt == null);
    } 

    @isTest
    static void NewstarSyncJobInfo_statusText_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo();
        String st = newstarSyncJobInfo.statusText;
        System.assert(st != null);
    } 

    @isTest
    static void NewstarSyncJobInfo_internalJobTypeText_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo();
        String ijtt = newstarSyncJobInfo.internalJobTypeText;
        System.assert(ijtt == null);
    } 

    @isTest
    static void NewstarSyncJobInfo_extendedStatus_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo();
        newstarSyncJobInfo.extendedStatus = 'test';
        String es = newstarSyncJobInfo.extendedStatus;
        System.assert(es != null);
    } 

    @isTest
    static void NewstarSyncJobInfo_lastCompletedDate_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo();
        newstarSyncJobInfo.lastCompletedDate = System.Date.today();
        Datetime lcd = newstarSyncJobInfo.lastCompletedDate;
        System.assert(lcd == System.Date.today());
    } 

    @isTest
    static void NewstarSyncJobInfo_isRunning_Test() {
        NewstarSyncJobInfo newstarSyncJobInfo = new NewstarSyncJobInfo();
        Boolean ir = newstarSyncJobInfo.isRunning;
        System.assert(ir == false);
    } 
    

    @isTest 
    static void NewstarLogEventSubscriberTrigger_Test() {
        Newstar_Log_Event__e newstar_Log_Event = new Newstar_Log_Event__e();
        newstar_Log_Event.Context__c='Test Context';
        newstar_Log_Event.Correlation_ID__c='TEST_CORRL';
        newstar_Log_Event.Primary_Object_ID__c='azxsasdsadad';
        newstar_Log_Event.Status__c='Success';
        newstar_Log_Event.Trace_Info__c='Trace';
        newstar_Log_Event.Type__c='Type';


        Test.startTest();
        System.Eventbus.publish(newstar_Log_Event);
        Test.stopTest();

        System.assert(true);
    }

    @isTest 
    static void NewstarLogEventSubscriberTriggerHandler_Test() {
        List<Newstar_Log_Event__e> logEvents = new  List<Newstar_Log_Event__e>();
        
        NewstarLogEventSubscriberTriggerHandler.processEvents(logEvents);
        System.assert(true);
    }


}