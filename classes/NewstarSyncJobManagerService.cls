public with sharing class NewstarSyncJobManagerService {

    public static final String JobEventNotificationObjectId='##SYNCJOBCMP##';
  
    private static List<NewstarSyncJobInfo> syncJobInfos=new List<NewstarSyncJobInfo>();


    public static NewstarSyncJobInfo initiateSync(List<NewstarSyncTarget> syncTargets) {

        if(syncTargets==null || syncTargets.size()>1) {
            throw new NewstarJobSyncException('Currently only one NEWSTAR sync target is supported.');
        }

        NewstarSyncTarget initialSyncTarget=syncTargets[0];

        NewstarSyncJobInfo initialSyncJob=new NewstarSyncJobInfo();
        initialSyncJob.jobType=initialSyncTarget.JobType;

        startBatchableForSyncJob(initialSyncJob);
        return initialSyncJob;
    }


    public static List<NewstarSyncJobInfo> getSyncJobsStatuses() {
     

        List<NewstarSyncJobInfo> snapshotJobInfos=new List<NewstarSyncJobInfo>();

        for(NewstarSyncJobInfo jobInfo: syncJobInfos) {
            
            NewstarSyncJobInfo snapshotJobInfo=jobInfo.copyOf();
            snapshotJobInfos.add(snapshotJobInfo);

            AsyncApexJob nativeApexJob=getNativeJobByClassId(snapshotJobInfo.classId);
            
            //status of the job is unknown
            if(nativeApexJob==null) continue;

            snapshotJobInfo.status=getJobStatus(nativeApexJob.Status);
            snapshotJobInfo.lastCompletedDate=nativeApexJob.CompletedDate;
            snapshotJobInfo.internalJobType=getInternalJobType(nativeApexJob.JobType);
            snapshotJobInfo.extendedStatus=nativeApexJob.ExtendedStatus;

        }

        return snapshotJobInfos;
    }


    private static void startBatchableForSyncJob(NewstarSyncJobInfo syncJob) {
        Database.Batchable<SObject> syncBatchable=getBatchable(syncJob);
        Database.executeBatch(syncBatchable);
    }


    private static Database.Batchable<SObject> getBatchable(NewstarSyncJobInfo syncJob){

        if(syncJob.jobType==NewstarSyncJobInfo.JobType.GEOGRAPHY_LAYOUT) {
            return (Database.Batchable<SObject>) new PullNewstarGeographyLayoutBatch(null);
        }
        else if(syncJob.jobType==NewstarSyncJobInfo.JobType.SALES_AGENT) {
            return (Database.Batchable<SObject>) new PullNewstarSalesAgentsBatch(null);
        }
        else if(syncJob.jobType==NewstarSyncJobInfo.JobType.SALES_OFFICE) {
            return (Database.Batchable<SObject>) new PullNewstarSalesOfficesBatch(null);
        }
        else if(syncJob.jobType==NewstarSyncJobInfo.JobType.SUBDIVSION) {
            return (Database.Batchable<SObject>)new PullNewstarSubdivisionsBatch(null);
        }
        else if(syncJob.jobType==NewstarSyncJobInfo.JobType.MODEL) {
            return (Database.Batchable<SObject>) new PullNewstarSubdivisionModelsBatch(null);
        }
        else if(syncJob.jobType==NewstarSyncJobInfo.JobType.LOT) {
            return new PullNewstarSubdivisionLotsBatch(null);
        }
         else if(syncJob.jobType==NewstarSyncJobInfo.JobType.OPPORTUNITY_UPDATE) {
            return(Database.Batchable<SObject>) new RefreshOpportunityPricesBatch();
        }

        throw new NewstarJobSyncException('Unsupported NEWSTAR sync job type encountered: '+syncJob.jobType.name());
    }
   


    private static Id getJobClassId(List<ApexClass> jobClasses, NewstarSyncJobInfo jobInfo){

        for(ApexClass jobClass : jobClasses) {
            if(jobClass.Name==jobInfo.className) {
                return jobClass.Id;
            }
        }

        return null;
    }


    private static AsyncApexJob getNativeJobByClassId(Id classId) {
         
          List<AsyncApexJob> nativeApexJobs=[
            SELECT 
                ApexClassID,
                CompletedDate,
                ExtendedStatus,
                JobItemsProcessed,
                JobType,
                NumberOfErrors,
                Status,
                TotalJobItems
            FROM 
                AsyncApexJob
            WHERE 
               ApexClassID =:classId
            ORDER BY CompletedDate DESC
            LIMIT 1

        ];

        if(nativeApexJobs.size()==1) {
            return nativeApexJobs[0];
        }

        return null;
    }


    private static NewstarSyncJobInfo.JobStatus getJobStatus(String jobStatusStringValue) {

        List< NewstarSyncJobInfo.JobStatus> jobStatusEnumValues=NewstarSyncJobInfo.JobStatus.values();

        for( NewstarSyncJobInfo.JobStatus jobStatusEnumValue: jobStatusEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(jobStatusEnumValue.name())==jobStatusStringValue) {
                    return jobStatusEnumValue;
                }
        }

        return NewstarSyncJobInfo.JobStatus.UNKNOWN;
    }


    private static NewstarSyncJobInfo.InternalJobType getInternalJobType(String internalJobTypeStringValue) {

        List< NewstarSyncJobInfo.InternalJobType> internalJobTypeEnumValues=NewstarSyncJobInfo.InternalJobType.values();

        for( NewstarSyncJobInfo.InternalJobType internalJobTypeEnumValue: internalJobTypeEnumValues) {

                if(NewstarDataConversionHelper.normalizeEnumValue(internalJobTypeEnumValue.name())==internalJobTypeStringValue) {
                    return internalJobTypeEnumValue;
                }
        }

        return NewstarSyncJobInfo.InternalJobType.BATCHAPEX;
    }




    static {

        syncJobInfos.add(new NewstarSyncJobInfo('Geography layout', NewstarSyncJobInfo.JobType.GEOGRAPHY_LAYOUT, PullNewstarGeographyLayoutBatch.class));
        syncJobInfos.add(new NewstarSyncJobInfo('Sales agents', NewstarSyncJobInfo.JobType.SALES_AGENT, PullNewstarSalesAgentsBatch.class));
        syncJobInfos.add(new NewstarSyncJobInfo('Sales offices', NewstarSyncJobInfo.JobType.SALES_OFFICE, PullNewstarSalesOfficesBatch.class));
        syncJobInfos.add(new NewstarSyncJobInfo('Subdivisions',NewstarSyncJobInfo.JobType.SUBDIVSION, PullNewstarSubdivisionsBatch.class));
        syncJobInfos.add(new NewstarSyncJobInfo('Models', NewstarSyncJobInfo.JobType.MODEL, PullNewstarSubdivisionModelsBatch.class));
        syncJobInfos.add(new NewstarSyncJobInfo('Lots', NewstarSyncJobInfo.JobType.LOT, PullNewstarSubdivisionLotsBatch.class));
        syncJobInfos.add(new NewstarSyncJobInfo('Opp. refresh', NewstarSyncJobInfo.JobType.OPPORTUNITY_UPDATE, RefreshOpportunityPricesBatch.class));


        List<String> apexJobClassNames=new List<String>();
        for(NewstarSyncJobInfo jobInfo: syncJobInfos) {
            apexJobClassNames.add(jobInfo.className);
        }


        List<ApexClass> jobClasses=[
            SELECT 
              Id,
              Name
            FROM 
                ApexClass
            WHERE 
               Name IN: apexJobClassNames
        ];


        for(NewstarSyncJobInfo jobInfo: syncJobInfos) {

            Id classId=getJobClassId(jobClasses, jobInfo);

            if(classId==null) {
                throw new NewstarJobSyncException('Unable to locate class ID for job: '+jobInfo.className);
            }

            jobInfo.classId=classId;
        }



    }

    


}