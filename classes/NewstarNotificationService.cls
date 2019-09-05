public class NewstarNotificationService {
    

    /*
        Processes an incoming event notification from NEWSTAR

        notification - Inbound notification event
    */
    public static NewstarNotificationResult processNotification(NewstarNotification notification) {

        //construct the result
        NewstarNotificationResult result=new NewstarNotificationResult();
        result.IsSuccess=true;
        
        if(notification.EventType == NewstarNotificationEvent.UndoContractReadyEvent.Name) {
               return processUndoContractReady(notification, result);
        }
        else if(notification.EventType == NewstarNotificationEvent.PendingOfferEvent.Name) {
               return processPendingOffer(notification, result);
        }
        else if(notification.EventType == NewstarNotificationEvent.UndoPendingOfferEvent.Name) {
               return processUndoPendingOffer(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.UnderContractEvent.Name) {
               return processUnderContract(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ClosedEvent.Name) {
               return processClosed(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.CancelledEvent.Name) {
               return processCancelled(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.ContingencyCreatedEvent.Name) {
               return processContingencyCreated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ContingencyUpdatedEvent.Name) {
               return processContingencyUpdated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ContingencyDeletedEvent.Name) {
               return processContingencyDeleted(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.ReservationExpiredEvent.Name) {
               return processReservationExpired(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.FinancialInfoUpdatedEvent.Name) {
               return processFinancialInfoUpdated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.InvestmentPropertyUpdatedEvent.Name) {
               return processInvestmentPropertyUpdated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ClosingDateUpdatedEvent.Name) {
               return processClosingDateUpdated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.SwingUpdatedEvent.Name) {
               return processSwingUpdated(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.DealNotesUpdatedEvent.Name) {
               return processDealNotesUpdated(notification, result);
        }  
        else if (notification.EventType == NewstarNotificationEvent.DealStipulationUpdatedEvent.Name) {
            return processDealStipulationUpdated(notification, result);
        }     
        else {
               result.IsSuccess=false;
               result.Message='Unsupported event type: '+notification.EventType;
           }
       

        return result;
    }


    private static NewstarNotificationResult processUndoContractReady(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.QuoteSelectionStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;

        Lot__c lot = getLotFromOpportunity(opp);
        if(lot==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate lot__c with the specified external ID.';
           return result;
        }


        lot.Status__c = 'Open';

        update lot;

        //return the result       
        return result;
    }


    private static NewstarNotificationResult processPendingOffer(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.PendingOfferStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Opportunity updated to Pending Offer');

        Lot__c lot = getLotFromOpportunity(opp);
        if(lot==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate lot__c with the specified external ID.';
           return result;
        }

        lot.Status__c = 'Sold';

        update lot;

        //return the result       
        return result;
    }


    private static NewstarNotificationResult processUndoPendingOffer(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }


        Id directOfferRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Direct_offer').getRecordTypeId(); 
       
        //attempt to set the requested opportunity stage    -- Contract Ready in NSS
        if (opp.RecordTypeId==directOfferRecordTypeId) { 
            setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.ContractReadyStage.Name);
        }
        else {
            setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.QuoteSelectionStage.Name);
        }


        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Opportunity updated to Quote');

        Lot__c lot = getLotFromOpportunity(opp);
        if(lot==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate lot__c with the specified external ID.';
           return result;
        }

        lot.Status__c = 'Open';

        update lot;

        //return the result       
        return result;
    }


    private static NewstarNotificationResult processUnderContract(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.UnderContractStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        // 2019.07.06 - Close other Quotes when the Won Quote set to Pending Offer
        List<Opportunity> opportunitiesToAutoClose=processQuoteAutoClosings(opp);
        
        //commit opp update, customer junction upsert
        SavePoint sp = Database.setSavePoint();

        try {
            //update the opportunity
            update opp;

            //update any other opportunities that need to be auto closed
            // 2019.07.06 - Do not close other Quotes until the Won Quote is Pending Offer
            Database.update(opportunitiesToAutoClose);
        }
        catch(Exception e){

            Database.rollback(sp);

            result.IsSuccess=false;
            result.Message='Error committing process Under Contract.' + e.getMessage();
            return result;
        }


        Lot__c lot = getLotFromOpportunity(opp);
        if(lot==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate lot__c with the specified external ID.';
           return result;
        }

        lot.Status__c = 'Sold';

        update lot;
        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Opportunity updated to Under Contract');


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processClosed(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.ClosedHomeStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);
        
        //update opportunity
        update opp;

        Lot__c lot = getLotFromOpportunity(opp);
        if(lot==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate lot__c with the specified external ID.';
           return result;
        }

        lot.Status__c = 'Closed';

        update lot;
        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Opportunity updated to Closed Home');


        //return the result       
        return result;
    }    


     private static NewstarNotificationResult processCancelled(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.CancelledStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;

        Lot__c lot = getLotFromOpportunity(opp);
        if(lot==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate lot__c with the specified external ID.';
           return result;
        }

        lot.Status__c = 'Open';

        update lot;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Opportunity updated to Cancelled');


        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processFinancialInfoUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;


        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Opportunity financial details updated');


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processContingencyCreated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }


        //get the contingency based on the notification
        Contigency__c con = new Contigency__c(Opportunity__c = opp.Id);

        //set deal Contingency returned from NEWSTAR
        setContingencyFromNewstar(notification, con);

        //insert contingency
        insert con;
       
        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Contract contingency was added');

        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processContingencyUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }


        //get the contingency based on the notification
        Contigency__c con=getContingencyFromNotification(notification);
       
       //if the con cannot be found, terminate further processing
       if(con==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate contingency with the specified external ID.';
           return result;
       }

        //set deal Contingency returned from NEWSTAR
        setContingencyFromNewstar(notification, con);

        //update contingency
        update con;


        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Contract contingency was updated');



        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processContingencyDeleted(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }


        //get the contingency based on the notification
        Contigency__c con=getContingencyFromNotification(notification);
       
       //if the con cannot be found, terminate further processing
       if(con==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate contingency with the specified external ID.';
           return result;
       }

        //delete contingency
        delete con;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Contract contingency was deleted');


        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processReservationExpired(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.EngagementStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //reset the Lot_Hold_Expiry_Date__c to NULL
        setOpportunityLotHoldExpiryDateToNull(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Lot reservation has expired');

        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processInvestmentPropertyUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        setOpportunityInvestmentFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Investment Property was updated');

        //return the result       
        return result;
    }


    private static NewstarNotificationResult processClosingDateUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        setOpportunityClosingDateFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Closing Date was updated');

        //return the result       
        return result;
    }


    private static NewstarNotificationResult processSwingUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        setOpportunitySwingFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Swing was updated');


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processDealNotesUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        setOpportunityDealNotesFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Deal notes info was updated');


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processDealStipulationUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        setOpportunityDealStipulationFromNewstar(notification, opp);

        //update opportunity
        update opp;

        //publish the notification event to event bus
        NewstarPushNotificationsService.publishNewstarNotificationEvent(opp.Id, 'Deal stipulation info was updated');


        //return the result       
        return result;
    }


    /*
        Attempts to set the opportunity stage based on a NEWSTAR notification.
    */
    private static void setOpportunityStage(NewstarNotification notification, Opportunity opp, NewstarNotificationResult result, String transactionStageName) {
        
        //setup the pipeline transition to validate if setting the requested stage is possible
        NewstarSalesPipelineStageTransition stageTransition=new NewstarSalesPipelineStageTransition();
        stageTransition.SourceStageName=opp.StageName;

        //target stage name is specified in the notification object
        stageTransition.TargetStageName=transactionStageName;       


        //mark the transition is automatic to prevent manual transition blocks in validation rules/triggers
        stageTransition.IsAutomated=true;

        //validate the transition
        NewstarSalesPipelineService.ValidateStageTransition(stageTransition);

        //if it is not valid, terminate further processing and return an error
        if(!stageTransition.IsValid)
        {
            result.IsSuccess=false;
            result.Message='Unable to set the requested opportunity to stage: '+stageTransition.TargetStageName+': '+stageTransition.ValidationMessage;
            return;
        }

        //set target stage and flag indicating automatic stage update
        opp.StageName=stageTransition.TargetStageName;
        opp.IsAutomatedStageUpdate__c=true;

    }


    /*
        Sets Lot Hold Expiry Date in the opportunity to Null.
    */
    private static void setOpportunityLotHoldExpiryDateToNull(NewstarNotification notification, Opportunity opp) {
        opp.Lot_Hold_Expiry_Date__c = null;
    }


    /*
        Sets key financial amounts on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunityFinancialInfoFromNewstar(NewstarNotification notification, Opportunity opp) {
        

        NewstarDealFinancialInfo financialInfo=new NewstarDealFinancialInfo();
        
        NewstarNotificationParameter baseModelPriceParam=notification.getParameter('BaseModelPrice');
        NewstarNotificationParameter lotPriceParam=notification.getParameter('LotPrice');
        NewstarNotificationParameter lotPremiumParam=notification.getParameter('LotPremium');
        NewstarNotificationParameter totalOptionsAmountParam=notification.getParameter('TotalOptionsAmount');
        NewstarNotificationParameter totalDiscountAmountParam=notification.getParameter('TotalDiscountAmount');
        NewstarNotificationParameter totalTaxAmountParam=notification.getParameter('TotalTaxAmount');
        NewstarNotificationParameter totalTaxRebateAmountParam=notification.getParameter('TotalTaxRebateAmount');
        NewstarNotificationParameter totalMortgageIncentiveParam=notification.getParameter('TotalMortgageIncentive');
        NewstarNotificationParameter totalMortgageIncentiveIncludedParam=notification.getParameter('TotalMortgageIncentiveIncluded');
        NewstarNotificationParameter totalActualSaleAmountParam=notification.getParameter('TotalSaleAmount');
        NewstarNotificationParameter totalProjectedOptionsAmountParam=notification.getParameter('TotalProjectedOptionsAmount');
        NewstarNotificationParameter totalProjectedDiscountAmountParam=notification.getParameter('TotalProjectedDiscountAmount');
        NewstarNotificationParameter totalProjectedTaxAmountParam=notification.getParameter('TotalProjectedTaxAmount');
        NewstarNotificationParameter totalProjectedTaxRebateAmountParam=notification.getParameter('TotalProjectedTaxRebateAmount');
        NewstarNotificationParameter totalProjectedMortgageIncentiveParam=notification.getParameter('TotalProjectedMortgageIncentive');
        NewstarNotificationParameter totalProjectedMortgageIncentiveIncludedParam=notification.getParameter('TotalProjectedMortgageIncentiveIncluded');
        NewstarNotificationParameter totalProjectedSaleAmountParam=notification.getParameter('TotalProjectedSaleAmount');
        NewstarNotificationParameter totalScheduledDepositParam=notification.getParameter('TotalScheduledDeposit');
        NewstarNotificationParameter totalReceivedDepositParam=notification.getParameter('TotalReceivedDeposit');
        NewstarNotificationParameter totalDepositDueParam=notification.getParameter('TotalDepositDue');
        
        
        if(baseModelPriceParam!=null){
            financialInfo.BaseModelPrice=NewstarDataConversionHelper.decimalFromString(baseModelPriceParam.Value);
        }

         if(lotPriceParam!=null){
            financialInfo.LotPrice=NewstarDataConversionHelper.decimalFromString(lotPriceParam.Value);
        }

         if(lotPremiumParam!=null){
            financialInfo.LotPremium=NewstarDataConversionHelper.decimalFromString(lotPremiumParam.Value);
        }

        if(totalOptionsAmountParam!=null){
            financialInfo.TotalOptionsAmount=NewstarDataConversionHelper.decimalFromString(totalOptionsAmountParam.Value);
        }

        if(totalDiscountAmountParam!=null){
            financialInfo.TotalDiscountAmount=NewstarDataConversionHelper.decimalFromString(totalDiscountAmountParam.Value);
        }

        
        if(totalTaxAmountParam!=null){
            financialInfo.TotalTaxAmount=NewstarDataConversionHelper.decimalFromString(totalTaxAmountParam.Value);
        }
        
        if(totalTaxRebateAmountParam!=null){
            financialInfo.TotalTaxRebateAmount=NewstarDataConversionHelper.decimalFromString(totalTaxRebateAmountParam.Value);
        }

        if(totalMortgageIncentiveParam!=null){
            financialInfo.TotalMortgageIncentive=NewstarDataConversionHelper.decimalFromString(totalMortgageIncentiveParam.Value);
        }

        if(totalMortgageIncentiveIncludedParam!=null){
            financialInfo.TotalMortgageIncentiveIncluded=NewstarDataConversionHelper.booleanFromString(totalMortgageIncentiveIncludedParam.Value);
        }

        if(totalActualSaleAmountParam!=null){
            financialInfo.TotalActualSaleAmount=NewstarDataConversionHelper.decimalFromString(totalActualSaleAmountParam.Value);
        }

        if(totalProjectedOptionsAmountParam!=null){
            financialInfo.TotalProjectedOptionsAmount=NewstarDataConversionHelper.decimalFromString(totalProjectedOptionsAmountParam.Value);
        }

        if(totalProjectedDiscountAmountParam!=null){
            financialInfo.TotalProjectedDiscountAmount=NewstarDataConversionHelper.decimalFromString(totalProjectedDiscountAmountParam.Value);
        }
        
        if(totalProjectedTaxAmountParam!=null){
            financialInfo.TotalProjectedTaxAmount=NewstarDataConversionHelper.decimalFromString(totalProjectedTaxAmountParam.Value);
        }
        
        if(totalProjectedTaxRebateAmountParam!=null){
            financialInfo.TotalProjectedTaxRebateAmount=NewstarDataConversionHelper.decimalFromString(totalProjectedTaxRebateAmountParam.Value);
        }

        if(totalProjectedMortgageIncentiveParam!=null){
            financialInfo.TotalProjectedMortgageIncentive=NewstarDataConversionHelper.decimalFromString(totalProjectedMortgageIncentiveParam.Value);
        }

        if(totalProjectedMortgageIncentiveIncludedParam!=null){
            financialInfo.TotalProjectedMortgageIncentiveIncluded=NewstarDataConversionHelper.booleanFromString(totalProjectedMortgageIncentiveIncludedParam.Value);
        }

        if(totalProjectedSaleAmountParam!=null){
            financialInfo.TotalProjectedSaleAmount=NewstarDataConversionHelper.decimalFromString(totalProjectedSaleAmountParam.Value);
        }

        if(totalScheduledDepositParam!=null){
            financialInfo.TotalScheduledDeposit=NewstarDataConversionHelper.decimalFromString(totalScheduledDepositParam.Value);
        }

        if(totalReceivedDepositParam!=null){
            financialInfo.TotalReceivedDeposit=NewstarDataConversionHelper.decimalFromString(totalReceivedDepositParam.Value);
        }

        if(totalDepositDueParam!=null){
            financialInfo.TotalDepositDue=NewstarDataConversionHelper.decimalFromString(totalDepositDueParam.Value);
        }


        //delegate actual update of the opportunity amounts to a separate service
        NewstarOpporunityInfoService.setOpportunityAmounts(opp, financialInfo);
    }


    /*
        Looks up the opportunity object based on the information supplied in a NEWSTAR notification.
    */
    private static Opportunity getOpportunityFromNotification(NewstarNotification notification) {
    
        //obtain the external ID parameter value
        NewstarNotificationParameter opportunityExternalId=notification.getParameter('opportunityExternalId');

        //if not available, return immediately
        if(opportunityExternalId==null){
            return null;
        }


        //lookup the opportunity
        List<Opportunity> oppList=[SELECT Id, StageName, Base_Model_Price__c, Lot_Price__c, Lot_Premium__c, Total_Options_Amount__c, 
                                    Total_Discount_Amount__c, Total_Tax_Amount__c, Total_Tax_Rebate_Amount__c, Total_Projected_Options_Amount__c, 
                                    Total_Projected_Discount_Amount__c, Total_Projected_Tax_Amount__c, Total_Projected_Tax_Rebate_Amount__c, 
                                    Total_Actual_Sale_Amount__c, Lot_Hold_Expiry_Date__c, RecordTypeId, Lot__r.Status__c, Investment__c, 
                                    Actual_Closing_Date__c, Target_Closing_Date__c, Revised_Closing_Date__c, Home_Swing__c, AccountId, Lot__c,
                                    Total_Scheduled_Deposit__c, Total_Received_Deposit__c, Total_Deposit_Due__c
                                    FROM Opportunity WHERE Newstar_ID__c=: opportunityExternalId.Value LIMIT 1];
        if(oppList.size()==0) {
                return null;
        }

        //return it
        return oppList.get(0);
    }


    /*
        Looks up the lot object based on the information supplied in a NEWSTAR notification.
    */
    private static Lot__c getLotFromOpportunity(Opportunity opp) {
    
        if(opp.Lot__r.Id==null){
            return null;
        }

        //lookup the Lot__c
        List<Lot__c> lotList=[SELECT Name, Status__c FROM Lot__c WHERE Id=: opp.Lot__r.Id LIMIT 1];
        if(lotList.size()==0) {
                return null;
        }

        //return it
        return lotList.get(0);
    }


    /*
        Looks up the contingency object based on the information supplied in a NEWSTAR notification.
    */
    private static Contigency__c getContingencyFromNotification(NewstarNotification notification) {
    
        //obtain the external ID parameter value
        NewstarNotificationParameter contingencyExternalId=notification.getParameter('contingencyExternalId');

        //if not available, return immediately
        if(contingencyExternalId==null){
            return null;
        }


        //lookup the contingency
        List<Contigency__c> conList=[SELECT Id,Type__c,Expiry_date__c,Met_date__c,Notes__c,Newstar_ID__c,Opportunity__c FROM Contigency__c WHERE Newstar_ID__c=: contingencyExternalId.Value LIMIT 1];
        if(conList.size()==0) {
                return null;
        }

        //return it
        return conList.get(0);
    }

    /*
        Sets contingency info on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setContingencyFromNewstar(NewstarNotification notification, Contigency__c con) {
        

        NewstarContingencyInfo contingencyInfo=new NewstarContingencyInfo();

        NewstarNotificationParameter contingencyExternalIdParam=notification.getParameter('ContingencyExternalId');
        NewstarNotificationParameter typeParam=notification.getParameter('Type');
        NewstarNotificationParameter expiryDateParam=notification.getParameter('ExpiryDate');
        NewstarNotificationParameter metDateParam=notification.getParameter('MetDate');
        NewstarNotificationParameter notesParam=notification.getParameter('Notes');

        
        if(contingencyExternalIdParam!=null){
            contingencyInfo.ContingencyExternalId=contingencyExternalIdParam.Value;
        }
        
        if(typeParam!=null){
            contingencyInfo.Type=typeParam.Value;
        }

        if(expiryDateParam!=null){
            contingencyInfo.ExpiryDate=NewstarDataConversionHelper.dateFromString(expiryDateParam.Value);
        }

        if(metDateParam!=null){
            if (metDateParam.Value.startsWith('1900'))
            {
                contingencyInfo.MetDate = null;
            }
            else {
                contingencyInfo.MetDate=NewstarDataConversionHelper.dateFromString(metDateParam.Value);
            }
        }

        if(notesParam!=null){
            contingencyInfo.Notes=notesParam.Value;
        }

        //delegate actual update of the contingency to a separate service
        NewstarContingencyService.setContingency(con, contingencyInfo);

    }


    /*
        Sets investment on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunityInvestmentFromNewstar(NewstarNotification notification, Opportunity opp) {
        
        NewstarNotificationParameter investmentParam=notification.getParameter('Investment');
        
        if(investmentParam!=null){
            opp.Investment__c = NewstarDataConversionHelper.booleanFromString(investmentParam.Value);
        }

    }


    /*
        Sets Closing Date on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunityClosingDateFromNewstar(NewstarNotification notification, Opportunity opp) {
        
        NewstarNotificationParameter actualClosingDateParam=notification.getParameter('ActualClosingDate');
        NewstarNotificationParameter targetClosingDateParam=notification.getParameter('TargetClosingDate');
        
        if(actualClosingDateParam!=null){
            if (actualClosingDateParam.Value.startsWith('1900'))
            {
                opp.Actual_Closing_Date__c = null;
            }
            else {
                opp.Actual_Closing_Date__c = NewstarDataConversionHelper.dateFromString(actualClosingDateParam.Value);
            }
        }

        if(targetClosingDateParam!=null){
            if (targetClosingDateParam.Value.startsWith('1900')) {
                // Do Nothing
            }
            else {
                if (opp.Target_Closing_Date__c!=null) {
                    opp.Revised_Closing_Date__c = NewstarDataConversionHelper.dateFromString(targetClosingDateParam.Value);    
                }     
                else {
                    opp.Target_Closing_Date__c = NewstarDataConversionHelper.dateFromString(targetClosingDateParam.Value);
                }
            }
        }

    }


    /*
        Sets Closing Date on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunitySwingFromNewstar(NewstarNotification notification, Opportunity opp) {
        
        NewstarNotificationParameter swingParam=notification.getParameter('Swing');
        
        if(swingParam!=null){
            if (swingParam.Value=='L') {
                opp.Home_Swing__c = 'Left';
            }
            else if (swingParam.Value=='R') {
                opp.Home_Swing__c = 'Right';
            }
        }

    }


    
    /*
        Sets deal notes on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunityDealNotesFromNewstar(NewstarNotification notification, Opportunity opp) {
        
        NewstarNotificationParameter dealNotesParam=notification.getParameter('dealNotes');
        
        if(dealNotesParam!=null){
            opp.Deal_Notes__c=dealNotesParam.Value;
        }

    }


    /*
        Sets deal stipulation on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunityDealStipulationFromNewstar(NewstarNotification notification, Opportunity opp) {
        
        NewstarNotificationParameter dealStipulationParam=notification.getParameter('dealStipulation');
        
        if(dealStipulationParam!=null){
            opp.Deal_Stipulations__c=dealStipulationParam.Value;
        }

    }



    private static List<Opportunity> processQuoteAutoClosings(Opportunity winningOpp) {

        //setup list of stages names that should be used to filter the opportunities to move to Quote Closed stage
        List<String> stagesToAutoClose=new List<String>();

        stagesToAutoClose.add(NewstarSalesPipelineStage.ProspectingStage.Name);
        stagesToAutoClose.add(NewstarSalesPipelineStage.EngagementStage.Name);
        stagesToAutoClose.add(NewstarSalesPipelineStage.QuoteSelectionStage.Name);

        //get all opportunities of the same customer that are in the above stages
        //and belong to the SAME LOT
        //exclude the supplied opportunity itself        
        List<Opportunity> opportunitiesToAutoClose=[
                SELECT
                    Id,
                    Name,
                    StageName,
                    Newstar_ID__c
                FROM
                    Opportunity
                WHERE
                    Id!=:winningOpp.Id
                    AND
                    AccountId=:winningOpp.AccountId
                    AND
                    Lot__c=:winningOpp.Lot__c
                    AND
                    StageName IN :stagesToAutoClose

        ];


        if(opportunitiesToAutoClose.size()>0){
            for (Opportunity opportunityToAutoClose : opportunitiesToAutoClose) {
                
                //move the opportunity to Quote Closed
                opportunityToAutoClose.StageName=NewstarSalesPipelineStage.QuoteClosedStage.Name;
                opportunityToAutoClose.IsAutomatedStageUpdate__c=true;
            }
        }

        return opportunitiesToAutoClose;

    }

}