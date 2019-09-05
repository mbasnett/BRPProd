public class NewstarSalesPipelineStageTransition {
    
    public String SourceStageName {get; set;}

    public String TargetStageName {get; set;}

    public Boolean IsAutomated {get; set;}

    public Boolean IsValid {get; set;} 

    public String ValidationMessage {get; set;}

    public NewstarSalesPipelineStageTransition() {

        this.IsAutomated=false;
        this.IsValid=false;

    }
}