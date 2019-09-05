({
  // Client-side function that invokes the subscribe method on the
  // empApi component.
  subscribe: function (component, event, helper) {
    // Get the empApi component.
    const empApi = component.find('empApi');
    // Get the channel from the attribute.
    const channel = component.get('v.channel');
    // Subscription option to get only new events.
    const replayId = -1;
    // Callback function to be passed in the subscribe call.
    // After an event is received, this callback prints the event
    // payload to the console. A helper method displays the message
    // in the console app.
    const callback = function (message) {
      console.log('Event Received : ' + JSON.stringify(message));
      helper.onReceiveNotification(component, message);
    };
    // Subscribe to the channel and save the returned subscription object.
      empApi.subscribe(channel, replayId, $A.getCallback(callback)).then($A.getCallback(function (newSubscription) {
      console.log('Subscribed to channel ' + channel);
      component.set('v.subscription', newSubscription);
    }));
  },
  onReceiveNotification: function (component, message) {
     try
     {
     var sessionvalue=component.get("v.session");
     //alert(sessionvalue);
     var recordid=  message.data.payload.recordid__c;
     var sessionId= message.data.payload.sessionId__c;
     var objecttype=message.data.payload.objecttype__c;
     //alert(sessionId);
     //alert(sessionvalue + ' ' + recordid + ' '+ sessionId);
     if(sessionvalue==sessionId)
     {
        //alert('hello');
        //alert('Record was created succesfully');
        component.set('v.Spinner', !component.get('v.Spinner'));
         const empApi = component.find('empApi');
    	//empApi.unsubscribe(component.get('v.subscription'), null);
    	/// Unsubscribe from event
    	var subscription= component.get('v.subscription');
         
        empApi.unsubscribe(subscription, $A.getCallback(unsubscribed => {
            
          // Confirm that we have unsubscribed from the event channel
          console.log('Unsubscribed from channel '+ unsubscribed.subscription);
          component.set('v.subscription', null);
            
          
           /* var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
                "recordId": recordid ,
            }); 
            navEvt.fire();*/
            
           //var url= '/lightning/r/' + objecttype +'/'+recordid+'/view';
           //window.parent.location.href=url;
           //alert(url);
           //window.location.href= url;
           //
		   
      
        }).bind(this)); 
            
        /*var navLink = component.find("navLink"); 
		var pageRef = { 
        type: 'standard__recordPage', 
        attributes: { 
                actionName: 'view', 
                objectApiName: objecttype, 
                recordId : recordid // change record id.  
            }, 
        }; 
        navLink.navigate(pageRef, true); */
        var url= '/lightning/r/' + objecttype +'/'+recordid+'/view';
        window.location.href= url;
       }
     }
     catch(e)
        {
        	//alert(e);
        }
          
  },
})