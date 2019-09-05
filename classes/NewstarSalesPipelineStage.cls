public  class NewstarSalesPipelineStage {
    
    public String Name {get; set;}

    public Boolean IsNewstarHandoffStage {get; set;}

    public Boolean IsNewstarTriggeredStage {get; set;}

    public Boolean IsPreNewstarHandoffStage {get; set;}


    public NewstarSalesPipelineStage() {
        
        this.IsNewstarHandoffStage=false;
        this.IsNewstarTriggeredStage=false;
        this.IsPreNewstarHandoffStage=false;
    }



    //static properties representing specific pipeline stages
    public static NewstarSalesPipelineStage ProspectingStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage EngagementStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage QuoteSelectionStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage ContractReadyStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage LotReservationStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage PendingOfferStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage UnderContractStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage ClosedHomeStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage CancelledStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage QuoteClosedStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage LostStage=new NewstarSalesPipelineStage();

    //static initializer
    static {
        
        ProspectingStage.Name='Prospecting';

        EngagementStage.IsPreNewstarHandoffStage=true;
        EngagementStage.Name='Engagement';

        QuoteSelectionStage.IsNewstarHandoffStage=true;
        QuoteSelectionStage.Name='Quote/Selection';

        ContractReadyStage.IsNewstarHandoffStage=true;
        ContractReadyStage.Name='Contract Ready';

        LotReservationStage.IsNewstarHandoffStage=true;
        LotReservationStage.Name='Lot Reservation';

        
        PendingOfferStage.IsNewstarTriggeredStage=true;
        PendingOfferStage.Name='Pending Offer';

        UnderContractStage.IsNewstarTriggeredStage=true;
        UnderContractStage.Name='Under Contract';
        
        ClosedHomeStage.IsNewstarTriggeredStage=true;
        ClosedHomeStage.Name='Closed Home';

        CancelledStage.IsNewstarTriggeredStage=true;
        CancelledStage.Name='Cancelled';

        QuoteClosedStage.Name='Quote Closed';

        LostStage.Name='Lost';

    }

    
}