/*
    Represents an NEWSTAR notification REST end-point used
    to push sales lifecycle notifications from NEWSTAR Sales.
*/
@RestResource(urlMapping='/NewstarNotification/*')
global with sharing class NewstarNotificationResource {


    /**
     * Processes a push notification event from NEWSTAR Sales.
     * 
     * @param notification - Notification object passed from NEWSTAR
    */
    @HttpPost
    global static NewstarNotificationResult postNotification(NewstarNotification notification) {
        return NewstarNotificationService.processNotification(notification);
    }


    
}