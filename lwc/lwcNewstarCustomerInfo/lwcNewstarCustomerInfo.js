import { track, wire } from 'lwc';
import LwcBaseActionDialog from 'c/lwcBaseActionDialog';
import { EventHelper } from 'c/lwcNewstarSharedServices';
import getCustomerWithSalesOffices from '@salesforce/apex/NewstarCustomerInfoController.getCustomerWithSalesOffices';
import syncCustomer from '@salesforce/apex/NewstarCustomerInfoController.syncCustomer';
import componentTemplate from './lwcNewstarCustomerInfo.html';


export default class LwcNewstarCustomerInfo extends LwcBaseActionDialog {

    @track currentCustomer;

    @track customerName;

    @track customerAccountId;

    @track customerSalesOfficeJunctions;

    @track
    customerSalesOfficeJunctionIdsToUpdate = [];

    @track
    isAlreadyInNewstar = false;

    interopActionCompletedEventMessageTitle='Manage NEWSTAR Customer';

    actualComponentTemplate=componentTemplate;


    get newstarSyncActionDisabled() {
        return this.customerSalesOfficeJunctionIdsToUpdate.length < 1;
    }


    @wire(getCustomerWithSalesOffices, { customerAccountId: '$recordId' })
    wiredRecord({ error, data }) {

        //check for record fetch errors
        if (error) {
            //if error occurred during customer person account fetch, ensure that the action shows as completed
            this.setActionCompleted();

            //and set the error state for the component
            this.setErrorStateInfo('Unable to fetch customer person account data.', error);

        } else if (data) {

            //set the customer
            this.currentCustomer = data;

            //and its details
            this.customerName = this.currentCustomer.Name;
            this.customerAccountId=this.currentCustomer.Id;

            this.customerSalesOfficeJunctions = [];

            //if the customer's person account has associated junction objects...
            if (this.currentCustomer.Sales_Office_Accounts__r != null) {

                //iterate over the junction objects associated with the person account
                this.currentCustomer.Sales_Office_Accounts__r.forEach(salesOffice => {

                    //and construct the options data for checkbox group component
                    this.customerSalesOfficeJunctions.push({
                        label: salesOffice.Sales_Office__r.Name,
                        value: salesOffice.Id
                    });

                });

                //flag the customer as already in NEWSTAR if there's at least one SO-based relationship record
                this.isAlreadyInNewstar = this.customerSalesOfficeJunctions.length > 0;

                //if there is only one sales office that the SF Person Account is associated with, 
                //pre-select that sales office by default
                if (this.customerSalesOfficeJunctions.length === 1) {
                    this.customerSalesOfficeJunctionIdsToUpdate[this.customerSalesOfficeJunctionIdsToUpdate.length]=this.customerSalesOfficeJunctions[0].value;
                }
            }


            //set action state as completed
            this.setActionCompleted();

        }

    }


    handleSalesOfficeSelectionChange(event) {
        this.customerSalesOfficeJunctionIdsToUpdate = event.detail.value;
    }


    handleNewstarSync() {

        EventHelper.triggerActionStartedEvent(this);

        syncCustomer({
            customerAccountId: this.customerAccountId,
            customerSalesOfficeJunctionIds: this.customerSalesOfficeJunctionIdsToUpdate
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "NEWSTAR customer info sync failed.", error);
            });
    }



}