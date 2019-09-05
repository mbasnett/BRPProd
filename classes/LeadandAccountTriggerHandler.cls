public with sharing class LeadandAccountTriggerHandler
{
    public  void leadconvert(list<Lead> lstlead)
    {   
       try
       {
            list<Id> lstaccountid=new list<Id>();
            map<Id,lead> mpLeadaccount=new map<id,lead>();
            string query='select Id,recordtypeId,sessionid__pc,Lead_Channel__c,FirstName,Project__c,createduser__pc,PersonLeadSource,Visit_Date__pc,LastName,sales_office_mapping__c,';
            string strfieldnames='';
            //list<Id> Accountid=new list<id>();
            for(Lead ld:lstLead)
            {
                if(ld.isconverted==false)
                {
                    Database.LeadConvertResult lcr=convertLead(ld.Id);
                    if(lcr.isSuccess())
                    {
                        //AccountId.add(lcr.getAccountId());
                        string nameval=BRPValidation.getsalesofficename(ld.sales_office_mapping__c);
                        Id accountid=lcr.getAccountId();
                        lstaccountid.add(accountid);
                        mpLeadaccount.put(accountid,ld);
                        Boolean exstfieldname=strfieldnames.contains('community_picklist_' + nameval +'__pc');
                        if(exstfieldname==false)
                        {
                            if(strfieldnames=='')
                                strfieldnames='community_picklist_' + nameval+'__pc';
                            else
                                strfieldnames=strfieldnames+','+'community_picklist_' + nameval+'__pc';
                        }
                    }
                }
            }
            query=query+ strfieldnames +' from  Account where Id=: lstaccountid';
            system.debug(query);
            if(lstaccountid.size()>0)
            {
                list<account> lstaccount=Database.query(query);//'select Id,recordtypeId,FirstName,createduser__pc,PersonLeadSource,Visit_Date__pc,LastName,sales_office_mapping__c,community_picklist_' + nameval+'__pc from  Account where Id in: lstaccountid');
                map<Id,ID> mpcontact=new map<id,Id>();
                for(contact con: [select Id,accountId from Contact where accountid IN: lstaccountId])
                    mpcontact.put(con.accountId,con.Id);
                ValidateExistingopportunities(lstaccount,mpcontact);
                
            }
        }
        catch(exception ex)
        {
           system.debug(ex.getmessage());      
        }
        
    }
    private Database.LeadConvertResult convertLead(Id leadId)
    {
        try
        {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(leadId);
        lc.setDoNotCreateOpportunity(true);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            system.debug('Before lead convert');
            //try{
           ///     system.debug('Inside Lead convert');
                return Database.convertLead(lc);
            //}
            //catch (Exception ex) {
            //    System.debug('@@@@ - convert error: ' + ex.getMessage());
           // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,string.valueof(ex));
            //ApexPages.addMessage(myMsg);
               // throw new AuraHandledException('Error Exception happend'+ex.getMessage());           
           // return null;
            //}
            }
            catch(exception ex)
            {
                system.debug(ex.getmessage());
                return null;
            }
    }
    
   /* private void createOpportunities(account acct,string mktcomm,string leadsource)
    {
        List<Opportunity> lstOpp=new list<Opportunity>();
        Set<Id> setIntlst= new Set<Id>();

       // integer index=0;
       // list<contact> lstContact= [select Id from Contact where accountid=: acct.Id];
        try
        {
              
               
               
 
        }
        catch(exception ex)
        {
            system.debug(ex.getmessage());
        }
        
    }*/
  
  public void ValidateExistingopportunities(list<account> lstacc,map<id,id> mpcontact)
  {
       try
       {
       List<Opportunity> lstOpp=new list<Opportunity>();
       list<HS_Create_Lead__e> lstevent=new list<HS_Create_Lead__e>();
       map<string, marketing_community__c> mpcommuntiynames=new Cachedcollections().getCachecommunityMapNames;
       system.debug('entering opportunity creation');
       map<string, subdivision__c> mpprojectnames=new Cachedcollections().getCacheprojectMapNames;
       for (account acct : lstacc)
       {
           sobject s=acct;
           //lead ld=mpLeadaccount.get(acct.Id);
           string nameval=BRPValidation.getsalesofficename(s);

           //createOpportunities(acc,(string) s.get('Community_Picklist_'+ nameval +'__pc'),ld.leadsource);
            Opportunity opp=new Opportunity();
            opp.accountId=acct.Id;
            string mktcomm=(string)s.get('Community_Picklist_'+ nameval +'__pc');
            if(mktcomm!=null)
            {
                opp.name=acct.Firstname + ' ' + acct.LastName + ' - ' + mktcomm;
                system.debug(opp.name);
                Marketing_community__c mktcommobj=mpcommuntiynames.get(mktcomm);
                opp.marketing_community__c=mktcommobj.Id;
                opp.lead_channel__c=acct.Lead_Channel__c;
                   //opp.LeadSource=ld.leadsource;
                opp.StageName='Prospecting';//intlst.stage__c;
                if (acct.PersonLeadSource!= '')
                    opp.LeadSource=acct.PersonLeadSource;
                opp.closeDate=date.today().addDays(60); /* Look into target close date in newstar*/
                opp.Converted_From_Lead__c=true;
    
                opp.Sales_Office__c=mktcommobj.sales_office__c;
                opp.Scenario_Name__c='Default Scenario';
                system.debug(acct.project__c);
                if(acct.project__c!=null )
                    opp.subdivision__c=mpprojectnames.get(acct.project__c).Id;
                opp.Visit_date__c =acct.Visit_date__pc;
                string profilename=new BRPValidation().getProfileName(acct.createduser__pc);
                string agentId=new BRPValidation().getSalesAgentOfficeId(acct.createduser__pc);
                if(profileName.endswith('ISR profile'))
                   opp.Internet_Sales_Repr__c=agentId;
                if(profileName.endswith('Sales User Profile'))
                   opp.Sales_Agent_Sales_Office_Relationship__c=agentId;
                if(profileName.endswith('Sales Assistant'))
                   opp.Assigned_Sales_Assistant__c=agentId;
                system.debug(opp);
                //system.debug(opp.Internet_Sales_Repr__c);
                //   insert Opp;
                lstopp.add(opp);
               
               if(acct.sessionId__pc!='')
               {
                   HS_Create_Lead__e event=new HS_Create_Lead__e();
                   event.recordid__c=acct.Id;
                   event.objecttype__c='Account';
                   event.sessionId__c=acct.sessionId__pc;
                   lstevent.add(event);
                   
               }
           }
       }
       insert lstopp;
       system.debug('opportunity inserted');
       list<OpportunityContactRole> lstoppconrole=new list<OpportunityContactRole>();
       for(Opportunity o : lstOpp)
        {
              OpportunityContactRole ocr = new OpportunityContactRole();
              ocr.OpportunityId = o.Id;
              ocr.ContactId = mpcontact.get(o.AccountId);
              ocr.Role = 'Primary Buyer';
              lstoppconrole.add(ocr);
         }
       insert lstoppconrole;
       system.debug('event to be published');        
       if(lstevent.size()>0)
           Eventbus.publish(lstevent);
    }
    catch(exception ex)
    {
        system.debug(ex.getmessage());
    }
  }
  public void CreateRealtors(list<lead> lstlead)
  {
       try
       { 
            account acct=database.query('select id from account where name=\'Temp Real Estate agency\'');
            list<contact> lstcontact=new list<contact>();
            list<HS_Create_Lead__e> lstevent=new list<HS_Create_Lead__e>();
            for(Lead ld:lstLead)
            {
                contact con=new contact();
                
                con.recordtypeId= SObjectType.Contact.getRecordTypeInfosByName().get('Real Estate Agent').getRecordTypeId();
                con.firstname=ld.firstname;
                con.lastname=ld.lastname;
                con.email=ld.email;
                con.mobilephone=ld.mobilephone;
                con.HomePhone=ld.phone;
                con.accountId=acct.Id;
                con.sessionId__c=ld.sessionid__c;
                lstcontact.add(con);
            }
            insert lstcontact;
            for(contact con:lstcontact)
            {
                if(con.sessionId__c!='') 
                {
                    HS_Create_Lead__e event=new HS_Create_Lead__e();
                    event.recordid__c=con.Id;
                    event.sessionId__c=con.sessionId__c;
                    event.objecttype__c='Contact';
                    lstevent.add(event);
                }
            }
            if(lstevent.size()>0)
               Eventbus.publish(lstevent);
       }
       catch(exception ex)
       {
       }
  }
}