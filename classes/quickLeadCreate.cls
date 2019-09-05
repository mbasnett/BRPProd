public Without Sharing class quickLeadCreate
{
 
    @auraenabled
    public static list<Marketing_community__c> getMktcommunity(id SalesOfficeId)
    {
       List<Marketing_community__c> lstMktCommunity= [select id, name from Marketing_community__c where Sales_office__c =:SalesOfficeId];
       return lstMktCommunity;
    }
    @auraenabled
    public static list<SalesAgentSalesOfficeLink__c> getSalesOffices(string userid)
    {
       system.debug(UserInfo.getUserId());
       list<SalesAgentSalesOfficeLink__c> lstSalesOffice=[select Sales_Office__r.Id,Sales_Office__r.Name from SalesAgentSalesOfficeLink__c where Sales_Agent__r.Related_to_User__c=:userid order by Is_primary__c desc ];
       return lstSalesOffice;
    }
   
  @AuraEnabled
    public static List<List<String>> getPicklistvalues(String objectName, String field_apinames,Boolean nullRequired){
        List<List<string>> picklists= new List<List<string>>();
        list<string> fieldnames=field_apinames.split(',');
        for (integer i =0; i<fieldnames.size(); i++)
        {
        List<String> optionlist = new List<String>();
        
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get(objectName.toLowerCase()).getDescribe().fields.getMap(); 
        system.debug(fieldnames[i]);
        List<Schema.PicklistEntry> picklistValues = field_map.get(fieldnames[i]).getDescribe().getPickListValues();
        
        if(nullRequired == true){
            optionlist.add('--None--');
        }
        
        for (Schema.PicklistEntry pv : picklistValues) {
            optionlist.add(pv.getlabel());
        }
        picklists.add(optionlist);
        }
        return picklists;
    }
  @Auraenabled
  public static string SaveHSrecord(lead leadObj,string selectcommunity)
  {
     
     string sessionid=userinfo.getsessionId();
     try
     {
          //system.debug(leadobj.mobilephone);
        // if(leadobj.realtor__c==true)
        // {
             boolean isperson=false;
             boolean isrealtor=false;
             list<contact> exstperscon=ContactExists(leadobj);
             id contactid;
             id personId;
             id accountid;
             if(exstperscon.size()>0)
             {
                 for(integer i=0; i<exstperscon.size();i++)
                 {
                     if(exstperscon[i].recordtypeid==null)
                     {
                         isperson=true;
                         personid=exstperscon[i].Id;
                         accountid=exstperscon[i].accountid;
                     }
                     else
                     {
                         isrealtor=true; 
                         contactid=exstperscon[i].Id;
                     }   
                 }
                 if(isperson )
                 {
                      if(isrealtor)
                      {
                         if(leadobj.realtor__c==true)
                         {
                             HS_Create_Lead__e event=new HS_Create_Lead__e();
                             event.recordid__c=contactid;
                             event.objecttype__c='Contact';
                             event.sessionId__c=userInfo.getSessionId();
                             Eventbus.publish(event);
                         }
                         else
                         {
                             marketing_community__c mktcommobj=new Cachedcollections().getCachecommunityMapNames.get(selectcommunity);
                             list<opportunity> exstopp=OpportunityExists(accountid,mktcommobj.Id);
                             if(exstopp.size()>0)
                             {
                                 if(leadobj.lead_channel__c=='Walk-in' || leadobj.lead_channel__c=='Phone Inquiry' || leadobj.Lead_Channel__c == 'MyTime Tour')
                                     new BRPValidation().ShareOppwithcommunity(exstopp);
                                 HS_Create_Lead__e event=new HS_Create_Lead__e();
                                 event.recordid__c=personid;
                                 event.objecttype__c='account';
                                 event.sessionId__c=userInfo.getSessionId();
                                 Eventbus.publish(event);
                             }
                             else
                             {
                                 if(!Test.isRunningTest())
                                     sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
                             }
                          }
                      }
                      else
                      {
                         if(leadobj.realtor__c==true)
                         {
                             if(!Test.isRunningTest())
                                     sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
                         }
                         else
                         {
                             marketing_community__c mktcommobj=new Cachedcollections().getCachecommunityMapNames.get(selectcommunity);
                             list<opportunity> exstopp=OpportunityExists(accountid,mktcommobj.Id);
                             if(exstopp.size()>0)
                             {
                                 if(!Test.isRunningTest())
                                     sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
                                 
                             }
                             else
                             {
                                if(leadobj.lead_channel__c=='Walk-in' || leadobj.lead_channel__c=='Phone Inquiry' || leadobj.Lead_Channel__c == 'MyTime Tour')
                                     new BRPValidation().ShareOppwithcommunity(exstopp);
                                 HS_Create_Lead__e event=new HS_Create_Lead__e();
                                 event.recordid__c=personid;
                                 event.objecttype__c='account';
                                 event.sessionId__c=userInfo.getSessionId();
                                 Eventbus.publish(event); 
                             }
                          }
                      
                      }
                 }    
                 else     
                 {
                      if(isrealtor)
                      {
                           if(leadobj.realtor__c)
                           {
                               HS_Create_Lead__e event=new HS_Create_Lead__e();
                               event.recordid__c=contactid;
                               event.sessionId__c=userInfo.getSessionId();
                               event.objecttype__c='Contact';
                               Eventbus.publish(event);
                           }
                           else
                           {
                               if(!Test.isRunningTest())
                               sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
                           }
                       }
                       else
                       {
                           if(!Test.isRunningTest())
                              sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
                       }
                 }    
             }
             else
                 if(!Test.isRunningTest())
                             sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);

        // }
        /* else
         {
             list<account>  exstacct=AccountExists(leadobj);
             if(exstacct.size()>0)
             {
                 marketing_community__c mktcommobj=new Cachedcollections().getCachecommunityMapNames.get(selectcommunity);
                 list<opportunity> exstopp=OpportunityExists(exstacct[0].Id,mktcommobj.Id);
                 if(exstopp.size()>0)
                 {
                      if(leadobj.lead_channel__c=='Walk-in' || leadobj.lead_channel__c=='Phone Inquiry' || leadobj.Lead_Channel__c == 'MyTime Tour')
                          new BRPValidation().ShareOppwithcommunity(exstopp);
                      HS_Create_Lead__e event=new HS_Create_Lead__e();
                      event.recordid__c=exstacct[0].Id;
                      event.objecttype__c='Account';
                      event.sessionId__c=userInfo.getSessionId();
                      Eventbus.publish(event);
                 }
                 else
                 {
                     if(!Test.isRunningTest())
                         sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
                 }
             }
             else
                 if(!Test.isRunningTest())
                     sessionid=Hubspotcreationcalls.createHsformdata(leadobj,selectcommunity);
          }*/
     }
     catch(exception ex)
     {
         throw new AuraHandledException(ex.getmessage());
     }
     return sessionid;
     
  }
  @AuraEnabled
  public static string getSalesofficename(string sofficename)
  {
      string nameval=BRPValidation.getsalesofficename(sofficename);
      return nameval;
  }
  @AuraEnabled
  public static List<string> getOppSharingGroups(string Id)
  {
      return new BRPValidation().getOppSharingGroups(Id);

  }
  @AuraEnabled
  public static string getProfilename(string userid)
  {
       system.debug('hello');
       string retvalue='';
       retvalue=new BrpValidation().getProfileName(userid);
       return retvalue;
  }
  public static list<Account> AccountExists(Lead leadobj)
    {
       // system.debug('lastname =' + leadobj.lastName + ' and marketing_division__c =' + leadobj.marketing_division__c + 'and (  phone =' + leadobj.Phone + ' or Personemail =' + leadobj.email +' or PersonMobilePhone = ' + leadobj.mobilephone +')'); 
/* **** commented out by Dave Aug 16 - added in a check that the phone numbers weren't matching on nulls ****
       List<Account> accountobj=[select Id, Name,PersonEmail,PersonMobilePhone,Phone,PersonMailingAddress from Account where lastname =: leadobj.lastName 
       and (  phone =: leadobj.Phone or Personemail =: leadobj.email
       or PersonMobilePhone =: leadobj.mobilephone ) limit 1];
       return accountobj;
*/      
        string mobilephone='';
        string phone='';
        if(leadobj.mobilephone!='')
               mobilephone='(' + leadobj.mobilephone.Left(3) + ') ' + leadobj.mobilephone.mid(4,3) + '-' + leadobj.mobilephone.right(4);
           if(leadobj.phone!='')
               phone='(' + leadobj.phone.Left(3) + ') ' + leadobj.phone.mid(4,3) + '-' + leadobj.phone.right(4);
 
       List<Account> accountobj=[select Id, Name,PersonEmail,PersonMobilePhone,Phone from Account where Personemail =: leadobj.email 
       or ( lastname =: leadobj.lastName and ( (phone =: phone and phone != '')  
       or (PersonMobilePhone =: mobilephone and PersonMobilePhone != '')) ) limit 1];
       return accountobj;
       
    }
    public static list<Opportunity> OpportunityExists(Id AccountId,Id MktcommId)
    {
       List<Opportunity> oppobj=[select id, name,StageName,Marketing_Community__c from Opportunity where accountId=: AccountId and Marketing_Community__c=: MktcommId and (Iswon= false or isclosed=false) ];
       return oppobj;
    }
    public static list<contact> ContactExists(lead leadobj)
    {
        string mobilephone='';
        string phone='';
        if(leadobj.mobilephone!='')
               mobilephone=leadobj.mobilephone;//'(' + leadobj.mobilephone.Left(3) + ') ' + leadobj.mobilephone.mid(4,3) + '-' + leadobj.mobilephone.right(4);
           if(leadobj.phone!='')
               phone=leadobj.phone;//'(' + leadobj.phone.Left(3) + ') ' + leadobj.phone.mid(4,3) + '-' + leadobj.phone.right(4);
 
        List<contact> contactobj=[select Id, Name,Email,accountid,MobilePhone,HomePhone,recordtypeid from contact where  email =: leadobj.email 
        or ( lastname =: leadobj.lastName and ( (HomePhone =: Phone and HomePhone != '') or (MobilePhone =: mobilephone and MobilePhone != '')) ) limit 1 ];
        return contactobj;
    }
}