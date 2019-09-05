trigger ContactTrigger on Contact(after update, before update, before insert) {
    /*list<Id> lstcontactid=new list<id>();
    if(trigger.isbefore && trigger.isupdate)
    {
        for(Contact con: Trigger.new)
        {
            contact prevcon = Trigger.oldMap.get(con.Id);
            if(prevcon.Are_you_a_Realtor__c==true && con.Are_you_a_Realtor__c==false)
            {
                lstcontactid.add(con.Id);
            }
        }
    }*/
    if(trigger.isbefore && trigger.isinsert)
    {
        for(Contact con: Trigger.new)
        {
            if(con.recordtypeid==SObjectType.Contact.getRecordTypeInfosByName().get('Real Estate Agent').getRecordTypeId())
                con.Are_you_a_Realtor__c=true;
        }
    }
    if(trigger.isafter && trigger.isupdate)
       {
           list<lead> lstlead=new list<lead>();
           for(Contact con: Trigger.new)
              {
                  contact prevcon = Trigger.oldMap.get(con.Id);
                  if(prevcon.Are_you_a_Realtor__c==true && con.Are_you_a_Realtor__c==false)
                    {
                      lead ld=new lead();
                      ld.firstname=con.firstname;
                      ld.lastname=con.lastname;
                      ld.email=con.email;
                      ld.lead_channel__c=con.lead_channel__c;
                      ld.createduser__c=con.createduser__c;
                      list<SalesAgentSalesOfficeLink__c> lstsalesoffice=quickLeadCreate.getSalesOffices(con.createduser__c);
                      string salesoffice= lstsalesoffice[0].Sales_Office__r.Name;
                      string nameval=BRPValidation.getsalesofficename(salesoffice);
                      string communityfieldname='community_picklist_'+ nameval +'__c';
                      ld.sales_office_mapping__c=salesoffice;
                      ld.sessionid__c=con.SessionId__c;
                      ld.realtor__c=con.Are_you_a_Realtor__c;
                      sobject scon=con;
                      sobject slead=ld;
                      slead.put(communityfieldname,scon.get(communityfieldname));
                      ld=(lead) slead;
                      lstlead.add(ld);
                 
                      }
               }
         insert lstlead;
       }
 }