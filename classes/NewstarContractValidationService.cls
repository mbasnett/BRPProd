public class NewstarContractValidationService {
    

    public static void validateOpportunityForMissingFields(Opportunity opp) {
        
        List<String> missingFields=new List<String>();

        List<String> missingCustomerFields=new List<String>();

        //validate opportunity data
        if(opp.Sales_Office__c==null){
            missingFields.add('Sales Office');
        }

        if(opp.Subdivision__c==null){
            missingFields.add('Project');
        }

        if(opp.Model__c==null){
            missingFields.add('Model');
        }

        if(opp.Lot__c==null){
            missingFields.add('Lot');
        }

        if(opp.Sales_Agent_Sales_Office_Relationship__c==null){
            missingFields.add('Sales Agent');
        }

        if(opp.Account.PersonMailingAddress==null) {
              missingFields.add('Customer address');
        }
        else {
            Address customerAddress=opp.Account.PersonMailingAddress;

            if(customerAddress.Street==null || customerAddress.Street=='') {
                 missingFields.add('Customer street address information');
            }

            if(customerAddress.City==null || customerAddress.City=='') {
                 missingFields.add('Customer city information');
            }

             if(customerAddress.PostalCode==null || customerAddress.PostalCode=='') {
                 missingFields.add('Customer ZIP/postal code information');
            }

            if(customerAddress.StateCode==null) {
                 missingFields.add('Customer state/province selection');
            }

            if(customerAddress.Country==null) {
                 missingFields.add('Customer country selection');
            }
        }

        if(missingFields.size()>0) {
            throw new NewstarContractValidationException(getValidationMessageForMissingFields(missingFields));
        }
    

    }


    public static void validateOpportunityForContractFlowConfiguration(Opportunity opp) {

        String configErrorMessage='Sales office associated with this opportunity record is not correctly configured for Supported Contract Flows.';

        if(opp.Sales_Office__r.Supported_Contract_Flows__c==null){
            throw new NewstarContractValidationException(configErrorMessage);
        }

        

    }


    public static void validateOpportunityForRealEstateAgent(Opportunity opp) {

        List<String> realEstateAgentIssues=new List<String>();

        if(opp.Real_Estate_Agent__c==null) return;

        Contact realEstateAgent=[
            SELECT 
                Id, 
                Name, 
                Newstar_ID__c,
                Account.Id,
                Account.Name,
                Account.Newstar_ID__c
            FROM 
                Contact 
            WHERE 
                Id =: opp.Real_Estate_Agent__c
            LIMIT 1
            ];

        if(realEstateAgent.Account.Newstar_ID__c==null) {
            realEstateAgentIssues.add(realEstateAgent.Account.Name + ' (Agency)');
        }

        if(realEstateAgent.Newstar_ID__c==null) {
            realEstateAgentIssues.add(realEstateAgent.Name + ' (Agent)');
        }

        if(realEstateAgentIssues.size()>0) {
            throw new NewstarContractValidationException(getValidationMessageForRealEstageAgentIssues(realEstateAgentIssues));
        }
        

    }


    private static String getValidationMessageForMissingFields(List<String> missingFields) {
        return 'The following fields should be populated prior to managing the contract in NEWSTAR: '
            + String.join(missingFields, ', ');
    }


      private static String getValidationMessageForRealEstageAgentIssues(List<String> realEstateAgentIssues) {
        return 'Please ensure that the following real estate agent entities associated with the opportunity have been sent to NEWSTAR: '+String.join(realEstateAgentIssues, ', ');
    }

}