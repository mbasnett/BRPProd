public class NewstarRealEstateAgentSyncService {
    

    /*
        Attempts to send the specified real estate agency data to NEWSTAR to either create a new agency record or update an existing one.
    */
    public static RealEstateAgencyResult syncAgency(Id agencyAccountId) {

        RealEstateAgencyResult result=new RealEstateAgencyResult();

        Account realEstateAgency=getRealEstateAgency(agencyAccountId);

        NewstarRealEstateAgency apiRealEstateAgency=syncAgencyInternal(realEstateAgency);

        realEstateAgency.Newstar_ID__c=String.valueOf(apiRealEstateAgency.id);

        try {
            update realEstateAgency;
        }
        catch(Exception ex){
            throw new NewstarRealEstateAgencyException('Error commiting post-real estate agency sync updates: '+ex.getMessage());
        }

        result.Message='Real estate agency synced successfully to NEWSTAR.';


        return result;

    }


    /*
        Attempts to send the specified real estate agent data to NEWSTAR to either create a new agency record or update an existing one.
    */
    public static RealEstateAgentResult syncAgent(Id agentContactId) {

        RealEstateAgentResult result=new RealEstateAgentResult();

        Contact realEstateAgent=getRealEstateAgent(agentContactId);

        NewstarRealEstateAgent apiRealEstateAgent=syncAgentInternal(realEstateAgent);

        realEstateAgent.Newstar_ID__c=String.valueOf(apiRealEstateAgent.id);

        try {
            update realEstateAgent;
        }
        catch(Exception ex){
            throw new NewstarRealEstateAgentException('Error commiting post-real estate agent sync updates: '+ex.getMessage());
        }

        result.Message='Real estate agent synced successfully to NEWSTAR.';


        return result;

    }


    private static NewstarRealEstateAgency syncAgencyInternal(Account realEstateAgency) {

        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for real estate agency
        NewstarRealEstateAgency apiRealEstateAgency=new NewstarRealEstateAgency();

        Boolean existsInNewstar=false;

        //if the agency does not have a NEWSTAR ID, treat it as a new record in NEWSTAR terms
        if(realEstateAgency.Newstar_ID__c==null) {
                apiRealEstateAgency.id=0;
        }
        else {
            apiRealEstateAgency.id=Integer.valueOf(realEstateAgency.Newstar_ID__c);
            existsInNewstar=true;
        }
        
        apiRealEstateAgency.name=realEstateAgency.Name;

        Address address=realEstateAgency.BillingAddress;

        if(address!=null){

            apiRealEstateAgency.streetAddress=address.street;
            apiRealEstateAgency.city=address.city;
            apiRealEstateAgency.zipPostalCode=address.postalcode;

            //attempt to resolve the agency's state/province ID in NEWSTAR as per NEWSTAR configuration
            Newstar_State__c state=NewstarContractInformationService.getNewstarStateAndCountry(address);
            if(state==null) {
                throw new NewstarContractOperationException('Real estate agency address information cannot be resolved for a NEWSTAR Sales-defined list of states and countries.');
            }
    
            apiRealEstateAgency.stateProvinceId=Integer.valueOf(state.Newstar_ID__c);
        }

        apiRealEstateAgency.phoneNumber=realEstateAgency.Phone;
      

        //construct and execute appropriate API request
        NewstarRealEstateAgencyApi realEstateAgencyApi=new NewstarRealEstateAgencyApi(newstarClient);

        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarRealEstateAgency', apiRealEstateAgency); 

        if(existsInNewstar){
            apiRealEstateAgency=realEstateAgencyApi.put(apiParams);
        }
        else {
            apiRealEstateAgency=realEstateAgencyApi.post(apiParams);
        }

        return apiRealEstateAgency;
    }


    private static NewstarRealEstateAgent syncAgentInternal(Contact realEstateAgent) {

        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for real estate agency
        NewstarRealEstateAgent apiRealEstateAgent=new NewstarRealEstateAgent();

        Boolean existsInNewstar=false;

        //if the agent does not have a NEWSTAR ID, treat it as a new record in NEWSTAR terms
        if(realEstateAgent.Newstar_ID__c==null) {
                apiRealEstateAgent.id=0;
        }
        else {
            apiRealEstateAgent.id=Integer.valueOf(realEstateAgent.Newstar_ID__c);
            existsInNewstar=true;
        }
        
        apiRealEstateAgent.firstName=realEstateAgent.FirstName;
        apiRealEstateAgent.lastName=realEstateAgent.LastName;
        apiRealEstateAgent.agencyId=Integer.valueOf(realEstateAgent.Account.Newstar_ID__c);

        Address address=realEstateAgent.MailingAddress;

        if(address!=null){

            apiRealEstateAgent.streetAddress=address.street;
            apiRealEstateAgent.city=address.city;
            apiRealEstateAgent.zipPostalCode=address.postalcode;

            //attempt to resolve the agent's state/province ID in NEWSTAR as per NEWSTAR configuration
            Newstar_State__c state=NewstarContractInformationService.getNewstarStateAndCountry(address);
            if(state==null) {
                throw new NewstarContractOperationException('Real estate agent address information cannot be resolved for a NEWSTAR Sales-defined list of states and countries.');
            }
    
            apiRealEstateAgent.stateProvinceId=Integer.valueOf(state.Newstar_ID__c);
        }

        apiRealEstateAgent.phoneNumber=realEstateAgent.Phone;
        apiRealEstateAgent.mobileNumber=realEstateAgent.MobilePhone;
        apiRealEstateAgent.email=realEstateAgent.Email;

        
        //construct and execute appropriate API request
        NewstarRealEstateAgentApi realEstateAgentApi=new NewstarRealEstateAgentApi(newstarClient);

        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarRealEstateAgent', apiRealEstateAgent); 

        if(existsInNewstar){
            apiRealEstateAgent=realEstateAgentApi.put(apiParams);
        }
        else {
            apiRealEstateAgent=realEstateAgentApi.post(apiParams);
        }

        return apiRealEstateAgent;
    }



    private static Account getRealEstateAgency(Id agencyAccountId){

        List<Account> agencies=[SELECT Id, Name, BillingAddress, Phone, Newstar_ID__c FROM Account WHERE Id =: agencyAccountId];
        if(agencies.size()!=1){
            return null;
        }

        return agencies[0];

    }


    private static Contact getRealEstateAgent(Id agentContactId){

        List<Contact> agents=[SELECT 
            Id, Name, 
            FirstName, LastName, Newstar_ID__c, 
            MailingAddress,
            Phone,
            MobilePhone,
            Email,
            Account.Newstar_ID__c
            FROM Contact 
            WHERE Id =: agentContactId];

        if(agents.size()!=1){
            return null;
        }

        return agents[0];

    }


}