public with sharing class RealEstateAgentResult {
   
    @AuraEnabled
    public string Message {get; set;}


    public RealEstateAgentResult(String message) {
        this.Message=message;
    }
   
    public RealEstateAgentResult() {

    }
}