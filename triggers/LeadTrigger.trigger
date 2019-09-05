trigger LeadTrigger on Lead (before insert, after insert) {
    
    if(trigger.isbefore && trigger.isinsert)
       {
           
           BRPValidation brpval=new BRPValidation();
           for(sobject s:trigger.new)
           {
               if(s.get('realtor__c')==false)
               {
                   string nameval=BRPValidation.getsalesofficename(s);
                   brpval.genericInterestcreation(s,'Insert',(string) s.get('Community_Picklist_'+ nameval +'__c'), 'Community_List_' + nameval +'__c', 'Community_History_' + nameval +'__c');
               }

               //lead ld=(lead) s;
               //ld.company='brookfield';
           }
           //new BRPValidation().CommunityInterestcreation(trigger.new,null,'Insert');
       }
        if(trigger.isafter && trigger.isinsert )
        {
           list<lead> lstProspectlead=new list<lead>();
           list<lead> lstRealtorlead=new list<lead>();
           list<lead> lstlead=new list<lead>();
           for(lead ld:trigger.new)
           {
               if(ld.get('realtor__c')==true)
               {
                   lstRealtorlead.add(ld);
                   lstlead.add(new lead (Id=ld.Id, firstname=ld.firstname, lastname=ld.lastname));
               }
               else
               {
                   lstProspectlead.add(ld);
               }
           }
           if(lstRealtorlead.size()>0)
           {
               new LeadandAccountTriggerHandler().CreateRealtors(lstRealtorlead);
           }
           if(lstprospectlead.size()>0)
               new LeadandAccountTriggerHandler().leadconvert(lstProspectlead);
           delete lstlead;
        }
        
}