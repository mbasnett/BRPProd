public class OpportunitySharing {
   
   public static void manualShareRead(map<Id,list<Group>> mpoppuserOrGroupId,string Accesslevel)
   {
      // Create new sharing object for the custom object Job.
      OpportunityShare[] oppsharearray=new opportunityshare[]{};
      list<Id> lstoppIds=new list<Id>(mpoppuserOrGroupId.keyset());
      for(Id i:lstoppIds)
      {
          list<group> lstuserOrGroupId=mpoppuserOrGroupId.get(i);
          for(Group userOrGroupId : lstuserOrGroupId)
          {
              OpportunityShare oppShr  = new OpportunityShare();
   
      // Set the ID of record being shared.
              oppShr.OpportunityId= i;
        
      // Set the ID of user or group being granted access.
              oppShr.UserOrGroupId = userOrGroupId.Id;
        
      // Set the access level.
              oppShr.OpportunityAccessLevel= Accesslevel;
              oppShr.RowCause = 'Manual';
              oppsharearray.add(oppShr);  
          }
       }
          Database.SaveResult[] srList = Database.insert(oppsharearray,false);
          for (Database.SaveResult sr : srList) 
          {
              if(sr.isSuccess())
              {
              }
              else 
              {
                 Database.Error err = sr.getErrors()[0];
                 if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  err.getMessage().contains('AccessLevel'))
                 {
                 }
                 else
                 {
                 }
              }
           }
    }
  
}