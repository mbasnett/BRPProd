import { api } from 'lwc';
import LwcBaseWidget from 'c/lwcBaseWidget';
import componentTemplate from './lwcOpportunityQualifyingInfo.html';

export default class LwcOpportunityQualifyingInfo extends LwcBaseWidget {

    @api recordId;

    actualComponentTemplate=componentTemplate;

    connectedCallback() {
        this.setActionCompleted();
    }

    
}