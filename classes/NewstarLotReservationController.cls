public with sharing class NewstarLotReservationController {


    public NewstarLotReservationController() {

    }


    /*
        Attempts lot reservation for the specified opportunity and hold period duration.
    */
    @AuraEnabled
    public static LotReservationResult reserveLot(Id opportunityId, Integer holdPeriodInDays) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.LotReservation, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {
            LotReservationResult result=NewstarLotReservationOperationsService.performLotReservation(opportunityId, holdPeriodInDays);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
          
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Lot reservation failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;

    }



    /*
        Attempts lot unreservation for the specified opportunity.
    */
    @AuraEnabled
    public static LotReservationResult unreserveLot(Id opportunityId) {


        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.LotUnreservation, 
            String.valueOf(opportunityId));

           NewstarLoggingService.pushActionStart();

        try {
            LotReservationResult result= NewstarLotReservationOperationsService.performLotUnreservation(opportunityId);

            NewstarLoggingService.pushActionSuccess();

            NewstarPushNotificationsService.postChatterNofication(result.Message, opportunityId, UserInfo.getUserId());
            
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Lot unreservation failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;
    }



    /*
        Returns the opportunity object based on the specified ID
        for use with the lot reservation/contract initiation UX.
    */
    @AuraEnabled
    public static Opportunity getOpportunity(Id opportunityId){

      return NewstarContractInformationService.getOpportunity(opportunityId);
    
    }

    
}