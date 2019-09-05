public with sharing class NewstarMasterDataApiService {
    

    /*
        Pulls all NEWSTAR geography data (countries/states) into Salesforce.
    */
    public static void ProcessGeographyLayout(NewstarClient newstarClient) {
        

        NewstarGeographyLayoutApi geoApi=new NewstarGeographyLayoutApi(newstarClient);
        NewstarPagedResultCountry countryPagedResult=geoApi.get();

        List<Newstar_Country__c> countries=new List<Newstar_Country__c>();
        Schema.SObjectField countryNewstarIdField = Newstar_Country__c.Fields.Newstar_ID__c;

        List<Newstar_State__c> states=new List<Newstar_State__c>();
        Schema.SObjectField stateNewstarIdField = Newstar_State__c.Fields.Newstar_ID__c;

        for (NewstarCountry apiCountry : countryPagedResult.data) {
       
            Newstar_Country__c country=new Newstar_Country__c();

            country.Name=apiCountry.name;
            country.Newstar_ID__c=String.valueOf(apiCountry.Id);
    
            countries.add(country);

            //process provinces of the current country
            if(apiCountry.statesProvinces!=null) {

                for (NewstarStateProvince apiStateProvince : apiCountry.statesProvinces) {
                    Newstar_State__c state=new Newstar_State__c();
                    
                    state.Name=apiStateProvince.name;
                    state.Code__c=apiStateProvince.code;
                    state.Newstar_ID__c=String.valueOf(apiStateProvince.Id);

                    //construct reference back to the parent country
                    state.Newstar_Country__r=new Newstar_Country__c(Newstar_ID__c=country.Newstar_ID__c);

                    states.add(state);
                }
            }
        }

        //commit both countries and provinces together

        SavePoint sp = Database.setSavePoint();
        try {
          Database.upsert(countries, countryNewstarIdField, true);
          Database.upsert(states, stateNewstarIdField, true);
          
        } 
        catch (Exception e) {
        
            Database.rollback(sp);

            // Throw exception on to caller
            throw e;
        }

    }




    /*
        Pulls all NEWSTAR sales agents and upserts sales agent data into Salesforce.
    */
    public static void ProcessSalesAgents(NewstarClient newstarClient) {
        
        NewstarSalesAgentApi salesAgentApi=new NewstarSalesAgentApi(newstarClient);
        NewstarPagedResultSalesAgent salesAgentPagedResult=salesAgentApi.get();

        List<Sales_Agent__c> salesAgents=new List<Sales_Agent__c>();
        Schema.SObjectField newstarIdField = Sales_Agent__c.Fields.Newstar_ID__c;

        for (NewstarSalesAgent apiSalesAgent : salesAgentPagedResult.data) {
       
            Sales_Agent__c salesAgent=new Sales_Agent__c();

            salesAgent.Name=string.valueOf(apiSalesAgent.firstName) + ' ' + string.valueOf(apiSalesAgent.lastName);
            salesAgent.First_Name__c = string.valueOf(apiSalesAgent.firstName);
            salesAgent.Last_Name__c = string.valueOf(apiSalesAgent.lastName);
            salesAgent.Newstar_ID__c=String.valueOf(apiSalesAgent.Id);

            if(Test.isRunningTest()){

                User salesUser = [SELECT Id FROM User WHERE ProfileId IN 
                                    (SELECT Id FROM Profile WHERE Name LIKE '%Sales User%') LIMIT 1];

                salesAgent.Related_to_User__c = salesUser.Id;     
            }
                
            salesAgents.add(salesAgent);
        }

        Database.upsert(salesAgents, newstarIdField, true);

    }


     /*
        Pulls all NEWSTAR sales offices and sales office<->sales agents relationships 
        and upserts sales office data into Salesforce.
    */
    public static void ProcessSalesOffices(NewstarClient newstarClient) {
        
        NewstarSalesOfficeApi salesOfficeApi=new NewstarSalesOfficeApi(newstarClient);
        NewstarPagedResultSalesOffice salesOfficePagedResult=salesOfficeApi.get();

        List<Sales_Office__c> salesOffices=new List<Sales_Office__c>();
        Schema.SObjectField newstarIdField = Sales_Office__c.Fields.Newstar_ID__c;
        
        List<SalesAgentSalesOfficeLink__c> salesAgentSalesOfficeLinks=new List<SalesAgentSalesOfficeLink__c>();
        Schema.SObjectField salesAgentSalesOfficeLinkNewstarIdField = SalesAgentSalesOfficeLink__c.Fields.Newstar_ID__c;

        //iterate the sales office received from the API
        for (NewstarSalesOffice apiSalesOffice : salesOfficePagedResult.data) {
       
            //setup the sales office SF object
            Sales_Office__c salesOffice=new Sales_Office__c();

            //set name
            salesOffice.Name=apiSalesOffice.name;
            salesOffice.Is_Active__c=apiSalesOffice.isActive;

            //set SO NEWSTAR ID
            salesOffice.Newstar_ID__c=String.valueOf(apiSalesOffice.Id);
                
            salesOffices.add(salesOffice);

            
            //check if sales office<->sales agent relationships data is included for the sales office...
            if(apiSalesOffice.salesAgents!=null) {

                //if so, iterate the relationship records from the API and build appropriate SF objects
                for (NewstarSalesOfficeSalesAgentRelation newstarSalesOfficeSalesAgentRelation : apiSalesOffice.salesAgents) {       

                    SalesAgentSalesOfficeLink__c salesAgentSalesOfficeLink = new SalesAgentSalesOfficeLink__c();

                    //configure a relationship to the sales agent
                    Sales_Agent__c salesAgent = new Sales_Agent__c(Newstar_ID__c=String.valueOf(newstarSalesOfficeSalesAgentRelation.userId));
                    
                    salesAgentSalesOfficeLink.Name = salesAgent.Name;
                    salesAgentSalesOfficeLink.Sales_Agent__r = salesAgent;

                    //configure the relationship to sales office being processed
                    salesAgentSalesOfficeLink.Sales_Office__r = new Sales_Office__c(Newstar_ID__c=String.valueOf(apiSalesOffice.id));
                    
                    //the NEWSTAR ID of the relationship object refers to the ID  of the relationship in SOUsers in NSS
                    salesAgentSalesOfficeLink.Newstar_ID__c=String.valueOf(newstarSalesOfficeSalesAgentRelation.id);

                    salesAgentSalesOfficeLinks.add(salesAgentSalesOfficeLink);
                }
            }
        }


        //commit sales offices and SO<->sales agent relationships
        SavePoint sp = Database.setSavePoint();

        try {

            Database.upsert(salesOffices, newstarIdField, true);
            Database.upsert(salesAgentSalesOfficeLinks, salesAgentSalesOfficeLinkNewstarIdField, true);
        } 
        catch (Exception e) {
        
            Database.rollback(sp);
            throw e;
        }
       
    }



    /*
        Pulls all NEWSTAR subdivisions and upserts subdivision data into Salesforce.
    */
    public static void ProcessSubdivisions(NewstarClient newstarClient) {
        
        Map<String, Object> subdivisionApiParams=new Map<String, Object>();
        //subdivisionApiParams.put('salesOfficeId',0);
        subdivisionApiParams.put('includeInactive', true);

        NewstarSubdivisionApi subdivisionApi=new NewstarSubdivisionApi(newstarClient);
        NewstarPagedResultSubdivision  subdivisionPagedResult=subdivisionApi.get(subdivisionApiParams);

        List<Subdivision__c> subdivisions=new List<Subdivision__c>();
        Schema.SObjectField newstarIdField = Subdivision__c.Fields.Newstar_ID__c;

        for (NewstarSubdivision apiSubdivision : subdivisionPagedResult.data) {
       
            Subdivision__c subdivision=new Subdivision__c();

            subdivision.Name=apiSubdivision.name;
            subdivision.Newstar_ID__c=String.valueOf(apiSubdivision.Id);
            subdivision.Is_Active__c=apiSubdivision.isActive;


            //construct reference to parent Sales Office using SO's external ID
            Sales_Office__c parentSalesOffice=new Sales_Office__c(Newstar_ID__c=String.valueOf(apiSubdivision.salesOfficeId));
            subdivision.Sales_Office__r=parentSalesOffice;

            subdivisions.add(subdivision);
        }

        Database.upsert(subdivisions, newstarIdField, true);

    }


    public static void ProcessSubdivisionModelsForBatch(NewstarClient newstarClient, List<Subdivision__c> subdivisionBatch) {
        
        List<Model__c> models=new List<Model__c>();
        Schema.SObjectField newstarIdField = Model__c.Fields.Newstar_ID__c;

        for(Subdivision__c subdivision: subdivisionBatch) {
            models.addAll(NewstarMasterDataApiService.GetProcessedSubdivisionModels(newstarClient, subdivision));
        }

        Database.upsert(models, newstarIdField, true);
    }  

    
    private static List<Model__c> GetProcessedSubdivisionModels(NewstarClient newstarClient, Subdivision__c subdivision) {
        
        Map<String, Object> modelApiParams=new Map<String, Object>();
        modelApiParams.put('subdivisionId', Integer.valueOf(subdivision.Newstar_ID__c));

        NewstarModelApi modelApi=new NewstarModelApi(newstarClient);
        NewstarPagedResultModel  modelPagedResult=modelApi.get(modelApiParams);

        List<Model__c> models=new List<Model__c>();
     
        for (NewstarModel apiModel : modelPagedResult.data) {
       
            Model__c model=new Model__c();

            //model code as either pure code of code-elevation combination
            model.Code__c=apiModel.code;
            

            //name
            //NSS returns name as description
            //descriptions are NOT unique when returned for Brookfield because they do NOT account
            //for the elevations
            //if elevation is populated, then append model code to the name
            model.Name=apiModel.name;
            
            if(apiModel.elevation!=null && apiModel.elevation!='') {
                model.Code__c=model.Code__c+'-'+apiModel.elevation;
                model.Name=model.Name+' - elev. '+apiModel.elevation;
            }

            //NEWSTAR ID
            model.Newstar_ID__c=String.valueOf(apiModel.Id);

            //base model product attributes
            model.Beds__c=apiModel.bedrooms;
            model.Baths__c=apiModel.fullBaths;
            model.Half_Baths__c=apiModel.halfBaths;
            model.Garages__c=apiModel.garageCapacity;
            model.Price__c=apiModel.baseModelPrice;
            model.Sq_Ft__c=apiModel.squareFootage;
            model.Is_Active__c=apiModel.isActive;
           
            
            //construct reference to parent subdivision
            model.Subdivision__c=subdivision.Id;

            models.add(model);
        }

        return models;

    }


    public static void ProcessSubdivisionLotsForBatch(NewstarClient newstarClient, List<Subdivision__c> subdivisionBatch) {
        
        List<Lot__c> lots=new List<Lot__c>();
        Schema.SObjectField newstarIdField = Lot__c.Fields.Newstar_ID__c;

        
        for(Subdivision__c subdivision: subdivisionBatch) {
            lots.addAll(NewstarMasterDataApiService.GetProcessedSubdivisionLots(newstarClient, subdivision));
        }

        Database.upsert(lots, newstarIdField, true);
    }



    private static List<Lot__c> GetProcessedSubdivisionLots(NewstarClient newstarClient, Subdivision__c subdivision) {
        
        Map<String, Object> lotApiParams=new Map<String, Object>();
        lotApiParams.put('subdivisionId', Integer.valueOf(subdivision.Newstar_ID__c));

        NewstarLotApi lotApi=new NewstarLotApi(newstarClient);
        NewstarPagedResultLot  lotPagedResult=lotApi.get(lotApiParams);

        List<Lot__c> lots=new List<Lot__c>();
    
        for (NewstarLot apiLot : lotPagedResult.data) {
       
            Lot__c lot=new Lot__c();

            //name, NEWSTAR ID and last sync
            lot.Name=apiLot.lotNumber;
            lot.Newstar_ID__c=String.valueOf(apiLot.Id);

            //resolve lot type 
            lot.Type__c=NewstarDataConversionHelper.normalizeEnumValue(apiLot.lotType.name());
            
            //override availability status to treat UNKNOWN as OPEN and OFFER as SOLD
            if(apiLot.availabilityStatus==NewstarLot.AvailabilityStatusEnum.UNKNOWN){
                apiLot.availabilityStatus=NewstarLot.AvailabilityStatusEnum.OPEN;
            }
            else if(apiLot.availabilityStatus==NewstarLot.AvailabilityStatusEnum.OFFER){
                apiLot.availabilityStatus=NewstarLot.AvailabilityStatusEnum.SOLD;
            }

            //resolve availability status
            lot.Status__c=NewstarDataConversionHelper.normalizeEnumValue(apiLot.availabilityStatus.name());


            //option total (based on LOA builder-approved options) for UNsold spec and model lots
            if((apiLot.lotType==NewstarLot.LotTypeEnum.SPEC 
                || apiLot.lotType==NewstarLot.LotTypeEnum.MODEL)
                && apiLot.availabilityStatus==NewstarLot.AvailabilityStatusEnum.OPEN)
                 {
                   lot.Preconfigured_Options_Amount__c=apiLot.totalOptionsAmount; 
                }

            //set pre-assigned model
            if(apiLot.modelId!=null && apiLot.modelId>0){

                Model__c assignedModelRef=new Model__c(Newstar_ID__c=String.valueOf(apiLot.modelId));
                lot.Assigned_Model__r=assignedModelRef;       
            }
            
             //construct reference to parent subdivision
            lot.Subdivision__c=subdivision.Id;

            //street address
            lot.Street_Address__c=apiLot.address;
            
            //flag indicating if released for sale - used for filtering
            lot.Released_For_Sale__c = apiLot.releasedForSale;

            //flag indicating if released for construction - for information only
            lot.Released_For_Construction__c = apiLot.releasedForConstruction;

            lot.Price__c = apiLot.basePrice;
            lot.Premium__c = apiLot.premium;
            lot.Base_Model_Price_Override__c = apiLot.baseModelPriceOverride;

            lots.add(lot);
        }

        return lots;

    }




    

}