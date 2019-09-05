public with sharing class NewstarQuoteController {
    
    public NewstarQuoteController() {

    }


    /*
        Attempts quote creation for the specified opportunity.
    */
    @AuraEnabled
    public static QuoteResult createQuote(Id opportunityId) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.Quote, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {
            QuoteResult result=NewstarQuoteOperationsService.performQuote(opportunityId);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
          
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Quote creation failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;

    }


    /*
        Attempts conversion of the previously created quote to a lot reservation for the specified opportunity.
    */
    @AuraEnabled
    public static LotReservationResult convertQuoteToLotReservation(Id opportunityId, Integer holdPeriodInDays) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.QuoteToLotReservationConversion, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {
            LotReservationResult result=NewstarQuoteOperationsService.performQuoteToLotReservationConversion(opportunityId, holdPeriodInDays);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
          
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Lot reservation from quote failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;

    }


    /*
        Attempts conversion of the previously created quote to a direct offer for the specified opportunity.
    */
    @AuraEnabled
    public static ContractResult convertQuoteToDirectOffer(Id opportunityId) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.QuoteToDirectOfferConversion, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {
            ContractResult result=NewstarQuoteOperationsService.performQuoteToDirectOfferConversion(opportunityId);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
          
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Contract creation from quote failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;

    }



     /*
        Explicitly closes out a rejected quote.
    */
    @AuraEnabled
    public static QuoteResult closeRejectedQuote(Id opportunityId) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.QuoteClose, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {
            QuoteResult result=NewstarQuoteOperationsService.performRejectedQuoteClose(opportunityId);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
          
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Quote closing failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;

    }



    @AuraEnabled
    public static QuoteResult createNewQuoteFromOpportunity(Id opportunityId, string scenarioName) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.QuoteOpportunityClone, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {
            QuoteResult result=NewstarQuoteOperationsService.createClonedOpportunityAsNewQuote(opportunityId, scenarioName);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
          
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('New quote opportunity creation failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;

    }

}