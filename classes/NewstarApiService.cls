public with sharing class NewstarApiService {
  
    /*
        Provides an authenticated API client object that can be used to interact with
        an instance of NEWSTAR API.
    */
    public static NewstarClient getAuthenticatedClient() {

        NewstarLoginCredentials creds=new NewstarLoginCredentials();
        creds.username='{!$Credential.Username}';
        creds.password='{!$Credential.Password}';

        Map<String,Object> loginParams=new Map<String,Object>();
        loginParams.put('newstarLoginCredentials', creds);

        NewstarTokenApi tokenApi=new NewstarTokenApi();
        NewstarLoginToken loginToken=tokenApi.create(loginParams);

        NewstarClient newstarClient=new NewstarClient();
        newstarClient.setApiKey('Bearer '+loginToken.value);

        return newstarClient;

    }


    /*
        Returns a query locator for subdivision-based batch processing of data from NEWSTAR API.
    */
    public static Database.QueryLocator GetNewstarPullBatchSubdivisionQueryLocator() {
        
        //return a query locator for all subdivisions that originated in NEWSTAR
        return Database.getQueryLocator([SELECT Id, Name, Newstar_ID__c 
                                            FROM Subdivision__c 
                                            WHERE Newstar_ID__c!=''
                                            ORDER BY Name]);
    }


   

}