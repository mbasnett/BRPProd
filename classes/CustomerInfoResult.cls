public with sharing class CustomerInfoResult {
    
    @AuraEnabled
    public String Message {get; set;}

    public CustomerInfoResult(String message) {
        this.Message=message;
    }

    public CustomerInfoResult() {

    }
}