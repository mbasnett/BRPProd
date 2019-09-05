public class RealEstateAgencyResult {

    @AuraEnabled
    public string Message {get; set;}


    public RealEstateAgencyResult(String message) {
        this.Message=message;
    }


    public RealEstateAgencyResult()
    {
        
    }

}