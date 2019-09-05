import reserveLot from '@salesforce/apex/NewstarLotReservationController.reserveLot';
import convertQuoteToLotReservation from '@salesforce/apex/NewstarQuoteController.convertQuoteToLotReservation';
import unreserveLot from '@salesforce/apex/NewstarLotReservationController.unreserveLot';
import { EventHelper, OpportunityStageNames, SalesPipelineHelper } from 'c/lwcNewstarSharedServices';
import { api, LightningElement, track } from 'lwc';



export default class LwcNewstarLotReservation extends LightningElement {

    //current opportunity
    @api currentOpportunity;

    //flag indicating an action in progress
    @api actionInProgress;

    //current reservation expieration date calculated based on the expiration period
    @track currentReservationExpirationDate;

    //flag indicating the hold period is selected
    @track currentHoldPeriodSelected=false;

    //currently selected lot hold period used to calc the reservation date
    @track currentHoldPeriodInDays = 0;


    get opportunityId() {
        return this.currentOpportunity.Id;
    }


    get opportunityName() {
        return this.currentOpportunity.Name;
    }

    get stageName() {
        return this.currentOpportunity.StageName;
    }

    get lotHoldExpiryDate() {
        return this.currentOpportunity.Lot_Hold_Expiry_Date__c;
    }

   
    get isAvailableForReservation() {
        return SalesPipelineHelper.isOpportunityAvailableForLotReservation(this.currentOpportunity);
    }

    get lotReservationExists() {
        return this.stageName === OpportunityStageNames.LotReservation;
    }

    get quoteExists() {
        return  this.stageName === OpportunityStageNames.QuoteSelection;
    }

    get reservationActionEnabled() {
        return this.currentHoldPeriodInDays>0;
    }

    get reservationActionDisabled() {
        return !this.reservationActionEnabled;
    }

    //TODO: move to separate service/module or pull-in as a custom object
    get holdPeriodOptions() {
        return [
            { label: '3 days', value: 3 },
            { label: 'week', value: 7 },
            { label: 'two weeks', value: 14 },
        ];
    }


    //hanlde the lot hold period change
    handleHoldPeriodChange(event) {
        this.currentHoldPeriodInDays = event.detail.value;
       

        this.currentReservationExpirationDate=new Date();
        
        let todayDate = new Date();
        this.currentReservationExpirationDate.setDate(todayDate.getDate() + parseInt(this.currentHoldPeriodInDays));
        
        this.currentHoldPeriodSelected=true;
    }


    handleLotReservation() {

        EventHelper.triggerActionStartedEvent(this);

        reserveLot({
            opportunityId: this.opportunityId,
            holdPeriodInDays: this.currentHoldPeriodInDays
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Lot reservation failed.", error);
            });
    }


    handleQuoteToLotReservationConversion() {

        EventHelper.triggerActionStartedEvent(this);

        convertQuoteToLotReservation({
            opportunityId: this.opportunityId,
            holdPeriodInDays: this.currentHoldPeriodInDays
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Lot reservation failed.", error);
            });
    }


    handleLotUnreservation() {

        EventHelper.triggerActionStartedEvent(this);
        
        unreserveLot({
            opportunityId: this.opportunityId,
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Lot unreservation failed.", error);
            });
    }





}