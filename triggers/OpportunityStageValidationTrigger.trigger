trigger OpportunityStageValidationTrigger on Opportunity (before update,after update,after insert) {
    if(trigger.isafter && trigger.isupdate)
    {
        list<opportunity> lstsharewithCommunity=new list<opportunity>();
        for (Opportunity opp: Trigger.new)
        {
          
         //if the opportunity has an assigned sales rep value added newly, share the opportunity object with the community group.
         if(trigger.oldmap.get(opp.Id).Sales_Agent_Sales_Office_Relationship__c !=trigger.newmap.get(opp.Id).Sales_Agent_Sales_Office_Relationship__c)
            {
                //string mktcommname=new Cachedcollections().getCachecommunityMapIds.get(opp.Marketing_Community__c);
                //Marketing_community__c mktcommobj=new Cachedcollections().getCachecommunityMapNames.get(mktcommname);
                //new BRPValidation().ShareOppwithcommunity(opp.Id,mktcommname,mktcommobj);
                lstsharewithCommunity.add(opp);
            }
        }
        if(lstsharewithCommunity.size()>0)
           new BRPValidation().ShareOppwithcommunity(lstsharewithCommunity);
    }
    if(trigger.isafter && trigger.isupdate)
    {
        map<Id,string> mpaccount=new map<Id,string>();
        for (Opportunity opp: Trigger.new)
        {
            
            if(trigger.oldmap.get(opp.Id).StageName !=trigger.newmap.get(opp.Id).StageName)
            { 
                
                if (trigger.newmap.get(opp.Id).StageName =='Quote Closed'|| trigger.newmap.get(opp.Id).StageName =='Cancelled')
                    mpaccount.put(opp.Id,opp.accountid + '~' + opp.Sales_Office__c);
                account acc=[select Stage__c, Appt_No_Show_Cancel_Reason__pc from account where id=:opp.accountId];
                string[] stagevalue=BRPValidation.rollupOppstages(opp.accountId).split('~');
                if (stagevalue.size()==1)
                {
                    acc.Stage__c=stagevalue[0];
                }
                else
                {
                   if(stagevalue[0]== 'Cancelled' || stagevalue[0]== 'Loss')
                   {
                       acc.Stage__c=stagevalue[0];
                       acc.Appt_No_Show_Cancel_Reason__pc=stagevalue[1];
                   }
                   
                }
                update acc;
            }
            
        }
        system.debug(mpaccount);
        BRPValidation brpval=new BRPValidation();
        if(mpaccount.size()>0)
        {
            for(Id oppId : mpaccount.keyset())
            {
               string splitstring=mpaccount.get(oppId);
               List<string>  arraccount=splitstring.split('~');
               //system.debug(new Cachedcollections().getCacheSalesofficeMapIds.get(arraccount[1]));
               string straccountId=arraccount[0];
               string nameval=BRPValidation.getsalesofficename(new Cachedcollections().getCacheSalesofficeMapIds.get(arraccount[1]));
               sobject saccount=database.query('select id, Community_list_' + nameval +'__pc, Community_history_' + nameval +'__pc from account where id=:straccountId');
               brpval.genericInterestcreation(saccount,'Delete',new Cachedcollections().getCachecommunityMapIds.get(trigger.newmap.get(oppId).Marketing_Community__c) , 'Community_list_' + nameval +'__pc', 'Community_history_' + nameval +'__pc');
           }
        }
    }
    else if ( trigger.isafter && trigger.isinsert)
    {
       list<opportunity> lstsharewithISR=new list<opportunity>();
       list<opportunity> lstsharewithCommunity=new list<opportunity>();
       for (Opportunity opp: Trigger.new)
       {
            //system.debug('hello');
           // string mktcomm=new Cachedcollections().getCachecommunityMapIds.get(opp.Marketing_Community__c);
           // Marketing_community__c mktcommobj=new Cachedcollections().getCachecommunityMapNames.get(mktcomm);
            if(opp.Lead_Channel__c=='Walk-in' || opp.Lead_Channel__c=='Phone Inquiry' || opp.Lead_Channel__c == 'MyTime Tour')
                lstsharewithCommunity.add(opp);
                 //new BRPValidation().ShareOppwithcommunity(opp.Id,mktcomm,mktcommobj);
            else
                 lstsharewithISR.add(opp);
                 //new BRPValidation().AssigntoISRgroup(opp.Id,mktcommobj.sales_office__r.Name);
       }
       if(lstsharewithCommunity.size()>0)
           new BRPValidation().ShareOppwithcommunity(lstsharewithCommunity);
       if(lstsharewithISR.size()>0)
           new BRPValidation().AssigntoISRgroup(lstsharewithISR);
       /* for (Opportunity opp: Trigger.new)
        {
        string nameval=BRPValidation.getsalesofficename(new Cachedcollections().mySalesOfficeIdMap.get(opp.Sales_Office__c));
        string accountid=opp.accountId;
        sobject s=Database.query('select Community_Picklist_'+ nameval +'__pc from account where id =: accountid' );
        s.put('Community_Picklist_'+ nameval +'__pc','');
        update s;
        }*/
    }
    else
    { 
        if(!OpportunityStageValidationTriggerHandler.isFirstExecution)
        {
            return;
        }
   
            for (Opportunity opp: Trigger.new) {

            Opportunity prevOpp = Trigger.oldMap.get(opp.Id);
            //configure stage transition object
            NewstarSalesPipelineStageTransition stageTransition=new NewstarSalesPipelineStageTransition();
            stageTransition.SourceStageName=prevOpp.StageName;
            stageTransition.TargetStageName=opp.StageName;
            stageTransition.IsAutomated=opp.IsAutomatedStageUpdate__c;
       
            //ask the pipeline service to validate the stage transition
            try{
                NewstarSalesPipelineService.ValidateStageTransition(stageTransition);
            }
            catch(NewstarSalesPipelineException e) {
                opp.addError('Error encountered validating stage transition: '+e.getMessage());
            }
      

            //check if the stage transition is valid
            if(!stageTransition.IsValid) {
                //if not, throw an error via the trigger
                opp.addError(stageTransition.ValidationMessage);
            }
            else{
               opp.IsAutomatedStageUpdate__c=false;
            }
        }

        OpportunityStageValidationTriggerHandler.isFirstExecution=false;
    }
    
     
}