global class PullNewstarSubdivisionsBatch 
    implements 
              Database.Batchable<NewstarApiRootEntity>,
              Database.AllowsCallouts,
              Database.Stateful {


    global NewstarClient newstarClient {get; set;}

    global PullNewstarSubdivisionsBatch() {
        
    }

    global PullNewstarSubdivisionsBatch(NewstarClient newstarClient) {
        this.newstarClient=newstarClient;
    }


    global List<NewstarApiRootEntity> start(Database.BatchableContext bc){

        System.debug('Executing NEWSTAR Subdivisions pull job start...');

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

        System.debug('Executing NEWSTAR Subdivisions pull job execute...');
        NewstarMasterDataApiService.ProcessSubdivisions(this.newstarClient);
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished NEWSTAR Subdivisions pull job');

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job completed successfully');

        //chain the models batch job
        PullNewstarSubdivisionModelsBatch subdivisionModelsBatch=new PullNewstarSubdivisionModelsBatch(this.newstarClient);
        Database.executeBatch(subdivisionModelsBatch,5);
    }
}