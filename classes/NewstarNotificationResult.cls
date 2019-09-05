global class NewstarNotificationResult {

    global Boolean IsSuccess {get; set;}
    
    global String Message {get; set;}

    public NewstarNotificationResult() {
        this.IsSuccess=false;
        this.Message='';
    }
}