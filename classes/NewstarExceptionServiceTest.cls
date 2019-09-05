@isTest
private class NewstarExceptionServiceTest {
    
    class TestException extends Exception {}

    @isTest static void testThrowsGeneralException() {

        String userFriendlyMessage='';

        try {
             TestException ex=new TestException();

             NewstarExceptionService.throwAuraException(userFriendlyMessage, ex);
        }
        catch(Exception e){
           System.assert(e instanceof AuraHandledException);
        }
        
    }

    
    @isTest static void testThrowsApiTriggeredExceptionWithValidationError() {

        String userFriendlyMessage='';

        try {
            NewstarApiValidationError apiValidationError=new NewstarApiValidationError();
            apiValidationError.message='Validation failed';
            apiValidationError.validationErrors=new List<NewstarValidationError>();

            NewstarValidationError valError=NewstarValidationError.getExample();         
            apiValidationError.validationErrors.add(valError);

            OAS.ApiException apiException=new OAS.ApiException(500, 'Failed', null, null, apiValidationError);
            NewstarExceptionService.throwAuraException(userFriendlyMessage, apiException);
        }
        catch(Exception e){
           System.assert(e instanceof AuraHandledException);

           // AuraHandledException auraEx=(AuraHandledException)e;
           // System.assert(auraEx.getMessage().contains('Validation'));
        }
        
    }
}