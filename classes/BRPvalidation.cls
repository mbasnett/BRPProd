public without sharing class BRPvalidation
{
   
   public void genericInterestcreation( sobject s,string actiontype,string val, string activelistfieldname, string historylistfieldname  )
   {
      list<string> lstcommunity=new list<string>();
      list<string> lstcommunityHist=new list<string>();
      string activevalue=(string)s.get(activelistfieldname);
      string historyvalue=(string)s.get(historylistfieldname);
      system.debug(activevalue);
      system.debug(historyvalue);
      if(activevalue!=null)
          lstcommunity = activevalue.split(';');
      if(historyvalue!=null)
          lstcommunityHist = historyvalue.split(';');
      if(lstcommunity.size()>0)
          {
              if(actiontype=='Insert')
                   {
                       if(lstCommunity.contains(val)==false)
                          s.put(activelistfieldname, activevalue + ';' + val);
                   }
              else if(actiontype=='Delete')
                   {
                       lstcommunity.remove(lstCommunity.indexOf(val));
                       string newlist='';
                       for(integer i=0;i<lstcommunity.size();i++)
                       newlist = newlist + ';' + lstcommunity[i];
                       s.put(activelistfieldname,newlist);                                 
                   }

           }
       else
           {
               if(actiontype=='Insert')
                   s.put(activelistfieldname, val);

           }
                          
       if(lstcommunityHist.size()>0)
           {
               if(actiontype=='Insert')
                   {
                        if(lstcommunityHist.contains(val)==false)
                             s.put(historylistfieldname  , historyvalue + ';' + val);
                   }
           }
        else
           {
               if(actiontype=='Insert')
                         s.put(historylistfieldname, val);

           }
      
   }
   public static string getsalesofficename(sobject s)
    {
        string sname=(string) s.get('sales_office_mapping__c');
        BRPSalesSettings__c soffname= BRPSalesSettings__c.getInstance(sname.split(' ')[0]);
        return soffname.Sales_Office_Name__c ;
    }
    public static string getsalesofficename(string sname)
    {
        //string sname=(string) s.get('sales_office_mapping__c');
        BRPSalesSettings__c soffname= BRPSalesSettings__c.getInstance(sname.split(' ')[0]);
        return soffname.Sales_Office_Name__c ;
    }
    public static String getSobjectNameById(Id inputId)
    {
        Schema.SObjectType sobjectType = inputId.getSObjectType();
        return sobjectType.getDescribe().getName();
    }
    public static string getHSFormUrl(string sname)
    {
        //string sname=(string) s.get('sales_office_mapping__c');
        BRPSalesSettings__c soffname= BRPSalesSettings__c.getInstance(sname.split(' ')[0]);
        return soffname.HsFormurl__c ;
    }
    public static boolean getSharingType(string sname)
    {
        //string sname=(string) s.get('sales_office_mapping__c');
        BRPSalesSettings__c soffname= BRPSalesSettings__c.getInstance(sname.split(' ')[0]);
        return soffname.SharingType__c   ;
    }
   /* public static void getGroup(Id oppId,List<string> mktcomm,string Accesslevel)
    {
           string query='select Id from Group where Type = \'Regular\' and ';
           for(integer i=0; i<mktcomm.size();i++)
           {
                if(mktcomm.size()==1)
                    query = query + ' Name like \'%' + String.escapeSingleQuotes(mktcomm[i])  +'%\'';
                else
                {  
                    if(i==0) 
                        query=query + '( Name like \'%' + String.escapeSingleQuotes(mktcomm[i])  +'%\'';
                    else if( i==mktcomm.size()-1)
                    {
                        query=query + ' or Name like \'%' + String.escapeSingleQuotes(mktcomm[i])  +'%\')';
                    }
                    else
                    {
                        query=query + ' or Name like \'%' + String.escapeSingleQuotes(mktcomm[i])  +'%\'';
                    }
                }
            }
           system.debug(query);
           list<Group> u =Database.query(query);
           OpportunitySharing.manualShareRead(oppId,u,AccessLevel);
    }*/
    public static string rollupOppstages(Id accountId)
    {
        string retstage='';
        List<Aggregateresult> groupedResults =[select stagename,count(ID) total from opportunity where accountid=: accountId group by stagename ];
        map<string,Integer> mpAccountoppostages=new map<String,Integer>();
        integer recordtotal=0;
        for (AggregateResult ar : groupedResults)  
        {
            mpAccountoppostages.put((string)ar.get('stagename'),(integer) ar.get('total'));
            recordtotal=recordtotal + (integer) ar.get('total');
        //    mpAccountoppostages.put(opp.Id,opp.StageName);
        }
        if(recordtotal == mpAccountoppostages.get('Prospecting'))
            retstage='Prospecting';
        else if(recordtotal == mpAccountoppostages.get('Cancelled'))
            retstage='Cancelled' + '~' + getCancelorLossreason(accountId,'Appt_No_Show_Cancel_Reason__c');
        else if(recordtotal == mpAccountoppostages.get('Lost'))
            retstage='Lost' + '~' + getCancelorLossreason(accountId,'Loss_Reason__c');
        else if(mpAccountoppostages.get('Closed Home')!=null)
            retstage='Closed Home';
        else if(mpAccountoppostages.get('Under Contract')!=null)
            retstage='Under Contract';
        else if(mpAccountoppostages.get('Pending Offer')!=null)
            retstage='Pending Offer';
        else if(mpAccountoppostages.get('Contract Ready')!=null)
            retstage='Contract Ready';
        else if(mpAccountoppostages.get('Lot Reservation')!=null)
            retstage='Lot Reservation';
        else if(mpAccountoppostages.get('Quote Closed')!=null)
            retstage='Quote Closed';
        else if(mpAccountoppostages.get('Quote/Selection')!=null)
            retstage='Quote/Selection';
        else if(mpAccountoppostages.get('Engagement')!=null)
            retstage='Engagement';
              
        return retstage;
    }
    private static string getCancelorLossreason(Id accountid,string fieldname )
    {
        string sqlQuery='Select ' + fieldname + ' from opportunity where accountid=: accountId order by Opp_Cancel_Loss_Date__c  desc limit 1';
        list<opportunity> lstopp=Database.query(sqlQuery);
        sobject s=lstopp[0];
        return (string)s.get(fieldname); 
    }
    public list<String> getOppSharingGroups(string Id)
    {
      list<string> lstshrgroups=new list<string> ();
      for(group g: [select Name from Group where Type = 'Regular' and Id  In (select userorgroupid from opportunityshare where opportunityid=:Id)])
          lstshrgroups.add(g.Name);
      return lstshrgroups;
    }
  private static list<string> getcommunitynames(string sofficename,string commname)
  {
     list<string> lstcommunityname=new list<string>();
     list<string>lstsecondlist=new list<string>();
     //system.debug(sofficename);
     //string nameval=BRPValidation.getsalesofficename(sofficename);
     List<List<string>> lstarrayCommunityname= quickLeadCreate.getPicklistvalues('account','community_picklist_' + sofficename +'__pc',false);
     for(integer i=0;i<lstarrayCommunityname.size();i++)
     {
         lstcommunityname.addall(lstarrayCommunityname[i]);
     }
     for(integer i=0;i<lstcommunityname.size();i++)
     {
         if(lstcommunityname[i] !=commname)
             lstsecondlist.add(lstcommunityname[i]);
     }
     return lstsecondlist;
  }
  public void ShareOppwithcommunity(list<Opportunity> lstopp)
  {
       
      // Sales team Group owning the community being added to opportunity share
               //list<string> lstprimarycommname=new list<string>();
               //lstprimarycommname.add(mktcomm);
         Map<Id,string> mpmktcomm=new Cachedcollections().getCachecommunityMapIds;
         map<string,Marketing_community__c> mpmktcommobj=new Cachedcollections().getCachecommunityMapNames;
         map<string,group> mpgroup=new Cachedcollections().getGroup;
         map<Id,list<Group>> mpoppuserOrGroupId=new map<Id,list<Group>>();
         for(opportunity opp:lstopp)
         {
               
               string mktcomm=mpmktcomm.get(opp.Marketing_Community__c);
               Marketing_community__c mktcommobj=mpmktcommobj.get(mktcomm);
               
               list<group> lstgroup=new list<group>();
               if(mpgroup.get(mktcomm)!=null)
               {
                   lstgroup.add(mpgroup.get(mktcomm));
                   mpoppuserOrGroupId.put(opp.Id,lstgroup);
               }
               //system.debug('Add opportunityshare for group owner');
              /* string soffname=BRPValidation.getsalesofficename(mktcommobj.sales_office__r.Name);
               if(brpValidation.getSharingType(mktcommobj.sales_office__r.Name)==true)
               {
                   if(mktcommobj.Other_groups_can_Read__c==true)
                   {
                       // system.debug('Add opportunityshare for others');
                        list<string> lstcommunityname=getcommunitynames(soffname,mktcomm);
                        list<group> u=new list<group>();
                        for(string s:lstcommunityname)
                        {
                            if(mpgroup.get(s)!=null)
                                u.add(mpgroup.get(s));
                        }
                        //BRPValidation.getGroup(oppId,lstcommunityname,'Read');
                        OpportunitySharing.manualShareRead(opp.Id,u,'Read');
                   }
               }*/
         }
         OpportunitySharing.manualShareRead(mpoppuserOrGroupId,'Edit');
 
  }
  public void AssigntoISRgroup(list<Opportunity> lstopp)
  {
         try
         {
          //ISR for that salesoffice being added to opportunity share
         Map<Id,string> mpmktcomm=new Cachedcollections().getCachecommunityMapIds;
         map<string,Marketing_community__c> mpmktcommobj=new Cachedcollections().getCachecommunityMapNames;
         map<string,group> mpgroup=new Cachedcollections().getGroup;
         map<Id,list<Group>> mpoppuserOrGroupId=new map<Id,list<Group>>();
         for(opportunity opp:lstopp)
         {
              string mktcomm=mpmktcomm.get(opp.Marketing_Community__c);
              Marketing_community__c mktcommobj=mpmktcommobj.get(mktcomm);
              string soffname=BRPValidation.getsalesofficename(mktcommobj.sales_office__r.Name);
              //list<string> lstsalesoffname=new list<string>();
          //lstsalesoffname.add(soffname);
              list<group> lstcommunitysalesname=new list<group>();
              system.debug(mpgroup);
              if(mpgroup.get(soffname + ' Online Sales')!=null)
              {
                   lstcommunitysalesname.add(mpgroup.get(soffname + ' Online Sales'));
                   mpoppuserOrGroupId.put(opp.Id,lstcommunitysalesname);
              }
              
          }
          OpportunitySharing.manualShareRead(mpoppuserOrGroupId,'Edit');
          }
          catch(exception ex)
          {
              system.debug(ex.getmessage());
          }
       
          //BRPValidation.getGroup(oppId,lstsalesoffname,'Edit');
  }

  public string getProfileName(string userId)
  {
      string retvalue='';
      for(user u :[SELECT Id,profile.Name From User where id =: userId limit 1])
      {
          retvalue=u.profile.name;
      }
      return retvalue;
  }
  public string getSalesAgentOfficeId(string UserId)
  {
      string retvalue='';
      for(SalesAgentSalesOfficeLink__c sagent :[SELECT Id From SalesAgentSalesOfficeLink__c where Sales_Agent__r.Related_to_User__c  =: userId and is_primary__c=true limit 1])
      {
          retvalue=sagent.Id;
      }
      return retvalue;
  }
}