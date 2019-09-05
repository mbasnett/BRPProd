@isTest
private class NewstarPagedResultCustomerInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo1 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo2 = pagedResultCustomerInfo1;
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo3 = new NewstarPagedResultCustomerInfo();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo4 = pagedResultCustomerInfo3;

        System.assert(pagedResultCustomerInfo1.equals(pagedResultCustomerInfo2));
        System.assert(pagedResultCustomerInfo2.equals(pagedResultCustomerInfo1));
        System.assert(pagedResultCustomerInfo1.equals(pagedResultCustomerInfo1));
        System.assert(pagedResultCustomerInfo3.equals(pagedResultCustomerInfo4));
        System.assert(pagedResultCustomerInfo4.equals(pagedResultCustomerInfo3));
        System.assert(pagedResultCustomerInfo3.equals(pagedResultCustomerInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo1 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo2 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo3 = new NewstarPagedResultCustomerInfo();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo4 = new NewstarPagedResultCustomerInfo();

        System.assert(pagedResultCustomerInfo1.equals(pagedResultCustomerInfo2));
        System.assert(pagedResultCustomerInfo2.equals(pagedResultCustomerInfo1));
        System.assert(pagedResultCustomerInfo3.equals(pagedResultCustomerInfo4));
        System.assert(pagedResultCustomerInfo4.equals(pagedResultCustomerInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo1 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo2 = new NewstarPagedResultCustomerInfo();

        System.assertEquals(false, pagedResultCustomerInfo1.equals('foo'));
        System.assertEquals(false, pagedResultCustomerInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo1 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo2 = new NewstarPagedResultCustomerInfo();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo3;

        System.assertEquals(false, pagedResultCustomerInfo1.equals(pagedResultCustomerInfo3));
        System.assertEquals(false, pagedResultCustomerInfo2.equals(pagedResultCustomerInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo1 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo2 = new NewstarPagedResultCustomerInfo();

        System.assertEquals(pagedResultCustomerInfo1.hashCode(), pagedResultCustomerInfo1.hashCode());
        System.assertEquals(pagedResultCustomerInfo2.hashCode(), pagedResultCustomerInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo1 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo2 = NewstarPagedResultCustomerInfo.getExample();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo3 = new NewstarPagedResultCustomerInfo();
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo4 = new NewstarPagedResultCustomerInfo();

        System.assert(pagedResultCustomerInfo1.equals(pagedResultCustomerInfo2));
        System.assert(pagedResultCustomerInfo3.equals(pagedResultCustomerInfo4));
        System.assertEquals(pagedResultCustomerInfo1.hashCode(), pagedResultCustomerInfo2.hashCode());
        System.assertEquals(pagedResultCustomerInfo3.hashCode(), pagedResultCustomerInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultCustomerInfo pagedResultCustomerInfo = new NewstarPagedResultCustomerInfo();
        System.assertEquals(new List<NewstarCustomerInfo>(), pagedResultCustomerInfo.data);
        System.assertEquals(null, pagedResultCustomerInfo.recordCount);
    }
}