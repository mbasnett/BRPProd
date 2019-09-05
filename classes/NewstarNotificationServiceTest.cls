@isTest

private class NewstarNotificationServiceTest {

    @testSetup static void setup() {
        TestDataFactory.setup();
    }


    @isTest
    static void processNotification_FinancialInfoUpdate_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('FinancialInfoUpdated','999999');

        System.assert(testNotificationResult != null);

    }   


    @isTest
    static void processNotification_UndoContractReady_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UndoContractReady','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UndoContractReady_LotNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UndoContractReady','999998');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_PendingOffer_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('PendingOffer','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_PendingOffer_LotNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('PendingOffer','999998');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UndoPendingOffer_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UndoPendingOffer','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UndoPendingOffer_LotNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UndoPendingOffer','999998');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UnderContract_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UnderContract','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UnderContract_LotNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UnderContract','999998');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_Closed_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('Closed','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_Closed_LotNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('Closed','999998');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_Closed_ExternalIDNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ExternalID_Null','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_Cancelled_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('Cancelled','999999');
        System.assert(testNotificationResult != null);

    }     


    @isTest
    static void processNotification_Cancelled_LotNull_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('Cancelled','999998');
        System.assert(testNotificationResult != null);

    }     


    @isTest
    static void processNotification_ContingencyCreated_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyCreated','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyUpdated_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyUpdated','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyUpdated_Test3() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyUpdated_MetNull','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyDeleted_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyDeleted','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ReservationExpired_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ReservationExpired','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_InvestmentPropertyUpdated_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('InvestmentPropertyUpdated','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ClosingDateUpdated_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ClosingDateUpdated','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_SwingUpdated_L_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('SwingUpdated_L','999999');
        System.assert(testNotificationResult != null);

    }  

    @isTest
    static void processNotification_SwingUpdated_R_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('SwingUpdated_R','999999');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_NotSupported_Test() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('NotSupported','999999');
        System.assert(testNotificationResult != null);

    }  


/****
****/

    @isTest
    static void processNotification_FinancialInfoUpdate_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('FinancialInfoUpdated','9999991');

        System.assert(testNotificationResult != null);

    }   


    @isTest
    static void processNotification_UndoContractReady_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UndoContractReady','9999991');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_PendingOffer_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('PendingOffer','9999991');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UndoPendingOffer_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UndoPendingOffer','9999991');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_UnderContract_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('UnderContract','9999991');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_ClosedHome_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ClosedHome','9999991');
        System.assert(testNotificationResult != null);

    }  


    @isTest
    static void processNotification_Cancelled_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('Cancelled','9999991');
        System.assert(testNotificationResult != null);

    }     


    @isTest
    static void processNotification_ContingencyCreated_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyCreated','9999991');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyUpdated_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyUpdated','9999991');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyUpdated_Test4() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyUpdated_ExternalIdNull','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyUpdated_Test5() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyUpdated_ExternalIdNA','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ContingencyDeleted_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ContingencyDeleted','9999991');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ReservationExpired_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ReservationExpired','9999991');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_InvestmentPropertyUpdated_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('InvestmentPropertyUpdated','9999991');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ClosingDateUpdated_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ClosingDateUpdated','9999991');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ClosingDateUpdated_Test3() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ClosingDateUpdated_ActualNull','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_ClosingDateUpdated_Test4() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('ClosingDateUpdated_TargetNull','999999');
        System.assert(testNotificationResult != null);

    }    


    @isTest
    static void processNotification_SwingUpdated_Test2() {

        NewstarNotificationResult testNotificationResult = processNotificationTest('SwingUpdated','9999991');
        System.assert(testNotificationResult != null);

    }  

/**** 
***/

    static NewstarNotificationResult processNotificationTest(string eventType, string opportunityExternalId) {

        NewstarNotification notification = new NewstarNotification();

        if ((eventType == 'SwingUpdated_L') || (eventType == 'SwingUpdated_R')) {
            notification.EventType = 'SwingUpdated';
        }
        else if ((eventType == 'ClosingDateUpdated_ActualNull') || (eventType == 'ClosingDateUpdated_TargetNull'))  {
            notification.EventType = 'ClosingDateUpdated';
        }
        else if (eventType == 'ContingencyUpdated_MetNull') {
            notification.EventType = 'ContingencyUpdated';
        }
        else if (eventType == 'ContingencyUpdated_ExternalIdNull') {
            notification.EventType = 'ContingencyUpdated';
        }
        else if (eventType == 'ContingencyUpdated_ExternalIdNA') {
            notification.EventType = 'ContingencyUpdated';
        }
        else if (eventType == 'ExternalID_Null') {
            notification.EventType = 'Closed';
        }
        else {
            notification.EventType = eventType;
        }

        List<NewstarNotificationParameter> newstarNotificationParameterList = new List<NewstarNotificationParameter>();
        
        if (eventType != 'ExternalID_Null') {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('opportunityExternalId', opportunityExternalId));
        }
        newstarNotificationParameterList.add(new NewstarNotificationParameter('lotPrice','1000'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('lotPremium','1500'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('baseModelPrice','350000'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalOptionsAmount','23000'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalDiscountAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalTaxAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalTaxRebateAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalSaleAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalProjectedOptionsAmount','23000'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalProjectedDiscountAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalProjectedTaxAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalProjectedTaxRebateAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalProjectedSaleAmount','0'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalScheduledDeposit','1500'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalReceivedDeposit','500'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('totalDepositDue','1000'));

        if (eventType == 'SwingUpdated_L') {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('swing','L'));
        }
        else {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('swing','R'));
        }


        if (eventType == 'ClosingDateUpdated_ActualNull') {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('actualClosingDate','1900-01-01T00:00:00.0000000'));
        }
        else {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('actualClosingDate','2019-07-17T00:00:00'));
        }
            
        if (eventType == 'ClosingDateUpdated_TargetNull')  {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('targetClosingDate','1900-01-01T00:00:00.0000000'));
        }
        else {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('targetClosingDate','2019-07-17T00:00:00'));
        }

        newstarNotificationParameterList.add(new NewstarNotificationParameter('investment','true'));

        if (eventType == 'ContingencyUpdated_ExternalIdNull') {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('contingencyExternalId','999999'));
        }

        if (eventType == 'ContingencyUpdated_ExternalIdNA') {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('contingencyExternalId','999991'));
        }

        newstarNotificationParameterList.add(new NewstarNotificationParameter('type','Home to Sell'));
        newstarNotificationParameterList.add(new NewstarNotificationParameter('expiryDate','2019-07-17T00:00:00'));

        if (eventType == 'ContingencyUpdated_MetNull') {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('metDate','1900-01-01T00:00:00'));
        }
        else {
            newstarNotificationParameterList.add(new NewstarNotificationParameter('metDate','2019-07-17T00:00:00'));
        }


        newstarNotificationParameterList.add(new NewstarNotificationParameter('notes','test'));


        notification.Parameters = newstarNotificationParameterList;

        NewstarNotificationResult testNotificationResult = NewstarNotificationService.processNotification(notification);        

        return testNotificationResult;
    }
}