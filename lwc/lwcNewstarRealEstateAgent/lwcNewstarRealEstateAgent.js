import { track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import LwcBaseActionDialog from 'c/lwcBaseActionDialog';
import { EventHelper } from 'c/lwcNewstarSharedServices';
import syncAgent from '@salesforce/apex/NewstarRealEstateAgentController.syncAgent';
import componentTemplate from './lwcNewstarRealEstateAgent.html'


/*
    List of fields fetched through the wire adapter for the Contact object
    that represents the Real Estage Agent.
*/
const REAL_ESTATE_AGENT_FIELDS = [
    'Contact.Id',
    'Contact.Name',
    'Contact.FirstName',
    'Contact.LastName',
    'Contact.Newstar_ID__c',
    'Contact.Account.Name',
    'Contact.Account.Newstar_ID__c'
];


export default class LwcNewstarRealEstateAgent extends LwcBaseActionDialog {

    @track currentAgent;

    @track agentName;

    @track newstarId;

    @track agentContactId;

    @track agencyName;

    @track agencyNewstarId;


    interopActionCompletedEventMessageTitle='Manage NEWSTAR Agent';

    actualComponentTemplate=componentTemplate;

    

    get isAlreadyInNewstar() {
        return this.newstarId !== undefined && this.newstarId != null;
    }



    @wire(getRecord, { recordId: '$recordId', fields: REAL_ESTATE_AGENT_FIELDS })
    wiredRecord({ error, data }) {

        //check for record fetch errors
        if (error) {
            //if error occurred during opportunity fetch, ensure that the action shows as completed
            this.setActionCompleted();

            //and set the error state for the component
            this.setErrorStateInfo('Error fetching real estate agent data.', error);

        } else if (data) {

            //set the agent
            this.currentAgent = data;

            //and its details
            this.agentContactId = this.currentAgent.fields.Id.value;
            this.agentName = this.currentAgent.fields.Name.value;
            this.newstarId = this.currentAgent.fields.Newstar_ID__c.value;
            this.agencyName=this.currentAgent.fields.Account.value.fields.Name.value;
            this.agencyNewstarId=this.currentAgent.fields.Account.value.fields.Newstar_ID__c.value;

            //set action state as completed
            this.setActionCompleted();

            //validate the state of account record representing the RE Agent fields required for lot/offer operations
            this.validateAgentRequiredFields();

        }
    }


    
    validateAgentRequiredFields() {

        if (this.agencyNewstarId==null) {
            //set error state with the appropriate message
            this.setErrorStateInfo('The parent real estate agency ('+this.agencyName+') has not been sent to NEWSTAR yet.');
        }
    }


    handleNewstarSync() {

        EventHelper.triggerActionStartedEvent(this);

        syncAgent({
            agentContactId: this.agentContactId,

        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "NEWSTAR real estate agent sync failed.", error);
            });
    }
}