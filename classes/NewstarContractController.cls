public with sharing class NewstarContractController {
    
    public NewstarContractController() {

    }

    /*
        Attempts Direct Offer for the specified opportunity.
    */
    @AuraEnabled
    public static ContractResult initiateContract(Id opportunityId, Date targetClosingDate) {

      
        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.DirectOffer, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();


        try {
            ContractResult result = NewstarContractOperationsService.performDirectOffer(opportunityId, targetClosingDate);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Direct Offer failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }


        return null;

    }



    /*
        Attempts Undo Direct Offer for the specified opportunity.
    */
    @AuraEnabled
    public static ContractResult cancelContractInitiation(Id opportunityId) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.DirectOffer, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {

            ContractResult result = NewstarContractOperationsService.performDirectOfferUndo(opportunityId);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Contract initiation undo failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }


        return null;
    }


    /*
        Returns the opportunity object based on the specified ID
        for use with all contract operations.
    */
    @AuraEnabled(cacheable=false)
    public static Opportunity getOpportunity(Id opportunityId){

       try {
            Opportunity opp=NewstarContractInformationService.getOpportunity(opportunityId);
           
            NewstarContractValidationService.validateOpportunityForMissingFields(opp);
            NewstarContractValidationService.validateOpportunityForContractFlowConfiguration(opp);
            NewstarContractValidationService.validateOpportunityForRealEstateAgent(opp);
            

            return opp;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Error obtaining opportunity record data', ex);
        }

        return null;
        
    }



}