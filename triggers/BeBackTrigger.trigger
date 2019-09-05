trigger BeBackTrigger on BeBack__c( after insert)
{
    if(trigger.isAfter && trigger.isInsert){
        //new GenericNotesCreation().CreateBeBacknotes(trigger.new); //Dave commented this out march 11 2019
        }
}