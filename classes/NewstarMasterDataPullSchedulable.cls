global class NewstarMasterDataPullSchedulable implements Schedulable, Database.AllowsCallouts {
    

    global void Execute(SchedulableContext ctx) {

        PullNewstarGeographyLayoutBatch b=new PullNewstarGeographyLayoutBatch();
        Database.executeBatch(b);

    }

}