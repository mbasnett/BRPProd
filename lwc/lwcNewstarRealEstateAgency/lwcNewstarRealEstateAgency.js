import { track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import LwcBaseActionDialog from 'c/lwcBaseActionDialog';
import { EventHelper } from 'c/lwcNewstarSharedServices';
import syncAgency from '@salesforce/apex/NewstarRealEstateAgencyController.syncAgency';
import componentTemplate from './lwcNewstarRealEstateAgency.html';

/*
    List of fields fetched through the wire adapter for the Account object
    that represents the Real Estage Agency.
*/
const REAL_ESTATE_AGENCY_FIELDS = [
    'Account.Id',
    'Account.Name',
    'Account.Newstar_ID__c'
];


export default class LwcNewstarRealEstateAgency extends LwcBaseActionDialog {

    @track currentAgency;

    @track agencyName;

    @track newstarId;

    @track agencyAccountId;

    interopActionCompletedEventMessageTitle='Manage NEWSTAR Agency';

    actualComponentTemplate=componentTemplate;

    get isAlreadyInNewstar() {
        return this.newstarId !== undefined && this.newstarId != null;
    }



    @wire(getRecord, { recordId: '$recordId', fields: REAL_ESTATE_AGENCY_FIELDS })
    wiredRecord({ error, data }) {

        //check for record fetch errors
        if (error) {
            //if error occurred during opportunity fetch, ensure that the action shows as completed
            this.setActionCompleted();

            //and set the error state for the component
            this.setErrorStateInfo('Unable to fetch real estate agency data.', error);

        } else if (data) {

            //set the agency
            this.currentAgency = data;

            //and its details
            this.agencyAccountId = this.currentAgency.fields.Id.value;
            this.agencyName = this.currentAgency.fields.Name.value;
            this.newstarId = this.currentAgency.fields.Newstar_ID__c.value;

            //set action state as completed
            this.setActionCompleted();

            //validate the state of account record representing the RE Agency fields required for lot/offer operations
            this.validateAgencyRequiredFields();

        }
    }


    //
    validateAgencyRequiredFields() {

        // if (true) {
        //     //set error state with the appropriate message
        //     this.setErrorStateInfo("This real estate agency account has insufficient data per NEWSTAR Sales requirements.");
        // }
    }


    handleNewstarSync() {

        EventHelper.triggerActionStartedEvent(this);

        syncAgency({
            agencyAccountId: this.agencyAccountId,

        })
            .then(result => {
               EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "NEWSTAR real estate agency sync failed.", error);
            });
    }



}