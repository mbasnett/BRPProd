({
	showRecordsData : function(component, event, helper) { 
        var recordId=component.get('v.recordId');
        var action = component.get("c.getOppSharingGroups"); 
        action.setParams({
            'Id': recordId});
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue();
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