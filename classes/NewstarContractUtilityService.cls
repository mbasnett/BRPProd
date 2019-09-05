public with sharing class NewstarContractUtilityService {
    

      /*
        Constructs a map of API cobuyer<->Salesforce cobuyer objects to be used in contract-related operations.
    */
    public static Map<NewstarCoBuyer, Cobuyer__c> createApiCobuyerMap(Opportunity opp) {

        Map<NewstarCoBuyer, Cobuyer__c> cobuyerMap=new Map<NewstarCoBuyer, Cobuyer__c>();

        //obtain the list of co-buyer records associated with this deal
        List<Cobuyer__c> cobuyers=[
            SELECT
                Id,
                Name,
                First_Name__c,
                Last_Name__c,
                Home_Email__c,
                Work_Email__c,
                Home_Phone__c,
                Work_Phone__c,
                Mobile_Phone__c,
                Newstar_ID__c
            FROM
                Cobuyer__c
            WHERE
                Opportunity__c =: opp.Id
        ];

        if(cobuyers.size()==0) {
            return cobuyerMap;
        }

        for (Cobuyer__c cobuyer : cobuyers) {
            
            NewstarCoBuyer apiCobuyer=new NewstarCoBuyer();

            apiCobuyer.id=0; //mark co-buyer as new
            
            apiCobuyer.firstName=cobuyer.First_Name__c;
            apiCobuyer.lastName=cobuyer.Last_Name__c;
            
            apiCobuyer.homeEmail=cobuyer.Home_Email__c;
            apiCobuyer.workEmail=cobuyer.Work_Email__c;
            
            apiCobuyer.homePhone=cobuyer.Home_Phone__c;
            apiCobuyer.workPhone=cobuyer.Work_Phone__c;
            apiCobuyer.mobilePhone=cobuyer.Mobile_Phone__c;

            apiCobuyer.externalId=cobuyer.Id;
            
            cobuyerMap.put(apiCobuyer, cobuyer);
        }

        return cobuyerMap;
        
    }


    public static NewstarCustomer createApiCustomer(
        Account customerAccount,
        Sales_Office_Customer__c customerSalesOfficeJunction) {

        NewstarCustomer apiCustomer=new NewstarCustomer();

        //if the junction object for this sales office does not yet have a NEWSTAR ID
        //then mark the API object for the customer as "explicitly new" (0)
        if(customerSalesOfficeJunction.Newstar_ID__c==null) {
            apiCustomer.id=0;
        }
        else {
            //otherwise set it to the NEWSTAR ID on record in order to update
            //the existing customer
            apiCustomer.id=Integer.valueOf(customerSalesOfficeJunction.Newstar_ID__c);
        }
        
        //set customer names
        apiCustomer.firstName=customerAccount.FirstName;
        apiCustomer.lastName=customerAccount.LastName;

        //get the mailing address and set its parts
        Address apiCustomerAddress=customerAccount.PersonMailingAddress;

        //street part of the address
        apiCustomer.streetAddress1=apiCustomerAddress.Street;

        //city part of the addresss
        apiCustomer.city=apiCustomerAddress.City;

        //ZIP/postal code
        apiCustomer.zipPostalCode=apiCustomerAddress.PostalCode;
    
        //attempt to resolve the customer's state/province ID in NEWSTAR as per NEWSTAR configuration
        Newstar_State__c state=NewstarContractInformationService.getNewstarStateAndCountry(customerAccount.PersonMailingAddress);
        if(state==null) {
            throw new NewstarContractOperationException('Customer record mailing address information cannot be resolved for a NEWSTAR Sales-defined list of states and countries.');
        }
  
        apiCustomer.stateProvinceId=Integer.valueOf(state.Newstar_ID__c);

        //customer email
        apiCustomer.homeEmail=customerAccount.PersonEmail;

        //phone numbers
        
        //NOTE: base phone field from Account is interpreted as a BUSINESS (work) phone number
        apiCustomer.workPhone=customerAccount.Phone;

        apiCustomer.mobilePhone=customerAccount.PersonMobilePhone;
        apiCustomer.homePhone=customerAccount.PersonHomePhone;


        //IMPORTANT: set external ID of the customer to that of the customer account
        apiCustomer.externalId=customerAccount.Id;
        

        return apiCustomer;
        }
        

    public static void processCobuyerNewstarMappings(
        Map<NewstarCoBuyer,Cobuyer__c> preOperationCobyerMap,
        List<NewstarCoBuyer> postOperationApiCobuyerList) {

        if(postOperationApiCobuyerList!=null && postOperationApiCobuyerList.size()>0) {

            for (NewstarCobuyer postOperationApiCobuyer : postOperationApiCobuyerList) {
                
                NewstarCoBuyer preOperationApiCobuyer=getApiCobuyerFromMap(preOperationCobyerMap, postOperationApiCobuyer.externalId);
                if(preOperationApiCobuyer==null) {
                    throw new NewstarContractOperationException('Unable to remap cobuyer information for Salesforce cobuyer record with ID: '+postOperationApiCobuyer.externalId);
                }

                Cobuyer__c cobuyer=preOperationCobyerMap.get(preOperationApiCobuyer);

                //record the NEWSTAR ID of the cobuyer returned by the API
                cobuyer.Newstar_ID__c=String.valueOf(postOperationApiCobuyer.id);
            }

        }

    }


    public static NewstarCoBuyer getApiCobuyerFromMap(Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap, String lookupCobuyerExternalId) {

        for (NewstarCoBuyer cobuyer: cobuyerMap.keySet()) {
            if(cobuyer.externalId==lookupCobuyerExternalId)
            {
                return cobuyer;
            }
        }

        return null;
    }


   

}