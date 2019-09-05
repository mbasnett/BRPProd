public with sharing class NewstarCustomerSyncService {
  

    /*
        Attempts to send the specified customer data to NEWSTAR in order to update NEWSTAR Sales records matching
        the instances of the customer account in the specified NEWSTAR Sales offices (expressed as junction object IDs).

        @param customerAccountId ID of the customer account object to sync
        @param customerSalesOfficeJunctionIds List of junction object IDs belonging to the customer account that require syncing to NEWSTAR
    */
    public static CustomerInfoResult syncCustomerInfo(
        Id customerAccountId, 
        List<Id> customerSalesOfficeJunctionIds) {

        
        CustomerInfoResult result=new CustomerInfoResult();

        //setup a list of sales offfice junction object to update after NEWSTAR sync
        List<Sales_Office_Customer__c> customerSalesOfficeJunctionsToUpdate=new List<Sales_Office_Customer__c>();

        //get the customer's person account with a child list of all sales office junction objects
        Account customer=NewstarContractInformationService.getCustomerWithSalesOffices(customerAccountId);

        //iterate through the junction objects
        for(Sales_Office_Customer__c customerSalesOfficeJunction: customer.Sales_Office_Accounts__r) {

            //if the list of sales office junction IDs SELECTED for the operation does NOT contain the junction object,
            //skip the record
            if(!customerSalesOfficeJunctionIds.contains(customerSalesOfficeJunction.Id)) {
                continue;
            }

            //perform sync to NEWSTAR via the API
            NewstarCustomer apiCustomer=syncCustomerInfoInternal(customer, customerSalesOfficeJunction);

            //add the current junction objec to the list of junction objects to update post-sync
            customerSalesOfficeJunctionsToUpdate.add(customerSalesOfficeJunction);
        }


        //IMPORTANT: this operation is currently for customer update only
        //so NEWSTAR ID is NOT updated as a result of this operation
        try {
            Database.update(customerSalesOfficeJunctionsToUpdate);
        }
        catch(Exception ex){
            throw new NewstarCustomerException('Error commiting post-customer sync updates: '+ex.getMessage());
        }

        result.Message='Customer info synced successfully to NEWSTAR.';


        return result;

    }


    /*
        Attemps to sync the specified cobuyer record to NEWSTAR.
    */
    public static CobuyerInfoResult syncCobuyer(Id cobuyerId) {

        CobuyerInfoResult result=new CobuyerInfoResult();

        //get the cobuyer object
        Cobuyer__c cobuyer=NewstarContractInformationService.getCobuyer(cobuyerId);
       
        //perform sync to NEWSTAR via the API
        NewstarCobuyer apiCobuyer=syncCobuyerInternal(cobuyer);

        //set NEWSTAR-side ID
        cobuyer.Newstar_ID__c=String.valueOf(apiCobuyer.id);
       
        try {
            //update the cobuyer record
            update cobuyer;
        }
        catch(Exception ex){
            throw new NewstarCobuyerException('Error commiting post-cobuyer sync updates: '+ex.getMessage());
        }

        result.Message='Cobuyer info synced successfully to NEWSTAR.';

        return result;

    }




    private static NewstarCustomer syncCustomerInfoInternal(Account customerAccount, 
        Sales_Office_Customer__c customerSalesOfficeJunction) {

        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for customer
        NewstarCustomer apiCustomer=NewstarContractUtilityService.createApiCustomer(
            customerAccount, 
            customerSalesOfficeJunction);

        //construct and execute appropriate API request
        NewstarCustomerApi customerApi=new NewstarCustomerApi(newstarClient);

        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarCustomer', apiCustomer); 
        apiParams.put('salesAgentId', null);

        //update-only operation via a PUT request
        apiCustomer=customerApi.put(apiParams);
        
        return apiCustomer;
    }


    private static NewstarCoBuyer syncCobuyerInternal(Cobuyer__c cobuyer) {

        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for the cobuyer
        NewstarCoBuyer apiCobuyer=new NewstarCoBuyer();

        Boolean existsInNewstar=false;

        //if the cobuyer does not have a NEWSTAR ID, treat it as a new record in NEWSTAR terms
        if(cobuyer.Newstar_ID__c==null) {
            apiCobuyer.id=0;

          
        }
        else {
            apiCobuyer.id=Integer.valueOf(cobuyer.Newstar_ID__c);
            existsInNewstar=true;
        }
        
        apiCobuyer.firstName=cobuyer.First_Name__c;
        apiCobuyer.lastName=cobuyer.Last_Name__c;

        apiCobuyer.homeEmail=cobuyer.Home_Email__c;
        apiCobuyer.workEmail=cobuyer.Work_Email__c;
        
        apiCobuyer.homePhone=cobuyer.Home_Phone__c;
        apiCobuyer.workPhone=cobuyer.Work_Phone__c;
        apiCobuyer.mobilePhone=cobuyer.Mobile_Phone__c;
     
        //construct and execute appropriate API request
        NewstarCoBuyerApi coubuyerApi=new NewstarCoBuyerApi(newstarClient);

        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarCoBuyer', apiCobuyer); 


        if(existsInNewstar){
            apiCobuyer=coubuyerApi.put(apiParams);
        }
        else {

            //NEW cobuyers in NEWSTAR must be associated with the NEWSTAR-side lot reservation ID
            //represented in Salesforce by NEWSTAR ID of the opportunity previously sent to NEWSTAR
            apiParams.put('lotReservationId', Integer.valueOf(cobuyer.Opportunity__r.Newstar_ID__c));

            apiCobuyer=coubuyerApi.post(apiParams);
        }

        return apiCobuyer;
    }
}