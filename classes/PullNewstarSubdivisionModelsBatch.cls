global class PullNewstarSubdivisionModelsBatch 
    implements 
              Database.Batchable<SObject>,
              Database.AllowsCallouts,
              Database.Stateful {

    global NewstarClient newstarClient {get; set;}

    global PullNewstarSubdivisionModelsBatch() {
        
    }

    global PullNewstarSubdivisionModelsBatch(NewstarClient newstarClient) {
        this.newstarClient=newstarClient;
    }

    global Database.QueryLocator start(Database.BatchableContext bc){

        System.debug('Executing NEWSTAR Subdivision Models pull job start...');

      
        
        if(this.newstarClient==null) {
            this.newstarClient=NewstarApiService.getAuthenticatedClient();
            System.debug('NEWSTAR client was not supplied; a new client was initialized');
        }

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job started');

      
        return NewstarApiService.GetNewstarPullBatchSubdivisionQueryLocator();
    }


    global void execute(Database.BatchableContext bc, List<Subdivision__c> scope) {

        System.debug('Executing NEWSTAR Subdivision Models pull job execute...');
       
        NewstarMasterDataApiService.ProcessSubdivisionModelsForBatch(newstarClient, scope);
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished NEWSTAR Subdivision Models pull job');

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job completed successfully');

        //chain the lots batch job
        PullNewstarSubdivisionLotsBatch subdivisionLotsBatch=new PullNewstarSubdivisionLotsBatch(this.newstarClient);
        Database.executeBatch(subdivisionLotsBatch, 5);
    }
}