({
     showRecordsData : function(component, event, helper) { 
         component.set('v.columns', [
            {label: 'Subject', fieldName: 'Subject', type: 'text'},
            {label: 'Opportunity', fieldName: 'opportunity', type: 'text'},
            {label: 'Due Date', fieldName: 'ActivityDate', type: 'date'},
            {label: 'Salesoffice', fieldName: 'Salesoffice', type: 'text'},
            {label: 'Marketing Community', fieldName: 'MktComm', type: 'text'}
        ]);
        var action = component.get("c.getTasklist"); 
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue();
  		   for (var i = 0; i < ListItems.length; i++) 
           { 
               var row = ListItems[i]; 
               if (row.Sales_office_mapping) row.Salesoffice = row.Sales_office_mapping__r.Name;
               if (row.Marketing_Community) row.MktComm = row.Marketing_Community__r.Name; 
               if (row.What) row.opportunity = row.What.Name;
           } 

           component.set("v.data", ListItems);
		   
         }
         else if(state === "ERROR")
            {
              var resultsToast = $A.get("e.force:showToast"); 
             	resultsToast.setParams({ 
                "title": "Error", 
                "message": response.getError()[0].message 
                 }); 
            	resultsToast.fire();
             
           }
        }); 
       
        $A.enqueueAction(action); 
     },    

})