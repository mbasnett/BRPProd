public  class LotReservationResult {

    @AuraEnabled
    public String Message {get; set;}

    public LotReservationResult(String message) {
        this.Message=message;
    }

    public LotReservationResult() {

    }
}