public with sharing class NewstarCustomerInfoController {
    
    public NewstarCustomerInfoController() {

    }


    @AuraEnabled(cacheable=true)
    public static Account getCustomerWithSalesOffices(Id customerAccountId){
        
        return NewstarContractInformationService.getCustomerWithSalesOffices(customerAccountId);
    }


    @AuraEnabled
    public static CustomerInfoResult syncCustomer(Id customerAccountId, List<Id> customerSalesOfficeJunctionIds) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.CustomerInfoSync, 
            String.valueOf(customerAccountId));

        NewstarLoggingService.pushActionStart();

        try {
            CustomerInfoResult result=NewstarCustomerSyncService.syncCustomerInfo(customerAccountId, 
                customerSalesOfficeJunctionIds);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Customer info sync to NEWSTAR failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;
    }   
    

    @AuraEnabled
    public static CobuyerInfoResult syncCobuyer(Id cobuyerId) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.CobuyerSync, 
            String.valueOf(cobuyerId));

        NewstarLoggingService.pushActionStart();

        try {
            CobuyerInfoResult result=NewstarCustomerSyncService.syncCobuyer(cobuyerId);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Cobuyer info sync to NEWSTAR failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }

        return null;
    }   
    
   
}