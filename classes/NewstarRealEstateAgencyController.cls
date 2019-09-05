public with sharing class NewstarRealEstateAgencyController {
    
    public NewstarRealEstateAgencyController() {

    }


    /*
        Attempts syncing the specified real estate agency account to NEWSTAR Sales.
    */
    @AuraEnabled
    public static RealEstateAgencyResult syncAgency(Id agencyAccountId) 
    {
        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.RealEstateAgencySync, 
            String.valueOf(agencyAccountId));

        NewstarLoggingService.pushActionStart();

        try {
            RealEstateAgencyResult result=NewstarRealEstateAgentSyncService.syncAgency(agencyAccountId);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Real estate agency sync to NEWSTAR failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;
    }
}