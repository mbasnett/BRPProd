public class NewstarSubdivisionExplorerData {

    @AuraEnabled
    public List<Model__c> models {get; set;}
    

    @AuraEnabled
    public List<Lot__c> lots {get; set;}

    @AuraEnabled
    public List<Special_Offer__c> specialOffers {get; set;}

    @AuraEnabled
    public Opportunity currentOpportunity{get; set; }

    @AuraEnabled
    public List<Opportunity> alternateOpportunities {get; set;}

    @AuraEnabled
    public List<Subdivision__c> availableSubdivisions {get; set;}
    

    public NewstarSubdivisionExplorerData() {

    }
}