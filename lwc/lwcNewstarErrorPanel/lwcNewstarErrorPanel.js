import { LightningElement, api, track } from 'lwc';

export default class LwcNewstarErrorPanel extends LightningElement {
   
    _friendlyMessage = '';
    
    @api
    get friendlyMessage(){
        return this._friendlyMessage;
    }

    set friendlyMessage(value ){
        this._friendlyMessage=this._friendlyMessage==null || this._friendlyMessage==='' ? value : this.friendlyMessage;
    }

    @api userInstructions='';

    @track viewDetails = false;

    _errors=null;

    @api 
    get errors() {
        return this._errors;
    }
    set errors(value) {
        this._errors=value;
        this.processErrors();
    }

    @track errorMessages=[];


    handleCheckboxChange(event) {
        this.viewDetails = event.target.checked;
    }


    processErrors() {

        if (!Array.isArray(this.errors)) {
            this.errors = [this.errors];
        }
    
        this.errorMessages= (
            this.errors
                // remove null/undefined items
                .filter(error => !!error)
                // extract an error message
                .map(error => {
                    
                    //custom errors return as serialized Aura exceptions
                    if (error.body && typeof error.body.message === 'string' && this.isValidJson(error.body.message)) {
                        
                        let errorData=JSON.parse(error.body.message);

                        if(typeof errorData.userFriendlyMessage==='string') {
                            this.friendlyMessage=errorData.userFriendlyMessage;
                        }

                        if(typeof errorData.userInstructionsMessage==='string') {
                            this.userInstructions=errorData.userInstructionsMessage;
                        }

                        let errorDetailsMessage=typeof errorData.detailsMessage==='string' ? errorData.detailsMessage : error.message;
                        
                        return errorDetailsMessage;
                    }    

                    //UI API read errors
                    else if (Array.isArray(error.body)) {
                        return error.body.map(e => e.message);
                    }
                    
                    //UI API DML, Apex and network errors
                    else if (error.body && typeof error.body.message === 'string') {
                        return error.body.message;
                    }
                    

                    //JS errors
                    else if (typeof error.message === 'string') {
                        return error.message;
                    }
                    
                    //unknown error shape so try HTTP status text
                    return error.statusText;
                })
                //flatten
                .reduce((prev, curr) => prev.concat(curr), [])
                //remove empty strings
                .filter(message => !!message)
        );
    }


    isValidJson(str) {
      
        try {
            JSON.parse(str);
        } catch (e) {
            return false;
        }

        return true;
        
    }


}