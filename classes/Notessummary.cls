public inherited sharing class Notessummary
{
    public lead leadObj{get; set;} 
    public account acctobj{get;set;}
    public string notes{get; set;}
    public Notessummary(ApexPages.StandardController controller) 
    {
      this.notes='';
      String type = controller.getRecord().getSObjectType().getDescribe().getName();
      if(type=='Account')
          this.acctobj = (Account)Controller.getRecord();
     this.notes=Getnotes(type,acctobj.Id);
    }
    public Notessummary() 
    {
     
    }
    public static string Getnotes(string type,string accId)
    {
        list<beBack__c> prospectnotes;
        if(type=='Account')
            prospectnotes=[select notes__c,visit_date__c,name, is_be_back__c, opportunity__c,opportunity__r.marketing_community__r.Name,Notes_Added_by__c
            from beback__c where  opportunity__c in
            (select id from opportunity where accountid =: accId) order by visit_date__c desc];
        system.debug(prospectnotes);
        string note='';
        for(beback__c n: prospectnotes)
        {            //system.debug(n.Community_of_Interest__r.marketing_community__r.Name);
            Date dt=n.Visit_date__c;
            string beback=': Is Be back';
            if(n.is_be_back__c==true)
             {
                 if(type=='Account')
                      note=note+ dt.day() + '-'+ dt.Month() + '-' + dt.year() + beback +'</br>' + 'Project: '
                    + n.opportunity__r.marketing_community__r.Name +'</br>'
                    + n.Notes_Added_by__c  + ': ' + n.notes__c + '</p>';
             }
                 
            else 
              {  
                 system.debug('hello');
                 if(type=='Account')
                     note=note+ dt.day() + '-'+ dt.Month() + '-' +dt.year() +'</br>' 
                     + 'Project: ' + n.opportunity__r.marketing_community__r.Name +'</br>'
                     + n.Notes_Added_by__c  + ': ' + n.notes__c + '</p>';
               }
                 
           
        }
       system.debug(note);
       return note;
    }
}