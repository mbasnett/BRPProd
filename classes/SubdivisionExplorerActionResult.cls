public  class SubdivisionExplorerActionResult {
    
    @AuraEnabled
    public string Message {get; set;}


    @AuraEnabled
    public string AdditionalWarningMessage {get; set;}


    public SubdivisionExplorerActionResult(String message) {
        this.Message=message;
    }
   
    public SubdivisionExplorerActionResult() {

    }
}