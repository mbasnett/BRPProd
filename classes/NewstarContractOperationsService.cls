public with sharing class NewstarContractOperationsService {

    /*
        Attempts to direct offer the specified lot in NEWSTAR Sales via the NEWSTAR API and
        updates the Saleforce opportunity, person account and other objects with the direct offer information.
    */
    public static ContractResult performDirectOffer(Id opportunityId, Date targetClosingDate) {

        //setup the operation result object
        ContractResult result=new ContractResult();

        //setup the opp and customer junction objects
        Opportunity opp=null;
        Sales_Office_Customer__c customerSalesOfficeJunction=null;

        //get the opp
        opp=NewstarContractInformationService.getOpportunity(opportunityId);

        //get the junction object
        customerSalesOfficeJunction=NewstarContractInformationService.getCustomerSalesOfficeJunction(opp);

        //construct the cobuyer map associated with the deal
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap=NewstarContractUtilityService.createApiCobuyerMap(opp);

        //perfom the actual direct offer via the API
        NewstarDirectOffer apiDirectOffer=NewstarContractOperationsService.performDirectOfferInternal(
            opp, 
            customerSalesOfficeJunction,
            cobuyerMap,
            targetClosingDate);
        
        //update the opportunity with the NEWSTAR-side "selection ID" used as external ID in Salesforce
        opp.Newstar_ID__c=String.valueOf(apiDirectOffer.id);
        
        //update the customer account<->junction object with the ID of the customer record in NEWSTAR
        //received from the API
        customerSalesOfficeJunction.Newstar_ID__c=String.valueOf(apiDirectOffer.customer.id);
    
        //set the opportunity stage to PreContract
        opp.StageName=NewstarSalesPipelineStage.ContractReadyStage.Name;

        // opp.SelectionDate
        // opp.ClosingTargetDate
        // opp.ClosingType


        //update record type to be "Direct Contract"
        try {
            Id directOfferRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Direct_offer').getRecordTypeId();
            opp.RecordTypeId=directOfferRecordTypeId;
        }
        catch(Exception e){
            throw new NewstarContractOperationException('Error setting record type for direct offer opportunity type: '+ e.getMessage());
        }

        //IMPORTANT! Ensure the processing pipeline is aware that is NOT a manual stage change
        opp.IsAutomatedStageUpdate__c=true;
       
        //commit opp update, customer junction upsert
        SavePoint sp = Database.setSavePoint();

        try {
            
            //update the opportunity
            update opp;

            //upsert customer Person Account <-> Sales Office associations
            Database.upsert(customerSalesOfficeJunction);

            //update original cobuyer records (with NEWSTAR-side IDs)
            Database.update(cobuyerMap.values());
        }
        catch(Exception e){

            Database.rollback(sp);
            throw new NewstarContractOperationException('Error committing post-direct offer database updates: '+ e.getMessage()); 
        }

        
        //return the message
        result.Message='Contract initiated successfully.';

        return result;
    }


    /*
        Attempts to Undo Direct Offer the lot in NEWSTAR Sales for the specified opportunity
        and updates the opportunity pipeline to reflect the undo direct offer.
    */
    public static ContractResult performDirectOfferUndo(Id opportunityId) {
 
        ContractResult result=new ContractResult();

        //get the opp
        Opportunity opp=NewstarContractInformationService.getOpportunity(opportunityId);

        //attempt actual lot Direct Offer Undo
        NewstarOperationResult operationResult=performDirectOfferUndoInternal(opp);
      
        //set the opportunity stage back to the stage BEFORE Direct Offer
        //currently Quote
        opp.StageName=NewstarSalesPipelineStage.QuoteSelectionStage.Name;

        // opp.SelectionDate
        // opp.ClosingTargetDate
        // opp.ClosingType

        // Date today=system.today();
        //opp.Lot_Hold_Expiry_Date__c=today.addDays(holdPeriodInDays);
                
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
        result.Message='Direct Offer Undo successfully.';

        return result;
    }


    private static NewstarDirectOffer performDirectOfferInternal(
        Opportunity opp, 
        Sales_Office_Customer__c customerSalesOfficeJunction,
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap,
        Date targetClosingDate) {
        
        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for Direct Offer
        NewstarDirectOffer apiDirectOffer=new NewstarDirectOffer();

        //expicitly set the Direct Offer ID to zero to indicate a NEW Direct Offer
        apiDirectOffer.id=0;

        //construct the nested customer object
        apiDirectOffer.customer=NewstarContractUtilityService.createApiCustomer(opp.Account, customerSalesOfficeJunction);

        //if the cobuyer map is not, empty set API cobuyers
        if(!cobuyerMap.isEmpty()){
            apiDirectOffer.coBuyers=new List<NewstarCoBuyer>(cobuyerMap.keySet());
        }
        
        //set subdivision
        apiDirectOffer.subdivisionId=Integer.valueOf(opp.Subdivision__r.Newstar_ID__c);

        //set model
        apiDirectOffer.modelId=Integer.valueOf(opp.Model__r.Newstar_ID__c);

        //set lot
        apiDirectOffer.lotId=Integer.valueOf(opp.Lot__r.Newstar_ID__c);

        //TODO: set SelectionDate
        apiDirectOffer.selectionDate=system.today();

      
        //resolve the NEWSTAR ID of the sales agent assigned to the opportunity
        Sales_Agent__c assignedSalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c);
        apiDirectOffer.salesAgentId=Integer.valueOf(assignedSalesAgent.Newstar_ID__c);


        //resolve the NEWSTAR ID of the optional secondary sales agent assigned to the opportunity
        if(opp.Sales_Agent_Sales_Office_Relationship_2__c!=null) {
            Sales_Agent__c secondarySalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship_2__r.Sales_Agent__c);
            apiDirectOffer.secondarySalesAgentId=Integer.valueOf(secondarySalesAgent.Newstar_ID__c);
        }

        //resolve the real estate agent associated with the deal, if set
        if(opp.Real_Estate_Agent__c!=null) {
            apiDirectOffer.realEstateAgentId=Integer.valueOf(opp.Real_Estate_Agent__r.Newstar_ID__c);
        }


        //set the investment property flag
        apiDirectOffer.isInvestment=NewstarDataConversionHelper.getBoolWithNull(opp.Investment__c);

        //set the swing if it is available
        if(opp.Home_Swing__c!=null){
            apiDirectOffer.swing=getHomeSwingForApi(opp.Home_Swing__c);
        }

        //set the first visit date if it is available
        if(opp.Visit_Date__c!=null){
            apiDirectOffer.firstVisitDate=opp.Visit_Date__c;
        }

        //IMPORTANT: set the external ID of the lot reservation to ID of the Opportunity
        //IMPORTANT: prepend the ID of the current org to allow multi-org event pushing from NEWSTAR Sales
        apiDirectOffer.externalId=UserInfo.getOrganizationId()+'^'+opp.Id;
        
        //construct the API and set its params
        NewstarDirectOfferApi directOfferApi=new NewstarDirectOfferApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarDirectOffer', apiDirectOffer); 

        //execute the lot Direct Offer request to NEWSTAR
        apiDirectOffer=directOfferApi.post(apiParams);

        return apiDirectOffer;
        
    }    


    private static NewstarOperationResult performDirectOfferUndoInternal(Opportunity opp) {

       
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();

        NewstarDirectOfferApi directOfferApi=new NewstarDirectOfferApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('directOfferId', Integer.valueOf(opp.Newstar_ID__c)); 

        NewstarOperationResult operationResult=directOfferApi.callDelete(apiParams);
        return operationResult;

    }


    private static NewstarDirectOffer.SwingEnum getHomeSwingForApi(String homeSwingStringValue) {

        List<NewstarDirectOffer.SwingEnum> swingEnumValues=NewstarDirectOffer.SwingEnum.values();

        for(NewstarDirectOffer.SwingEnum swingEnumValue: swingEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(swingEnumValue.name())==homeSwingStringValue) {
                    return swingEnumValue;
                }
        }

        return null;
    }
   
    
}