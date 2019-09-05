@isTest
private class NewstarPagedResultHomeInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo1 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo2 = pagedResultHomeInfo1;
        NewstarPagedResultHomeInfo pagedResultHomeInfo3 = new NewstarPagedResultHomeInfo();
        NewstarPagedResultHomeInfo pagedResultHomeInfo4 = pagedResultHomeInfo3;

        System.assert(pagedResultHomeInfo1.equals(pagedResultHomeInfo2));
        System.assert(pagedResultHomeInfo2.equals(pagedResultHomeInfo1));
        System.assert(pagedResultHomeInfo1.equals(pagedResultHomeInfo1));
        System.assert(pagedResultHomeInfo3.equals(pagedResultHomeInfo4));
        System.assert(pagedResultHomeInfo4.equals(pagedResultHomeInfo3));
        System.assert(pagedResultHomeInfo3.equals(pagedResultHomeInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo1 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo2 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo3 = new NewstarPagedResultHomeInfo();
        NewstarPagedResultHomeInfo pagedResultHomeInfo4 = new NewstarPagedResultHomeInfo();

        System.assert(pagedResultHomeInfo1.equals(pagedResultHomeInfo2));
        System.assert(pagedResultHomeInfo2.equals(pagedResultHomeInfo1));
        System.assert(pagedResultHomeInfo3.equals(pagedResultHomeInfo4));
        System.assert(pagedResultHomeInfo4.equals(pagedResultHomeInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo1 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo2 = new NewstarPagedResultHomeInfo();

        System.assertEquals(false, pagedResultHomeInfo1.equals('foo'));
        System.assertEquals(false, pagedResultHomeInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo1 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo2 = new NewstarPagedResultHomeInfo();
        NewstarPagedResultHomeInfo pagedResultHomeInfo3;

        System.assertEquals(false, pagedResultHomeInfo1.equals(pagedResultHomeInfo3));
        System.assertEquals(false, pagedResultHomeInfo2.equals(pagedResultHomeInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo1 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo2 = new NewstarPagedResultHomeInfo();

        System.assertEquals(pagedResultHomeInfo1.hashCode(), pagedResultHomeInfo1.hashCode());
        System.assertEquals(pagedResultHomeInfo2.hashCode(), pagedResultHomeInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo1 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo2 = NewstarPagedResultHomeInfo.getExample();
        NewstarPagedResultHomeInfo pagedResultHomeInfo3 = new NewstarPagedResultHomeInfo();
        NewstarPagedResultHomeInfo pagedResultHomeInfo4 = new NewstarPagedResultHomeInfo();

        System.assert(pagedResultHomeInfo1.equals(pagedResultHomeInfo2));
        System.assert(pagedResultHomeInfo3.equals(pagedResultHomeInfo4));
        System.assertEquals(pagedResultHomeInfo1.hashCode(), pagedResultHomeInfo2.hashCode());
        System.assertEquals(pagedResultHomeInfo3.hashCode(), pagedResultHomeInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultHomeInfo pagedResultHomeInfo = new NewstarPagedResultHomeInfo();
        System.assertEquals(new List<NewstarHomeInfo>(), pagedResultHomeInfo.data);
        System.assertEquals(null, pagedResultHomeInfo.recordCount);
    }
}