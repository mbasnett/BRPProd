public with sharing class CachedCollections {
   /*private static boolean run = true;
   public static boolean runOnce(){
    System.debug('run variable: ' + run);
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }*/

  /* private List <Marketing_Community__c> myCommunityList {
        get {
            if(myCommunityList == null){
                myCommunityList = [SELECT Name,Id,sales_office__c,sales_office__r.Name,Other_groups_can_Read__c  From Marketing_Community__c];
            }
        return myCommunityList;
        }
    set;
    }

     private Map<String, Marketing_Community__c> myCommunityMap {
        get {
            if(myCommunityMap == null){
                myCommunityMap = new Map<String, Marketing_Community__c>();
                for(Marketing_Community__c comm: myCommunityList) {
                    myCommunityMap.put(comm.Name, comm);
                }
            }
            system.debug(myCommunityMap);
            return myCommunityMap;
        }
        set;
    }
     private Map<Id,String> myCommunityIdMap {
        get {
            if(myCommunityIdMap == null){
                myCommunityIdMap = new Map<Id,String>();
                for(Marketing_Community__c comm: myCommunityList) {
                    myCommunityIdMap.put(comm.Id,comm.Name);
                }
            }
            return myCommunityIdMap;
        }
        set;
    }
     private Map<Id,String> mySalesOfficeIdMap {
        get {
            if(mySalesOfficeIdMap == null){
                mySalesOfficeIdMap = new Map<Id,String>();
                for(Sales_office__c soff: mySalesofficeList ) {
                    mySalesOfficeIdMap.put(soff.Id,soff.Name);
                }
            }
            return mySalesOfficeIdMap ;
        }
        set;
    }
    public  List <Sales_office__c> mySalesofficeList {
        get {
            if(mySalesofficeList == null){
                mySalesofficeList = [SELECT Name, Id From Sales_office__c];
            }
        return mySalesofficeList ;
        }
    set;
    }
     private Map<String, Sales_office__c> mySalesofficeMap {
        get {
            if(mySalesofficeMap == null){
                mySalesofficeMap = new Map<String, Sales_office__c>();
                for(Sales_office__c soff: mySalesofficeList ) {
                    mySalesofficeMap.put(soff.Name, soff);
                }
            }
            return mySalesofficeMap ;
        }
        set;
    }*/
    public Map<String, Marketing_Community__c> getCachecommunityMapNames
    {
        get {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<String, Marketing_Community__c> getCachecommunityMapNames= (Map<String, Marketing_Community__c>)orgPart.get('CommunityMapNames'); 
            if (getCachecommunityMapNames==null) 
            {
                getCachecommunityMapNames=new map<string,Marketing_Community__c>();
                for(marketing_community__c mkt:[SELECT Name,Id,sales_office__c,sales_office__r.Name,Other_groups_can_Read__c  From Marketing_Community__c])
                {
                    getCachecommunityMapNames.put(mkt.name,mkt);
                }
                orgPart.put('CommunityMapNames', getCachecommunityMapNames);
                
            }
            system.debug(getCachecommunityMapNames);
            return getCachecommunityMapNames;
            }
            
        set;

    }
    public  Map<Id,String> getCachecommunityMapIds
    {
        get {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<Id,String> getCachecommunityMapIds = (Map<Id,String>)orgPart.get('CommunityMapIds'); 
            if (getCachecommunityMapIds ==null) 
            {
                getCachecommunityMapIds=new map<Id,String>();
                for(marketing_community__c mkt:[SELECT Name,Id,sales_office__c,sales_office__r.Name,Other_groups_can_Read__c  From Marketing_Community__c])
                {
                    getCachecommunityMapIds.put(mkt.Id,mkt.Name);
                }
                orgPart.put('CommunityMapIds', getCachecommunityMapIds);
                
            }
            return getCachecommunityMapIds;
            }
            
        set;

    }
     public  Map<Id,Marketing_Community__c> getCachecommunityMapIdsExtended
    {
        get {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<Id,Marketing_Community__c> getCachecommunityMapIdsExtended = (Map<Id,Marketing_Community__c>)orgPart.get('CommunityMapIdsExtended'); 
            if (getCachecommunityMapIdsExtended ==null) 
            {
                getCachecommunityMapIdsExtended=new map<Id,Marketing_Community__c>();
                for(marketing_community__c mkt:[SELECT Name,Id,sales_office__c,sales_office__r.Name,Other_groups_can_Read__c,  Sales_Process_Type__c  From Marketing_Community__c])
                {
                    getCachecommunityMapIdsExtended.put(mkt.Id,mkt);
                }
                orgPart.put('CommunityMapIdsExtended', getCachecommunityMapIdsExtended);
                
            }
            return getCachecommunityMapIdsExtended;
            }
            
        set;

    }
 public  Map<String, sales_office__c> getCacheSalesofficeMapNames
    {
        get {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<String, sales_office__c> getCacheSalesofficeMapNames= (Map<String, sales_office__c>)orgPart.get('SalesofficeMapNames');
            if (getCacheSalesofficeMapNames==null) 
            {
                getCacheSalesofficeMapNames=new map<string,sales_office__c>();
                for(sales_office__c soff:[SELECT Name, Id From Sales_office__c])
                {
                    getCacheSalesofficeMapNames.put(soff.name,soff);
                }
                orgPart.put('SalesofficeMapNames', getCacheSalesofficeMapNames);
                
            }
            return getCacheSalesofficeMapNames;
            }
            
        set;

    }
    public  Map<Id,String> getCacheSalesofficeMapIds
    {
        get {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<Id,String> getCacheSalesofficeMapIds= (Map<Id,String>)orgPart.get('SalesofficeMapIds'); 
            if (getCacheSalesofficeMapIds==null) 
            {
                getCacheSalesofficeMapIds=new map<Id,string>();
                for(sales_office__c soff:[SELECT Name, Id From Sales_office__c])
                {
                    getCacheSalesofficeMapIds.put(soff.Id,soff.Name);
                }
                orgPart.put('SalesofficeMapIds', getCacheSalesofficeMapIds);
                
            }
            return getCacheSalesofficeMapIds;
            }
            
        set;

    }
    public map<string, group> getGroup
    {
        get
        {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<String,group> getGroup= (Map<String,group>)orgPart.get('BRPGroups'); 
            if (getGroup==null) 
            {
                getGroup=new map<string,group>();
                for(group grp:[select Id,Name from Group where Type = 'Regular'])
                {
                    getGroup.put(grp.Name,grp);
                }
                orgPart.put('BRPGroups', getGroup);
            }
            return getGroup;
        }
           set;
    }
    public  Map<String, subdivision__c> getCacheProjectMapNames
    {
        get {
            Cache.OrgPartition orgPart = Cache.Org.getPartition('local.BRPCache2019');
            Map<String, subdivision__c> getCacheProjectMapNames= (Map<String, subdivision__c>)orgPart.get('ProjectMapNames'); 
            if (getCacheProjectMapNames==null) 
            {
                getCacheProjectMapNames=new map<string,subdivision__c>();
                for(subdivision__c sdiv:[select Id,Name from subdivision__c])
                {
                    getCacheProjectMapNames.put(sdiv.Name,sdiv);
                }
                orgPart.put('ProjectMapNames', getCacheProjectMapNames);
            }
            return getCacheProjectMapNames;
            }
            
        set;

    }
}