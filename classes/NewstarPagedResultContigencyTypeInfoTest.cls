@isTest
private class NewstarPagedResultContigencyTypeInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo1 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo2 = pagedResultContigencyTypeInfo1;
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo3 = new NewstarPagedResultContigencyTypeInfo();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo4 = pagedResultContigencyTypeInfo3;

        System.assert(pagedResultContigencyTypeInfo1.equals(pagedResultContigencyTypeInfo2));
        System.assert(pagedResultContigencyTypeInfo2.equals(pagedResultContigencyTypeInfo1));
        System.assert(pagedResultContigencyTypeInfo1.equals(pagedResultContigencyTypeInfo1));
        System.assert(pagedResultContigencyTypeInfo3.equals(pagedResultContigencyTypeInfo4));
        System.assert(pagedResultContigencyTypeInfo4.equals(pagedResultContigencyTypeInfo3));
        System.assert(pagedResultContigencyTypeInfo3.equals(pagedResultContigencyTypeInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo1 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo2 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo3 = new NewstarPagedResultContigencyTypeInfo();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo4 = new NewstarPagedResultContigencyTypeInfo();

        System.assert(pagedResultContigencyTypeInfo1.equals(pagedResultContigencyTypeInfo2));
        System.assert(pagedResultContigencyTypeInfo2.equals(pagedResultContigencyTypeInfo1));
        System.assert(pagedResultContigencyTypeInfo3.equals(pagedResultContigencyTypeInfo4));
        System.assert(pagedResultContigencyTypeInfo4.equals(pagedResultContigencyTypeInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo1 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo2 = new NewstarPagedResultContigencyTypeInfo();

        System.assertEquals(false, pagedResultContigencyTypeInfo1.equals('foo'));
        System.assertEquals(false, pagedResultContigencyTypeInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo1 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo2 = new NewstarPagedResultContigencyTypeInfo();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo3;

        System.assertEquals(false, pagedResultContigencyTypeInfo1.equals(pagedResultContigencyTypeInfo3));
        System.assertEquals(false, pagedResultContigencyTypeInfo2.equals(pagedResultContigencyTypeInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo1 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo2 = new NewstarPagedResultContigencyTypeInfo();

        System.assertEquals(pagedResultContigencyTypeInfo1.hashCode(), pagedResultContigencyTypeInfo1.hashCode());
        System.assertEquals(pagedResultContigencyTypeInfo2.hashCode(), pagedResultContigencyTypeInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo1 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo2 = NewstarPagedResultContigencyTypeInfo.getExample();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo3 = new NewstarPagedResultContigencyTypeInfo();
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo4 = new NewstarPagedResultContigencyTypeInfo();

        System.assert(pagedResultContigencyTypeInfo1.equals(pagedResultContigencyTypeInfo2));
        System.assert(pagedResultContigencyTypeInfo3.equals(pagedResultContigencyTypeInfo4));
        System.assertEquals(pagedResultContigencyTypeInfo1.hashCode(), pagedResultContigencyTypeInfo2.hashCode());
        System.assertEquals(pagedResultContigencyTypeInfo3.hashCode(), pagedResultContigencyTypeInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultContigencyTypeInfo pagedResultContigencyTypeInfo = new NewstarPagedResultContigencyTypeInfo();
        System.assertEquals(new List<NewstarContigencyTypeInfo>(), pagedResultContigencyTypeInfo.data);
        System.assertEquals(null, pagedResultContigencyTypeInfo.recordCount);
    }
}