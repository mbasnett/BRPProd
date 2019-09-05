public with sharing class NewstarRealEstateAgentController {
    public NewstarRealEstateAgentController() {

    }

     /*
        Attempts syncing the specified real estate agent contact to NEWSTAR Sales.
    */
    @AuraEnabled
    public static RealEstateAgentResult syncAgent(Id agentContactId) 
    {
        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.RealEstateAgentSync, 
            String.valueOf(agentContactId));

        NewstarLoggingService.pushActionStart();

        try {
            RealEstateAgentResult result=NewstarRealEstateAgentSyncService.syncAgent(agentContactId);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Real estate agent sync to NEWSTAR failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;
    }
}