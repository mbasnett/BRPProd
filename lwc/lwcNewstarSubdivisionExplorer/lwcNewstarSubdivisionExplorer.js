import { track, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';
import { SalesPipelineHelper, EventHelper, DataHelper, AuraWrapperActions, NotificationHelper, ToastVariant, ToastBehaviorMode } from 'c/lwcNewstarSharedServices';

import getExplorerData from '@salesforce/apex/NewstarSubdivisionExplorerController.getExplorerData';
import setOpportunityLot from '@salesforce/apex/NewstarSubdivisionExplorerController.setOpportunityLot';
import setOpportunityModel from '@salesforce/apex/NewstarSubdivisionExplorerController.setOpportunityModel';
import setOpportunitySubdivision from '@salesforce/apex/NewstarSubdivisionExplorerController.setOpportunitySubdivision';

import LwcBaseWidget from 'c/lwcBaseWidget';
import componentTemplate from './lwcNewstarSubdivisionExplorer.html';


const EVENT_BUS_NOTIFICATION_CHANNEL='/event/Newstar_Notification_Event__e';

const CURRENCY_FIELD_ATTRIBUTES = {
    alignment: 'left'
};

const CURRENCY_TYPE_ATTRIBUTES = {
    currencyCode: DataHelper.getUserCurrencyCode(),
    currencyDisplayAs: 'symbol'
};


const NUM_FIELD_ATTRIBUTES = {
    alignment: 'left'
};


const MODEL_ACTION_COLUMN =
{
    type: 'button',
    typeAttributes: { label: 'Select', name: 'Select_Model', variant: 'neutral' }
};


const MODEL_COLUMNS = [
    {
        label: 'Name',
        fieldName: 'name'
    },
    {
        label: 'Priced from',
        fieldName: 'price',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    }
];



const MODEL_COLUMNS_EXPANDED = [
    {
        label: 'Name',
        fieldName: 'name'
    },
    {
        label: 'Price',
        fieldName: 'price',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    },
    {
        label: 'Sq. Ft.',
        fieldName: 'sqft',
        type: 'number',
        cellAttributes: NUM_FIELD_ATTRIBUTES
    },
    {
        label: 'Beds',
        fieldName: 'beds',
        type: 'number',
        cellAttributes: NUM_FIELD_ATTRIBUTES
    },
    {
        label: 'Baths',
        fieldName: 'baths',
        type: 'number',
        cellAttributes: NUM_FIELD_ATTRIBUTES
    },
    {
        label: 'Garages',
        fieldName: 'garages',
        type: 'number',
        cellAttributes: NUM_FIELD_ATTRIBUTES
    }
];




const LOT_ACTION_COLUMN = {
    type: 'button',
    typeAttributes: { label: 'Select', name: 'Select_Lot', variant: 'neutral' }
}

const DIRT_LOT_COLUMNS = [
    {
        label: 'Lot No.',
        fieldName: 'number'
    },
    {
        label: 'Address',
        fieldName: 'address'
    }

];

const DIRT_LOT_COLUMNS_EXPANDED = [
    {
        label: 'Lot No.',
        fieldName: 'number'
    },
    {
        label: 'Address',
        fieldName: 'address'
    },
    {
        label: 'Released for Sale',
        fieldName: 'releasedForSale',
        type: 'boolean'
    },
    {
        label: 'Released for Construction',
        fieldName: 'releasedForConstruction',
        type: 'boolean'
    },
    {
        label: 'Premium',
        fieldName: 'premium',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    },
    {
        label: 'Price',
        fieldName: 'price',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    },
    {
        label: 'Options Total',
        fieldName: 'preconfiguredOptionsAmount',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    }
];


const INVENTORY_LOT_COLUMNS = [
    {
        label: 'Lot No.',
        fieldName: 'number'
    },
    {
        label: 'Address',
        fieldName: 'address'
    },
    {
        label: 'Model',
        fieldName: 'model'
    },
    {
        label: 'Est. price',
        fieldName: 'totalPrice',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    }
];


const INVENTORY_LOT_COLUMNS_EXPANDED = [
    {
        label: 'Lot No.',
        fieldName: 'number'
    },
    {
        label: 'Address',
        fieldName: 'address'
    },
    {
        label: 'Model',
        fieldName: 'model'
    },
    {
        label: 'Est. price',
        fieldName: 'totalPrice',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    },
    {
        label: 'Released for Sale',
        fieldName: 'releasedForSale',
        type: 'boolean'
    },
    {
        label: 'Released for Construction',
        fieldName: 'releasedForConstruction',
        type: 'boolean'
    },
    {
        label: 'Premium',
        fieldName: 'premium',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    },
    {
        label: 'Price',
        fieldName: 'price',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    },
    {
        label: 'Options Total',
        fieldName: 'preconfiguredOptionsAmount',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    }
];




const SPECIAL_OFFER_COLUMNS = [
    {
        label: 'Offer',
        fieldName: 'name'
    },
    {
        label: 'Expiry date',
        fieldName: 'expiryDate',
        type: "date-local",
        typeAttributes: {
            month: "short",
            day: "2-digit"
        },
        fixedWidth: 110
    }
];

const SPECIAL_OFFER_COLUMNS_EXPANDED = [
    ...SPECIAL_OFFER_COLUMNS,
    {
        label: 'Description',
        fieldName: 'description'
    }
];


const ALTERNATE_OPPORTUNITY_COLUMNS = [
    {
        label: 'V',
        fieldName: 'isCurrent',
        type: 'boolean',
        initialWidth: 50
    },
    {
        label: 'Scenario',
        fieldName: 'scenarioUrl',
        type: 'url',
        typeAttributes: {
            label: { fieldName: 'scenarioName' },
            target: '_self'
        }
    },
    {
        label: 'Stage',
        fieldName: 'stageName'
    },
    {
        label: 'Est. Total',
        fieldName: 'totalSaleAmount',
        type: 'currency',
        cellAttributes: CURRENCY_FIELD_ATTRIBUTES,
        typeAttributes : CURRENCY_TYPE_ATTRIBUTES
    }
];


const LOT_TYPES = {
    Regular: 'Regular',
    Spec: 'Spec',
    Model: 'Model'
};


const SUBDIVISON_ACTION_COLUMN =
{
    type: 'button',
    initialWidth: 120,
    typeAttributes: { label: 'Select', name: 'Select_Subdivision', variant: 'neutral' }
};


const SUBDIVISION_COLUMNS = [
    {
        label: 'Project',
        fieldName: 'name'
    },

    SUBDIVISON_ACTION_COLUMN
    
];


export default class LwcNewstarSubdivisionExplorer extends NavigationMixin(LwcBaseWidget) {

    //ID of the opportunity
    @api recordId;


    //all lots : dirt+inventory
    @track lots = [];

    //dirt lots
    @track dirtLots = [];
    @track dirtLotsAll=[];
    @track inventoryLots = [];

    //models
    @track models = [];

    //special offers
    @track specialOffers = [];

    //banner special offer
    @track bannerSpecialOffer = null;

    //alternate opportunities representing other open quotes on the same lot
    @track alternateOpportunities = [];

    //column defs
    @track dirtLotColumns = [...DIRT_LOT_COLUMNS];
    @track inventoryLotColumns = [...INVENTORY_LOT_COLUMNS];
    @track modelColumns = [...MODEL_COLUMNS];
    @track specialOfferColumns = SPECIAL_OFFER_COLUMNS;
    @track alternateOpportunityColumns = ALTERNATE_OPPORTUNITY_COLUMNS;
    @track specialOfferColumnsExpanded = SPECIAL_OFFER_COLUMNS_EXPANDED;


    //columns defs for expanded mode
    @track dirtLotColumnsExpanded = [...DIRT_LOT_COLUMNS_EXPANDED];
    @track modelColumnsExpanded = [...MODEL_COLUMNS_EXPANDED];
    @track inventoryLotColumnsExpanded = [...INVENTORY_LOT_COLUMNS_EXPANDED];


    //search queries
    //lot
    @track dirtLotQuery='';




    //flag indicating if the expanded view is open
    @track isExpandedViewModalOpen = false;

    //current opportunity object
    @track currentOpportunity;

    //sitemap URL
    @track sitemapUrl = '';


    //object used to subscribe to the event bus
    eventBusSubscription = {};


    //title of the toast messages generated by the component
    interopActionCompletedEventMessageTitle = '';

    //actual template of the component
    actualComponentTemplate = componentTemplate;

    //wired record result for programmatic refresh
    wiredRecordResult;

    //flag indicating if the the subdivision is selected on the current opportunity
    @track isSubdivisionSelected=false;
    @track subdivisionColumns=[...SUBDIVISION_COLUMNS];
    @track availableSubdivisions=[];



    get isSelectionAllowed() {
        return SalesPipelineHelper.isOpportunityAvailableForAssistantSelections(this.currentOpportunity);
    }

    get areAlternateOpportunitiesPresent() {
        return this.alternateOpportunities.length > 0;
    }

    get areSpecialOffersAvailable() {
        return this.specialOffers.length > 0;
    }

    get areModelsAvailable() {
        return this.models.length > 0;
    }

    get areDirtLotsAvailable() {
        return this.dirtLotsAll.length > 0;
    }

    get areInventoryLotsAvailable() {
        return this.inventoryLots.length > 0;
    }

    get isSitemapAvailable() {
        return this.sitemapUrl !== undefined && this.sitemapUrl !== '';
    }

    get areSubdivisionsAvailable() {
        return this.availableSubdivisions.length > 0;
    }


    //lifecycle hook: connected callback
    connectedCallback() {

        //set the interop action title to the component title passed as a public property
        this.interopActionCompletedEventMessageTitle = this.componentTitle;

        //subscribe to event bus
        this.subscribeToEventBusEvents();
    }


    //lifecycle hook: disconnected callback
    disconnectedCallback() {

        //unsubscribe from the event bus
        this.unsubscribeFromEventBusEvents();
    }


    //method to refresh the wire adapter data programmatically
    //using the wired result object initially obtained from the wiredRecord function below
    @api
    refreshData() {
        return refreshApex(this.wiredRecordResult);
    }


    //wire the method to use LDS to return exporer data
    @wire(getExplorerData, { opportunityId: '$recordId' })
    wiredRecord(result) {

        //set the wired result for programmatic refresh
        this.wiredRecordResult = result;

        //get error and data separately
        let error = result.error;
        let data = result.data;

        //check for record fetch errors
        if (error) {

            //if error occurred during data fetch, ensure that the action shows as completed
            this.setActionCompleted();

            //and set the error state for the component
            this.setErrorStateInfo('Unable to fetch subdivision explorer data.', error);

        } else if (data) {

            let thisCmp = this;

            //process available subdivisions data
            this.resetAvailableSubdivisions();
            if (data.availableSubdivisions !== undefined && data.availableSubdivisions != null) {
                data.availableSubdivisions.forEach(function (subdivision) {

                    thisCmp.availableSubdivisions.push({
                        id: subdivision.Id,
                        name: subdivision.Name
                    });
                });
            }


            //process lots for data table display
            this.resetLots();
            if (data.lots !== undefined && data.lots != null) {
                data.lots.forEach(function (lot) {

                    thisCmp.lots.push({
                        id: lot.Id,
                        number: lot.Name,
                        address: lot.Street_Address__c,
                        model: lot.Assigned_Model__r === undefined ? undefined : lot.Assigned_Model__r.Name,
                        type: lot.Type__c,
                        releasedForSale: lot.Released_for_Sale__c,
                        releasedForConstruction: lot.Released_for_Construction__c,
                        price: lot.Price__c,
                        premium: lot.Premium__c,
                        preconfiguredOptionsAmount: lot.Preconfigured_Options_Amount__c,
                        totalPrice: lot.Total_Price__c
                    });
                });
            }



            //separate dirt and inventory lots
            this.processLots();

            //process models for data table display
            this.resetModels();
            if (data.models !== undefined && data.models != null) {
                data.models.forEach(function (model) {

                    thisCmp.models.push({
                        id: model.Id,
                        name: model.Name,
                        code: model.Code__c,
                        price: model.Price__c,
                        info: model.Info__c,
                        stories: model.Floors__c,
                        beds: model.Beds__c,
                        baths: (model.Baths__c + model.Half_Baths__c * 0.5),
                        garages: model.Garages__c,
                        sqft: model.Sq_Ft__c
                    });
                });
            }


            this.resetSpeciaOffers();

            if (data.specialOffers !== undefined && data.specialOffers != null) {
                data.specialOffers.forEach(function (specialOffer) {

                    if (specialOffer.Banner_Special__c) {
                        thisCmp.bannerSpecialOffer = {
                            id: specialOffer.Id,
                            name: specialOffer.Name,
                            description: specialOffer.Description__c,
                            expiryDate: specialOffer.Expiry_Date__c
                        }
                        return;
                    }

                    thisCmp.specialOffers.push({
                        id: specialOffer.Id,
                        name: specialOffer.Name,
                        description: specialOffer.Description__c,
                        expiryDate: specialOffer.Expiry_Date__c
                    });

                });
            }


            //assign opportuntiy
            this.currentOpportunity = data.currentOpportunity;

            //determine if the subdivision has been already selected
            if(this.currentOpportunity.Subdivision__c===undefined || this.currentOpportunity.Subdivision__c==null) {
                this.isSubdivisionSelected=false;
            }
            else {
                this.isSubdivisionSelected=true;
            }
 
             //assign sitemap URL
             this.sitemapUrl = data.currentOpportunity.Subdivision__r === undefined ? '' : data.currentOpportunity.Subdivision__r.Sitemap_URL__c;
 

            this.resetAlternateOpportunities();

            if (data.alternateOpportunities !== undefined && data.alternateOpportunities != null) {
                data.alternateOpportunities.forEach(function (alternateOpportunity) {

                    var aOppRecord = {
                        id: alternateOpportunity.Id,
                        stageName: alternateOpportunity.StageName,
                        scenarioName: alternateOpportunity.Scenario_Name__c,
                        totalSaleAmount: alternateOpportunity.Total_Sale_Amount__c,
                        isCurrent: alternateOpportunity.Id===thisCmp.currentOpportunity.Id,
                        scenarioUrl: '/' + alternateOpportunity.Id
                    };

                    // thisCmp[NavigationMixin.GenerateUrl]({
                    //     type: 'standard__recordPage',
                    //     attributes: {
                    //         recordId: thisCmp.recordId,
                    //         actionName: 'view',
                    //     },
                    // }).then(url => {
                    //     aOppRecord.scenarioUrl=url;
                    // });

                    thisCmp.alternateOpportunities.push(aOppRecord);

                });
            }

           
            //process model columns
            this.resetModelColumns();
            if (this.isSelectionAllowed) {
                this.modelColumns.push(MODEL_ACTION_COLUMN);
                this.modelColumnsExpanded.push(MODEL_ACTION_COLUMN);
            }

            //process lot columns
            this.resetDirtLotColumns();
            this.resetInventoryLotColumns();

            if (this.isSelectionAllowed) {
                this.dirtLotColumns.push(LOT_ACTION_COLUMN);
                this.dirtLotColumnsExpanded.push(LOT_ACTION_COLUMN);
                this.inventoryLotColumns.push(LOT_ACTION_COLUMN);
                this.inventoryLotColumnsExpanded.push(LOT_ACTION_COLUMN);
            }

            //set action state as completed
            this.setActionCompleted();

        }

    }


    processLots() {

        let thisLot = this;

        this.lots.forEach(function (lot) {
            if (lot.type === LOT_TYPES.Regular) {
                thisLot.dirtLots.push(lot);
                thisLot.dirtLotsAll.push(lot);
            }
            else if (lot.type === LOT_TYPES.Spec || lot.type === LOT_TYPES.Model) {
                thisLot.inventoryLots.push(lot);
            }
        });
    }


    resetAvailableSubdivisions() {
        this.availableSubdivisions = [];
    }

    resetLots() {
        this.lots=[];
        this.dirtLots = [];
        this.dirtLotsAll=[];
        this.inventoryLots = [];
    }


    resetModels() {
        this.models = [];
    }


    resetSpeciaOffers() {
        this.specialOffers = [];

        //reset banner special offer
        this.bannerSpecialOffer=null;
    }


    resetAlternateOpportunities() {
        this.alternateOpportunities = [];
    }


    resetModelColumns() {
        this.modelColumns = [...MODEL_COLUMNS];
        this.modelColumnsExpanded = [...MODEL_COLUMNS_EXPANDED];
    }


    resetDirtLotColumns() {
        this.dirtLotColumns = [...DIRT_LOT_COLUMNS];
        this.dirtLotColumnsExpanded = [...DIRT_LOT_COLUMNS_EXPANDED];
    }


    resetInventoryLotColumns() {
        this.inventoryLotColumns = [...INVENTORY_LOT_COLUMNS];
        this.inventoryLotColumnsExpanded = [...INVENTORY_LOT_COLUMNS_EXPANDED];
    }


    resetAll() {
        this.resetModels();
        this.resetLots();
        this.resetAlternateOpportunities();
        this.resetSpeciaOffers();
    }


    handleSearchKeyup(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.dirtLotQuery = evt.target.value;
            this.handleDirtLotSearch();
        }
    }


    handleDirtLotSearch() {
        this.dirtLots=[];
        
        if(this.dirtLotQuery===''){
            this.dirtLots=[...this.dirtLotsAll];
            return;
        }

        this.dirtLots=this.dirtLotsAll.filter(dirtLot => {
            return dirtLot.number.toLowerCase().startsWith(this.dirtLotQuery.toLowerCase()) 
            || (dirtLot.address!==undefined && dirtLot.address.toLowerCase().startsWith(this.dirtLotQuery.toLowerCase()));
        });
    }


    handleRowAction(event) {

        const action = event.detail.action;
        const row = event.detail.row;

        switch (action.name) {

             //subdivision selection
             case 'Select_Subdivision':
                this.setSubdivision(row.id);
                break;

            //lot selection
            case 'Select_Lot':
                this.setLot(row.id);
                break;


            //model selection
            case 'Select_Model':
                this.setModel(row.id);
                break;

            default:
                break;
        }
    }


    //assign the selected lot to the opportunity
    setLot(lotId) {

        EventHelper.triggerActionStartedEvent(this);

        setOpportunityLot({
            opportunityId: this.recordId,
            lotId: lotId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);

                //if there's additional warning message passed from the server, display it as toast
                if (result.AdditionalWarningMessage !== undefined && result.AdditionalWarningMessage !== '') {
                    NotificationHelper.showToast(this,
                        this.interopActionCompletedEventMessageTitle,
                        result.AdditionalWarningMessage,
                        ToastVariant.Warning,
                        ToastBehaviorMode.Sticky)
                }
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Lot assignment to the opportunity failed.", error);
            });
    }



    //assign the selected model to the opportunity
    setModel(modelId) {

        EventHelper.triggerActionStartedEvent(this);

        setOpportunityModel({
            opportunityId: this.recordId,
            modelId: modelId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);

                //if there's additional warning message passed from the server, display it as toast
                if (result.AdditionalWarningMessage !== undefined && result.AdditionalWarningMessage !== '') {
                    NotificationHelper.showToast(this,
                        this.interopActionCompletedEventMessageTitle,
                        result.AdditionalWarningMessage,
                        ToastVariant.Warning,
                        ToastBehaviorMode.Sticky)
                }
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Model assignment to the opportunity failed.", error);
            });
    }


    //assign the selected subdivision to the opportunity
    setSubdivision(subdivisionId) {

        EventHelper.triggerActionStartedEvent(this);

        setOpportunitySubdivision({
            opportunityId: this.recordId,
            subdivisionId: subdivisionId
        })
            .then(result => {
                EventHelper.triggerActionCompletedEvent(this, result.Message);

                //if there's additional warning message passed from the server, display it as toast
                if (result.AdditionalWarningMessage !== undefined && result.AdditionalWarningMessage !== '') {
                    NotificationHelper.showToast(this,
                        this.interopActionCompletedEventMessageTitle,
                        result.AdditionalWarningMessage,
                        ToastVariant.Warning,
                        ToastBehaviorMode.Sticky)
                }
            })
            .catch(error => {
                EventHelper.triggerActionErrorEvent(this, "Project assignment to the opportunity failed.", error);
            });
    }


    handleExpandView() {
        this.openExpandedView();
    }


    handleCloseModal(event) {
        let modalName = event.detail.modalName;

        if (modalName === 'expanded-view') {
            this.closeExpandedView();
        }
    }

    openExpandedView() {
        this.isExpandedViewModalOpen = true;
    }


    closeExpandedView() {
        this.isExpandedViewModalOpen = false;
    }


    //subscribe the event bus events
    subscribeToEventBusEvents() {

        var thisCmp=this;

        //callback invoked whenever a new event message is received
        const messageCallback = function (response) {

            console.log('New message received : ', JSON.stringify(response));

            const data=response.data;
            const payload=data.payload;
            
            //if the notification event is targeting the current opportunity
            if(payload.Primary_Object_Id__c===thisCmp.recordId) {


                 //use Aura interop to trigger a set of platform events not yet fully supported
                //by LWC: show success toast, close quick action and refresh opp view
                EventHelper.triggerAuraInteropActionCompletedEvent(
                    thisCmp,
                    payload.Notification_Message__c,
                    this.interopActionCompletedEventMessageTitle,
                    [
                        AuraWrapperActions.ShowSuccessToast,
                        AuraWrapperActions.RefreshView
                    ]);

             
            }

        };

        //subscribe to the event bus events using empApi
        subscribe(EVENT_BUS_NOTIFICATION_CHANNEL, -1, messageCallback)
            .then(response => {

                //
                console.log('Successfully subscribed to : ', JSON.stringify(response.channel));
                this.eventBusSubscription = response;

            });
    }


    unsubscribeFromEventBusEvents() {

        //unsubscribe using empApi
        unsubscribe(this.eventBusSubscription,
            response => {
                console.log('unsubscribe() response: ', JSON.stringify(response));
                // Response is true for successful unsubscribe
            });
    }


    registerErrorListener() {
    
        //trap empApi errors
        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
            // Error contains the server-side error
        });
    }

}