import { LightningElement, track, api } from 'lwc';
import { EventHelper, AuraWrapperActions } from 'c/lwcNewstarSharedServices';

import actionInProgressTemplate from './lwcBaseAction_ActionInProgressTemplate.html';
import errorStateTemplate from './lwcBaseAction_ErrorStateTemplate.html';




/*
    Provides base functionality for a quick action-type dialog-based component
    UX.
*/
export default class LwcBaseActionDialog extends LightningElement {

    //ID of the SF record associated with the quic action dialog
    @api recordId;

    //flag specifying if there's an action in Progress
    @track actionInProgress = true;

    @track actionInProgressMessage = 'Processing...';

    //error state info
    @track isInErrorState = false;

    @track errorFriendlyMessage = '';

    @track errors;

    interopActionCompletedEventMessageTitle='';

    actualComponentTemplate='';


    get actionInProgressOrInErrorState() {
        return this.actionInProgress || this.isInErrorState;
    }

    get isInErrorStateAndNoActionInProgress() {
        return this.isInErrorState && !this.actionInProgress;
    }


    //CTor
    constructor() {

        //super class CTor call required by LWC
        super();

        //subscribe to events from components that extend this base component
        this.addEventListener("actionstarted", this.handleComponentActionStarted.bind(this));
        this.addEventListener("actioncompleted", this.handleComponentActionCompleted.bind(this));
        this.addEventListener("actionerror", this.handleComponentActionError.bind(this));

        //ensure the component shows the progress loader during initial rendering
        this.setActionInProgress();
    }


    //override standard rendering to enable support for in progress, error state and normal templates
    render() {

        if(this.actionInProgress) {
            return actionInProgressTemplate;
        }
        else if(this.isInErrorStateAndNoActionInProgress){
            return errorStateTemplate;
        }
        
        return this.actualComponentTemplate;
    }

    
    //handles the event sent by child components indicating that a certain long-running action has started
    handleComponentActionStarted(event) {
        //render loader
        this.setActionInProgress(event.detail.message);
    }


    //handles the event sent by child components indicating that a certain long-running action has completed
    //successfully
    handleComponentActionCompleted(event) {

        //un-render loader
        this.setActionCompleted();

        //use Aura interop to trigger a set of platform events not yet fully supported
        //by LWC: show success toast, close quick action and refresh opp view
        EventHelper.triggerAuraInteropActionCompletedEvent(
            this, 
            event.detail.message,
            this.interopActionCompletedEventMessageTitle,
            [
                AuraWrapperActions.ShowSuccessToast,
                AuraWrapperActions.CloseQuickAction,
                AuraWrapperActions.RefreshView
            ]);
    }


    //handles the event sent by child components indicating that a certain long-running action has 
    //encountered an error
    handleComponentActionError(event) {

        //un-render loader
        this.setActionCompleted();

        //set component-wide error state
        this.setErrorStateInfo(event.detail.message, event.detail.errors);
    }


    //helper: sets action in progress state (render the loader)
    setActionInProgress(actionMessage) {
        this.actionInProgress = true;
        this.actionInProgressMessage = actionMessage;
    }


    //helper: sets action complete state (un-renders the loader)
    setActionCompleted() {
        this.actionInProgress = false;
        this.actionInProgressMessage = '';
    }


    //helper: sets error state (renders special error panel)
    setErrorStateInfo(friendlyMessage, errorData) {
        this.isInErrorState = true;
        this.errorFriendlyMessage = friendlyMessage;
        this.errors = errorData;
    }

    //helper: resets error state (un-renders special error panel)
    resetErrorState() {
        this.isInErrorState = false;
        this.errors = null;
        this.errorFriendlyMessage = '';
    }


}