@isTest
private class NewstarPagedResultHomeOptionInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo1 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo2 = pagedResultHomeOptionInfo1;
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo3 = new NewstarPagedResultHomeOptionInfo();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo4 = pagedResultHomeOptionInfo3;

        System.assert(pagedResultHomeOptionInfo1.equals(pagedResultHomeOptionInfo2));
        System.assert(pagedResultHomeOptionInfo2.equals(pagedResultHomeOptionInfo1));
        System.assert(pagedResultHomeOptionInfo1.equals(pagedResultHomeOptionInfo1));
        System.assert(pagedResultHomeOptionInfo3.equals(pagedResultHomeOptionInfo4));
        System.assert(pagedResultHomeOptionInfo4.equals(pagedResultHomeOptionInfo3));
        System.assert(pagedResultHomeOptionInfo3.equals(pagedResultHomeOptionInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo1 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo2 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo3 = new NewstarPagedResultHomeOptionInfo();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo4 = new NewstarPagedResultHomeOptionInfo();

        System.assert(pagedResultHomeOptionInfo1.equals(pagedResultHomeOptionInfo2));
        System.assert(pagedResultHomeOptionInfo2.equals(pagedResultHomeOptionInfo1));
        System.assert(pagedResultHomeOptionInfo3.equals(pagedResultHomeOptionInfo4));
        System.assert(pagedResultHomeOptionInfo4.equals(pagedResultHomeOptionInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo1 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo2 = new NewstarPagedResultHomeOptionInfo();

        System.assertEquals(false, pagedResultHomeOptionInfo1.equals('foo'));
        System.assertEquals(false, pagedResultHomeOptionInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo1 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo2 = new NewstarPagedResultHomeOptionInfo();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo3;

        System.assertEquals(false, pagedResultHomeOptionInfo1.equals(pagedResultHomeOptionInfo3));
        System.assertEquals(false, pagedResultHomeOptionInfo2.equals(pagedResultHomeOptionInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo1 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo2 = new NewstarPagedResultHomeOptionInfo();

        System.assertEquals(pagedResultHomeOptionInfo1.hashCode(), pagedResultHomeOptionInfo1.hashCode());
        System.assertEquals(pagedResultHomeOptionInfo2.hashCode(), pagedResultHomeOptionInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo1 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo2 = NewstarPagedResultHomeOptionInfo.getExample();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo3 = new NewstarPagedResultHomeOptionInfo();
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo4 = new NewstarPagedResultHomeOptionInfo();

        System.assert(pagedResultHomeOptionInfo1.equals(pagedResultHomeOptionInfo2));
        System.assert(pagedResultHomeOptionInfo3.equals(pagedResultHomeOptionInfo4));
        System.assertEquals(pagedResultHomeOptionInfo1.hashCode(), pagedResultHomeOptionInfo2.hashCode());
        System.assertEquals(pagedResultHomeOptionInfo3.hashCode(), pagedResultHomeOptionInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultHomeOptionInfo pagedResultHomeOptionInfo = new NewstarPagedResultHomeOptionInfo();
        System.assertEquals(new List<NewstarHomeOptionInfo>(), pagedResultHomeOptionInfo.data);
        System.assertEquals(null, pagedResultHomeOptionInfo.recordCount);
    }
}