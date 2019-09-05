public class HubspotcreationcallTest
{
       public static HTTPResponse createHsformdata() 
       {
       
           Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
           string formdata='';
       
           formdata=formdata +'firstname=' + EncodingUtil.urlEncode('Test','utf-8');
           formdata=formdata +'&lastname=' + EncodingUtil.urlEncode('Test1','utf-8');
           formdata=formdata +'&email=' + EncodingUtil.urlEncode('test1test1@hellotest.com','utf-8');
           formdata=formdata +'&mobile_phone =' + EncodingUtil.urlEncode('2343523556','utf-8');
           formdata=formdata +'&phone=' + EncodingUtil.urlEncode('2343523556','utf-8');

           formdata=formdata +'&realtor__c=false';
           formdata=formdata +'&maritalstatus__c=false';
           formdata=formdata +'&hs_email_optout=true';
           formdata=formdata +'&sales_office_mapping__c=' + EncodingUtil.urlEncode('Washington Sales Office','utf-8');
           string nameval='Wash';
           string communityfieldname='community_picklist_'+ nameval;

           formdata=formdata +'&' + communityfieldname.toLowerCase() + '=' + EncodingUtil.urlEncode('Avendale','utf-8');
           JSONGenerator pc= JSON.createGenerator(true);
           pc.writeStartObject();
           pc.writeStringField('hutk','76cb4fcc-1514-444a-b627-5714574482b0');
           pc.writeEndObject();
           string body= pc.getAsString();
           formdata=formdata + '&hs_context=' + body;
           string url='https://forms.hubspot.com/uploads/form/v2/6035427/76cb4fcc-1514-444a-b627-5714574482b0';
           HttpRequest req = new HttpRequest();
           req.setEndpoint(url);
           req.setMethod('POST');
        //req.setHeader('Content-Type', 'application/json');
           req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
           req.setBody(formdata); 
           Http http = new Http(); 
           HTTPResponse res = http.send(req);
           return res;
       }
}