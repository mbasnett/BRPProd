public with sharing class NewstarLotReservationOperationsService {
    
     /*
        Attempts to reserve the specified lot in NEWSTAR Sales via the NEWSTAR API and
        updates the Saleforce opportunity, person account and other objects with the reservation information.
    */
    public static LotReservationResult performLotReservation(Id opportunityId, Integer holdPeriodInDays) {

        //setup the operation result object
        LotReservationResult result=new LotReservationResult();

        //setup the oppp and customer junction objects
        Opportunity opp=null;
        Sales_Office_Customer__c customerSalesOfficeJunction=null;

        //get the opp
        opp=NewstarContractInformationService.getOpportunity(opportunityId);

        //get the junction object
        customerSalesOfficeJunction=NewstarContractInformationService.getCustomerSalesOfficeJunction(opp);

        //construct the cobuyer map associated with the deal
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap=NewstarContractUtilityService.createApiCobuyerMap(opp);

        //perfom the actual reservation via the API
        NewstarLotReservation apiLotReservation=performLotReservationInternal(
            opp, 
            holdPeriodInDays, 
            customerSalesOfficeJunction,
            cobuyerMap);
        
        //update the opportunity with the NEWSTAR-side "selection ID" used as external ID in Salesforce
        opp.Newstar_ID__c=String.valueOf(apiLotReservation.id);
        
        //update the customer account<->junction object with the ID of the customer record in NEWSTAR
        //received from the API
        customerSalesOfficeJunction.Newstar_ID__c=String.valueOf(apiLotReservation.customer.id);
    
        //set the opportunity stage to Lot Reservation
        opp.StageName=NewstarSalesPipelineStage.LotReservationStage.Name;

        //automatically calculate the expiration date based on the hold period
        Date today=system.today();
        opp.Lot_Hold_Expiry_Date__c=today.addDays(holdPeriodInDays);

        //update record type to be "Lot Reservation"
        try {
            Id lotReservationRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Lot_reservation').getRecordTypeId();
            opp.RecordTypeId=lotReservationRecordTypeId;
        }
        catch(Exception e){
            throw new NewstarContractOperationException('Error setting record type for lot reservation opportunity type: '+ e.getMessage());
        }

        //post-process cobuyers to update their NEWSTAR IDs
        NewstarContractUtilityService.processCobuyerNewstarMappings(cobuyerMap, apiLotReservation.coBuyers);

        //IMPORTANT! Ensure the processing pipeline is aware that is NOT a manual stage change
        opp.IsAutomatedStageUpdate__c=true;
       
        //commit opp update, customer junction upsert
        SavePoint sp = Database.setSavePoint();

        try {
            //update opportunity
             update opp;

             //upsert customer Person Account <-> Sales Office associations
             Database.upsert(customerSalesOfficeJunction);

             //update original cobuyer records (with NEWSTAR-side IDs)
             Database.update(cobuyerMap.values());
        }
        catch(Exception e){

            Database.rollback(sp);
            throw new NewstarContractOperationException('Error committing post-resevation database updates: '+ e.getMessage()); 
        }

        
        //return the message
        result.Message='Lot reserved successfully.';

        return result;
    }


    /*
        Attempts to unreserve the lot in NEWSTAR Sales for the specified opportunity
        and updates the opportunity pipeline to reflect the unreservation.
    */
    public static LotReservationResult performLotUnreservation(Id opportunityId) {
 
        LotReservationResult result=new LotReservationResult();

        //get the opp
        Opportunity opp=NewstarContractInformationService.getOpportunity(opportunityId);

        //attempt actual lot UNreservation
        NewstarOperationResult operationResult=performLotUnreservationInternal(opp);
      
        //set the opportunity stage back to the stage BEFORE Lot Reservation
        //currently engagement
        opp.StageName=NewstarSalesPipelineStage.EngagementStage.Name;

        //reset the hold expiry date
        opp.Lot_Hold_Expiry_Date__c=null;

        //reset the NEWSTAR ID to disconnect this opportunity from the selection record
        opp.Newstar_ID__c=null;

        //TODO: MUST disconnect cobuyers and contigencies?
        
        //IMPORTANT! Ensure the processing pipeline is aware that is NOT a manual stage change
        opp.IsAutomatedStageUpdate__c=true;
        
        //commit opp updates
        try {
            update opp;
        }
         catch(Exception e){
             throw new NewstarContractOperationException('Error updating opportunity record: '+ e.getMessage()); 
        }
      
        
        //return the message
        result.Message='Lot unreserved successfully.';

        return result;
    }

  
    private static NewstarLotReservation performLotReservationInternal(Opportunity opp, 
        Integer holdPeriodInDays, 
        Sales_Office_Customer__c customerSalesOfficeJunction,
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap
        ) {
        
        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for lot reservation
        NewstarLotReservation apiLotReservation=new NewstarLotReservation();

        //expicitly set the reservation ID to zero to indicate a NEW reservation
        apiLotReservation.id=0;

        //construct the nested customer object
        apiLotReservation.customer=NewstarContractUtilityService.createApiCustomer(opp.Account, customerSalesOfficeJunction);

        //if the cobuyer map is not, empty set API cobuyers
        if(!cobuyerMap.isEmpty()){
            apiLotReservation.coBuyers=new List<NewstarCoBuyer>(cobuyerMap.keySet());
        }
      
        
        //set subdivision
        apiLotReservation.subdivisionId=Integer.valueOf(opp.Subdivision__r.Newstar_ID__c);

        //set model
        apiLotReservation.modelId=Integer.valueOf(opp.Model__r.Newstar_ID__c);

        //set lot
        apiLotReservation.lotId=Integer.valueOf(opp.Lot__r.Newstar_ID__c);

        //set hold period
        apiLotReservation.holdPeriodInDays=holdPeriodInDays;

        //resolve the NEWSTAR ID of the sales agent assigned to the opportunity
        Sales_Agent__c assignedSalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c);
        apiLotReservation.salesAgentId=Integer.valueOf(assignedSalesAgent.Newstar_ID__c);

        //resolve the NEWSTAR ID of the optional secondary sales agent assigned to the opportunity
        if(opp.Sales_Agent_Sales_Office_Relationship_2__c!=null) {
            Sales_Agent__c secondarySalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship_2__r.Sales_Agent__c);
            apiLotReservation.secondarySalesAgentId=Integer.valueOf(secondarySalesAgent.Newstar_ID__c);
        }

        //resolve the real estate agent associated with the deal, if set
        if(opp.Real_Estate_Agent__c!=null) {
            apiLotReservation.realEstateAgentId=Integer.valueOf(opp.Real_Estate_Agent__r.Newstar_ID__c);
        }

        //set the investment property flag
        apiLotReservation.isInvestment=NewstarDataConversionHelper.getBoolWithNull(opp.Investment__c);

        //set the swing if it is available
        if(opp.Home_Swing__c!=null){
            apiLotReservation.swing=getHomeSwingForApi(opp.Home_Swing__c);
        }

        //set the first visit date if it is available
        if(opp.Visit_Date__c!=null){
            apiLotReservation.firstVisitDate=opp.Visit_Date__c;
        }

        //IMPORTANT: set the external ID of the lot reservation to ID of the Opportunity
        //IMPORTANT: prepend the ID of the current org to allow multi-org event pushing from NEWSTAR Sales
        apiLotReservation.externalId=UserInfo.getOrganizationId()+'^'+opp.Id;

        //construct the API and set its params
        NewstarLotReservationApi lotReservationApi=new NewstarLotReservationApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarLotReservation', apiLotReservation); 

        //execute the lot reservation request to NEWSTAR
        apiLotReservation=lotReservationApi.post(apiParams);

        return apiLotReservation;
        
    }    


    private static NewstarOperationResult performLotUnreservationInternal(Opportunity opp) {

       
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();

        NewstarLotReservationApi lotReservationApi=new NewstarLotReservationApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('lotReservationId', Integer.valueOf(opp.Newstar_ID__c)); 

        NewstarOperationResult operationResult=lotReservationApi.callDelete(apiParams);
        return operationResult;

    }

  
    private static NewstarLotReservation.SwingEnum getHomeSwingForApi(String homeSwingStringValue) {

        List<NewstarLotReservation.SwingEnum> swingEnumValues=NewstarLotReservation.SwingEnum.values();

        for(NewstarLotReservation.SwingEnum swingEnumValue: swingEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(swingEnumValue.name())==homeSwingStringValue) {
                    return swingEnumValue;
                }
        }

        return null;
    }

}