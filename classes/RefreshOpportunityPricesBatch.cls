global class RefreshOpportunityPricesBatch
	implements
		Database.Batchable<SObject>, 
		Database.AllowsCallouts,
		Database.Stateful {

            global Database.QueryLocator start(Database.BatchableContext bc) {
                System.debug('Executing Salesforce Refresh Opportunity Prices job start...');

                  NewstarPushNotificationsService.publishNewstarNotificationEvent(
                    NewstarSyncJobManagerService.JobEventNotificationObjectId, 
                    'Job started');
               
                return Database.getQueryLocator([SELECT Name, StageName, Base_Model_Price__c, Lot_Price__c, Lot_Premium__c, Total_Options_Amount__c,  
                    		    		 		 Model__r.Name, Model__r.Price__c, Lot__r.Name, Lot__r.Price__c, Lot__r.Premium__c, Lot__r.Base_Model_Price_Override__c, 
                    		   		 			 Lot__r.Preconfigured_Options_Amount__c  
							    				 FROM Opportunity   
							    				 WHERE (StageName = 'Prospecting' OR StageName = 'Engagement')]);
            }            
            
            global void execute(Database.BatchableContext bc, List<Opportunity> scope) {
                System.debug('Executing Salesforce Refresh Opportunity Prices job execute...');

                for(Opportunity s : scope) {

                    if (s.Lot__r.Base_Model_Price_Override__c == null)          
                        s.Base_Model_Price__c = s.Model__r.Price__c;
                    else 
                        s.Base_Model_Price__c = s.Lot__r.Base_Model_Price_Override__c;

                    s.Lot_Price__c = s.Lot__r.Price__c;
                    s.Lot_Premium__c = s.Lot__r.Premium__c;
                    s.Total_Options_Amount__c = s.Lot__r.Preconfigured_Options_Amount__c;
                }    
                
                update scope;
            }
            
            global void finish(Database.BatchableContext bc) {
                NewstarPushNotificationsService.publishNewstarNotificationEvent(
                    NewstarSyncJobManagerService.JobEventNotificationObjectId, 
                    'Job completed successfully');

                System.debug('Finished Salesforce Refresh Opportunity Prices job');
            }
}