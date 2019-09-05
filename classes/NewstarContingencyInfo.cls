public class NewstarContingencyInfo {
    
    public String ContingencyExternalId {get; set;}
    public String Type {get; set;}
    public Date ExpiryDate {get; set;}
    public Date MetDate {get; set;}
    public String Notes {get; set;}
    
    public NewstarContingencyInfo() {
        this.ContingencyExternalId='';
        this.Type='';
        this.ExpiryDate = null;
        this.MetDate = null;
        this.Notes = '';
    }
}