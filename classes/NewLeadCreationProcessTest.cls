@isTest
private class NewLeadCreationProcessTest
{
    static testmethod void CreateLeadTest1()
    {
        test.startTest();
        TestDataFactoryforHS.CreateCustomSetting();
        user u=TestDataFactoryforHS.createISRUser();
        user u2=TestDataFactoryforHS.createSalesUser();
        Sales_Office__c soffice=TestDataFactoryforHS.CreateSalesOffice('Washington Sales Office');
        SalesAgentSalesOfficeLink__c sofficeagent=TestDataFactoryforHS.Createsalesagentlink('standt','Testing',u.Id,soffice.Id);
        
        Marketing_community__c mktcomm=TestDataFactoryforHS.CreateMarketingcommunity('Avendale', soffice.Id);
        Marketing_community__c mktcomm2=TestDataFactoryforHS.CreateMarketingcommunity('Admirals Square', soffice.Id);
        System.runAs(u) 
        { 
            
            Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com',Community_Picklist_Wash__c ='Avendale',
            sales_office_mapping__c='Washington Sales Office',createduser__c=u.Id,lead_channel__c='Online');
            insert ld;
            user us=[select id, profile.Name from user where id=:u.Id];
            string profilename=us.profile.name;
            id userid=us.Id;
            list<account> lstaccount=[select id,Stage__c,Community_Picklist_Wash__pc from account where name='Test1 Lead Tester' and personemail='test1@rediff.com'];
            system.assertEquals(1,lstaccount.size());
            Id accountid;
            if(lstaccount.size()==1)
            {
               lstaccount[0].Community_Picklist_Wash__pc='Admirals Square';
               update lstaccount;
               accountId =lstaccount[0].Id;            
               list<opportunity> lstopp=[select id,sales_office__c,Marketing_Community__c,Internet_Sales_Repr__c,Assigned_Sales_Assistant__c,
               Sales_Agent_Sales_Office_Relationship__c,stageName,Appt_No_Show_Cancel_Reason__c  from opportunity where accountid=:accountid];
               
               
               if(profileName.endswith('ISR profile'))
                    system.assertEquals(lstopp[0].Internet_Sales_Repr__c,sofficeagent.Id);
               if(profileName.endswith('Sales User Profile'))
                    system.assertEquals(lstopp[0].Sales_Agent_Sales_Office_Relationship__c,sofficeagent.Id);
               if(profileName.endswith('Sales Assistant'))
                    system.assertEquals(lstopp[0].Assigned_Sales_Assistant__c,sofficeagent.Id);
            

                system.assertEquals(2,lstopp.size());
                system.assertEquals(lstopp[0].Marketing_Community__c,mktcomm.Id);
                system.assertEquals(lstopp[0].sales_office__c, soffice.Id);
                system.assertEquals(lstopp[1].Marketing_Community__c,mktcomm2.Id);
                system.assertEquals(lstopp[1].sales_office__c, soffice.Id);
                
                              
                // Test rollup opportunity stages to account
                
                system.assertEquals(lstaccount[0].Stage__c,'Prospecting');
                lstopp[1].stageName='Engagement';
                update lstopp;
                lstaccount=[select id,Stage__c,Community_picklist_Wash__pc,community_list_wash__pc,community_history_wash__pc,Appt_No_Show_Cancel_Reason__pc 
                 from account where name='Test1 Lead Tester' and personemail='test1@rediff.com'];
                system.assertEquals(lstaccount[0].Stage__c,'Engagement');
                
                //Test to check History and List multiselect picklist fields on 
                
                system.assertEquals(lstaccount[0].community_list_wash__pc,'Admirals Square;Avendale');
                system.assertEquals(lstaccount[0].community_history_wash__pc,'Admirals Square;Avendale');
                
                lstopp[0].stageName='Quote Closed';
                update lstopp;
                lstaccount=[select id,Stage__c,Community_picklist_Wash__pc,community_list_wash__pc,community_history_wash__pc,Appt_No_Show_Cancel_Reason__pc 
                 from account where name='Test1 Lead Tester' and personemail='test1@rediff.com'];
                system.assertEquals(lstaccount[0].Stage__c,'Quote Closed');
                                
                lstopp[0].stageName='Cancelled';
                lstopp[0].Appt_No_Show_Cancel_Reason__c='Decided to go with a different builder';
                lstopp[1].stageName='Cancelled';
                lstopp[1].Appt_No_Show_Cancel_Reason__c='Decided to go with a different builder';
                update lstopp;
                
                //Test to check if cancellation reason shows up on account
                lstaccount=[select id,Stage__c,Community_picklist_Wash__pc,community_list_wash__pc,community_history_wash__pc,Appt_No_Show_Cancel_Reason__pc 
                 from account where name='Test1 Lead Tester' and personemail='test1@rediff.com'];
                system.assertEquals(lstaccount[0].Stage__c,'Cancelled');
                system.assertEquals(lstaccount[0].Appt_No_Show_Cancel_Reason__pc,'Decided to go with a different builder');
                
                
                
            }
            
        }
        test.stopTest();

        
    }
    /*static testmethod void getSalesofficenameTest()
    {
        string soffname=quickleadcreate.getSalesofficename('Washington Sales Office');
        system.assertequals('Wash', soffname);
    }
    static testmethod void SendHSformTest()
    {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        httpresponse res=Hubspotcreationcalltest.createHsformdata();
        System.assertEquals(204, res.getStatusCode()); 
    }
    static testmethod void getHsformUrltest()
    {
        string formname=BRPValidation.getHSFormUrl('Washington');
        system.assertEquals('6035427/76cb4fcc-1514-444a-b627-5714574482b0',formname);
    }*/
    static testmethod void CreateLeadTest2()
    {
        TestDataFactoryforHS.CreateCustomSetting();
        user u=TestDataFactoryforHS.createISRUser();
        user u2=TestDataFactoryforHS.createSalesUser();
        Sales_Office__c soffice=TestDataFactoryforHS.CreateSalesOffice('Washington Sales Office');
        SalesAgentSalesOfficeLink__c sofficeagent=TestDataFactoryforHS.Createsalesagentlink('standt','Testing',u.Id,soffice.Id);
        
        Marketing_community__c mktcomm=TestDataFactoryforHS.CreateMarketingcommunity('Avendale', soffice.Id);
        Marketing_community__c mktcomm2=TestDataFactoryforHS.CreateMarketingcommunity('Admirals Square', soffice.Id);
        
        System.runAs(u) 
        { 
                 
            Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com',Community_Picklist_Wash__c ='Avendale',
            sales_office_mapping__c='Washington Sales Office',createduser__c=u.Id,lead_channel__c='Online');
            insert ld;
            Lead ld2=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com',Community_Picklist_Wash__c ='Avendale',
            sales_office_mapping__c='Washington Sales Office',createduser__c=u.Id,lead_channel__c='Walk - In');
            string sessionid=quickleadcreate.SaveHSrecord(ld2,'Avendale');
            list<account> lstaccount=[select id from account where name='Test1 Lead Tester' and personemail='test1@rediff.com'];
            system.assertEquals(1,lstaccount.size());
            Id accountid;
            if(lstaccount.size()==1)
            {

               accountId =lstaccount[0].Id;            
               list<opportunity> lstopp=[select id from opportunity where accountid=:accountid];
               system.assertEquals(1,lstopp.size());
               list<OpportunityContactRole> lstopprole=[select Id from OpportunityContactRole where opportunityid=: lstopp[0].Id];
               system.assertEquals(1,lstopprole.size());
           }
        }
     }

    static testmethod void CreateLeadTest3()
    {
        TestDataFactoryforHS.CreateCustomSetting();
        user u=TestDataFactoryforHS.createISRUser();
        user u2=TestDataFactoryforHS.createSalesUser();
        Sales_Office__c soffice=TestDataFactoryforHS.CreateSalesOffice('Washington Sales Office');
        SalesAgentSalesOfficeLink__c sofficeagent=TestDataFactoryforHS.Createsalesagentlink('standt','Testing',u.Id,soffice.Id);
        SalesAgentSalesOfficeLink__c sofficeagent2=TestDataFactoryforHS.Createsalesagentlink('standt2','Testing2',u2.Id,soffice.Id);
        Marketing_community__c mktcomm=TestDataFactoryforHS.CreateMarketingcommunity('Avendale', soffice.Id);
        Marketing_community__c mktcomm2=TestDataFactoryforHS.CreateMarketingcommunity('Admirals Square', soffice.Id);
        
        System.runAs(u) 
        { 
                       
            Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com',Community_Picklist_Wash__c ='Avendale',
            sales_office_mapping__c='Washington Sales Office',createduser__c=u.Id,lead_channel__c='Online');
            insert ld;
            Lead ld2=new Lead(FirstName='Test2',LastName='Lead Tester2', Email='test2@rediff.com',Community_Picklist_Wash__c ='Avendale',
            sales_office_mapping__c='Washington Sales Office',createduser__c=u.Id,lead_channel__c='Walk-in');
            insert ld2;
             //Test to check if record shared with salesoffice ISR group only
            list<account> lstaccount=[select id,Stage__c,Community_Picklist_Wash__pc from account where name='Test1 Lead Tester' and personemail='test1@rediff.com'];
            system.assertEquals(1,lstaccount.size());
            Id accountid;
            list<account> lstaccount2=[select id,Stage__c,Community_Picklist_Wash__pc from account where name='Test2 Lead Tester2' and personemail='test2@rediff.com'];
            Id accountid2;
            if(lstaccount.size()==1)
            {
                accountId =lstaccount[0].Id;            
                accountId2 =lstaccount2[0].Id;            
                list<opportunity> lstopp=[select id,sales_office__c,Marketing_Community__c,Internet_Sales_Repr__c,Assigned_Sales_Assistant__c,
                Sales_Agent_Sales_Office_Relationship__c,stageName,Appt_No_Show_Cancel_Reason__c  from opportunity where accountid=:accountid];
                list<opportunity> lstopp2=[select id,sales_office__c,Marketing_Community__c,Internet_Sales_Repr__c,Assigned_Sales_Assistant__c,
                Sales_Agent_Sales_Office_Relationship__c,stageName,Appt_No_Show_Cancel_Reason__c  from opportunity where accountid=:accountid2];
               
                string query='select Id from Group where Type = \'Regular\' and  Name like \'Wash Online Sales\'';
                List<group> lstISRgrp=Database.query(query);
                    
                string query2='select Id from Group where Type = \'Regular\' and  Name like \'Avendale\'';
                List<group> lstcommgrp=Database.query(query2);
                
                string oppId=lstopp[0].Id;
                string oppId2=lstopp2[0].Id;
                
                //ISR group only 
                list<opportunityshare> lstoppshare=[select id from opportunityshare where opportunityid=:oppId and UserOrGroupId=:lstISRgrp[0].Id ];
                system.assertEquals(1,lstoppshare.size());
                list<opportunityshare> lstoppshare2=[select id from opportunityshare where opportunityid=:oppId and UserOrGroupId=:lstcommgrp[0].Id ];
                system.assertEquals(0,lstoppshare2.size());
                
                // Community groups
                list<opportunityshare> lstoppsharecomm=[select id from opportunityshare where opportunityid=:oppId2 and UserOrGroupId=:lstISRgrp[0].Id];
                system.assertEquals(0,lstoppsharecomm.size());
                list<opportunityshare> lstoppsharecomm2=[select id from opportunityshare where opportunityid=:oppId2 and UserOrGroupId=:lstcommgrp[0].Id ];
                system.assertEquals(1,lstoppsharecomm2.size());
                
                //Test when ISR assigns opportunity record to Sales user a new sharing rule is created.
                lstopp[0].Sales_Agent_Sales_Office_Relationship__c=new BRPValidation().getSalesAgentOfficeId(u2.Id);
                update lstopp;
                
                lstoppshare=[select id from opportunityshare where opportunityid=:oppId and UserOrGroupId=:lstISRgrp[0].Id ];
                system.assertEquals(1,lstoppshare.size());
                lstoppshare2=[select id from opportunityshare where opportunityid=:oppId and UserOrGroupId=:lstcommgrp[0].Id ];
                system.assertEquals(1,lstoppshare2.size());
                
                
                Beback__c bback=new Beback__c(Opportunity__c=lstopp[0].Id,Notes_Added_by__c=u.Name,Notes__c='Test note1',visit_date__c=date.today());
                insert bback;
                Beback__c bback2=new Beback__c(Opportunity__c=lstopp[0].Id,Notes_Added_by__c=u.Name,Notes__c='Test note2',visit_date__c=date.today(),Is_be_back__c=true);
                insert bback2;
                list<beback__c> lstbback=[select Id from beback__c where opportunity__c=: lstopp[0].Id];
                system.assertEquals(2,lstbback.size());
                string notes=Notessummary.Getnotes('Account',accountid);
                system.debug(notes);
                string dtstr=date.today().day() + '-'+ date.today().Month() + '-' + date.today().year();
                string comparenotes=dtstr +'</br>Project: Avendale</br>null: Test note1</p>' + dtstr + ': Is Be back</br>Project: Avendale</br>null: Test note2</p>';
                system.debug(comparenotes);
                system.assertEquals(notes,comparenotes);
                
            }
         }
    }
     static testmethod void testcommonfunctions()
     {
        TestDataFactoryforHS.CreateCustomSetting();
        user u=TestDataFactoryforHS.createISRUser();
        user u2=TestDataFactoryforHS.createSalesUser();
        Sales_Office__c soffice=TestDataFactoryforHS.CreateSalesOffice('Washington Sales Office');
        SalesAgentSalesOfficeLink__c sofficeagent=TestDataFactoryforHS.Createsalesagentlink('standt','Testing',u.Id,soffice.Id);
        
        Marketing_community__c mktcomm=TestDataFactoryforHS.CreateMarketingcommunity('Avendale', soffice.Id);
        Marketing_community__c mktcomm2=TestDataFactoryforHS.CreateMarketingcommunity('Admirals Square', soffice.Id);
        
        System.runAs(u) 
        { 
            list<SalesAgentSalesOfficeLink__c> lstsaleasoffagent=quickleadcreate.getSalesOffices(u.Id);
            system.assertEquals(1,lstsaleasoffagent.size());
            system.assertEquals(soffice.Id,lstsaleasoffagent[0].Sales_Office__r.Id);
            list<Marketing_community__c>lstmktcomm=quickleadcreate.getMktcommunity(soffice.Id);
            system.assertNotEquals(0,lstmktcomm.size());
            List<List<String>>lstpicklistvalues=quickleadcreate.getPicklistvalues('Lead','Community_pickList_Den__c',false);
            system.assertEquals(1,lstpicklistvalues.size());
            list<string>lstcomm=lstpicklistvalues[0];
            system.assertEquals(7,lstcomm.size());
            //system.assertEquals('Barefoot Lakes',lstcomm[0]);
        }
     
     } 
}