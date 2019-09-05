global class SFDataCleanUpSchedulable implements Schedulable, Database.AllowsCallouts {
    
    global void Execute(SchedulableContext ctx) {

        SFDataCleanUpBatch b=new SFDataCleanUpBatch();
        Database.executeBatch(b);

    }

}