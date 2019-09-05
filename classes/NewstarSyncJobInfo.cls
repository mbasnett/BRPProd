public class NewstarSyncJobInfo {
    
    @AuraEnabled
    public string id {get; set;}
  
    @AuraEnabled
    public String name {get; set;}

    @AuraEnabled
    public JobType jobType {get; set;}

    @AuraEnabled
    public String jobTypeText {
        get {
            return this.jobType==null ? null : NewstarDataConversionHelper.normalizeEnumValue(this.jobType.name());
        }
    }
    
    @AuraEnabled
    public JobStatus status {get; set;}

    @AuraEnabled
    public String statusText {
        get {
            return this.status==null ? null : NewstarDataConversionHelper.normalizeEnumValue(this.status.name());
        }
    }

   
    @AuraEnabled
    public InternalJobType internalJobType {get; set;}
    
    @AuraEnabled
    public String internalJobTypeText {
        get {
            return this.internalJobType==null ? null : NewstarDataConversionHelper.normalizeEnumValue(this.internalJobType.name());
        }
    }

    @AuraEnabled
    public Type type {get; set; }

    @AuraEnabled
    public String extendedStatus {get; set;}
    
    @AuraEnabled
    public String className {get; set;}
    
    @AuraEnabled
    public Id classId {get; set;}

    @AuraEnabled
    public Datetime lastCompletedDate {get; set;}

    @AuraEnabled
    public Boolean isRunning {get {
        return runningJobStatuses.contains(this.status);
    }}


    public NewstarSyncJobInfo() {
        this.status=NewstarSyncJobInfo.JobStatus.UNKNOWN;
    }


    public NewstarSyncJobInfo(String name, JobType jobType, Type type) {
        this.name=name;
        this.jobType=jobType;
        this.type=type;
        this.className=type.getName();
        this.status=NewstarSyncJobInfo.JobStatus.UNKNOWN;
    }


    public NewstarSyncJobInfo copyOf() {
        NewstarSyncJobInfo jobInfo=new NewstarSyncJobInfo();
        
        jobInfo.id=this.id;
        jobInfo.name=this.name;
        jobInfo.type=this.type;
        jobInfo.status=this.status;
        jobInfo.internalJobType=this.internalJobType;
        jobInfo.type=this.type;
        jobInfo.className=this.className;
        jobInfo.classId=this.classId;

        return jobInfo;
    }


    public enum JobType {
        GEOGRAPHY_LAYOUT,
        SALES_AGENT,
        SALES_OFFICE,
        SUBDIVSION,
        MODEL,
        LOT,
        OPPORTUNITY_UPDATE
    }


    public enum InternalJobType {
        FUTURE,
        SHARING,
        RECALCULATION,
        SCHEDULEDAPEX,
        BATCHAPEX,
        BATCHAPEXWORKER,
        TESTREQUEST,
        TESTWORKER,
        APEXTOKEN,
        QUEUEABLE
    }

    
    public enum JobStatus {

        HOLDING,
        QUEUED,
        PREPARING,
        PROCESSING,
        COMPLETED,
        ABORTED,
        FAILED,
        UNKNOWN
    }


    static List<JobStatus> runningJobStatuses;


    static {
        runningJobStatuses=new List<JobStatus>();
        runningJobStatuses.add(JobStatus.HOLDING);
        runningJobStatuses.add(JobStatus.QUEUED);
        runningJobStatuses.add(JobStatus.PREPARING);
        runningJobStatuses.add(JobStatus.PROCESSING);
    }
}