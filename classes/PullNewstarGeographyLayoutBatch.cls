global class PullNewstarGeographyLayoutBatch 
    implements 
              Database.Batchable<NewstarApiRootEntity>,
              Database.AllowsCallouts,
              Database.Stateful  {
 
    global NewstarClient newstarClient {get; set;}

    global PullNewstarGeographyLayoutBatch() {
        
    }

    global PullNewstarGeographyLayoutBatch(NewstarClient newstarClient) {
        this.newstarClient=newstarClient;
    }

    global List<NewstarApiRootEntity> start(Database.BatchableContext bc){

        System.debug('Executing NEWSTAR Geograpy Layout pull job start...');

        
        if(this.newstarClient==null) {
            this.newstarClient=NewstarApiService.getAuthenticatedClient();
            System.debug('NEWSTAR client was not supplied; a new client was initialized');
        }

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job started');
     
      
        List<NewstarApiRootEntity> rootEntityList=new List<NewstarApiRootEntity>();
        rootEntityList.add(new NewstarApiRootEntity());

        return rootEntityList;
    }


    global void execute(Database.BatchableContext bc, List<NewstarApiRootEntity> scope) {

        System.debug('Executing NEWSTAR Geograpy Layout pull job execute...');
        if(this.newstarClient==null) 
        {
            System.debug('newstarClient is null is execute!!!');
        }
        
        NewstarMasterDataApiService.ProcessGeographyLayout(this.newstarClient);
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished NEWSTAR Geograpy Layout pull job');

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job completed successfully');

        PullNewstarSalesAgentsBatch salesAgentBatch=new PullNewstarSalesAgentsBatch(this.newstarClient);
        Database.executeBatch(salesAgentBatch);
    }
}