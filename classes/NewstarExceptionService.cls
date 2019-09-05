public class NewstarExceptionService {
    
    public static void throwAuraException(String userFriendlyMessagePrefixText, Object ex){ 

        NewstarExceptionData exceptionData=new NewstarExceptionData();
        exceptionData.detailsMessage='';
        
        //check if this is an NEWSTAR API-related exception
        if(ex instanceof OAS.ApiException)
        {
            //cast it as API exception
            OAS.ApiException apiE=(OAS.ApiException)ex;

            //get the original error object set 
            Object errorObject=apiE.getErrorObject();

            //field-level or business-logic level validaton error
            if(errorObject!=null && errorObject instanceof NewstarApiValidationError){
                NewstarApiValidationError apiValidationError=(NewstarApiValidationError) errorObject;

                //special case: business logic validation error
                if(apiValidationError.validationErrors!=null 
                    && apiValidationError.validationErrors.size()==1
                    && apiValidationError.validationErrors[0].field.contains('BusinessLogic')
                    )
                    {
                        NewstarValidationError businessLogicError=apiValidationError.validationErrors[0];
                        exceptionData.detailsMessage=businessLogicError.message;

                        //subcase: dedup error
                        if(businessLogicError.field.contains('Deduplication')) {
                            exceptionData.userFriendlyMessage='The requested operation failed NEWSTAR Sales record deduplication checks.';
                        }
                        else {
                            //all other business logic errors
                            exceptionData.userFriendlyMessage=businessLogicError.message;
                        }
                        
                        exceptionData.userInstructionsMessage='Please contact your sales administrator.';
                    }
                else {
                    //actual field-level validation errors
                    for(NewstarValidationError validationError : apiValidationError.validationErrors){
                        exceptionData.detailsMessage+='\n**Error in field: '+validationError.field+': '+validationError.message;
                    }

                    exceptionData.userFriendlyMessage='Validation errors were encountered processing this request.';
                    exceptionData.userInstructionsMessage='Please review validation error details and contact your administrator.';
                }

                
            }
            //unauthorized access
            else if(errorObject instanceof NewstarApiUnauthorizedError){
                NewstarApiUnauthorizedError apiAuthorizationError=(NewstarApiUnauthorizedError) errorObject;

                exceptionData.detailsMessage+='The NEWSTAR Sales authorization of the request failed: '+apiAuthorizationError.message;
                exceptionData.userFriendlyMessage='NEWSTAR Sales authorization failed';
                exceptionData.userInstructionsMessage='Please try the operation again shortly. If the issue persists, please contact your sales administrator.';
            }
            //generic internal error from the API server
            else if(errorObject instanceof NewstarApiError){
                NewstarApiError apiError=(NewstarApiError) errorObject;

                exceptionData.detailsMessage+='NEWSTAR Sales API internal error encountered: '+apiError.message;
                exceptionData.userFriendlyMessage='NEWSTAR Sales authorization failed';
                 exceptionData.userInstructionsMessage='Please try the operation again shortly. If the issue persists, please contact your sales administrator.';
            }
            //unclassified error, can include transitional network failures
            else {
                exceptionData.detailsMessage+= 'An unexpected error encountered communicating with NEWSTAR Sales: '+apiE.getMessage()+'.\n Body:'+apiE.getBody();
                exceptionData.userFriendlyMessage='NEWSTAR Sales commnuication failed';
                exceptionData.userInstructionsMessage='Please try the operation again shortly. If the issue persists, please contact your sales administrator.';
            }

            exceptionData.userFriendlyMessage=userFriendlyMessagePrefixText+': '+exceptionData.userFriendlyMessage;

            throwAuraExceptionInternal(exceptionData);
        }
        else if (ex instanceof NewstarContractValidationException) {

            NewstarContractValidationException e=(NewstarContractValidationException) ex;
            exceptionData.userFriendlyMessage=e.getMessage();
            throwAuraExceptionInternal(exceptionData);
           
        }
        else if (ex instanceof Exception){
            //generic unhandled exception

            Exception e=(Exception)ex;
            exceptionData.detailsMessage=e.getMessage();
            exceptionData.userFriendlyMessage='Operation failed';
            exceptionData.userInstructionsMessage='Please try the operation again shortly. If the issue persists, please contact your sales administrator.';
        
            throwAuraExceptionInternal(exceptionData);
        }
    }


    private static void throwAuraExceptionInternal(NewstarExceptionData exceptionData)
    {

        String serExceptionData=JSON.serialize(exceptionData);

        NewstarLoggingService.pushLogMessage(serExceptionData, NewstarLoggingService.EventStatus.Failure);
        throw new AuraHandledException(serExceptionData);
    }
   

}