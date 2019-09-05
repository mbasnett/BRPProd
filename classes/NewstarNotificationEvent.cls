/*
* Represents a NEWSTAR notification event type.
*/
public class NewstarNotificationEvent {
   
    //name of the event type
    public String Name {get; private set;}


    public NewstarNotificationEvent(String name) {
        this.Name=name;
    }


    public static NewstarNotificationEvent DealNotesUpdatedEvent {  
        get 
        {
            return new NewstarNotificationEvent('DealNotesUpdated');
        }
    }

    public static NewstarNotificationEvent DealStipulationUpdatedEvent {  
        get 
        {
            return new NewstarNotificationEvent('DealStipulationUpdated');
        }
    }

    public static NewstarNotificationEvent UndoContractReadyEvent {  
        get 
        {
            return new NewstarNotificationEvent('UndoContractReady');
        }
    }

    public static NewstarNotificationEvent PendingOfferEvent { 
        get 
        {
            return new NewstarNotificationEvent('PendingOffer');
        }
    }

    public static NewstarNotificationEvent UndoPendingOfferEvent { 
        get 
        {
            return new NewstarNotificationEvent('UndoPendingOffer');
        }
    }

    public static NewstarNotificationEvent UnderContractEvent { 
        get 
        {
            return new NewstarNotificationEvent('UnderContract');
        }
    }


    public static NewstarNotificationEvent ClosedEvent { 
        get 
        {
            return new NewstarNotificationEvent('Closed');
        }
    }


    public static NewstarNotificationEvent CancelledEvent { 
        get 
        {
            return new NewstarNotificationEvent('Cancelled');
        }
    }
    

    public static NewstarNotificationEvent ContingencyCreatedEvent { 
        get 
        {
            return new NewstarNotificationEvent('ContingencyCreated');
        }
    }

    public static NewstarNotificationEvent ContingencyUpdatedEvent { 
        get 
        {
            return new NewstarNotificationEvent('ContingencyUpdated');
        }
    }


    public static NewstarNotificationEvent ContingencyDeletedEvent { 
        get 
        {
            return new NewstarNotificationEvent('ContingencyDeleted');
        }
    }


    public static NewstarNotificationEvent ReservationExpiredEvent { 
        get 
        {
            return new NewstarNotificationEvent('ReservationExpired');
        }
    }


    public static NewstarNotificationEvent FinancialInfoUpdatedEvent {
        get
        {
            return new NewstarNotificationEvent('FinancialInfoUpdated');
        }
    }


    public static NewstarNotificationEvent InvestmentPropertyUpdatedEvent {
        get
        {
            return new NewstarNotificationEvent('InvestmentPropertyUpdated');
        }
    }


    public static NewstarNotificationEvent ClosingDateUpdatedEvent {
        get
        {
            return new NewstarNotificationEvent('ClosingDateUpdated');
        }
    }


    public static NewstarNotificationEvent SwingUpdatedEvent {
        get
        {
            return new NewstarNotificationEvent('SwingUpdated');
        }
    }


    static {

    }

}