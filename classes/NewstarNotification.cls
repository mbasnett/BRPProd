/*
* Represents a NEWSTAR Sales -> Salesforce notification.
*/
global class NewstarNotification {

    //type of the event Salesforce is being notified of from NEWSTAR    
    public String EventType {get; set;}

    //event date/time stamp
    public Datetime EventDate {get; set;}

    //list of additional parameters specific to this notification as name/value pairs
    public List<NewstarNotificationParameter> Parameters {get; set;}

    //CTor
    public NewstarNotification() {

        this.EventDate=Datetime.now();
        this.EventType='';
        this.Parameters=new List<NewstarNotificationParameter>();
    }


    /*
    * Returns a specific notification parameter using the supplied parameter name.
    */
    public NewstarNotificationParameter getParameter(String parameterName) {
        
        for (NewstarNotificationParameter parameter : this.Parameters) {
           if(parameter.Name==parameterName){
               return parameter;
           }
        }

        return null;

    } 
}