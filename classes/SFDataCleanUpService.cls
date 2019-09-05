public with sharing class SFDataCleanUpService {


    public static List<SObject> getObjectsToDelete() {

      
        List<SObject> deleteList=new List<SObject>();


        // ========================= opp child entities first

        //cobuyers
        List<Cobuyer__c> cobuyerList=[SELECT Id, Name FROM Cobuyer__c];
        deleteList.addAll(cobuyerList);

        //contigencies
        List<Contigency__c> contigencyList=[SELECT Id, Name FROM Contigency__c];
        deleteList.addAll(contigencyList);


        //tasks
        List<Task> taskList=[SELECT Id FROM Task];
        deleteList.addAll(taskList);

        //events
        List<Event> eventList=[SELECT Id FROM Event];
        deleteList.addAll(eventList);


        
        //prospect notes (BeBack__c)
        List<BeBack__c> prospectNoteList=[SELECT Id, Name FROM BeBack__c];
        deleteList.addAll(prospectNoteList);

        //opportunities
        List<Opportunity> opportunityList= [SELECT Id, AccountId FROM Opportunity];
        deleteList.addAll(opportunityList);

        //real estate agents (as Contacts)
        List<Contact> agentContactList= [SELECT Id, Name FROM Contact WHERE IsPersonAccount=false];
        deleteList.addAll(agentContactList);


        //customer -> sales office associations
         List<Sales_Office_Customer__c> salesOfficeCustomerList= [SELECT Id, Name FROM Sales_Office_Customer__c];
        deleteList.addAll(salesOfficeCustomerList);
        

        //real estate agencies and customers (as Accounts)
        List<Account> accountList= [SELECT Id, Name FROM Account];
        deleteList.addAll(accountList);


         // ========================= master data

        //lots
        List<Lot__c> lotList= [SELECT Id, Name FROM Lot__c];
        deleteList.addAll(lotList);

        //models
        List<Model__c> modelList= [SELECT Id, Name FROM Model__c];
        deleteList.addAll(modelList);

        //subdivisions
        List<Subdivision__c> subdivisionList= [SELECT Id, Name FROM Subdivision__c];
        deleteList.addAll(subdivisionList);


        //sales agent sales office relationships
        List<SalesAgentSalesOfficeLink__c> salesAgentSalesOfficeRelList= [SELECT Id, Name FROM SalesAgentSalesOfficeLink__c];
        deleteList.addAll(salesAgentSalesOfficeRelList);


        //sales agents
        List<Sales_Agent__c> salesAgentList= [SELECT Id, Name FROM Sales_Agent__c];
        deleteList.addAll(salesAgentList);

        //sales offices
        List<Sales_Office__c> salesOfficeList= [SELECT Id, Name FROM Sales_Office__c];
        deleteList.addAll(salesOfficeList);


        //NEWSTAR states
        List<Newstar_State__c> stateList= [SELECT Id, Name FROM Newstar_State__c];
        deleteList.addAll(stateList);

        //NEWSTAR countries
        List<Newstar_Country__c> countryList= [SELECT Id, Name FROM Newstar_Country__c];
        deleteList.addAll(countryList);

        return deleteList;
      
    }


   
}