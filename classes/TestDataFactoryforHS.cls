@isTest 
public class TestDataFactoryforHS 
{ 
    public static user createISRUser()
    { 
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com'; 
        Profile p = [SELECT Id FROM Profile WHERE Name='DC ISR profile']; 
               
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', 
        UserName=uniqueUserName); 
        insert u;
        return u;
    } 
    public static user createSalesUser()
    { 
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com'; 
        Profile p = [SELECT Id FROM Profile WHERE Name='DC Sales User profile']; 

        User u = new User(Alias = 'standt2', Email='standarduser2@testorg.com', 
        EmailEncodingKey='UTF-8', LastName='Testing2', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', 
        UserName=uniqueUserName+'.ver2'); 
        insert u;
        return u;
    } 
    
    public static BRPSalesSettings__c  CreateCustomSetting()
    {
        BRPSalesSettings__c csobj=new BRPSalesSettings__c (); 
        csobj.Sales_Office_Name__c='Wash'; 
        csobj.name='Washington'; 
        insert csobj;
        return csobj;
    }
    
    public static Sales_Office__c  CreateSalesOffice(string soffname)
    {
        Sales_Office__c soffice=new Sales_Office__c(name=soffname);
        insert soffice;
        return soffice;
    }
    public static Marketing_community__c CreateMarketingcommunity(string mktname,Id SofficeId)
    {
        Marketing_community__c mktcomm=new  Marketing_community__c(name=mktname,Sales_office__c=SofficeId,Sales_Process_Type__c='Lot reservation',Other_groups_can_Read__c=false);
        insert mktcomm;
        return mktcomm;
    }
    public static SalesAgentSalesOfficeLink__c  Createsalesagentlink(string fname, string lname, Id userid,ID sofficeId)
    {
        //ISR user sales agent
        sales_agent__c sagent= new sales_agent__c(First_name__c=fname,last_name__c=lname, Related_to_User__c=userid);
        insert sagent;
        SalesAgentSalesOfficeLink__c sofficeagent= new SalesAgentSalesOfficeLink__c(Name=fname + ' ' + lname, Sales_Office__c=sofficeId,
        Is_Primary__c=true,Sales_Agent__c=sagent.Id);
        insert sofficeagent;
        return sofficeagent;
    }
}