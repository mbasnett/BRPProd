/*
Trigger sets the junction object SalesAgentSalesOfficeLink's agent name to the correct
actual sales agent first/last name combination to make it properly searchable and presentable.
*/
trigger SalesAgentSalesOfficeLinkTrigger on SalesAgentSalesOfficeLink__c (before insert, before update) {

  
    SalesAgentSalesOfficeLinkTriggerHandler.processChanges(Trigger.new);

}