public class NewstarLogEventSubscriberTriggerHandler {
    

    public static void processEvents(List<Newstar_Log_Event__e> logEvents) {

        List<Newstar_Log_Record__c> logRecords=new List<Newstar_Log_Record__c>();

        for(Newstar_Log_Event__e logEvent: logEvents) {

            Newstar_Log_Record__c logRecord=new Newstar_Log_Record__c();

            logRecord.Event_Type__c=logEvent.Type__c;
            logRecord.Event_Context__c=logEvent.Context__c;
            logRecord.Primary_Object_ID__c=logEvent.Primary_Object_ID__c;
            logRecord.Trace_Info__c=logEvent.Trace_Info__c;
            logRecord.Correlation_ID__c=logEvent.Correlation_ID__c;
            logRecord.Status__c=logEvent.Status__c;
            logRecord.Event_Date__c=logEvent.CreatedDate;

            logRecords.add(logRecord);
        
        }

        Database.insert(logRecords);
    }

}