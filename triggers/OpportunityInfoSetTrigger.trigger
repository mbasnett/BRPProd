trigger OpportunityInfoSetTrigger on Opportunity (before insert, before update) {


    //build a map of opp ID => parent customer account ID for all opportunities affected by trigger scope
    Map<Id, Id> oppIdToAccountIdMap=new Map<Id,Id>();

    for(Opportunity opp: Trigger.new){ 
        oppIdToAccountIdMap.put(opp.Id, opp.AccountId);
    }

    //build a map of account ID => account object
    Map<Id, Account> accountIdToAccountMap=new Map<Id, Account>();

    //...for all customer accounts referenced by all opportunities in the trigger scope
    List<Account> oppCustomerAccounts=[SELECT Id, Name FROM Account WHERE Id IN : oppIdToAccountIdMap.values()];

    for(Account acc: oppCustomerAccounts) {
        accountIdToAccountMap.put(acc.Id, acc);
    }

    //build a map of opportunity ID => account object
    Map<Id, Account> oppIdToAccountMap=new Map<Id, Account>();

    for(Id oppId: oppIdToAccountIdMap.keySet()) {
        oppIdToAccountMap.put(oppId, accountIdToAccountMap.get(oppIdToAccountIdMap.get(oppId)));
    }


    for(Opportunity opp: Trigger.new){

        Opportunity prevOpp = null;
        
        if(!Trigger.isInsert) {
            prevOpp=Trigger.oldMap.get(opp.Id);
        }
         
         //get deal context
        NewstarDealContext dealContext=NewstarOpporunityInfoService.getDealContext(opp, oppIdToAccountMap);
     
      //set the opportunity name using marketing community
        NewstarOpporunityInfoService.setOpportunityNameAtMarketingCommunityLevel(opp, dealContext);

        //if this lead is  just being created from a lead conversion...
        if(opp.Converted_From_Lead__c && Trigger.isInsert)
        {

            //initialize the marketing community's default sales process
            NewstarOpporunityInfoService.setOpportunitySalesProcess(opp, dealContext);

            //skip further processing
            continue;
        }


        //set the opportunity's name using subdivision-level information, if available
        NewstarOpporunityInfoService.setOpportunityNameAtSubdivisionLevel(opp, dealContext);

        //if the opportunity is still in pure marketing stage on the pre-handoff stage
        //update name and financials
        String stageToCheck=opp.StageName;
        if(stageToCheck==null && prevOpp!=null) {
            stageToCheck=prevOpp.StageName;
        }

        if(
            NewstarSalesPipelineService.IsPureMarketingStage(stageToCheck)
            || NewstarSalesPipelineService.IsPreNewstarHandoffStage(stageToCheck)
            ){

            //set opportunity's ESTIMATED financial details based on model/lot selections
            NewstarOpporunityInfoService.setOpportunityAmountsFromDealContext(opp, dealContext);
        }

        
    }

   
}