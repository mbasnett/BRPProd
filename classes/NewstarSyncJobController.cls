public with sharing class NewstarSyncJobController {
    public NewstarSyncJobController() {

    }

    @AuraEnabled
    public static NewstarSyncJobInfo initiateSync(){

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.MasterData_SyncInitiate, 
            '');

        NewstarLoggingService.pushActionStart();

        try {

            List<NewstarSyncTarget> syncTargets=new List<NewstarSyncTarget>();
            
            NewstarSyncTarget allInTarget=new NewstarSyncTarget();
            allInTarget.JobType=NewstarSyncJobInfo.JobType.GEOGRAPHY_LAYOUT;
            syncTargets.add(allInTarget);

            NewstarSyncJobInfo result=NewstarSyncJobManagerService.initiateSync(syncTargets);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('NEWSTAR sync job initiation failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;
    }


    @AuraEnabled
    public static List<NewstarSyncJobInfo> getSyncJobsStatuses(){

        List<NewstarSyncJobInfo> jobInfos= NewstarSyncJobManagerService.getSyncJobsStatuses();
        return jobInfos;
    }

    
}