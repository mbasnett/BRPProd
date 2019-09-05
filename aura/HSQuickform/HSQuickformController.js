({
  // Called when the component is initialized.
  // Subscribes to the channel and displays a toast message.
  // Specifies an error handler function for empApi   
   submitLead: function (component, event, helper) {
    var email=component.find('Email').get('v.value');
    var ldchannel=component.find('LeadchannelSelect').get('v.value');
    var commpicklistvalue=component.find("CommIntSelect").get("v.value");
    var blnrelator=component.find("chkRealtor").get("v.checked");
    var blnerror=false;
    if(email=='')  
    {
        component.set("v.validateError" , true);
        component.set('v.ErrorMsg','Email cannot be empty');
        blnerror=true;
    }
    else
    {
    	var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if(!email.match(regExpEmailformat))
        {
            component.set("v.validateError" , true);
            component.set('v.ErrorMsg','Invalid email address');
            blnerror=true;
        }
    }
    if(component.find("Mobile").checkValidity()==false)
    {
       component.set("v.validateError" , true);
       component.set('v.ErrorMsg','Mobile can only be in number format');
       blnerror=true;
    }
    if(component.find("Phone").checkValidity()==false)
    {
       component.set("v.validateError" , true);
       component.set('v.ErrorMsg','Phone can only be in number format');
       blnerror=true;
    }
    
    //alert(blnrelator);
    if(blnrelator==false)
    {
    	if(ldchannel=='')  
    	{
        	component.set("v.validateError" , true);
        	component.set('v.ErrorMsg','Lead Channel cannot be empty');
        	blnerror=true;
    	}
        if(ldchannel=='Walk-in')
        {
        	if(component.find('Visitdate').get('v.value')=='')
            {
        		component.set("v.validateError" , true);
        		component.set('v.ErrorMsg','Visit date cannot be empty');
        		blnerror=true;
    		}

        }
    	if(commpicklistvalue=='')  
    	{
        	component.set("v.validateError" , true);
        	component.set('v.ErrorMsg','community cannot be empty');
        	blnerror=true;
    	}
    }
    if(blnerror==false)
    {
        component.set("v.validateError" , false);
    	var a=component.get("c.saverecord");
    	$A.enqueueAction(a);  
    }
  },
  // Clear notifications in console app.
  onClear: function (component, event, helper) {
    component.set('v.notifications', []);
  },
  // Mute toast messages and unsubscribe/resubscribe to channel.
  onToggleMute: function (component, event, helper) {
    const isMuted = !(component.get('v.isMuted'));
    component.set('v.isMuted', isMuted);
    if (isMuted) {
      helper.unsubscribe(component, event, helper);
    } else {
      helper.subscribe(component, event, helper);
    }
    helper.displayToast(component, 'success', 'Notifications ' +
      ((isMuted) ? 'muted' : 'unmuted') + '.');
  },
     fetchPicklist : function(component, event, helper){
        var regionpicklistname=component.get("v.regionpicklistname");
        //alert(regionpicklistname);
        var action = component.get("c.getPicklistvalues");
        action.setParams({
            'objectName': 'Lead',
            'field_apinames': 'LeadSource,Age_Group__c,Do_you_currently_own_or_rent__c,' +
            'Are_you_transferring_to_the_area__c,How_long_have_you_been_house_hunting__c,' +
            'TX_Timeframe_to_purchase__c,What_is_your_price_range__c,Bedrooms__c,' +
            'Bathrooms__c,Number_of_Children_in_Home__c,Visit_Brookfield_website_during_search__c,'+
            'Household_Income__c,Area_of_Interest__c,' + regionpicklistname +',Lead_Channel__c' ,
            'nullRequired': true// includes --None--
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var records = response.getReturnValue();
                component.set("v.LeadsourcePicklist", records[0]);
                component.set("v.AgegroupPicklist", records[1]);
                component.set("v.OwnorRentPicklist",records[2]);
                component.set("v.TransfertoareaPicklist",records[3]);
                component.set("v.TimehousehuntPicklist",records[4]);
                component.set("v.PurchasetimePicklist",records[5]);
                component.set("v.PriceRangePicklist",records[6]);
                component.set("v.BedroomPicklist",records[7]);
                component.set("v.BathroomPicklist",records[8]);
                component.set("v.NoofchildrenPicklist",records[9]);
                component.set("v.VisitBrookfielddcPicklist",records[10]);
                component.set("v.HouseholdIncomePicklist",records[11]);
                
                var results=records[12]
                var plvalues=[];
                for(var i=0; i<results.length; i++)
                {
                    plvalues.push({
                        label:results[i],
                        value:results[i]
                    });
                }
                component.set("v.AreaofInterestpicklist",plvalues);
                component.set("v.CommunityOfInterestpicklist",records[13]);
                component.set("v.leadchannelpicklist",records[14]);
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
    handleSelectionchange : function(component, event, helper)
    {
        var selectedvalues= event.getParam("value");
        component.set("v.Selectedareaofinterestpicklist", selectedvalues);
        
    },
    loadjscripts : function(component, event, helper) 
    {
        var fname=component.find("Firstname").get("v.value");
        var lname=component.find("LastName").get("v.value");
        if(fname !== '' && lname !== '')
        {
            var text = "";
            var temp = "temp";
            var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var x = document.forms[0];
            for (var i = 0; i < 4; i++)
               text += possible.charAt(Math.floor(Math.random() * possible.length));
           var emailadd=fname.replace(/\s+/g, '') + '.' + lname.replace(/\s+/g, '') + '.' + text + '@brookfieldtemp.com';
           component.find("Email").set("v.value",emailadd);
           component.set("v.isfakeemail",'true');
        } 
    
    },
    loadSalesoffice : function(component, event, helper) {
              
        var action = component.get("c.getSalesOffices"); 
        var uid=$A.get("$SObjectType.CurrentUser.Id");
        action.setParams({
        	userid: uid
        });
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue(); 
           component.set("v.Salesoffice", ListItems[0].Sales_Office__r.Name);
           var a=component.get("c.getSalesoffname");
           $A.enqueueAction(a); 
           //alert('hello');
           var b=component.get("c.getuserprofile");
    	   $A.enqueueAction(b); 
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
    getSalesoffname:function(component,event,helper)
    {
        var action = component.get("c.getSalesofficename");
        var Salesoffice= component.get("v.Salesoffice");
        action.setParams({
        	sofficename: Salesoffice
        });
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue(); 
           component.set("v.regionpicklistname", 'Community_picklist_'+ListItems+ '__c');
           var a=component.get("c.fetchPicklist");
           $A.enqueueAction(a); 
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
    validatevisitDate: function(component,event,helper)
    {
        //selected date
        var sdate=new Date(component.find('Visitdate').get('v.value'));
        var selectdate= sdate.getFullYear()+'-'+String(sdate.getMonth()+1).padStart(2, '0')+'-'+String(sdate.getDate() +1).padStart(2, '0');
        //today's date        
        var today = new Date();
        var todayFormattedDate =today.getFullYear()+'-'+String(today.getMonth()+1).padStart(2, '0')+'-'+String(today.getDate()).padStart(2, '0');
	    
        var mindate=new Date();
        var day=mindate.getDay();
        var diff=mindate.getDate()-day+(day==0?-6:1)
       // alert(diff);   
        mindate.setDate(diff);
        var compdate=mindate.getFullYear()+'-'+String(mindate.getMonth()+1).padStart(2, '0')+'-'+String(mindate.getDate()).padStart(2, '0');
       // alert(compdate);
       // alert(selectdate);
        
        if(selectdate>todayFormattedDate)
        {
        	component.set("v.dateValidationError" , true);
            component.find('Visitdate').set('v.value','');
        }
        else if(selectdate < compdate)
        {
            component.set("v.dateValidationError" , true);
            component.find('Visitdate').set('v.value','');
        }
        else
        {
           component.set("v.dateValidationError" , false);
        }
 
    },
    checkcontact : function(component,event,helper)
    {
       var mobile=component.find('Mobile').get('v.value');
       var phone=component.find('Phone').get('v.value');
       if(mobile!='' || phone!='')
           component.set("v.isfakeemail",'false');
       else
           component.set("v.isfakeemail",'true');
    },
    saverecord : function(component,event,helper)
    {
    	component.set("v.validateError" , false);
        component.set('v.ErrorMsg','');
        
    	component.set('v.subscription', null);
    	component.set('v.notifications', []);
    // Get empApi component.
    	const empApi = component.find('empApi');
    // Register empApi error listener and pass in the error handler function.
    //empApi.onError($A.getCallback(errorHandler));
    helper.subscribe(component, event, helper);
    //helper.displayToast(component, 'success', 'Ready to receive notifications.');
    var newlead = component.get("v.newLead");
    newlead.MaritalStatus__c=component.find("chkMaritalstatus").get("v.checked");
    newlead.Realtor__c=component.find("chkRealtor").get("v.checked");
    newlead.Consent_to_Follow_Up__c=component.find("chkConsentfollwup").get("v.checked");
    if(component.find("chkWebLead")!=null)
    	newlead.Is_Web_Lead__c=component.find("chkWebLead").get("v.checked");
    //var mobileval=newlead.MobilePhone;
   
    //var leadmobile='(' + mobileval.slice(0,3)  +') ' + mobileval.slice(3,3) +'-' +mobileval.slice(6,4) ;
   //alert(leadmobile);    
    //alert(newlead.Phone);
    //alert(newlead.MobilePhone);
    var regionpicklistname=component.get("v.regionpicklistname");
    var commpicklistvalue=component.find("CommIntSelect").get("v.value");
    newlead.regionpicklistname=commpicklistvalue;
    /*if(regionpicklistname=='Den')
    	newlead.community_picklist_den__c=commpicklistvalue;
    else if(regionpicklistname=='Wash')
        newlead.community_picklist_wash__c=commpicklistvalue;*/
    var a1 =component.find("LeadsourceSelect").get("v.value");
    if(a1!='--None--')
            newlead.LeadSource=a1;
    var a2=component.find("AgeGroupSelect").get("v.value");
    if(a2!='--None--')
            newlead.Age_Group__c=a2;
    var a3=component.find("OwnorRentSelect").get("v.value");
    if(a3!='--None--')
          newlead.Do_you_currently_own_or_rent__c=a3;
    var a4=component.find("TransfertoAreaSelect").get("v.value");
    if(a4!='--None--')
          newlead.Are_you_transferring_to_the_area__c=a4;
    var a5=component.find("TimehousehuntSelect").get("v.value");
    if(a5!='--None--')
          newlead.How_long_have_you_been_house_hunting__c=a5;
    var a6=component.find("PurchaseTimeSelect").get("v.value");
    if(a6!='--None--')
          newlead.TX_Timeframe_to_purchase__c=a6;
    var a7=component.find("PriceRangeSelect").get("v.value");
    if(a7!='--None--')
          newlead.What_is_your_price_range__c=a7;
    var a8=component.find("BedroomSelect").get("v.value");
    if(a8!='--None--')
          newlead.Bedrooms__c=a8;
    var a9=component.find("BathroomSelect").get("v.value");
    if(a9!='--None--')
          newlead.Bathrooms__c=a9;
    var a10=component.find("NoofcildrenSelect").get("v.value");
    if(a10!='--None--')
          newlead.Number_of_Children_in_Home__c=a10
    var a11=component.find("VisitBrookfielddcSelect").get("v.value");
    if(a11!='--None--')
          newlead.Visit_Brookfield_website_during_search__c=a11;
    var a12=component.find("HouseholdincomeSelect").get("v.value");
    if(a12!='--None--')
          newlead.Household_Income__c=a12;
    var a13=component.get("v.Selectedareaofinterestpicklist")
    var results='';
    for(var i=0;i<a13.length; i++)
      {
        if(i== 0)
            results=a13[i];
        else
        results=results+ ';' + a13[i];  
      }
    newlead.Area_of_Interest__c=results;
    var a14=component.find("LeadchannelSelect").get("v.value");
    if(a14!='--None--')
          newlead.Lead_Channel__c=a14;
    var action = component.get("c.SaveHSrecord");
      action.setParams({
        	leadObj: newlead,
            selectcommunity:commpicklistvalue
        });
       action.setCallback(this, function(response) { 
       var state = response.getState(); 
       if (state === "SUCCESS") 
        { 
           var retvalue = response.getReturnValue();
           component.set("v.session",retvalue);
           //alert(component.get("v.session"));
           component.set('v.Spinner', !component.get('v.Spinner'));
        } 
        else if (state === "ERROR")
        {
           var resultsToast = $A.get("e.force:showToast"); 
             	resultsToast.setParams({ 
                "title": "Error", 
                "message": response.getError() 
                 }); 
            	resultsToast.fire();
        }
        }); 
  		$A.enqueueAction(action); 
    
},
    getuserprofile : function(component,event,helper)
    {
        //alert('hello2');
        var uid=$A.get("$SObjectType.CurrentUser.Id");
        //alert(uid);
    	var action = component.get("c.getProfilename");
        action.setParams({
            userid:uid
       });
       action.setCallback(this, function(response) { 
       var state = response.getState();
           //alert(state);
       if (state === "SUCCESS") 
        { 
            var retvalue = response.getReturnValue();
            //alert(retvalue);
            if(retvalue.includes('ISR Profile') || retvalue.includes('System Administrator'))
                component.set("v.showwebLead",true);
            else
            	component.set("v.showwebLead",false);
        }
        else if (state === "ERROR")
        {
        }
       });
       $A.enqueueAction(action); 
    }
})