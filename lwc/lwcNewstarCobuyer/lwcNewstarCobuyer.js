import { track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import LwcBaseActionDialog from 'c/lwcBaseActionDialog';
import { EventHelper } from 'c/lwcNewstarSharedServices';
import syncCobuyer from '@salesforce/apex/NewstarCustomerInfoController.syncCobuyer';
import componentTemplate from './lwcNewstarCobuyer.html';


/*
    List of fields fetched through the wire adapter for the custom object
    that represents the Cobuyer.
*/
const COBUYER_FIELDS = [
    'Cobuyer__c.Id',
    'Cobuyer__c.Name',
    'Cobuyer__c.Newstar_ID__c',
    'Cobuyer__c.Opportunity__r.Newstar_ID__c'
];


export default class LwcNewstarCobuyer extends LwcBaseActionDialog {

    @track currentCobuyer;

    @track cobuyerName;

    @track newstarId;

    @track cobuyerId;

    @track parentOpportunityNewstarId;

    interopActionCompletedEventMessageTitle='Manage NEWSTAR Cobuyer';

    actualComponentTemplate=componentTemplate;


    get isAlreadyInNewstar() {
        return this.newstarId !== undefined && this.newstarId != null;
    }

    get isParentOpportunityInNewstar() {
        return this.parentOpportunityNewstarId !== undefined && this.parentOpportunityNewstarId != null;
    }


    @wire(getRecord, { recordId: '$recordId', fields: COBUYER_FIELDS })
    wiredRecord({ error, data }) {

        //check for record fetch errors
        if (error) {
            //if error occurred during opportunity fetch, ensure that the action shows as completed
            this.setActionCompleted();

            //and set the error state for the component
            this.setErrorStateInfo('Unable to fetch cobuyer data.', error);

        } else if (data) {

            //set the cobuyer
            this.currentCobuyer = data;

            //and its details
            this.cobuyerId = this.currentCobuyer.fields.Id.value;
            this.cobuyerName = this.currentCobuyer.fields.Name.value;
            this.newstarId = this.currentCobuyer.fields.Newstar_ID__c.value;
            this.parentOpportunityNewstarId=this.currentCobuyer.fields.Opportunity__r.value.fields.Newstar_ID__c.value;
          
            //set action state as completed
            this.setActionCompleted();

            //validate the state of the cobuyer record for NEWSTAR sync operations
            this.validateCobuyerRequiredFields();

        }
    }


    //
    validateCobuyerRequiredFields() {

        if (!this.isParentOpportunityInNewstar) {
            //set error state with the appropriate message
            this.setErrorStateInfo("This cobuyer record cannot be synced to NEWSTAR as it belongs to an Opportunity that has not been sent to NEWSTAR yet as a lot reservation or contract.");
        }
    }


    handleNewstarSync() {

        EventHelper.triggerActionStartedEvent(this);

        syncCobuyer({
            cobuyerId: this.cobuyerId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "NEWSTAR cobuyer sync failed.", error);
            });
    }

}