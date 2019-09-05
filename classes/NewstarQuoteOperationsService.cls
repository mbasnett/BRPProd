public with sharing class NewstarQuoteOperationsService {
   

    /*
        Attempts to create a quote for the specified opportunity in NEWSTAR Sales via the NEWSTAR API and
        updates the Saleforce opportunity, person account and other objects with the quote information.
    */
    public static QuoteResult performQuote(Id opportunityId) {

        //setup the operation result object
        QuoteResult result=new QuoteResult();

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
        NewstarQuote apiQuote=performQuoteInternal(opp, customerSalesOfficeJunction, cobuyerMap);
          
        //update the opportunity with the NEWSTAR-side "selection ID" used as external ID in Salesforce
        opp.Newstar_ID__c=String.valueOf(apiQuote.id);
        
        //update the customer account<->junction object with the ID of the customer record in NEWSTAR
        //received from the API
        customerSalesOfficeJunction.Newstar_ID__c=String.valueOf(apiQuote.customer.id);
    
        //set the opportunity stage to Lot Reservation
        opp.StageName=NewstarSalesPipelineStage.QuoteSelectionStage.Name;
     
        //post-process cobuyers to update their NEWSTAR IDs
        NewstarContractUtilityService.processCobuyerNewstarMappings(cobuyerMap, apiQuote.coBuyers);

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
            throw new NewstarContractOperationException('Error committing post-quote creation database updates: '+ e.getMessage()); 
        }

        
        //return the message
        result.Message='Quote created successfully.';

        return result;
    }



    /*
        Attempts to convert an existing quote to a lot reservation in NEWSTAR Sales via the NEWSTAR API and
        updates the Saleforce opportunity other objects with the lot reservation information.
    */
    public static LotReservationResult performQuoteToLotReservationConversion(Id opportunityId, 
        Integer holdPeriodInDays) {

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

        //perfom the actual conversion of the quote to the reservation via the API
        NewstarQuoteToLotReservation apiQuoteToLotReservation=performQuoteToLotReservationConversionInternal(opp, holdPeriodInDays, customerSalesOfficeJunction, cobuyerMap);
       
        //IMPORTANT: lot reservation NEWSTAR ID and customer sales office junction NEWSTAR ID do not need to be 
        //set in this case as they both already exist from quote process

        //set the opportunity stage to Lot Reservation
        opp.StageName=NewstarSalesPipelineStage.LotReservationStage.Name;


        //update record type to be "Lot Reservation"
        try {
            Id lotReservationRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Lot_reservation').getRecordTypeId();
            opp.RecordTypeId=lotReservationRecordTypeId;
        }
        catch(Exception e){
            throw new NewstarContractOperationException('Error setting record type for lot reservation opportunity type: '+ e.getMessage());
        }
     
        //post-process cobuyers to update their NEWSTAR IDs
        //IMPORTANT: cobuyers submitted with the conversion request may be a mixture of existing and new cobuyers
        NewstarContractUtilityService.processCobuyerNewstarMappings(cobuyerMap, apiQuoteToLotReservation.coBuyers);

        //IMPORTANT! Ensure the processing pipeline is aware that is NOT a manual stage change
        opp.IsAutomatedStageUpdate__c=true;


        //commit opp update and other objects
        SavePoint sp = Database.setSavePoint();

        try {
            //update the opportunity
            update opp;

            //update original cobuyer records (with NEWSTAR-side IDs)
            Database.update(cobuyerMap.values());

        }
        catch(Exception e){

            Database.rollback(sp);
            throw new NewstarContractOperationException('Error committing post-quote to lot reservation conversion database updates: '+ e.getMessage()); 
        }

        
        //return the message
        result.Message='Lot reserved successfully.';

        return result;
    }



    /*
        Attempts to convert an existing quote to a direct offer in NEWSTAR Sales via the NEWSTAR API and
        updates the Saleforce opportunity and other objects with the direct offer information.
    */
    public static ContractResult performQuoteToDirectOfferConversion(Id opportunityId) {

        //setup the operation result object
        ContractResult result=new ContractResult();

        //setup the oppp and customer junction objects
        Opportunity opp=null;
        Sales_Office_Customer__c customerSalesOfficeJunction=null;

        //get the opp
        opp=NewstarContractInformationService.getOpportunity(opportunityId);

        //get the junction object
        customerSalesOfficeJunction=NewstarContractInformationService.getCustomerSalesOfficeJunction(opp);

        //construct the cobuyer map associated with the deal
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap=NewstarContractUtilityService.createApiCobuyerMap(opp);

        //perfom the actual conversion of the quote to a direct offer via the API
        NewstarQuoteToDirectOffer apiQuoteToDirectOffer=performQuoteToDirectOfferConversionInternal(opp, customerSalesOfficeJunction, cobuyerMap);
       
        //IMPORTANT: direct offer NEWSTAR ID and customer sales office junction NEWSTAR ID do not need to be 
        //set in this case as they both already exist from quote process

        //set the opportunity stage to Contract Ready
        opp.StageName=NewstarSalesPipelineStage.ContractReadyStage.Name;


        //update record type to be "Direct Offer"
        try {
            Id directOfferRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Direct_offer').getRecordTypeId();
            opp.RecordTypeId=directOfferRecordTypeId;
        }
        catch(Exception e){
            throw new NewstarContractOperationException('Error setting record type for direct offer opportunity type: '+ e.getMessage());
        }
     
        //post-process cobuyers to update their NEWSTAR IDs
        //IMPORTANT: cobuyers submitted with the conversion request may be a mixture of existing and new cobuyers
        NewstarContractUtilityService.processCobuyerNewstarMappings(cobuyerMap, apiQuoteToDirectOffer.coBuyers);

        //IMPORTANT! Ensure the processing pipeline is aware that is NOT a manual stage change
        opp.IsAutomatedStageUpdate__c=true;

        //commit opp update and other operations
        SavePoint sp = Database.setSavePoint();

        try {
            //update the opportunity
            update opp;

            //update original cobuyer records (with NEWSTAR-side IDs)
            Database.update(cobuyerMap.values());

        }
        catch(Exception e){

            Database.rollback(sp);
            throw new NewstarContractOperationException('Error committing post-quote to direct offer conversion database updates: '+ e.getMessage()); 
        }

        
        //return the message
        result.Message='Contract initiated successfully.';

        return result;
    }




    /*
       Explicitly closes a rejected (unaccepted quote).
    */
    public static QuoteResult performRejectedQuoteClose(Id opportunityId) {

        //setup the operation result object
        QuoteResult result=new QuoteResult();

        //setup the oppp and customer junction objects
        Opportunity opp=null;
        Sales_Office_Customer__c customerSalesOfficeJunction=null;

        //get the opp
        opp=NewstarContractInformationService.getOpportunity(opportunityId);

        //get the junction object
        customerSalesOfficeJunction=NewstarContractInformationService.getCustomerSalesOfficeJunction(opp);

        //IMPORTANT: currently, rejected quote closing does NOT update anything in NEWSTAR
        //the existing selection record representing the quote in NEWSTAR continues to exist
 
        //NewstarQuoteToLotReservation apiQuoteToLotReservation=performQuoteToLotReservationConversionInternal(opp, holdPeriodInDays, customerSalesOfficeJunction, cobuyerMap);
        
        //set the opportunity stage to Quote Closed
        opp.StageName=NewstarSalesPipelineStage.QuoteClosedStage.Name;
     
        //IMPORTANT! Ensure the processing pipeline is aware that is NOT a manual stage change
        opp.IsAutomatedStageUpdate__c=true;
       
        //commit opp update, customer junction upsert
        SavePoint sp = Database.setSavePoint();

        try {
            //update the opportunity
             update opp;
        }
        catch(Exception e){

            Database.rollback(sp);
            throw new NewstarContractOperationException('Error committing post-quote closing database updates: '+ e.getMessage()); 
        }

        
        //return the message
        result.Message='Quote closed successfully.';

        return result;
    }



    public static QuoteResult createClonedOpportunityAsNewQuote(Id sourceOpportunityId, string scenarioName) {
        
        QuoteResult result=new QuoteResult();

        Opportunity opp=NewstarContractInformationService.getOpportunity(sourceOpportunityId);

        //perform a deep clone of the current opportunity WITHOUT preserving its ID
        Opportunity newQuoteOpp=opp.clone(false, true);

        newQuoteOpp.Scenario_Name__c=scenarioName;
        newQuoteOpp.StageName=NewstarSalesPipelineStage.ProspectingStage.Name;
        newQuoteOpp.Total_Options_Amount__c = 0;
        newQuoteOpp.Newstar_ID__c=null;
        newQuoteOpp.CloseDate=opp.CloseDate;

        SavePoint sp = Database.setSavePoint();

        try {
            //insert the newly created opportunity
             insert newQuoteOpp;

        }
        catch(Exception e){

            Database.rollback(sp);
            throw new NewstarContractOperationException('Error committing post-quote create from opportunity data: '+ e.getMessage()); 
        }

        result.ClonedOpportunityId=newQuoteOpp.Id;
        result.Message='New quote opportunity created successfully';

        return result;

    }



    
     private static NewstarQuote performQuoteInternal(
        Opportunity opp, 
        Sales_Office_Customer__c customerSalesOfficeJunction,
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap
        ) {
        
        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for quote
        NewstarQuote apiQuote=new NewstarQuote();

        //expicitly set the quote ID to zero to indicate a NEW reservation
        apiQuote.id=0;

        //construct the nested customer object
        apiQuote.customer=NewstarContractUtilityService.createApiCustomer(opp.Account, customerSalesOfficeJunction);

        //if the cobuyer map is not empty, set API cobuyers
        if(!cobuyerMap.isEmpty()){
            apiQuote.coBuyers=new List<NewstarCoBuyer>(cobuyerMap.keySet());
        }
      
        
        //set subdivision
        apiQuote.subdivisionId=Integer.valueOf(opp.Subdivision__r.Newstar_ID__c);

        //set model
        apiQuote.modelId=Integer.valueOf(opp.Model__r.Newstar_ID__c);

        //set lot
        apiQuote.lotId=Integer.valueOf(opp.Lot__r.Newstar_ID__c);

        //set scenario name
        apiQuote.scenarioName=opp.Scenario_Name__c;

        //resolve the NEWSTAR ID of the sales agent assigned to the opportunity
        Sales_Agent__c assignedSalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c);
        apiQuote.salesAgentId=Integer.valueOf(assignedSalesAgent.Newstar_ID__c);


        //resolve the NEWSTAR ID of the optional secondary sales agent assigned to the opportunity
        if(opp.Sales_Agent_Sales_Office_Relationship_2__c!=null) {
            Sales_Agent__c secondarySalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship_2__r.Sales_Agent__c);
            apiQuote.secondarySalesAgentId=Integer.valueOf(secondarySalesAgent.Newstar_ID__c);
        }
        
       

        //resolve the real estate agent associated with the deal, if set
        if(opp.Real_Estate_Agent__c!=null) {
            apiQuote.realEstateAgentId=Integer.valueOf(opp.Real_Estate_Agent__r.Newstar_ID__c);
        }

        //set the investment property flag
        apiQuote.isInvestment=NewstarDataConversionHelper.getBoolWithNull(opp.Investment__c);

       
        //set the swing if it is available
        apiQuote.swing=getHomeSwingForQuoteApi(opp.Home_Swing__c);
        if(opp.Home_Swing__c!=null){
            apiQuote.swing=getHomeSwingForQuoteApi(opp.Home_Swing__c);
        }
       
        //set the first visit date if it is available
        if(opp.Visit_Date__c!=null){
            apiQuote.firstVisitDate=opp.Visit_Date__c;
        }


        //IMPORTANT: set the external ID of the quote to ID of the Opportunity
        //IMPORTANT: prepend the ID of the current org to allow multi-org event pushing from NEWSTAR Sales
        apiQuote.externalId=UserInfo.getOrganizationId()+'^'+opp.Id;

        //construct the API and set its params
        NewstarQuoteApi quoteApi=new NewstarQuoteApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarQuote', apiQuote); 

        //execute the quote creation request to NEWSTAR
        apiQuote=quoteApi.post(apiParams);

        return apiQuote;
        
    }    


     private static NewstarQuoteToLotReservation performQuoteToLotReservationConversionInternal
     (
        Opportunity opp, 
        Integer holdPeriodInDays, 
        Sales_Office_Customer__c customerSalesOfficeJunction,
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap
        ) {
        
        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for lot reservation
        NewstarQuoteToLotReservation apiQuoteToLotReservation=new NewstarQuoteToLotReservation();

        //set the ID of the quote to NEWSTAR-side ID of the opportunity (the ID was obtained when the quote was submitted)
        apiQuoteToLotReservation.id=Integer.valueOf(opp.Newstar_ID__c);

        //construct the nested customer object
        apiQuoteToLotReservation.customer=NewstarContractUtilityService.createApiCustomer(opp.Account, customerSalesOfficeJunction);

        //if the cobuyer map is not, empty set API cobuyers
        if(!cobuyerMap.isEmpty()){
            apiQuoteToLotReservation.coBuyers=new List<NewstarCoBuyer>(cobuyerMap.keySet());
        }
      
        //set hold period
        apiQuoteToLotReservation.holdPeriodInDays=holdPeriodInDays;

        //resolve the NEWSTAR ID of the sales agent assigned to the opportunity
        Sales_Agent__c assignedSalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c);
        apiQuoteToLotReservation.salesAgentId=Integer.valueOf(assignedSalesAgent.Newstar_ID__c);

        //resolve the NEWSTAR ID of the optional secondary sales agent assigned to the opportunity
        if(opp.Sales_Agent_Sales_Office_Relationship_2__c!=null) {
            Sales_Agent__c secondarySalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship_2__r.Sales_Agent__c);
            apiQuoteToLotReservation.secondarySalesAgentId=Integer.valueOf(secondarySalesAgent.Newstar_ID__c);
        }

        //resolve the real estate agent associated with the deal, if set
        if(opp.Real_Estate_Agent__c!=null) {
            apiQuoteToLotReservation.realEstateAgentId=Integer.valueOf(opp.Real_Estate_Agent__r.Newstar_ID__c);
        }

        //set the investment property flag
        apiQuoteToLotReservation.isInvestment=NewstarDataConversionHelper.getBoolWithNull(opp.Investment__c);

        //set the swing if it is available
        if(opp.Home_Swing__c!=null){
            apiQuoteToLotReservation.swing=getHomeSwingForQuoteToLotReservationConversionApi(opp.Home_Swing__c);
        }

        //set the first visit date if it is available
        if(opp.Visit_Date__c!=null){
            apiQuoteToLotReservation.firstVisitDate=opp.Visit_Date__c;
        }

        //IMPORTANT: set the external ID of the lot reservation to ID of the Opportunity
        //IMPORTANT: prepend the ID of the current org to allow multi-org event pushing from NEWSTAR Sales
        apiQuoteToLotReservation.externalId=UserInfo.getOrganizationId()+'^'+opp.Id;

        //construct the API and set its params
        NewstarQuoteToLotReservationApi quoteTolotReservationApi=new NewstarQuoteToLotReservationApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarQuoteToLotReservation', apiQuoteToLotReservation); 

        //execute the lot reservation request to NEWSTAR
        apiQuoteToLotReservation=quoteTolotReservationApi.post(apiParams);

        return apiQuoteToLotReservation;
        
    }    



     private static NewstarQuoteToDirectOffer performQuoteToDirectOfferConversionInternal
     (
        Opportunity opp, 
        Sales_Office_Customer__c customerSalesOfficeJunction,
        Map<NewstarCoBuyer,Cobuyer__c> cobuyerMap
        ) {
        
        //get the API client
        NewstarClient newstarClient=NewstarApiService.getAuthenticatedClient();
       
        //setup the API object used for direct offer
        NewstarQuoteToDirectOffer apiQuoteToDirectOffer=new NewstarQuoteToDirectOffer();

        //set the ID of the quote to NEWSTAR-side ID of the opportunity (the ID was obtained when the quote was submitted)
        apiQuoteToDirectOffer.id=Integer.valueOf(opp.Newstar_ID__c);

        //construct the nested customer object
        apiQuoteToDirectOffer.customer=NewstarContractUtilityService.createApiCustomer(opp.Account, customerSalesOfficeJunction);

        //if the cobuyer map is not, empty set API cobuyers
        if(!cobuyerMap.isEmpty()){
            apiQuoteToDirectOffer.coBuyers=new List<NewstarCoBuyer>(cobuyerMap.keySet());
        }
      
      
        //resolve the NEWSTAR ID of the sales agent assigned to the opportunity
        Sales_Agent__c assignedSalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c);
        apiQuoteToDirectOffer.salesAgentId=Integer.valueOf(assignedSalesAgent.Newstar_ID__c);


        //resolve the NEWSTAR ID of the optional secondary sales agent assigned to the opportunity
        if(opp.Sales_Agent_Sales_Office_Relationship_2__c!=null) {
            Sales_Agent__c secondarySalesAgent=NewstarContractInformationService.getSalesAgentFromOpportunity(opp.Sales_Agent_Sales_Office_Relationship_2__r.Sales_Agent__c);
            apiQuoteToDirectOffer.secondarySalesAgentId=Integer.valueOf(secondarySalesAgent.Newstar_ID__c);
        }


        //resolve the real estate agent associated with the deal, if set
        if(opp.Real_Estate_Agent__c!=null) {
            apiQuoteToDirectOffer.realEstateAgentId=Integer.valueOf(opp.Real_Estate_Agent__r.Newstar_ID__c);
        }

        //set the investment property flag
        apiQuoteToDirectOffer.isInvestment=NewstarDataConversionHelper.getBoolWithNull(opp.Investment__c);

        //set the swing if it is available
        if(opp.Home_Swing__c!=null){
            apiQuoteToDirectOffer.swing=getHomeSwingForQuoteToDirectOfferConversionApi(opp.Home_Swing__c);
        }

        //set the first visit date if it is available
        if(opp.Visit_Date__c!=null){
            apiQuoteToDirectOffer.firstVisitDate=opp.Visit_Date__c;
        }

        //IMPORTANT: set the external ID of the direct offer to ID of the Opportunity
        //IMPORTANT: prepend the ID of the current org to allow multi-org event pushing from NEWSTAR Sales
        apiQuoteToDirectOffer.externalId=UserInfo.getOrganizationId()+'^'+opp.Id;

        //construct the API and set its params
        NewstarQuoteToDirectOfferApi quoteToDirectOfferApi=new NewstarQuoteToDirectOfferApi(newstarClient);
        
        Map<String, Object> apiParams=new Map<String,Object>();
        apiParams.put('newstarQuoteToDirectOffer', apiQuoteToDirectOffer); 

        //execute the lot reservation request to NEWSTAR
        apiQuoteToDirectOffer=quoteToDirectOfferApi.post(apiParams);

        return apiQuoteToDirectOffer;
        
    }    



    private static List<Opportunity> processQuoteAutoClosings(Opportunity winningOpp) {

        //setup list of stages names that should be used to filter the opportunities to move to Quote Closed stage
        List<String> stagesToAutoClose=new List<String>();

        stagesToAutoClose.add(NewstarSalesPipelineStage.ProspectingStage.Name);
        stagesToAutoClose.add(NewstarSalesPipelineStage.EngagementStage.Name);
        stagesToAutoClose.add(NewstarSalesPipelineStage.QuoteSelectionStage.Name);

        //get all opportunities of the same customer that are in the above stages
        //and belong to the SAME LOT
        //exclude the supplied opportunity itself        
        List<Opportunity> opportunitiesToAutoClose=[
                SELECT
                    Id,
                    Name,
                    StageName,
                    Newstar_ID__c
                FROM
                    Opportunity
                WHERE
                    Id!=:winningOpp.Id
                    AND
                    AccountId=:winningOpp.AccountId
                    AND
                    Lot__c=:winningOpp.Lot__c
                    AND
                    StageName IN :stagesToAutoClose

        ];

        if(opportunitiesToAutoClose.size()>0){
            for (Opportunity opportunityToAutoClose : opportunitiesToAutoClose) {
                
                //move the opportunity to Quote Closed
                opportunityToAutoClose.StageName=NewstarSalesPipelineStage.QuoteClosedStage.Name;
                opportunityToAutoClose.IsAutomatedStageUpdate__c=true;
            }
        }

        return opportunitiesToAutoClose;

    }


    private static NewstarQuote.SwingEnum getHomeSwingForQuoteApi(String homeSwingStringValue) {

        List<NewstarQuote.SwingEnum> swingEnumValues=NewstarQuote.SwingEnum.values();

        for(NewstarQuote.SwingEnum swingEnumValue: swingEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(swingEnumValue.name())==homeSwingStringValue) {
                    return swingEnumValue;
                }
        }

        return null;
    }


    private static NewstarQuoteToLotReservation.SwingEnum getHomeSwingForQuoteToLotReservationConversionApi(String homeSwingStringValue) {

        List<NewstarQuoteToLotReservation.SwingEnum> swingEnumValues=NewstarQuoteToLotReservation.SwingEnum.values();

        for(NewstarQuoteToLotReservation.SwingEnum swingEnumValue: swingEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(swingEnumValue.name())==homeSwingStringValue) {
                    return swingEnumValue;
                }
        }

        return null;
    }


    private static NewstarQuoteToDirectOffer.SwingEnum getHomeSwingForQuoteToDirectOfferConversionApi(String homeSwingStringValue) {

        List<NewstarQuoteToDirectOffer.SwingEnum> swingEnumValues=NewstarQuoteToDirectOffer.SwingEnum.values();

        for(NewstarQuoteToDirectOffer.SwingEnum swingEnumValue: swingEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(swingEnumValue.name())==homeSwingStringValue) {
                    return swingEnumValue;
                }
        }

        return null;
    }

}