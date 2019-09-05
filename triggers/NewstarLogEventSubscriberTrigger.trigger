/*
    This trigger subscribes to the Salesforce Platform Event for the custom 
    NEWSTAR Log Event and performs actions to persist the event, issue notifications, etc.
*/
trigger NewstarLogEventSubscriberTrigger on Newstar_Log_Event__e (after insert) {

    NewstarLogEventSubscriberTriggerHandler.processEvents(Trigger.new);

}