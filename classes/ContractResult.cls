public class ContractResult {
  

     @AuraEnabled
    public String Message {get; set;}

    public ContractResult(String message) {
        this.Message=message;
    }

    public ContractResult() {

    }
}