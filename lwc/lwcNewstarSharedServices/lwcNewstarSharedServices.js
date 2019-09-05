import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import CURRENCY from '@salesforce/i18n/currency'
import LOCALE from '@salesforce/i18n/locale'


const GeoLocales = {
    UnitedStates: 'en-US',
    Canada: 'en-CA'
};


const GeoCurrencyCodes = {
    UnitedStates: 'USD',
    Canada: 'CAD'
};


/**
 * Pre-defined stage names association with the handoff and post-handoff stages 
 * of the opportunity object pipeline.
 */
const OpportunityStageNames = {
    Prospecting: "Prospecting",
    Engagement: "Engagement",
    QuoteSelection: "Quote/Selection",
    LotReservation: "Lot Reservation",
    ContractReady: "Contract Ready",
    PendingOffer: "Pending Offer",
    UnderContract: "Under Contract",
    Closed: "Closed Home",
    Cancelled: "Cancelled",
    QuoteClosed: "Quote Closed",
    Lost: "Lost"
};


/**
 * Pre-defined Aura framework actions inplemented by the Aura->LWC component wrapper to
 * perform actions that are not yet possible directly from LWC.
 */
const AuraWrapperActions = {
    ShowSuccessToast: "ShowSuccessToast",
    ShowWarningToast: "ShowWarningToast",
    ShowErrorToast: "ShowErrorToast",
    CloseQuickAction: "CloseQuickAction",
    RefreshView: "RefreshView"
};


/**
 * List of the sales process types as defined in Salesforce.
 */
const OpportunitySalesProcessTypes = {
    DirectOffer: "Direct offer",
    LotReservation: "Lot reservation"
};



/**
 * Provides utility methods to trigger LWC and Aura/LWC interop events.
 */
class EventHelper {

    /**
     * Constructs an action started request using
     * @param {String} message 
     * @param {Array} auraActions 
     */
    static getActionStartedEvent(message) {

        const actionStartedEvent = CustomEvent('actionstarted', {
            bubbles: true,
            composed: true,
            detail: {
                message: message
            }
        });

        return actionStartedEvent;
    }


    /**
     * Triggers the action started event against the specified event target.
     * @param {LightningComponent} eventTarget 
     * @param {String} message 
     * @param {Array} auraActions 
     */
    static triggerActionStartedEvent(eventTarget, message) {
        let actionStartedEvent = this.getActionStartedEvent(message);
        eventTarget.dispatchEvent(actionStartedEvent);
    }


    /**
     * Constructs an action completed event.
     * @param {String} message 
     * @param {Array} postEventActions 
     */
    static getActionCompletedEvent(message, postEventActions) {

        const actionCompletedEvent = CustomEvent('actioncompleted', {
            bubbles: true,
            composed: true,
            detail: {
                message: message,
                postEventActions: postEventActions
            }
        });

        return actionCompletedEvent;
    }


    /**
     * Triggers an action completed event against the specified event target.
     * @param {LightningComponent} eventTarget 
     * @param {String} message 
     * @param {Array} postEventActions 
     */
    static triggerActionCompletedEvent(eventTarget, message, postEventActions) {
        let actionCompletedEvent = this.getActionCompletedEvent(message, postEventActions);
        eventTarget.dispatchEvent(actionCompletedEvent);
    }


    /**
     * Constructs an LWC-Aura interop action completed event.
     * @param {String} message 
     * @param {Array} auraActions 
     */
    static getAuraInteropActionCompletedEvent(message, messageTitle, auraActions) {

        const actionCompletedEvent = CustomEvent('interopactioncompleted', {
            bubbles: true,
            composed: true,
            detail: {
                message: message,
                messageTitle: messageTitle,
                auraActions: auraActions
            }
        });

        return actionCompletedEvent;
    }


    /**
     * Triggers an LWC-Aura action completed event against the specified event target.
     * @param {LightningComponent} eventTarget 
     * @param {String} message 
     * @param {String} messageTitle
     * @param {Array} auraActions 
     */
    static triggerAuraInteropActionCompletedEvent(eventTarget, message, messageTitle, auraActions) {
        let actionCompletedEvent = this.getAuraInteropActionCompletedEvent(message, messageTitle, auraActions);
        eventTarget.dispatchEvent(actionCompletedEvent);
    }


    /**
     * Constructs an action error event.
     * @param {String} message 
     * @param {*} errors 
     */
    static getActionErrorEvent(message, errors) {

        const actionErrorEvent = CustomEvent('actionerror', {
            bubbles: true,
            composed: true,
            detail: {
                message: message,
                errors: errors
            }
        });

        return actionErrorEvent;
    }


    /**
     * Triggers an action error event against the specified event target.
     * @param {LightningComponent} eventTarget 
     * @param {String} message 
     * @param {Array} postEventActions 
     */
    static triggerActionErrorEvent(eventTarget, message, errors) {
        let actionErrorEvent = this.getActionErrorEvent(message, errors);
        eventTarget.dispatchEvent(actionErrorEvent);
    }

}



/**
 * Variant of the toast notification to display.
 */
const ToastVariant = {
    Info: 'info',
    Success: 'success',
    Warning: 'warning',
    Error: 'error'
};


/**
 * Behavior of the toast notification.
 */
const ToastBehaviorMode = {
    Dismissable: 'dismissable',
    Pester: 'pester',
    Sticky: 'sticky'
};


/**
 * Provides helper methods to show toast notifications.
 */
class NotificationHelper {

    static showToast(eventTarget, title, message, variant = ToastVariant.Info, behaviorMode = ToastBehaviorMode.Dismissable) {

        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: behaviorMode
        });

        eventTarget.dispatchEvent(event);
    }

}


/**
 * Provides helper methods for the Salesforce pipeline logic on the client side (LWC).
 */
class SalesPipelineHelper {

    /**
     * Checks if the specified opportunity is using the direct-to-offer sales process.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityUsingDirectOffer(opp) {
        return opp.RecordType.Name === OpportunitySalesProcessTypes.DirectOffer;
    }


    /**
   * Checks if the specified opportunity is using the direct offer sales process AND the process has reached 
   * the Contract Ready stage.
   * @param {Opportunity} opp Opportunity object. 
   */
    static isOpportunityUsingDirectOfferAndContractInitiated(opp) {
        return this.isOpportunityUsingDirectOffer(opp)
            && opp.StageName === OpportunityStageNames.ContractReady;
    }


    /**
     * Checks if the specified opportunity is using the lot reservation sales process.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityUsingLotReservation(opp) {
        return opp.RecordType.name === OpportunitySalesProcessTypes.LotReservation;
    }


    /**
     * Checks if the specified opportunity is using the lot reservation sales process AND the process has reached 
     * the lot reservation stage.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityUsingLotReservationAndLotReserved(opp) {
        return this.isOpportunityUsingLotReservation(opp)
            && opp.StageName === OpportunityStageNames.LotReservation;
    }


    /**
     * Checks if the specified opportunity is available for contract operations.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityAvailableForContractOperations(opp) {

        var ineligibleStages = [
            OpportunityStageNames.PendingOffer,
            OpportunityStageNames.UnderContract,
            OpportunityStageNames.Closed,
            OpportunityStageNames.Cancelled,
            OpportunityStageNames.QuoteClosed,
            OpportunityStageNames.Lost
        ];

        return !ineligibleStages.includes(opp.StageName);
    }


    /**
     * Checks if the specified opportunity is available for Opportunity Assistant selections.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityAvailableForAssistantSelections(opp) {

        var ineligibleStages = [
            OpportunityStageNames.QuoteSelection,
            OpportunityStageNames.LotReservation,
            OpportunityStageNames.ContractReady,
            OpportunityStageNames.PendingOffer,
            OpportunityStageNames.UnderContract,
            OpportunityStageNames.Closed,
            OpportunityStageNames.Cancelled,
            OpportunityStageNames.QuoteClosed,
            OpportunityStageNames.Lost
        ];

        return !ineligibleStages.includes(opp.StageName);
    }


    /**
     * Checks if the specified opportunity is available specifically for lot reservation.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityAvailableForLotReservation(opp) {

        var ineligibleStages = [
            OpportunityStageNames.ContractReady,
            OpportunityStageNames.PendingOffer,
            OpportunityStageNames.UnderContract,
            OpportunityStageNames.Closed,
            OpportunityStageNames.Cancelled,
            OpportunityStageNames.QuoteClosed,
            OpportunityStageNames.Lost
        ];

        return !ineligibleStages.includes(opp.StageName);
    }


    /**
    * Checks if the specified opportunity is available specifically for direct offer.
    * @param {Opportunity} opp Opportunity object. 
    */
    static isOpportunityAvailableForDirectOffer(opp) {

        var ineligibleStages = [
            OpportunityStageNames.LotReservation,
            OpportunityStageNames.PendingOffer,
            OpportunityStageNames.UnderContract,
            OpportunityStageNames.Closed,
            OpportunityStageNames.Cancelled,
            OpportunityStageNames.QuoteClosed,
            OpportunityStageNames.Lost
        ];

        return !ineligibleStages.includes(opp.StageName);
    }


    /**
     * Checks if the specified opportunity is available specifically for quote.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityAvailableForQuote(opp) {

        var ineligibleStages = [
            OpportunityStageNames.QuoteSelection,
            OpportunityStageNames.LotReservation,
            OpportunityStageNames.ContractReady,
            OpportunityStageNames.PendingOffer,
            OpportunityStageNames.UnderContract,
            OpportunityStageNames.Closed,
            OpportunityStageNames.Cancelled,
            OpportunityStageNames.QuoteClosed,
            OpportunityStageNames.Lost
        ];

        return !ineligibleStages.includes(opp.StageName);
    }


    /**
    * Checks if the specified opportunity is at the Quote stage.
    * @param {Opportunity} opp Opportunity object. 
    */
    static isOpportunityAtQuoteStage(opp) {

        return opp.StageName === OpportunityStageNames.QuoteSelection;
    }

    /**
     * Checks if the specified opportunity is at some stage prior to the Quote stage or at the Quote stage itself.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityBeforeOrAtQuoteStage(opp) {

        return SalesPipelineHelper.isOpportunityAvailableForQuote(opp)
            || opp.StageName === OpportunityStageNames.QuoteSelection;
    }



    /**
     * Checks if the specified opportunity is available specifically for quote cloning.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityAvailableForQuoteCloning(opp) {

        var ineligibleStages = [
            OpportunityStageNames.LotReservation,
            OpportunityStageNames.ContractReady,
            OpportunityStageNames.PendingOffer,
            OpportunityStageNames.UnderContract,
            OpportunityStageNames.Closed,
            OpportunityStageNames.Cancelled,
            OpportunityStageNames.QuoteClosed,
            OpportunityStageNames.Lost
        ];

        return !ineligibleStages.includes(opp.fields.StageName.value);
    }


    /**
     * Checks if the specified opportunity is available specifically for show deal actuals.
     * @param {Opportunity} opp Opportunity object. 
     */
    static isOpportunityStageEligibleForFinancialActuals(stageName) {

        var ineligibleStages = [
            OpportunityStageNames.Prospecting,
            OpportunityStageNames.Engagement,
            OpportunityStageNames.QuoteSelection,
            OpportunityStageNames.ContractReady,
            OpportunityStageNames.LotReservation
        ];

        return !ineligibleStages.includes(stageName);
    }

}


class DataHelper {

    /**
     * Returns the currency code to be used when rendering.
     */
    static getUserCurrencyCode() {

        let currencyCode = '';
        if (CURRENCY === GeoCurrencyCodes.Canada) {
            currencyCode = LOCALE === GeoLocales.UnitedStates ? GeoCurrencyCodes.UnitedStates : GeoCurrencyCodes.Canada;

        }
        else {
            currencyCode = LOCALE === GeoLocales.Canada ? GeoCurrencyCodes.Canada : GeoCurrencyCodes.UnitedStates;
        }

        return currencyCode;
    }
}



//module exports
export {
    OpportunityStageNames,
    AuraWrapperActions,
    ToastBehaviorMode,
    ToastVariant,
    EventHelper,
    NotificationHelper,
    SalesPipelineHelper,
    DataHelper,
    OpportunitySalesProcessTypes
};