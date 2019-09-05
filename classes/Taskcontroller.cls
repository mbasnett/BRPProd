public with sharing class Taskcontroller
{
    @Auraenabled
    public static list<task> getTasklist()
    {
        list<task> lstTask= [select Id,what.Name,subject,ActivityDate, Sales_office_mapping__r.Name ,Marketing_Community__r.Name from task where 
        (status !='Completed' or status !='Deferred') and OwnerId=: userinfo.getuserId() ];
        system.debug(lstTask);
        return lstTask;
    }
}