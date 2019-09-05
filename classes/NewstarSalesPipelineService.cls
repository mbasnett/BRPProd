/*
    Provides Newstar sales pipeline utility services.
*/
public with sharing class NewstarSalesPipelineService {


    /*
        Validates if the specified stage transition is valid 
    */
    public static void ValidateStageTransition(NewstarSalesPipelineStageTransition stageTransition)
    {

        
        //validate that the stage has actually changed
        if(!HasStageChanged(stageTransition)){

            //no actual transition, so "valid"
            stageTransition.IsValid=true;
            return;
        }

        //TODO: prevent transitions to any stage from ANY closed-type stage, including Quote Closed



        //check if this is any transition between two pure marketing stages: 
        if(IsTransitionBetweenPureMarketingStages(stageTransition)) {
            //IMPORTANT: allow transitions between pure marketing stages
            stageTransition.IsValid=true;
            return;
        }


        //check if this is a manual transition to a pure marketing stage from a NEWSTAR-triggered stage
        if(IsManualTransitionToPureMarketingStageFromNewstarTriggeredStage(stageTransition)){

            stageTransition.ValidationMessage=stageTransition.TargetStageName+' stage cannot be activated manually at current stage: '+stageTransition.SourceStageName+'. Please use the NEWSTAR Sales to update the opportunity pipeline, if applicable.';
            stageTransition.IsValid=false;
            return;
        }

         //check if this is a manual transition to a pure marketing stage from a NEWSTAR handoff stage
        if(IsManualTransitionToPureMarketingStageFromNewstaHandoffStage(stageTransition)){

            stageTransition.ValidationMessage=stageTransition.TargetStageName+' stage cannot be activated manually at current stage: '+stageTransition.SourceStageName+'.  Please use the "Manage NEWSTAR Contract" action to update the opportunity pipeline, if applicable.';
            stageTransition.IsValid=false;
            return;
        }

        //check if this is a manual transition to one of the handoff stages
        if(IsManualTransitionToNewstarHandoffStage(stageTransition)){

            stageTransition.ValidationMessage=stageTransition.TargetStageName+' stage cannot be activated manually. Please use the "Manage NEWSTAR Contract" action on the opportunity.';
            stageTransition.IsValid=false;
            return;
        }

        //check if this is a manual transition to one of the NEWSTAR-triggered stages
        if(IsManualTransitionToNewstarTriggeredStage(stageTransition)){
            stageTransition.ValidationMessage=stageTransition.TargetStageName+' stage cannot be activated manually. Please initiate this action from NEWSTAR Sales.';
            stageTransition.IsValid=false;
            return;
        }


        //check if this is a manual transition to a stage that immediately preceeds a handoff stage (pre-handoff stage)
        if(IsManualTransitionToNewstarPrehandoffStageFromNewstarTriggeredStage(stageTransition)){
            stageTransition.ValidationMessage=stageTransition.TargetStageName+' stage cannot be activated manually from current stage: '+stageTransition.SourceStageName+'. Please use the "Manage NEWSTAR Contract" action on the opportunity.';
            stageTransition.IsValid=false;
            return;
        }


        //default result: stage transition is valid
        stageTransition.IsValid=true;
       
    }


    private static Boolean HasStageChanged(NewstarSalesPipelineStageTransition stageTransition)
    {
        return stageTransition.SourceStageName!=stageTransition.TargetStageName;
    }


    private static Boolean IsManualTransitionToNewstarHandoffStage(NewstarSalesPipelineStageTransition stageTransition) {

        if(IsNewstarHandoffStage(stageTransition.TargetStageName)
               && !stageTransition.IsAutomated
               )
                {
                    return true;
                }

        return false;
    }


    private static Boolean IsManualTransitionToNewstarTriggeredStage(NewstarSalesPipelineStageTransition stageTransition) {

        if(IsNewstarTriggeredStage(stageTransition.TargetStageName)
                && !stageTransition.IsAutomated)
                {
                    return true;
                }

        return false;
    }


    private static boolean IsTransitionBetweenPureMarketingStages(NewstarSalesPipelineStageTransition stageTransition) {
 
        if(
            (
                IsPureMarketingStage(stageTransition.SourceStageName)
                 || IsPreNewstarHandoffStage(stageTransition.SourceStageName) 
            )
            && IsPureMarketingStage(stageTransition.TargetStageName))
        {
            return true;
        }
    

        return false;

    }


    private static boolean IsManualTransitionToPureMarketingStageFromNewstarTriggeredStage(NewstarSalesPipelineStageTransition stageTransition) {
 
        if(
            !IsPureMarketingStage(stageTransition.SourceStageName) 
            && IsNewstarTriggeredStage(stageTransition.SourceStageName)
            && IsPureMarketingStage(stageTransition.TargetStageName)
            && !stageTransition.IsAutomated
            )
        {
            return true;
        }
    

        return false;

    }


    private static boolean IsManualTransitionToPureMarketingStageFromNewstaHandoffStage(NewstarSalesPipelineStageTransition stageTransition) {
 
        if(
            !IsPureMarketingStage(stageTransition.SourceStageName) 
            && IsNewstarHandoffStage(stageTransition.SourceStageName)
            && IsPureMarketingStage(stageTransition.TargetStageName)
            && !stageTransition.IsAutomated
            )
        {
            return true;
        }
    

        return false;

    }



    private static Boolean IsManualTransitionToNewstarPrehandoffStageFromNewstarTriggeredStage(NewstarSalesPipelineStageTransition stageTransition) {
       
        
         if(IsPreNewstarHandoffStage(stageTransition.TargetStageName)
            && !IsPureMarketingStage(stageTransition.SourceStageName)
                && !stageTransition.IsAutomated)
                {
                    return true;
                }

        return false;
    }


    private static Boolean IsNewstarHandoffStage(String stageName){
      ValidateStageDefined(stageName);
      return pipelineStagesMap.get(stageName).IsNewstarHandoffStage;

    }

    private static Boolean IsNewstarTriggeredStage(String stageName){
        ValidateStageDefined(stageName);
        return pipelineStagesMap.get(stageName).IsNewstarTriggeredStage;

    }

    public static Boolean IsPreNewstarHandoffStage(String stageName){
        ValidateStageDefined(stageName);
        return pipelineStagesMap.get(stageName).IsPreNewstarHandoffStage;

    }


    public static Boolean IsPureMarketingStage(String stageName){
        return !pipelineStagesMap.containsKey(stageName);
    }


    private static void ValidateStageDefined(String stageName) {

        if(!pipelineStagesMap.containsKey(stageName)) {
            throw new NewstarSalesPipelineException('Stage '+stageName+' is not defined as a NEWSTAR sales pipeline stage.');
        }
    }


    private static Map<string, NewstarSalesPipelineStage> pipelineStagesMap=new Map<string, NewstarSalesPipelineStage>();


    //static initilizer
    static {
        
        pipelineStagesMap.put(NewstarSalesPipelineStage.EngagementStage.Name, NewstarSalesPipelineStage.EngagementStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.QuoteSelectionStage.Name, NewstarSalesPipelineStage.QuoteSelectionStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.ContractReadyStage.Name, NewstarSalesPipelineStage.ContractReadyStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.QuoteSelectionStage.Name, NewstarSalesPipelineStage.QuoteSelectionStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.LotReservationStage.Name, NewstarSalesPipelineStage.LotReservationStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.PendingOfferStage.Name, NewstarSalesPipelineStage.PendingOfferStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.UnderContractStage.Name, NewstarSalesPipelineStage.UnderContractStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.ClosedHomeStage.Name, NewstarSalesPipelineStage.ClosedHomeStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.CancelledStage.Name, NewstarSalesPipelineStage.CancelledStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.QuoteClosedStage.Name, NewstarSalesPipelineStage.QuoteClosedStage);
        pipelineStagesMap.put(NewstarSalesPipelineStage.LostStage.Name, NewstarSalesPipelineStage.LostStage);
        
       
    }

}