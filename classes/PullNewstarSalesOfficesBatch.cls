global class PullNewstarSalesOfficesBatch 
    implements 
              Database.Batchable<NewstarApiRootEntity>,
              Database.AllowsCallouts,
              Database.Stateful  {
 
    global NewstarClient newstarClient {get; set;}

    global PullNewstarSalesOfficesBatch() {
        
    }

    global PullNewstarSalesOfficesBatch(NewstarClient newstarClient) {
        this.newstarClient=newstarClient;
    }

    global List<NewstarApiRootEntity> start(Database.BatchableContext bc){

        System.debug('Executing NEWSTAR Sales Office pull job start...');
        
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

        System.debug('Executing NEWSTAR Sales Office pull job execute...');
        if(this.newstarClient==null) 
        {
            System.debug('newstarClient is null is execute!!!');
        }
        
        NewstarMasterDataApiService.ProcessSalesOffices(this.newstarClient);
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished NEWSTAR Sales Office pull job');

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job completed successfully');

        PullNewstarSubdivisionsBatch subdivisionBatch=new PullNewstarSubdivisionsBatch(this.newstarClient);
        Database.executeBatch(subdivisionBatch);
    }
}