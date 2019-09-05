global class PullNewstarSalesAgentsBatch 
    implements 
              Database.Batchable<NewstarApiRootEntity>,
              Database.AllowsCallouts,
              Database.Stateful  {
 
    global NewstarClient newstarClient {get; set;}

    global PullNewstarSalesAgentsBatch() {
        
    }

    global PullNewstarSalesAgentsBatch(NewstarClient newstarClient) {
        this.newstarClient=newstarClient;
    }

    global List<NewstarApiRootEntity> start(Database.BatchableContext bc){
        
        System.debug('Executing NEWSTAR Sales Agent pull job start...');

        
        
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

        System.debug('Executing NEWSTAR Sales Agent pull job execute...');
        if(this.newstarClient==null) 
        {
            System.debug('newstarClient is null is execute!!!');
        }
        
        NewstarMasterDataApiService.ProcessSalesAgents(this.newstarClient);
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished NEWSTAR Sales Agent pull job');

        NewstarPushNotificationsService.publishNewstarNotificationEvent(
            NewstarSyncJobManagerService.JobEventNotificationObjectId, 
            'Job completed successfully');

        PullNewstarSalesOfficesBatch salesOfficeBatch=new PullNewstarSalesOfficesBatch(this.newstarClient);
        Database.executeBatch(salesOfficeBatch);
    }
}