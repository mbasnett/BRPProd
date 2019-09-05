public with sharing class NewstarContingencyService {

    public static void setContingency(Contigency__c con, NewstarContingencyInfo contingencyInfo) {

        con.Newstar_ID__c = contingencyInfo.ContingencyExternalId;          

        con.Type__c = contingencyInfo.Type;

        if (contingencyInfo.ExpiryDate != null)
            con.Expiry_date__c = contingencyInfo.ExpiryDate;

        con.Met_date__c = contingencyInfo.MetDate;
        
        con.Notes__c = contingencyInfo.Notes;
     } 

}