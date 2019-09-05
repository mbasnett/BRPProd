@isTest
private class NewstarPagedResultHomeScheduleTaskInTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo1 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo2 = pagedResultHomeScheduleTaskInfo1;
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo3 = new NewstarPagedResultHomeScheduleTaskIn();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo4 = pagedResultHomeScheduleTaskInfo3;

        System.assert(pagedResultHomeScheduleTaskInfo1.equals(pagedResultHomeScheduleTaskInfo2));
        System.assert(pagedResultHomeScheduleTaskInfo2.equals(pagedResultHomeScheduleTaskInfo1));
        System.assert(pagedResultHomeScheduleTaskInfo1.equals(pagedResultHomeScheduleTaskInfo1));
        System.assert(pagedResultHomeScheduleTaskInfo3.equals(pagedResultHomeScheduleTaskInfo4));
        System.assert(pagedResultHomeScheduleTaskInfo4.equals(pagedResultHomeScheduleTaskInfo3));
        System.assert(pagedResultHomeScheduleTaskInfo3.equals(pagedResultHomeScheduleTaskInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo1 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo2 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo3 = new NewstarPagedResultHomeScheduleTaskIn();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo4 = new NewstarPagedResultHomeScheduleTaskIn();

        System.assert(pagedResultHomeScheduleTaskInfo1.equals(pagedResultHomeScheduleTaskInfo2));
        System.assert(pagedResultHomeScheduleTaskInfo2.equals(pagedResultHomeScheduleTaskInfo1));
        System.assert(pagedResultHomeScheduleTaskInfo3.equals(pagedResultHomeScheduleTaskInfo4));
        System.assert(pagedResultHomeScheduleTaskInfo4.equals(pagedResultHomeScheduleTaskInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo1 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo2 = new NewstarPagedResultHomeScheduleTaskIn();

        System.assertEquals(false, pagedResultHomeScheduleTaskInfo1.equals('foo'));
        System.assertEquals(false, pagedResultHomeScheduleTaskInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo1 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo2 = new NewstarPagedResultHomeScheduleTaskIn();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo3;

        System.assertEquals(false, pagedResultHomeScheduleTaskInfo1.equals(pagedResultHomeScheduleTaskInfo3));
        System.assertEquals(false, pagedResultHomeScheduleTaskInfo2.equals(pagedResultHomeScheduleTaskInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo1 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo2 = new NewstarPagedResultHomeScheduleTaskIn();

        System.assertEquals(pagedResultHomeScheduleTaskInfo1.hashCode(), pagedResultHomeScheduleTaskInfo1.hashCode());
        System.assertEquals(pagedResultHomeScheduleTaskInfo2.hashCode(), pagedResultHomeScheduleTaskInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo1 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo2 = NewstarPagedResultHomeScheduleTaskIn.getExample();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo3 = new NewstarPagedResultHomeScheduleTaskIn();
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo4 = new NewstarPagedResultHomeScheduleTaskIn();

        System.assert(pagedResultHomeScheduleTaskInfo1.equals(pagedResultHomeScheduleTaskInfo2));
        System.assert(pagedResultHomeScheduleTaskInfo3.equals(pagedResultHomeScheduleTaskInfo4));
        System.assertEquals(pagedResultHomeScheduleTaskInfo1.hashCode(), pagedResultHomeScheduleTaskInfo2.hashCode());
        System.assertEquals(pagedResultHomeScheduleTaskInfo3.hashCode(), pagedResultHomeScheduleTaskInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultHomeScheduleTaskIn pagedResultHomeScheduleTaskInfo = new NewstarPagedResultHomeScheduleTaskIn();
        System.assertEquals(new List<NewstarHomeScheduleTaskInfo>(), pagedResultHomeScheduleTaskInfo.data);
        System.assertEquals(null, pagedResultHomeScheduleTaskInfo.recordCount);
    }
}