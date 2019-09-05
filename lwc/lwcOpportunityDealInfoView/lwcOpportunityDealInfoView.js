import { api, track } from 'lwc';
import LwcBaseWidget from 'c/lwcBaseWidget';
import componentTemplate from './lwcOpportunityDealInfoView.html';
import { SalesPipelineHelper } from 'c/lwcNewstarSharedServices';

export default class LwcOpportunityDealInfoView extends LwcBaseWidget {

    @api recordId;

    actualComponentTemplate=componentTemplate;

    @track displayActuals=false;

    connectedCallback() {
        this.setActionCompleted();
    }

    handleRecordLoaded(evt) {
      
      
    }

}