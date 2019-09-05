public with sharing class CobuyerInfoResult {
    
    @AuraEnabled
    public String Message {get; set;}

    public CobuyerInfoResult(String message) {
        this.Message=message;
    }

    public CobuyerInfoResult() {

    }

}