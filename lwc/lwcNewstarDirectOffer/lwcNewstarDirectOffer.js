import initiateContract from '@salesforce/apex/NewstarContractController.initiateContract';
import convertQuoteToDirectOffer from '@salesforce/apex/NewstarQuoteController.convertQuoteToDirectOffer';
import cancelContractInitiation from '@salesforce/apex/NewstarContractController.cancelContractInitiation';

import { EventHelper, OpportunityStageNames, SalesPipelineHelper } from 'c/lwcNewstarSharedServices';
import { api, LightningElement, track } from 'lwc';

export default class LwcNewstarDirectOffer extends LightningElement {

    //current opportunity
    @api currentOpportunity;

    //action flag
    @api actionInProgress;

    //track
    @track targetClosingDate = new Date('1980-01-01T00:00:00');


    get opportunityId() {
        return this.currentOpportunity.Id;
    }

    get opportunityName() {
        return this.currentOpportunity.Name;
    }

    get stageName() {
        return this.currentOpportunity.StageName;
    }

    get isAvailableForContract() {
        return SalesPipelineHelper.isOpportunityAvailableForDirectOffer(this.currentOpportunity);
    }

    get isInPreContract() {
        return this.stageName === OpportunityStageNames.ContractReady;
    }

    get quoteExists() {
        return  this.stageName === OpportunityStageNames.QuoteSelection;
    }

    get contractInitiationEnabled() {
        return true;
    }

    get contractInitiationDisabled(){
        return !this.contractInitiationEnabled;
    }

    get todaysDate() {
        let today=new Date();
        today.setHours(0,0,0,0);
        return today;
    }


    handleTargetClosingDateChange(event) {
        this.targetClosingDate = new Date(event.target.value);
        this.targetClosingDate.setHours(0,0,0,0);
    }

   
    handleContractInitiation() {

        EventHelper.triggerActionStartedEvent(this);

        initiateContract({
            opportunityId: this.opportunityId,
            targetClosingDate: this.targetClosingDate
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Contract initiation failed.", error);
            });
    }


    handleQuoteToDirectOfferConversion() {

        EventHelper.triggerActionStartedEvent(this);

        convertQuoteToDirectOffer({
            opportunityId: this.opportunityId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Contract initiation failed.", error);
            });
    }


    handleContractInitiationCancellation() {

        EventHelper.triggerActionStartedEvent(this);

        cancelContractInitiation({
            opportunityId: this.opportunityId,
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Contract initiation cancellation failed.", error);
            });
    }

}