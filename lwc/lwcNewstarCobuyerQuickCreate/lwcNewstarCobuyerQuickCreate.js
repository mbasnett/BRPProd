import COBUYER_OBJECT from '@salesforce/schema/Cobuyer__c';
import FIRSTNAME_FIELD from '@salesforce/schema/Cobuyer__c.First_Name__c';
import LASTNAME_FIELD from '@salesforce/schema/Cobuyer__c.Last_Name__c';
import OPPORTUNITY_FIELD from '@salesforce/schema/Cobuyer__c.Opportunity__c';
import HOME_EMAIL_FIELD from '@salesforce/schema/Cobuyer__c.Home_Email__c';
import WORK_EMAIL_FIELD from '@salesforce/schema/Cobuyer__c.Work_Email__c';
import HOME_PHONE_FIELD from '@salesforce/schema/Cobuyer__c.Home_Phone__c';
import WORK_PHONE_FIELD from '@salesforce/schema/Cobuyer__c.Work_Phone__c';
import MOBILE_PHONE_FIELD from '@salesforce/schema/Cobuyer__c.Mobile_Phone__c';

import { AuraWrapperActions, EventHelper } from 'c/lwcNewstarSharedServices';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { api, LightningElement, track, wire } from 'lwc';



export default class LwcNewstarCobuyerQuickCreate extends LightningElement {

    cobuyerObject = COBUYER_OBJECT;
    firstNameField = FIRSTNAME_FIELD;
    lastNameField = LASTNAME_FIELD;
    oppField=OPPORTUNITY_FIELD;
    homeEmailField=HOME_EMAIL_FIELD;
    workEmailField=WORK_EMAIL_FIELD;
    homePhoneField=HOME_PHONE_FIELD;
    workPhoneField=WORK_PHONE_FIELD;
    mobilePhoneField=MOBILE_PHONE_FIELD;

    @api recordId;
    @api objectApiName = COBUYER_OBJECT;

    @track objectInfo;

    @wire(getObjectInfo, { objectApiName: COBUYER_OBJECT })
    objectInfo;

    get recordTypeId() {
        const rtis = this.objectInfo.data.recordTypeInfos;
        return Object.keys(rtis).find(rti => rtis[rti].name === 'Opportunity');
    }


    handleFormSubmitted(event) {
        event.preventDefault(); 

        EventHelper.triggerActionStartedEvent(this);
        
        const fields = event.detail.fields;

        fields.Opportunity__c = this.recordId;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }


    handleCobuyerCreated() {
      
        EventHelper.triggerAuraInteropActionCompletedEvent(
            this,
            'Cobuyer created successfully.',
            'Opportunity Cobuyer',
            [
                AuraWrapperActions.ShowSuccessToast,
                AuraWrapperActions.RefreshView
            ]);
    }
    
}