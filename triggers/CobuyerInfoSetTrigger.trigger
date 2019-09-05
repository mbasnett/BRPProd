trigger CobuyerInfoSetTrigger on Cobuyer__c (before insert, before update) {

   //do nothing if this is not the first execution of this trigger in the transaction
    if(!CobuyerInfoSetTriggerHandler.isFirstExecution){
        return;
    }


    for(Cobuyer__c cb: Trigger.new){
        cb.Name=cb.First_Name__c+' '+cb.Last_Name__c;
    }
        
     CobuyerInfoSetTriggerHandler.isFirstExecution=false;    
}