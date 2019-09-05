@isTest
private class NewstarHomeScheduleTaskInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo1 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo2 = homeScheduleTaskInfo1;
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo3 = new NewstarHomeScheduleTaskInfo();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo4 = homeScheduleTaskInfo3;

        System.assert(homeScheduleTaskInfo1.equals(homeScheduleTaskInfo2));
        System.assert(homeScheduleTaskInfo2.equals(homeScheduleTaskInfo1));
        System.assert(homeScheduleTaskInfo1.equals(homeScheduleTaskInfo1));
        System.assert(homeScheduleTaskInfo3.equals(homeScheduleTaskInfo4));
        System.assert(homeScheduleTaskInfo4.equals(homeScheduleTaskInfo3));
        System.assert(homeScheduleTaskInfo3.equals(homeScheduleTaskInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo1 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo2 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo3 = new NewstarHomeScheduleTaskInfo();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo4 = new NewstarHomeScheduleTaskInfo();

        System.assert(homeScheduleTaskInfo1.equals(homeScheduleTaskInfo2));
        System.assert(homeScheduleTaskInfo2.equals(homeScheduleTaskInfo1));
        System.assert(homeScheduleTaskInfo3.equals(homeScheduleTaskInfo4));
        System.assert(homeScheduleTaskInfo4.equals(homeScheduleTaskInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo1 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo2 = new NewstarHomeScheduleTaskInfo();

        System.assertEquals(false, homeScheduleTaskInfo1.equals('foo'));
        System.assertEquals(false, homeScheduleTaskInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo1 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo2 = new NewstarHomeScheduleTaskInfo();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo3;

        System.assertEquals(false, homeScheduleTaskInfo1.equals(homeScheduleTaskInfo3));
        System.assertEquals(false, homeScheduleTaskInfo2.equals(homeScheduleTaskInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo1 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo2 = new NewstarHomeScheduleTaskInfo();

        System.assertEquals(homeScheduleTaskInfo1.hashCode(), homeScheduleTaskInfo1.hashCode());
        System.assertEquals(homeScheduleTaskInfo2.hashCode(), homeScheduleTaskInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo1 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo2 = NewstarHomeScheduleTaskInfo.getExample();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo3 = new NewstarHomeScheduleTaskInfo();
        NewstarHomeScheduleTaskInfo homeScheduleTaskInfo4 = new NewstarHomeScheduleTaskInfo();

        System.assert(homeScheduleTaskInfo1.equals(homeScheduleTaskInfo2));
        System.assert(homeScheduleTaskInfo3.equals(homeScheduleTaskInfo4));
        System.assertEquals(homeScheduleTaskInfo1.hashCode(), homeScheduleTaskInfo2.hashCode());
        System.assertEquals(homeScheduleTaskInfo3.hashCode(), homeScheduleTaskInfo4.hashCode());
    }
}