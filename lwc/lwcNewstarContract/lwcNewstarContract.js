import { LightningElement, track, api, } from 'lwc';
import getOpportunity from '@salesforce/apex/NewstarContractController.getOpportunity';
import { SalesPipelineHelper, EventHelper, DataHelper, AuraWrapperActions, OpportunitySalesProcessTypes } from 'c/lwcNewstarSharedServices';


export default class LwcNewstarContract extends LightningElement {

    //ID of the opportunity for which the NEWSTAR contract is being managed
    @api recordId;

    //flag specifying if there's an action in Progress
    @track actionInProgress = true;

    @track actionInProgressMessage = 'Processing...';

    //error state info
    @track isInErrorState = false;

    @track errorFriendlyMessage = '';

    @track errors;

    //current opportunity
    @track currentOpportunity;


    //tracked vars for the opp details
    @track opportunityName;

    @track customerName;

    @track scenarioName;

    @track subdivisionName;

    @track lotNumber;

    @track modelName;

    @track stageName;

    @track modelPrice;

    @track lotPremium;

    @track totalSaleAmount;

    @track lotNumber;

    @track supportedContractFlows=[];

    @track currencyCode;


    get actionInProgressOrInErrorState() {
        return this.actionInProgress || this.isInErrorState;
    }

    get isInErrorStateAndNoActionInProgress() {
        return this.isInErrorState && !this.actionInProgress;
    }

    get isUsingDirectOffer() {
        return SalesPipelineHelper.isOpportunityUsingDirectOffer(this.currentOpportunity);
    }

    get isUsingLotReservation() {
        return SalesPipelineHelper.isOpportunityUsingLotReservation(this.currentOpportunity);
    }

    get isUsingDirectOfferAndContractInitiated() {
        return SalesPipelineHelper.isOpportunityUsingDirectOfferAndContractInitiated(this.currentOpportunity);
    }

    get isUsingLotReservationAndLotReserved() {
        return SalesPipelineHelper.isOpportunityUsingLotReservationAndLotReserved(this.currentOpportunity);
    }

    get isBeforeOrAtQuoteStage() {
        return SalesPipelineHelper.isOpportunityBeforeOrAtQuoteStage(this.currentOpportunity);
    }


    get isBeforeQuoteStage() {
        return SalesPipelineHelper.isOpportunityAvailableForQuote(this.currentOpportunity);
    }

    get isAtQuoteStage() {
        return SalesPipelineHelper.isOpportunityAtQuoteStage(this.currentOpportunity);
    }

    
    get activeSalesProcessType() {
        
        if(this.isBeforeQuoteStage) return "quote";

        return this.isUsingDirectOffer ? "direct-offer" : "lot-reservation";
    }

    get isDirectOfferFlowEnabled() {
        return this.supportedContractFlows.includes(OpportunitySalesProcessTypes.DirectOffer);
    }

    get isLotReservationFlowEnabled() {
        return this.supportedContractFlows.includes(OpportunitySalesProcessTypes.LotReservation);
    }

    

    //CTor
    constructor() {

        //super class CTor call required by LWC
        super();

        //ensure the component shows the progress loader during initial rendering
        this.setActionInProgress();
    }



    connectedCallback() {

        this.currencyCode=DataHelper.getUserCurrencyCode();

        getOpportunity({opportunityId: this.recordId})
            .then (data =>
                {
 
                //set the opportunity
                this.currentOpportunity = data;
    
                //and its details
                this.opportunityName = this.currentOpportunity.Name;
                this.subdivisionName = this.currentOpportunity.Subdivision__r.Name;
                this.modelName = this.currentOpportunity.Model__r.Name;
                this.lotNumber = this.currentOpportunity.Lot__r.Name;
                this.customerName=this.currentOpportunity.Account.Name;
                this.scenarioName = this.currentOpportunity.Scenario_Name__c;
    
                //financials
                this.lotPremium = this.currentOpportunity.Lot_Premium__c;
                this.modelPrice=this.currentOpportunity.Base_Model_Price__c;
                this.totalSaleAmount=this.currentOpportunity.Total_Sale_Amount__c;

                //supported contract flows
                this.supportedContractFlows=this.currentOpportunity.Sales_Office__r.Supported_Contract_Flows__c.split(';');
                
               
                //set action state as completed
                this.setActionCompleted();
    
            })
        .catch(error => {
              
                //if error occurred during opportunity fetch, ensure that the action shows as completed
                this.setActionCompleted();
    
                //and set the error state for the component
                this.setErrorStateInfo('', error);
    
            
    
        });
        
    }

   

    //handles the event sent by child components indicating that a certain long-running action has started
    handleChildComponentActionStarted(event) {
        //render loader
        this.setActionInProgress(event.detail.message);
    }


    //handles the event sent by child components indicating that a certain long-running action has completed
    //successfully
    handleChildComponentActionCompleted(event) {

        //un-render loader
        this.setActionCompleted();

        //use Aura interop to trigger a set of platform events not yet fully supported
        //by LWC: show success toast, close quick action and refresh opp view
        EventHelper.triggerAuraInteropActionCompletedEvent(this, event.detail.message, 
            'Manage NEWSTAR Contract',
            [
                AuraWrapperActions.ShowSuccessToast,
                AuraWrapperActions.CloseQuickAction,
                AuraWrapperActions.RefreshView
            ]);
    }


    //handles the event sent by child components indicating that a certain long-running action has 
    //encountered an error
    handleChildComponentActionError(event) {

        //un-render loader
        this.setActionCompleted();

        //set component-wide error state
        this.setErrorStateInfo(event.detail.message, event.detail.errors);
    }


    //helper: sets action in progress state (render the loader)
    setActionInProgress(actionMessage) {
        this.actionInProgress = true;
        this.actionInProgressMessage = actionMessage;
    }


    //helper: sets action complete state (un-renders the loader)
    setActionCompleted() {
        this.actionInProgress = false;
        this.actionInProgressMessage = '';
    }


    //helper: sets error state (renders special error panel)
    setErrorStateInfo(friendlyMessage, errorData) {
        this.isInErrorState = true;
        this.errorFriendlyMessage = friendlyMessage;
        this.errors = errorData;
    }

    //helper: resets error state (un-renders special error panel)
    resetErrorState() {
        this.isInErrorState = false;
        this.errors = null;
        this.errorFriendlyMessage = '';
    }

}