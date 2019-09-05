/*
    Provides utility functionality for adhoc logging
    via Saleforce Platform Events (Event Bus).
*/
public class NewstarLoggingService {
    
    private static List<Newstar_Log_Event__e> logEvents;

    /*
        Represents the unique correlation ID of the current logging context (e.g. an APEX request).
    */
    public static String currentCorrelationId {get; private set;}


    /*
        Represents the current logging context event type.
    */
    public static String currentEventType {get; private set;}

    /*
        Represents the current logging context event context.
    */
    public static String currentEventContext {get; private set;}


    /*
        Represents the current logging context primary object ID.
    */
    public static String currentPrimaryObjectId {get; private set;}


    public static Boolean groupCurrentContextEvents {get; private set;}


    /*
        Represents the logged event status as set by the event source.
    */
    public enum EventStatus {
        Info,
        Success,
        Failure,
        Unknown
    }


    /*
        Represents common event types used for logging.
    */
    public enum CommonEventType {

        /*
            Adhoc (on-demand) invocation from a Lightning Web Component.
        */
        LWC,

        /*
            Batch job (APEX batchable)
        */
        BatchJob


    }


    /*
        Represents common event contexts used for logging.
    */
    public enum CommonEventContext {
        Quote,
        QuoteToLotReservationConversion,
        QuoteToDirectOfferConversion,
        QuoteClose,
        QuoteOpportunityClone,
        LotReservation,
        LotUnreservation,
        DirectOffer,
        DirectOfferCancellation,
        RealEstateAgencySync,
        RealEstateAgentSync,
        CustomerInfoSync,
        CobuyerSync,
        MasterData_SalesOffices,
        MasterData_Subdivisions,
        MasterData_SalesAgents,
        MasterData_SubdivisionModels,
        MasterData_SubdivisionLots,
        MasterData_GeographyLayout,
        SetOpportunityLot,
        MasterData_SyncInitiate
    }


    private static final EventStatus DefaultEventStatus=EventStatus.Info;


    private static List<String> eventStatusNames;

    /*
        Indicates whether a current logging context has been configured
        via configureLoggingContext.
    */
    public static Boolean isLoggingContextConfigured {get; private set;}


    /*  
        Configures the current logging context based on the parameters supplied.
    */
    public static void configureLoggingContext(CommonEventType eventType, CommonEventContext eventContext, String primaryObjectId) {
        configureLoggingContext(eventType.name(), eventContext.name(), primaryObjectId);
    }


    /*  
        Configures the current logging context based on the parameters supplied.
    */
    public static void configureLoggingContext(String eventType, String eventContext, String primaryObjectId) {
        currentEventContext=eventContext;
        currentEventType=eventType;
        currentPrimaryObjectId=primaryObjectId;
        isLoggingContextConfigured=true;
    }

    public static void pushActionStart() {
        pushLogMessage('Action started');
    }


    public static void pushActionSuccess() {
        pushLogMessage('Action completed successfully', EventStatus.Success);
    }

    /*
        Adds a logged event to the current transaction/context log event queue 
        based on the supplied trace information using
        the default event status (Info).
    */
    public static void pushLogMessage(String traceInfo) {
            
        pushLogMessage(traceInfo, DefaultEventStatus);
    }

    
    /*
        Adds a logged event to the current transaction/context log event queue 
        based on the supplied event type, context and other parameters.
    */
    public static void pushLogMessage(String traceInfo, EventStatus eventStatus)
    {

        //do not perform any actual logging if the logging context is not configured
        if(!isLoggingContextConfigured) return;
        
        //validate status and do nothing if status is invalid
        String eventStatusName=eventStatus.name();
        if(!eventStatusNames.contains(eventStatusName)) {
            return;
        }

        //prepare the custom log event
        Newstar_Log_Event__e logEvent=new Newstar_Log_Event__e();
        logEvent.Type__c=currentEventType;
        logEvent.Context__c=currentEventContext;
        logEvent.Trace_Info__c=traceInfo;
        logEvent.Correlation_ID__c=currentCorrelationId;
        logEvent.Primary_Object_ID__c=currentPrimaryObjectId;
        logEvent.Status__c=eventStatusName;

        //add it to the queue

        if (!Test.isRunningTest()) {
            logEvents.add(logEvent);
        }    
    }


    /*
        Flushes the current correlation context event queue 
        by publishing the events on the Event Bus.
    */
    public static void flushLogEventQueue() {
        
        try {
            //publish queued events on the Event Bus
            if(logEvents.size()>0) {
                System.Eventbus.publish(logEvents);
            }
           
        }
        catch(Exception e){
            System.debug(System.LoggingLevel.ERROR, 'Error: publishing NEWSTAR log event to the Event Bus: '+e.getMessage());
        }
    }


    private static void arrangeLogEventQueue() {

        if(!groupCurrentContextEvents) return;

    }


    private static void performInit() {

        eventStatusNames=new List<String>();

        logEvents=new List<Newstar_Log_Event__e>();

        currentCorrelationId=NewstarDataConversionHelper.generateUniqueId();

        isLoggingContextConfigured=false;

        groupCurrentContextEvents=false;

        
        Schema.DescribeFieldResult logRecordDescribe=Newstar_Log_Record__c.Status__c.getDescribe();
        for(Schema.PicklistEntry pe: logRecordDescribe.getPicklistValues()){
            eventStatusNames.add(pe.getValue());
        }
    }


    //static CTor
    static {
      performInit();
    }

}