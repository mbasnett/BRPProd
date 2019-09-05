trigger PersonAccountTrigger on Account (before update,after update) {
 if(trigger.isbefore && trigger.isupdate)
    {
           system.debug('before update');
           BRPValidation brpval=new BRPValidation();
           for(account a:trigger.new)
           {
               if(a.RecordTypeID == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId())
               {
                   sobject s=a;
                   string nameval=BRPValidation.getsalesofficename(s);
                   system.debug(s.get('Community_Picklist_'+ nameval +'__pc'));
                   sobject oldrecord=trigger.oldmap.get(a.Id);
                   sobject newrecord=trigger.newmap.get(a.Id);
                   if((string) newrecord.get('Community_Picklist_'+ nameval +'__pc')!=null  && (string) oldrecord.get('Community_Picklist_'+ nameval +'__pc') != (string) newrecord.get('Community_Picklist_'+ nameval +'__pc'))
                   {
                       brpval.genericInterestcreation(s,'Insert',(string) s.get('Community_Picklist_'+ nameval +'__pc'), 'Community_List_' + nameval +'__pc', 'Community_History_' + nameval +'__pc');
                       //new LeadandAccountTriggerhandler().ValidateExistingopportunities(a,a.sessionid__pc);
                      
                   }
               }
           }
     }
 if(trigger.isafter && trigger.isupdate)
     {
         system.debug('after update');
         BRPValidation brpval=new BRPValidation();
         list<account> lstaccount=new list<account>();
         list<lead> lstlead =new list<lead>();
         list<Id> lstaccountid=new list<Id>();
         map<id,id> mpcontact=new map<id,id>();
           for(account a:trigger.new)
           {
               if(a.Are_you_a_Realtor__pc ==false)
               {
                   if(a.RecordTypeID == Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId())
                   {
                       sobject s=a;
                       string nameval=BRPValidation.getsalesofficename(s);
                       system.debug(s.get('Community_Picklist_'+ nameval +'__pc'));
                       sobject oldrecord=trigger.oldmap.get(a.Id);
                       sobject newrecord=trigger.newmap.get(a.Id);
                       if((string) newrecord.get('Community_Picklist_'+ nameval +'__pc')!=null  && (string) oldrecord.get('Community_Picklist_'+ nameval +'__pc') != (string) newrecord.get('Community_Picklist_'+ nameval +'__pc'))
                       {
                           lstaccount.add(a);
                           lstaccountid.add(a.Id);
                           //brpval.genericInterestcreation(s,'Insert',(string) s.get('Community_Picklist_'+ nameval +'__pc'), 'Community_List_' + nameval +'__pc', 'Community_History_' + nameval +'__pc');
                           //new LeadandAccountTriggerhandler().ValidateExistingopportunities(a,a.sessionid__pc,a.PersonLeadSource);
                           //a.put('Community_Picklist_'+ nameval +'__pc','');
                       }
                   }
               }
               else
               {
                   lead ld=new lead();
                   ld.firstname=a.firstname;
                   ld.lastname=a.lastname;
                   ld.email=a.personemail;
                   ld.sessionId__c=a.sessionid__pc;
                   ld.phone=a.phone;
                   ld.mobilephone=a.PersonMobilePhone;
                   ld.realtor__c=a.Are_you_a_Realtor__pc;
                   lstlead.add(ld);
               }
           }
           if(lstaccountid.size()>0)
           {
               for(contact con: [select Id,accountId from Contact where accountid IN: lstaccountId])
                    mpcontact.put(con.accountId,con.Id);
               new LeadandAccountTriggerhandler().ValidateExistingopportunities(lstaccount,mpcontact);
           }
           if(lstlead.size()>0)
           {
               new LeadandAccountTriggerhandler().CreateRealtors(lstlead);
           }
           
     }
}