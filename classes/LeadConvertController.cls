public inherited sharing class LeadConvertController
{
   /* public static Map<String, Schema.RecordTypeInfo> CobuyerRecordTypeaMap = cobuyer__c.SObjectType.getDescribe().getRecordTypeInfosByName();
    public static map<id,integer> mpOpp=new map<id,integer>();
    
    @Auraenabled
    public static Id leadconvert(Id LeadId)
    {   
        Database.LeadConvertResult lcr=convertLead(leadId);
        if(lcr.isSuccess())
        {
            Id AccountId=lcr.getAccountId();
            Account acc=[select Id, recordtypeId from  Account where Id=: AccountId];
            acc.recordtypeId=account.SObjectType.getDescribe().getRecordTypeInfosByName().get('Customer').getRecordTypeId();
            update acc;
            list<Opportunity> lstOpp=createOpportunities(leadId, AccountId);
            return AccountId;
        }
        return null;
    }
    
    // Convert Lead and create a new Account and Opportunity
    private static Database.LeadConvertResult convertLead(Id leadId)
    {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(leadId);
        lc.setDoNotCreateOpportunity(true);
        lc.setConvertedStatus(convertStatus.MasterLabel);
        system.debug('Before lead convert');
        try{
            system.debug('Inside Lead convert');
            return Database.convertLead(lc);
        }
        catch (Exception ex) {
            System.debug('@@@@ - convert error: ' + ex.getMessage());
           // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,string.valueof(ex));
            //ApexPages.addMessage(myMsg);
            throw new AuraHandledException('Error Exception happend'+ex.getMessage());           
            //return null;
        }
    }


  /* convert Interest Lists to Opportunities and change cobuyer recordtype to Opporttunity*/
  /*  private static list<Opportunity> createOpportunities(Id leadId,Id acct)
    {
        //List<Interest_list__c> lstIntLst=[select Id, Name, stage__c,rank__c,lead_source__c from Interest_list__c where Lead__c =: ld.Id];
        List<Opportunity> lstOpp=new list<Opportunity>();
        Set<Id> setIntlst= new Set<Id>();

        integer index=0;
        list<contact> lstContact= [select Id from Contact where accountid=: acct];
        list<Interest_list__c> lstIntLst=[select Id, Name, stage__c,lead_source__c,marketing_community__c,Sales_Office__c,lead__r.Name,
        Subdivision__c,subdivision__r.name,Realtor__c from Interest_list__c where Lead__c =: leadId];
        Validate(lstIntLst);
        try
        {
        for(Interest_list__c intLst:lstIntLst)
        {
           Opportunity opp=new Opportunity();
           opp.accountId=acct;
           string oppname=IntLst.Lead__r.name + ' - ' + Cachedcollections.mysubdivisionIdMap.get(IntLst.subdivision__c);
           system.debug(' Opportunity name: ' + oppname);
           system.debug(' Subdivision name: ' + IntLst.subdivision__c);
           system.debug(' Cached Subdivision name: ' + Cachedcollections.mysubdivisionIdMap.get(IntLst.subdivision__c));
           opp.name=oppname;
           opp.marketing_community__c=intLst.marketing_community__C;
           opp.StageName='Prospecting';//intlst.stage__c;
           if (intLst.lead_source__c!= '')
               opp.LeadSource=intLst.lead_source__c;
           opp.closeDate=date.today().addDays(60); /* Look into target close date in newstar*/
           //opp.Converted_From_Lead__c=true;
          /* if (intLst.Realtor__c!= '')
               opp.Real_Estate_Agent__c=intLst.Realtor__c;
           opp.Sales_Office__c=intLst.Sales_Office__c;
           opp.Scenario_Name__c='Default Scenario';
           if(intlst.Subdivision__c!=null)
               opp.Subdivision__c=intlst.Subdivision__c;
           setIntlst.add(intlst.Id);
           mpopp.put(intlst.Id, index);
           index++;
           lstopp.add(opp);
        }
        insert lstOpp;
        list<cobuyer__c> lstCobuyer = [select Id,recordtypeId,Opportunity__c,interest_list__c from Cobuyer__c where Interest_list__c in :setIntlst];
        //list<beback__c> lstnotes = [select Id,Opportunity__c,Community_of_Interest__c from beback__c where Community_of_Interest__c in :setIntlst];
        for(Cobuyer__c coby:lstCobuyer )
        {
            coby.recordtypeId=CobuyerRecordTypeaMap.get('Opportunity').getRecordTypeId();
            if(mpopp.containskey(coby.interest_list__c))
            {
               // system.debug('index' + mpopp.get(coby.interest_list__c));
              //  system.debug('Opportunity list:' + lstOpp);
                coby.opportunity__c=lstOpp[mpopp.get(coby.interest_list__c)].Id;
            }
        }
        update lstCobuyer;*/
        /*for(beback__c n: lstnotes)
        {
            if(mpopp.containskey(n.Community_of_Interest__c))
            {
               // system.debug('index' + mpopp.get(coby.interest_list__c));
              //  system.debug('Opportunity list:' + lstOpp);
                n.opportunity__c=lstOpp[mpopp.get(n.Community_of_Interest__c)].Id;
            }
        }
        update lstnotes;*/
       /* list<OpportunityContactRole> lstoppconrole=new list<OpportunityContactRole>();
        for(Opportunity opp : lstOpp)
        {
            OpportunityContactRole ocr = new OpportunityContactRole();
            ocr.OpportunityId = opp.Id;
            ocr.ContactId = lstcontact[0].Id;
            ocr.Role = 'Primary Buyer';
            lstoppconrole.add(ocr);
        }
        insert lstoppconrole;
        //account = [Select Id, PersonContactId from Account where Id=: account.Id];
        }
        catch(exception ex)
        {
            throw new AuraHandledException('Error Exception happend'+ex.getMessage());
        }
        return lstOpp;
    }
    private static void Validate(List<Interest_List__c> lstIntLst)
    {
        for(Interest_list__c intLst:lstIntLst)
        {
            if (intLst.stage__c == null) 
                { 
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value')); 
                }  
        }
    }
   private static void addToOpportunityRole(String personContactId, 
                                            String oppId, 
                                            String role)
    {
       
    }  */
}