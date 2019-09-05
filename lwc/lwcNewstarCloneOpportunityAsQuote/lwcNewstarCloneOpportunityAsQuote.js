import { track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import LwcBaseActionDialog from 'c/lwcBaseActionDialog';
import { EventHelper, SalesPipelineHelper } from 'c/lwcNewstarSharedServices';
import createNewQuoteFromOpportunity from '@salesforce/apex/NewstarQuoteController.createNewQuoteFromOpportunity';
import componentTemplate from './lwcNewstarCloneOpportunityAsQuote.html';



const OPP_FIELDS=[
'Opportunity.Name',

'Opportunity.Subdivision__c',
'Opportunity.Subdivision__r.Name',

'Opportunity.Lot__c',
'Opportunity.Lot__r.Name',

'Opportunity.Lot_Premium__c',
'Opportunity.Lot_Price__c',

'Opportunity.Model__c',
'Opportunity.Model__r.Name',
'Opportunity.Base_Model_Price__c',

'Opportunity.StageName',

'Opportunity.Lot_Hold_Expiry_Date__c',

'Opportunity.Total_Sale_Amount__c',

'Opportunity.Sales_Agent_Sales_Office_Relationship__c'
];



export default class lwcNewstarCloneOpportunityAsQuote extends NavigationMixin(LwcBaseActionDialog) {

    @track currentOpportunity;

    @track opportunityName;

    @track scenarioName;

    @track stageName;

    interopActionCompletedEventMessageTitle='Create New Quote Opportunity';

    actualComponentTemplate=componentTemplate;


    get isCloningDisabled() {
        return this.scenarioName===undefined || this.scenarioName==='';
    }

    get isAvailableForCloning() {
        return SalesPipelineHelper.isOpportunityAvailableForQuoteCloning(this.currentOpportunity);
    }


    @wire(getRecord, { recordId: '$recordId', fields: OPP_FIELDS })
    wiredRecord({ error, data }) {

        //check for record fetch errors
        if (error) {
            //if error occurred during opportunity fetch, ensure that the action shows as completed
            this.setActionCompleted();

            //and set the error state for the component
            this.setErrorStateInfo('Unable to fetch opportunity data.', error);

        } else if (data) {

            //set the opportunity
            this.currentOpportunity = data;

            //and its details
            this.opportunityName = this.currentOpportunity.fields.Name.value;
            this.stageName= this.currentOpportunity.fields.StageName.value;
        
            //set action state as completed
            this.setActionCompleted();

       
        }
    }


    handleScenarioNameChange(event) {
        this.scenarioName=event.target.value;
    }
  

    handleClone() {

        EventHelper.triggerActionStartedEvent(this);

        createNewQuoteFromOpportunity({
            opportunityId: this.recordId,
            scenarioName: this.scenarioName
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
                this.navigateToClonedOpportunity(result.ClonedOpportunityId);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "New quote opportunity creation failed.", error);
            });
    }


    navigateToClonedOpportunity(clonedOpportunityId) {

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: clonedOpportunityId,
                objectApiName: 'Opportunity',
                actionName: 'view'
            },
        });
    }

}