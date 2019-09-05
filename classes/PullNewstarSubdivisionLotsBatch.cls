global class PullNewstarSubdivisionLotsBatch 
    implements 
              Database.Batchable<SObject>,
              Database.AllowsCallouts,
              Database.Stateful {


    global NewstarClient newstarClient {get; set;}

    global PullNewstarSubdivisionLotsBatch() {
        
    }

    global PullNewstarSubdivisionLotsBatch(NewstarClient newstarClient) {
        this.newstarClient=newstarClient;
    }


    global Database.QueryLocator start(Database.BatchableContext bc){

        System.debug('Executing NEWSTAR Subdivision Lots pull job start...');

       
        
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

        System.debug('Executing NEWSTAR Subdivision Lots pull job execute...');

        if(this.newstarClient==null) 
        {
            System.debug('newstarClient is null in execute!!!');
        }
       
        NewstarMasterDataApiService.ProcessSubdivisionLotsForBatch(newstarClient, scope);
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished NEWSTAR Subdivision Lots pull job');

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job completed successfully');

        RefreshOpportunityPricesBatch refreshOpportunityPricesBatch=new RefreshOpportunityPricesBatch();
        Database.executeBatch(refreshOpportunityPricesBatch);      
    }
}