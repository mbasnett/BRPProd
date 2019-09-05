global class SFDataCleanUpBatch 
    implements 
              Database.Batchable<SObject>,
              Database.AllowsCallouts,
              Database.Stateful  {
 
    global SFDataCleanUpBatch() {
        
    }

    global List<SObject> start(Database.BatchableContext bc){
        System.debug('Executing SF Data Clean Up start...');
        return SFDataCleanUpService.getObjectsToDelete();
    }


    global void execute(Database.BatchableContext bc, List<SObject> scope) {

        System.debug('Executing SF Data Clean Up execute...');
        
        delete scope;
    }


    global void finish(Database.BatchableContext bc) {
        System.debug('Finished SF Data Clean Up job');
    }
}