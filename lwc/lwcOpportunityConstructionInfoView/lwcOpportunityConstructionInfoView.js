import { api } from 'lwc';
import LwcBaseWidget from 'c/lwcBaseWidget';
import componentTemplate from './lwcOpportunityConstructionInfoView.html';

export default class LwcOpportunityConstructionInfoView extends LwcBaseWidget {

    @api recordId;

    actualComponentTemplate=componentTemplate;

    connectedCallback() {
        this.setActionCompleted();
    }

    handleRecordLoaded(event) {
        
    }

    
}