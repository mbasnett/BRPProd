import { api, track } from 'lwc';
import LwcBaseWidget from 'c/lwcBaseWidget';
import componentTemplate from './lwcOpportunityFinancialsView.html';
import { SalesPipelineHelper } from 'c/lwcNewstarSharedServices';

export default class LwcOpportunityFinancialsView extends LwcBaseWidget {

    @api recordId;

    actualComponentTemplate=componentTemplate;

    @track displayActuals=false;

    connectedCallback() {
        this.setActionCompleted();
    }

    handleRecordLoaded(evt) {
      
       var stageName=evt.detail.records[evt.target.recordId].fields.StageName.value;

        this.displayActuals=SalesPipelineHelper.isOpportunityStageEligibleForFinancialActuals(stageName);
    }

    
}