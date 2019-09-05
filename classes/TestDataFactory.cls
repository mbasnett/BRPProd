public class TestDataFactory {

    public static void setup() {

        Newstar_Country__c myNewstarCountry = generateNewstarCountry();

        Newstar_State__c myNewstarState = generateNewstarState();

        User myUser = generateSalesUser();

        BRPSalesSettings__c myBRPSalesSettings = generateBRPSalesSettings();

        Sales_Agent__c mySalesAgent = generateCustomerSalesAgent(myUser);

        Sales_Office__c mySalesOffice = generateCustomerSalesOffice();

        SalesAgentSalesOfficeLink__c mySalesAgentSalesOfficeLink = generateCustomerSalesAgentSalesOfficeLink();

        Marketing_Community__c myMarketingCommunity = generateMarketingCommunity();

        Subdivision__c mySubdivision = generateCustomerSubdivision();

        Model__c myModel = generateCustomerModel(); 

        Lot__c myLot = generateCustomerLot(); 

        Account myAccount = generateCustomerAccount(myBRPSalesSettings);

        Cobuyer__c myCoBuyer = generateCoBuyer();

        Sales_Office_Customer__c mySalesOfficeCustomer = generateSalesOfficeCustomer(myAccount, mySalesOffice);

        Opportunity myOpportunity = generateContractOperationsReadyOpportunity(
                        myAccount, 
                        myCoBuyer,
                        mySalesOffice, 
                        mySalesAgentSalesOfficeLink,
                        myMarketingCommunity,
                        mySubdivision,
                        myModel,
                        myLot);

        Contigency__c myContigency = generateCustomerContigency(myOpportunity);


        Opportunity myOpportunity2 = generateContractOperationsReadyOpportunity(
                        myAccount, 
                        myCoBuyer,
                        mySalesOffice, 
                        mySalesAgentSalesOfficeLink,
                        myMarketingCommunity,
                        mySubdivision,
                        myModel,
                        null);

        Account myAgencyAccount = generateAgencyAccount(myBRPSalesSettings);

        Contact myContact = generateContact(myAgencyAccount);

        Account myDummyAccount = generateDummyAccount(myBRPSalesSettings);

        Opportunity myDummyOpportunity = generateDummyOpportunity(myDummyAccount, mySalesOffice, myMarketingCommunity); 

        Account myDummyAccount2 = generateDummyAccount2(myBRPSalesSettings);

        Opportunity myDummyOpportunity2 = generateDummyOpportunity2(myDummyAccount2, mySalesOffice, myMarketingCommunity); 

    }


    public static Account generateAgencyAccount(BRPSalesSettings__c myBRPSalesSettings) {
        Account agencyAccount=new Account();
        agencyAccount.Name='Test_Agency';
        agencyAccount.Newstar_ID__c = '999997';
        agencyAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Real Estate Agency').getRecordTypeId();

        agencyAccount.Sales_Office_mapping__c = myBRPSalesSettings.Name;

        insert agencyAccount;

        return agencyAccount;
    }


    public static Contact generateContact(Account myAgencyAccount) {
        Contact contact = new Contact();

        contact.FirstName = 'Test_F';
        contact.LastName = 'Test_L';
        contact.Newstar_ID__c = '999999';
        contact.Email = 'Contact@Test.com';
        contact.Account = myAgencyAccount;
        contact.AccountId = myAgencyAccount.Id;

        insert contact;

        return contact;
    }


    public static Account generateDummyAccount(BRPSalesSettings__c myBRPSalesSettings) {
        Account acc = new Account();

        acc.FirstName='Test_F';
        acc.LastName='Test_L';
        acc.PersonEmail = 'Test@constellationhb.com';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();

        acc.Newstar_ID__c = '999996';
        acc.Sales_Office_mapping__c = myBRPSalesSettings.Name;

        insert acc;
        return acc;
    }

    public static Account generateDummyAccount2(BRPSalesSettings__c myBRPSalesSettings) {
        Account acc = new Account();

        acc.FirstName='Test_F';
        acc.LastName='Test_L';
        acc.PersonEmail = 'Test@constellationhb.com';
        acc.PersonMailingCountryCode = 'CA';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();

        acc.Newstar_ID__c = '999995';
        acc.Sales_Office_mapping__c = myBRPSalesSettings.Name;

        insert acc;
        return acc;
    }


    public static Opportunity generateDummyOpportunity(
        Account myAccount,
        Sales_Office__c mySalesOffice,
        Marketing_Community__c myMarketingCommunity
        ) {
        Opportunity opp = new Opportunity();

        opp.Name = 'Dummy';
        opp.Newstar_ID__c = '999996';
        opp.CloseDate = System.Date.today();
        opp.StageName = 'Prospecting';
        opp.Scenario_Name__c = 'Default';

        opp.Account = myAccount;
        opp.AccountId = myAccount.Id;

        opp.Sales_Office__c = mySalesOffice.Id;

        opp.Marketing_Community__c = myMarketingCommunity.Id;        


        insert opp;

        return opp;
    }


    public static Opportunity generateDummyOpportunity2(
        Account myAccount,
        Sales_Office__c mySalesOffice,
        Marketing_Community__c myMarketingCommunity
        ) {
        Opportunity opp = new Opportunity();

        opp.Name = 'Dummy';
        opp.Newstar_ID__c = '999995';
        opp.CloseDate = System.Date.today();
        opp.StageName = 'Prospecting';
        opp.Scenario_Name__c = 'Default';

        opp.Account = myAccount;
        opp.AccountId = myAccount.Id;

        opp.Sales_Office__c = mySalesOffice.Id;

        opp.Marketing_Community__c = myMarketingCommunity.Id;        

        insert opp;

        return opp;
    }


    public static Opportunity generateContractOperationsReadyOpportunity(
            Account myAccount,
            Cobuyer__c myCoBuyer,
            Sales_Office__c mySalesOffice,
            SalesAgentSalesOfficeLink__c mySalesAgentSalesOfficeLink,
            Marketing_Community__c myMarketingCommunity,
            Subdivision__c mySubdivision,
            Model__c myModel,
            Lot__c myLot
            ) {

        Opportunity opp=new Opportunity();

        opp.Name = 'Test_DoesNotMatter';
        opp.CloseDate = System.Date.today();
        opp.StageName = 'Prospecting';
        opp.Home_Swing__c = 'Left';
        opp.Investment__c = true;

        // opp.Lot_Hold_Expiry_Date__c = System.Date.today();

        opp.Base_Model_Price__c = 350000.0;
        opp.Lot_Price__c = 1000;
        opp.Lot_Premium__c = 1500;

        if (myLot == null) {
            opp.Newstar_ID__c = '999998';
            opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Direct offer').getRecordTypeId();
        }
        else {
            opp.Newstar_ID__c = '999999';
            opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Lot reservation').getRecordTypeId();
        }

        opp.Scenario_Name__c = 'Default';

        opp.Total_Actual_Sale_Amount__c = 1000;

        opp.Total_Options_Amount__c = 1000;
        opp.Total_Discount_Amount__c = 500;

        opp.Total_Tax_Amount__c = 900;
        // opp.Total_Tax_Rebate_Amount__c = 1000;

        opp.Total_Projected_Discount_Amount__c = 0;
        opp.Total_Projected_Sale_Amount__c = 0;
        opp.Total_Projected_Tax_Amount__c = 0;
        // opp.Total_Projected_Tax_Rebate_Amount__c = 0;

        opp.Total_Scheduled_Deposit__c = 3000;
        opp.Total_Received_Deposit__c = 2000;
        opp.Total_Deposit_Due__c = 1000;

        opp.Visit_Date__c = System.Date.today();

        if (myLot == null) {
            opp.Target_Closing_Date__c = null;
        }
        else {    
            opp.Target_Closing_Date__c = System.Date.today() + 100;
        }

        opp.Revised_Closing_Date__c = System.Date.today() + 110;

        opp.Account = myAccount;
        opp.AccountId = myAccount.Id;

        opp.Sales_Office__c = mySalesOffice.Id;

        opp.Sales_Agent_Sales_Office_Relationship__c = mySalesAgentSalesOfficeLink.Id;

        opp.Marketing_Community__c = myMarketingCommunity.Id;

        opp.Subdivision__c = mySubdivision.Id;

        opp.Model__c = myModel.Id;

        if (myLot != null) {
            opp.Lot__c = myLot.Id;
        }

        insert opp;

        return opp;
    }


    private static Account generateCustomerAccount(BRPSalesSettings__c myBRPSalesSettings) { 

        Account customerAccount=new Account();
        customerAccount.FirstName='Test_F';
        customerAccount.LastName='Test_L';
        customerAccount.PersonEmail = 'Test@constellationhb.com';
        customerAccount.PersonHomePhone = '9054751234';
        customerAccount.PersonMailingCity = 'Markham';
        customerAccount.PersonMailingCountry = 'Canada';
        customerAccount.PersonMailingCountryCode = 'CA';
        customerAccount.PersonMailingPostalCode = 'L3R 6H2';
        customerAccount.PersonMailingState = 'Ontario';
        customerAccount.PersonMailingStateCode = 'ON';
        customerAccount.PersonMailingStreet = '75 Frontenac Drive';
        
        customerAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();

        customerAccount.Newstar_ID__c = '999999';
        customerAccount.Sales_Office_mapping__c = myBRPSalesSettings.Name;

        insert customerAccount;

        return customerAccount;
        
    }


    private static Sales_Office_Customer__c generateSalesOfficeCustomer(Account myAccount, Sales_Office__c mySalesOffice) {
        Sales_Office_Customer__c salesOfficeCustomer = new Sales_Office_Customer__c();

        salesOfficeCustomer.Account__c = myAccount.Id;
        salesOfficeCustomer.Sales_Office__c = mySalesOffice.Id;
        salesOfficeCustomer.Newstar_ID__c = '999999';

        insert salesOfficeCustomer;
        return salesOfficeCustomer;
    }


    private static Cobuyer__c generateCoBuyer() {
        Cobuyer__c coBuyer = new Cobuyer__c();

        coBuyer.First_Name__c = 'Test_CoB_F';
        coBuyer.Last_Name__c = 'Test_CoB_L';
        coBuyer.Newstar_ID__c = '999999';

        insert coBuyer;
        return coBuyer;
    }

    private static Newstar_Country__c generateNewstarCountry() {

        Newstar_Country__c customerNewstarCountry=new Newstar_Country__c();

        customerNewstarCountry.Name='Canada';
        customerNewstarCountry.Newstar_ID__c = '999999';

        insert customerNewstarCountry;

        return customerNewstarCountry;
    }


    private static Newstar_State__c generateNewstarState() {

        Newstar_State__c customerNewstarState = new Newstar_State__c();

        customerNewstarState.Name='Ontario';
        customerNewstarState.Code__c='ON';
        customerNewstarState.Newstar_ID__c = '999999';

        customerNewstarState.Newstar_Country__r=new Newstar_Country__c(Newstar_ID__c = '999999');

        insert customerNewstarState;

        return customerNewstarState;
    }


    private static User generateSalesUser() {

        User salesUser = new User();

        Profile salesProfile = [SELECT Id, Name FROM Profile WHERE Name LIKE '%Sales User%' LIMIT 1];

        salesUser.FirstName = 'Test';
        salesUser.LastName = 'User';
        salesUser.Email = 'kchan@constellationhb.com';
        salesUser.Alias = 'TestUser';
        salesUser.Username = 'ConstellationTest@constellationhb.com';
        salesUser.CommunityNickname = 'chbtest';
        salesUser.LocaleSidKey = 'en_US';
        salesUser.TimeZoneSidKey = 'GMT';
        salesUser.LanguageLocaleKey = 'en_US';
        salesUser.EmailEncodingKey = 'UTF-8'; 
        salesUser.ProfileId = salesProfile.Id;

        insert salesUser;
        return salesUser;
    }

    private static Sales_Agent__c generateCustomerSalesAgent(User myUser) {

        Sales_Agent__c customerSalesAgent = new Sales_Agent__c();

        customerSalesAgent.First_Name__c='Test_SA_F';
        customerSalesAgent.Last_Name__c='Test_SA_L';
        customerSalesAgent.Name=string.valueOf(customerSalesAgent.First_Name__c) + ' ' + string.valueOf(customerSalesAgent.Last_Name__c);
        customerSalesAgent.Newstar_ID__c='999999';

        customerSalesAgent.Related_to_User__c = myUser.Id;

        insert customerSalesAgent;

        return customerSalesAgent;
    }


    private static BRPSalesSettings__c generateBRPSalesSettings() {

        BRPSalesSettings__c bRPSalesSettings = new BRPSalesSettings__c();

        bRPSalesSettings.Name = 'Test_Sales_Office';
        bRPSalesSettings.Sales_Office_Name__c = 'Test';

        insert bRPSalesSettings;
        
        return bRPSalesSettings;

    }


    private static Sales_Office__c generateCustomerSalesOffice() {

        Sales_Office__c customerSalesOffice = new Sales_Office__c();
        
        customerSalesOffice.Name='Test_Sales_Office ForTest';
        customerSalesOffice.Is_Active__c = true;
        customerSalesOffice.Newstar_ID__c='999999';

        insert customerSalesOffice;

        return customerSalesOffice;
    }


    private static SalesAgentSalesOfficeLink__c generateCustomerSalesAgentSalesOfficeLink() {

        SalesAgentSalesOfficeLink__c customerSalesAgentSalesOfficeLink = new SalesAgentSalesOfficeLink__c();

        Sales_Agent__c salesAgent = new Sales_Agent__c(Newstar_ID__c='999999');

        customerSalesAgentSalesOfficeLink.Name = salesAgent.Name;

        customerSalesAgentSalesOfficeLink.Sales_Agent__r = salesAgent;
        customerSalesAgentSalesOfficeLink.Sales_Office__r = new Sales_Office__c(Newstar_ID__c='999999');
        customerSalesAgentSalesOfficeLink.Newstar_ID__c='999999';

        insert customerSalesAgentSalesOfficeLink;

        return customerSalesAgentSalesOfficeLink;
    }


    private static Marketing_Community__c generateMarketingCommunity() {
        
        Marketing_Community__c marketingCommunity = new Marketing_Community__c();

        marketingCommunity.Name='Test_Marketing_Community';
        marketingCommunity.Sales_Process_Type__c = 'Direct offer';

        Sales_Office__c salesOffice = new Sales_Office__c(Newstar_ID__c='999999');
        marketingCommunity.Sales_office__r = salesOffice;    

        insert marketingCommunity;

        return marketingCommunity;
    }


    private static Subdivision__c generateCustomerSubdivision() {

        Subdivision__c customerSubdivision = new Subdivision__c();

        customerSubdivision.Name = 'Test_Subdivision';
        customerSubdivision.Newstar_ID__c='999999';
        customerSubdivision.Is_Active__c= true;

        Sales_Office__c parentSalesOffice=new Sales_Office__c(Newstar_ID__c='999999');
        customerSubdivision.Sales_Office__r=parentSalesOffice;

        Marketing_Community__c parentMarketingCommunity=new Marketing_Community__c(Name='Test_Marketing_Community');
        customerSubdivision.Marketing_Community__r=parentMarketingCommunity;

        insert customerSubdivision;

        return customerSubdivision;
    }


    private static Model__c generateCustomerModel() {

        Model__c customerModel = new Model__c();

        Subdivision__c customerSubdivision = new Subdivision__c(Newstar_ID__c='999999');
        customerModel.Subdivision__r=customerSubdivision;

        customerModel.Newstar_ID__c='999999';

        customerModel.Beds__c=1;
        customerModel.Baths__c=1;
        customerModel.Half_Baths__c=1;
        customerModel.Garages__c=1;
        customerModel.Price__c=10000;
        customerModel.Sq_Ft__c=1000;
        customerModel.Is_Active__c=true;
        customerModel.Floors__c=1;

        customerModel.Code__c = 'Test_MC';
        customerModel.Name = 'Test_Model';


        insert customerModel;

        return customerModel;
    }


    private static Lot__c generateCustomerLot() {

        Lot__c customerLot = new Lot__c();

        customerLot.Name='Test_Lot';
        customerLot.Newstar_ID__c='999999';

        customerLot.Type__c='Regular';
        customerLot.Status__c='Open';
        customerLot.Preconfigured_Options_Amount__c = 1000;


        Model__c assignedModelRef=new Model__c(Newstar_ID__c='999999');
        customerLot.Assigned_Model__r=assignedModelRef;


        Subdivision__c customerSubdivison = new Subdivision__c(Newstar_ID__c = '999999');
        customerLot.Subdivision__r=customerSubdivison;

        customerLot.Street_Address__c='Test_Street_Address';
        customerLot.Released_for_Sale__c=true;
        customerLot.Released_for_Construction__c=true;
        customerLot.Price__c = 1000;
        customerLot.Premium__c = 2000;
        customerLot.Base_Model_Price_Override__c = 3000;

        insert customerLot;

        return customerLot;
    }


    private static Contigency__c generateCustomerContigency(Opportunity myOpportunity) {

        Contigency__c customerContigency = new Contigency__c();

        customerContigency.Type__c = 'Home to Sell';
        customerContigency.Newstar_ID__c = '999999';
        customerContigency.Expiry_date__c = date.ValueOf('2019-07-25');
        customerContigency.Opportunity__c = myOpportunity.Id;

        insert customerContigency;

        return customerContigency;
    }


/*** 
    public static void cleanUp() {

        List<Contigency__c> contigencyList = [SELECT Id FROM Contigency__c WHERE Newstar_ID__c = '999999'];
        DELETE contigencyList;

        List<Opportunity> OpportunityList = [SELECT Id FROM Opportunity WHERE Newstar_ID__c = '999999'];
        DELETE OpportunityList;

        List<Sales_Office_Customer__c> SalesOfficeCustomerList = [SELECT Id FROM Sales_Office_Customer__c WHERE Newstar_ID__c = '999999'];
        DELETE SalesOfficeCustomerList;

        List<Account> AccountList = [SELECT Id FROM Account WHERE Newstar_ID__c = '999999'];
        DELETE AccountList;

        List<Lot__c> LotList = [SELECT Id FROM Lot__c WHERE Newstar_ID__c='999999'];
        DELETE LotList;

        List<Model__c> ModelList = [SELECT Id FROM Model__c WHERE Newstar_ID__c = '999999'];
        DELETE ModelList;

        LIST<Subdivision__c> SubdivisionList = [SELECT Id FROM Subdivision__c WHERE Newstar_ID__c = '999999'];
        DELETE SubdivisionList;

        LIST<Marketing_Community__c> MarketingCommunityList = [SELECT Id FROM Marketing_Community__c WHERE Name = 'Test_Marketing_Community'];
        DELETE MarketingCommunityList;

        List<SalesAgentSalesOfficeLink__c> salesAgentSalesOfficeLinkList = [SELECT Id FROM SalesAgentSalesOfficeLink__c WHERE Newstar_ID__c='999999'];
        DELETE salesAgentSalesOfficeLinkList;

        List<Sales_Office__c> salesOfficeList = [SELECT Id FROM Sales_Office__c WHERE Newstar_ID__c='999999'];
        DELETE salesOfficeList;

        List<Sales_Agent__c> salesAgentList = [SELECT Id FROM Sales_Agent__c WHERE Newstar_ID__c='999999'];
        DELETE salesAgentList;

        List<Newstar_State__c> newstarStateList = [SELECT Id FROM Newstar_State__c WHERE Newstar_ID__c='999999'];
        DELETE newstarStateList;

        List<Newstar_Country__c> newstarCountryList = [SELECT Id FROM Newstar_Country__c WHERE Newstar_ID__c = '999999'];
        DELETE newstarCountryList;

    }
***/


}