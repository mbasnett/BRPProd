import createQuote from '@salesforce/apex/NewstarQuoteController.createQuote';
import closeRejectedQuote from '@salesforce/apex/NewstarQuoteController.closeRejectedQuote';
import { EventHelper, OpportunityStageNames, SalesPipelineHelper } from 'c/lwcNewstarSharedServices';
import { api, LightningElement, track } from 'lwc';


export default class LwcNewstarQuote extends LightningElement {

    //current opportunity
    @api currentOpportunity;

    //flag indicating an action in progress
    @api actionInProgress;


    get opportunityId() {
        return this.currentOpportunity.Id;
    }


    get opportunityName() {
        return this.currentOpportunity.Name;
    }

    get stageName() {
        return this.currentOpportunity.StageName;
    }


    get isBeforeQuoteStage() {
        return SalesPipelineHelper.isOpportunityAvailableForQuote(this.currentOpportunity);
    }

    get isAtQuoteStage() {
        return SalesPipelineHelper.isOpportunityAtQuoteStage(this.currentOpportunity);
    }

    get isAfterQuoteStage() {
        return !this.isBeforeQuoteStage && !this.isAtQuoteStage;
    }

  
    handleQuoteCreation() {

        EventHelper.triggerActionStartedEvent(this);

        createQuote({
            opportunityId: this.opportunityId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Quote creation failed.", error);
            });
    }


    handleQuoteClosing() {

        EventHelper.triggerActionStartedEvent(this);

        closeRejectedQuote({
            opportunityId: this.opportunityId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Quote closing failed.", error);
            });
    }


}