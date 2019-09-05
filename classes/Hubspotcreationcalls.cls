public class Hubspotcreationcalls
{
   public static string createHsformdata(lead leadobj,string selectcommunity) 
   {
       string formdata='';
       
       formdata=formdata +'firstname=' + EncodingUtil.urlEncode(leadobj.firstname,'utf-8');
       formdata=formdata +'&lastname=' + EncodingUtil.urlEncode(leadobj.lastname,'utf-8');
       formdata=formdata +'&email=' + EncodingUtil.urlEncode(leadobj.email,'utf-8');
       formdata=formdata +'&mobile_phone =' + EncodingUtil.urlEncode(leadobj.MobilePhone,'utf-8');
       formdata=formdata +'&phone=' + EncodingUtil.urlEncode(leadobj.Phone,'utf-8');

       formdata=formdata +'&realtor__c=' + leadobj.realtor__c;
       formdata=formdata +'&maritalstatus__c=' + leadobj.maritalstatus__c;
       formdata=formdata +'&hs_email_optout=' + !(leadobj.Consent_to_Follow_Up__c);
       formdata=formdata +'&consent_to_follow_up =' + leadobj.Consent_to_Follow_Up__c;
       list<SalesAgentSalesOfficeLink__c> lstsalesoffice=quickLeadCreate.getSalesOffices(userInfo.getUserId());
       string salesoffice= lstsalesoffice[0].Sales_Office__r.Name;
       sobject s =(sobject) leadobj;
       if(leadobj.realtor__c == false)
       {
           string salesofficeId= lstsalesoffice[0].Sales_Office__r.Id;
           formdata=formdata +'&sales_office_mapping__c=' + EncodingUtil.urlEncode(salesoffice,'utf-8');
           formdata=formdata +'&salesoffice =' + EncodingUtil.urlEncode(salesofficeId,'utf-8');
           //formdata=formdata +'&salesoffice =' + EncodingUtil.urlEncode(salesofficeId,'utf-8');project__c 
           string nameval=BRPValidation.getsalesofficename(salesoffice);
           string communityfieldname='community_picklist_'+ nameval;
           system.debug(communityfieldname);
           system.debug(selectcommunity);
           formdata=formdata +'&' + communityfieldname.toLowerCase() + '=' + EncodingUtil.urlEncode(selectcommunity,'utf-8');
       }
        if(leadobj.Visit_Date__c!=null)
       {
           Datetime dt=leadobj.visit_date__c;
           string d=dt.formatGMT('yyyy-MM-dd');
           system.debug('visit_date__c: ' + d);
           formdata=formdata +'&visit_date__c=' + d ;
       }
       if(leadobj.lead_channel__c!='')
           formdata=formdata +'&lead_channel__c=' + EncodingUtil.urlEncode(leadobj.lead_channel__c ,'utf-8');
       if(leadobj.LeadSource!='')
           formdata=formdata +'&leadsource=' + EncodingUtil.urlEncode(leadobj.leadsource,'utf-8');
       if(leadobj.lead_source_detail__c!='')
           formdata=formdata +'&lead_source_detail__c=' + EncodingUtil.urlEncode(leadobj.lead_source_detail__c,'utf-8');
       if(leadobj.area_of_interest__c!='')
           formdata=formdata +'&area_of_interest__c=' + EncodingUtil.urlEncode(leadobj.area_of_interest__c,'utf-8');
       
       if(leadobj.age_group__c!='')
           formdata=formdata +'&age_group__c=' + EncodingUtil.urlEncode(leadobj.age_group__c,'utf-8');

       if(leadobj.do_you_currently_own_or_rent__c!='')
           formdata=formdata +'&do_you_currently_own_or_rent__c=' + EncodingUtil.urlEncode(leadobj.do_you_currently_own_or_rent__c,'utf-8');
       if(leadobj.are_you_transferring_to_the_area__c!='')
           formdata=formdata +'&are_you_transferring_to_the_area__c=' + EncodingUtil.urlEncode(leadobj.are_you_transferring_to_the_area__c,'utf-8');
        if(leadobj.transferring_to_area_date__c!=null)
       {
           Datetime dt=leadobj.transferring_to_area_date__c;
           string d=dT.format('yyyy-MM-dd');
           formdata=formdata +'&transferring_to_area_date__c=' + d;
       }
       if(leadobj.how_long_have_you_been_house_hunting__c!='')
           formdata=formdata +'&how_long_have_you_been_house_hunting__c=' + EncodingUtil.urlEncode(leadobj.how_long_have_you_been_house_hunting__c,'utf-8');
       if(leadobj.visit_brookfield_website_during_search__c!='')
           formdata=formdata +'&visit_brookfield_website_during_search__c=' + EncodingUtil.urlEncode(leadobj.visit_brookfield_website_during_search__c,'utf-8');
       if(leadobj.household_income__c!='')
           formdata=formdata +'&household_income__c=' + EncodingUtil.urlEncode(leadobj.household_income__c,'utf-8');
       if(leadobj.what_is_your_price_range__c !='')
           formdata=formdata +'&what_is_your_price_range__c =' + EncodingUtil.urlEncode(leadobj.what_is_your_price_range__c ,'utf-8');
       if(leadobj.bedrooms__c!='')
           formdata=formdata +'&bedrooms__c=' + EncodingUtil.urlEncode(leadobj.bedrooms__c,'utf-8');
       if(leadobj.bathrooms__c!='')
           formdata=formdata +'&bathrooms__c=' + EncodingUtil.urlEncode(leadobj.bathrooms__c,'utf-8');
       if(leadobj.Number_of_Children_in_Home__c!='')
           formdata=formdata +'&number_of_children_in_home__c =' + EncodingUtil.urlEncode(leadobj.Number_of_Children_in_Home__c,'utf-8');   
       formdata=formdata +'&Is_Web_Lead__c=' + leadobj.Is_Web_Lead__c;
       formdata=formdata +'&sessionid=' + EncodingUtil.urlEncode(userInfo.getSessionId(),'utf-8'); 
       formdata=formdata +'&createduser=' + EncodingUtil.urlEncode(userInfo.getUserId(),'utf-8'); 
       
       
       
       JSONGenerator pc= JSON.createGenerator(true);
       pc.writeStartObject();
       pc.writeStringField('hutk','76cb4fcc-1514-444a-b627-5714574482b0');
       pc.writeEndObject();
       string body= pc.getAsString();
       formdata=formdata + '&hs_context=' + body;
       system.debug(formdata);
       string url='https://forms.hubspot.com/uploads/form/v2/'+ BRPValidation.getHSFormUrl(salesoffice);
       system.debug('pc: ' + pc);
       HttpRequest req = new HttpRequest();
       req.setEndpoint(url);
       req.setMethod('POST');
        //req.setHeader('Content-Type', 'application/json');
       req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
       req.setBody(formdata); 
       Http http = new Http(); 
          try
            {

            HTTPResponse res = http.send(req);
            Integer retCode = res.getStatusCode();
            if(retCode != 204)
            {
                //s.put('Sales_office_mapping__c',salesoffice);
                //s.put(communityfieldname +'__c',selectcommunity);
                //s.put('sessionId__c',userinfo.getsessionId());
                //lead ld=(lead) s;
                //insert ld;
            }
            String retMsg = res.getStatus();
            }
            catch(exception ex)
            {
            }
      return userInfo.getSessionId();
   }      
}