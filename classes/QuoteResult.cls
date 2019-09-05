public class QuoteResult {

    @AuraEnabled
    public string Message {get; set;}

    @AuraEnabled
    public Id ClonedOpportunityId { get; set; }


    public QuoteResult(String message) {
        this.Message=message;
    }

    public QuoteResult() {

    }

}