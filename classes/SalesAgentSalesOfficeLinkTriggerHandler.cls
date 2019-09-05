public class SalesAgentSalesOfficeLinkTriggerHandler {

    private static List<Sales_Agent__c> affectedSalesAgents;
    private static List<Sales_Office__c> affectedSalesOffices;


    public static void processChanges(List<SalesAgentSalesOfficeLink__c> affectedObjects){

        populateAffectedRelationshipObjects(affectedObjects);

        //iterate through inserted/modified records
        for(SalesAgentSalesOfficeLink__c link: affectedObjects) {

            //get the actual sales agent associated with the current junction record
            Sales_Agent__c salesAgent=getSalesAgent(link.Sales_Agent__c);
            if(salesAgent==null){
                link.addError('Unable to locate linked sales agent object.');
                return;
            }


            Sales_Office__c salesOffice=getSalesOffice(link.Sales_Office__c);
            if(salesOffice==null) {
                link.addError('Unable to locate linked sales office object.');
            }

            //set the junction name to that of the sales agent
            link.Name=salesAgent.First_Name__c+' '+salesAgent.Last_Name__c;

     
        } 
  
     
    }


    private static void populateAffectedRelationshipObjects(List<SalesAgentSalesOfficeLink__c> affectedObjects) {

          List<Id> affectedSalesAgentIds=new List<Id>();

            List<Id> affectedSalesOfficeIds=new List<Id>();

            for(SalesAgentSalesOfficeLink__c link: affectedObjects) {

                if(!affectedSalesAgentIds.contains(link.Sales_Agent__c)){
                    affectedSalesAgentIds.add(link.Sales_Agent__c);
                }

                if(!affectedSalesOfficeIds.contains(link.Sales_Office__c)) {
                    affectedSalesOfficeIds.add(link.Sales_Office__c);
                }

            }

            affectedSalesAgents=
            [
                SELECT 
                    Id, Name, First_Name__c, Last_Name__c 
                FROM 
                    Sales_Agent__c  
                WHERE 
                    Id IN : affectedSalesAgentIds 
            ];

            affectedSalesOffices=
            [
                SELECT 
                    Id, Name
                FROM
                    Sales_Office__c
                WHERE
                    Id IN : affectedSalesOfficeIds
            ];

    }


    private static Sales_Agent__c getSalesAgent(Id id) {

        if(affectedSalesAgents==null) return null;

        for(Sales_Agent__c salesAgent: affectedSalesAgents) {
            if(salesAgent.Id==id){
                return salesAgent;
            }
        }

        return null;
    }


    private static Sales_Office__c getSalesOffice(Id id){

        if(affectedSalesOffices==null) return null;

        for(Sales_Office__c salesOffice: affectedSalesOffices) {
            if(salesOffice.Id==id) {
                return salesOffice;
            }
        }

        return null;
    }

}