import { LightningElement, api } from 'lwc';

export default class LwcNewstarModal extends LightningElement {

    //unique name of the modal dialog (used in events)
    @api name="";

    //title of the modal dialog
    @api title="";

    closeModal() {

        //raise custom event to notify listener that the modal should be closed

        const closeModalEvent = CustomEvent('closemodal', {
            bubbles: true,
            composed: true,
            detail: {
                modalName: this.name
            }
        });

        this.dispatchEvent(closeModalEvent);
    }

}