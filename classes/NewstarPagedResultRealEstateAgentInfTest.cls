@isTest
private class NewstarPagedResultRealEstateAgentInfTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo1 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo2 = pagedResultRealEstateAgentInfo1;
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo3 = new NewstarPagedResultRealEstateAgentInf();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo4 = pagedResultRealEstateAgentInfo3;

        System.assert(pagedResultRealEstateAgentInfo1.equals(pagedResultRealEstateAgentInfo2));
        System.assert(pagedResultRealEstateAgentInfo2.equals(pagedResultRealEstateAgentInfo1));
        System.assert(pagedResultRealEstateAgentInfo1.equals(pagedResultRealEstateAgentInfo1));
        System.assert(pagedResultRealEstateAgentInfo3.equals(pagedResultRealEstateAgentInfo4));
        System.assert(pagedResultRealEstateAgentInfo4.equals(pagedResultRealEstateAgentInfo3));
        System.assert(pagedResultRealEstateAgentInfo3.equals(pagedResultRealEstateAgentInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo1 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo2 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo3 = new NewstarPagedResultRealEstateAgentInf();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo4 = new NewstarPagedResultRealEstateAgentInf();

        System.assert(pagedResultRealEstateAgentInfo1.equals(pagedResultRealEstateAgentInfo2));
        System.assert(pagedResultRealEstateAgentInfo2.equals(pagedResultRealEstateAgentInfo1));
        System.assert(pagedResultRealEstateAgentInfo3.equals(pagedResultRealEstateAgentInfo4));
        System.assert(pagedResultRealEstateAgentInfo4.equals(pagedResultRealEstateAgentInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo1 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo2 = new NewstarPagedResultRealEstateAgentInf();

        System.assertEquals(false, pagedResultRealEstateAgentInfo1.equals('foo'));
        System.assertEquals(false, pagedResultRealEstateAgentInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo1 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo2 = new NewstarPagedResultRealEstateAgentInf();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo3;

        System.assertEquals(false, pagedResultRealEstateAgentInfo1.equals(pagedResultRealEstateAgentInfo3));
        System.assertEquals(false, pagedResultRealEstateAgentInfo2.equals(pagedResultRealEstateAgentInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo1 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo2 = new NewstarPagedResultRealEstateAgentInf();

        System.assertEquals(pagedResultRealEstateAgentInfo1.hashCode(), pagedResultRealEstateAgentInfo1.hashCode());
        System.assertEquals(pagedResultRealEstateAgentInfo2.hashCode(), pagedResultRealEstateAgentInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo1 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo2 = NewstarPagedResultRealEstateAgentInf.getExample();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo3 = new NewstarPagedResultRealEstateAgentInf();
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo4 = new NewstarPagedResultRealEstateAgentInf();

        System.assert(pagedResultRealEstateAgentInfo1.equals(pagedResultRealEstateAgentInfo2));
        System.assert(pagedResultRealEstateAgentInfo3.equals(pagedResultRealEstateAgentInfo4));
        System.assertEquals(pagedResultRealEstateAgentInfo1.hashCode(), pagedResultRealEstateAgentInfo2.hashCode());
        System.assertEquals(pagedResultRealEstateAgentInfo3.hashCode(), pagedResultRealEstateAgentInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultRealEstateAgentInf pagedResultRealEstateAgentInfo = new NewstarPagedResultRealEstateAgentInf();
        System.assertEquals(new List<NewstarRealEstateAgentInfo>(), pagedResultRealEstateAgentInfo.data);
        System.assertEquals(null, pagedResultRealEstateAgentInfo.recordCount);
    }
}