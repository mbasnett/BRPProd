@isTest
private class NewstarPagedResultRealEstateAgencyInTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo1 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo2 = pagedResultRealEstateAgencyInfo1;
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo3 = new NewstarPagedResultRealEstateAgencyIn();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo4 = pagedResultRealEstateAgencyInfo3;

        System.assert(pagedResultRealEstateAgencyInfo1.equals(pagedResultRealEstateAgencyInfo2));
        System.assert(pagedResultRealEstateAgencyInfo2.equals(pagedResultRealEstateAgencyInfo1));
        System.assert(pagedResultRealEstateAgencyInfo1.equals(pagedResultRealEstateAgencyInfo1));
        System.assert(pagedResultRealEstateAgencyInfo3.equals(pagedResultRealEstateAgencyInfo4));
        System.assert(pagedResultRealEstateAgencyInfo4.equals(pagedResultRealEstateAgencyInfo3));
        System.assert(pagedResultRealEstateAgencyInfo3.equals(pagedResultRealEstateAgencyInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo1 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo2 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo3 = new NewstarPagedResultRealEstateAgencyIn();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo4 = new NewstarPagedResultRealEstateAgencyIn();

        System.assert(pagedResultRealEstateAgencyInfo1.equals(pagedResultRealEstateAgencyInfo2));
        System.assert(pagedResultRealEstateAgencyInfo2.equals(pagedResultRealEstateAgencyInfo1));
        System.assert(pagedResultRealEstateAgencyInfo3.equals(pagedResultRealEstateAgencyInfo4));
        System.assert(pagedResultRealEstateAgencyInfo4.equals(pagedResultRealEstateAgencyInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo1 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo2 = new NewstarPagedResultRealEstateAgencyIn();

        System.assertEquals(false, pagedResultRealEstateAgencyInfo1.equals('foo'));
        System.assertEquals(false, pagedResultRealEstateAgencyInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo1 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo2 = new NewstarPagedResultRealEstateAgencyIn();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo3;

        System.assertEquals(false, pagedResultRealEstateAgencyInfo1.equals(pagedResultRealEstateAgencyInfo3));
        System.assertEquals(false, pagedResultRealEstateAgencyInfo2.equals(pagedResultRealEstateAgencyInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo1 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo2 = new NewstarPagedResultRealEstateAgencyIn();

        System.assertEquals(pagedResultRealEstateAgencyInfo1.hashCode(), pagedResultRealEstateAgencyInfo1.hashCode());
        System.assertEquals(pagedResultRealEstateAgencyInfo2.hashCode(), pagedResultRealEstateAgencyInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo1 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo2 = NewstarPagedResultRealEstateAgencyIn.getExample();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo3 = new NewstarPagedResultRealEstateAgencyIn();
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo4 = new NewstarPagedResultRealEstateAgencyIn();

        System.assert(pagedResultRealEstateAgencyInfo1.equals(pagedResultRealEstateAgencyInfo2));
        System.assert(pagedResultRealEstateAgencyInfo3.equals(pagedResultRealEstateAgencyInfo4));
        System.assertEquals(pagedResultRealEstateAgencyInfo1.hashCode(), pagedResultRealEstateAgencyInfo2.hashCode());
        System.assertEquals(pagedResultRealEstateAgencyInfo3.hashCode(), pagedResultRealEstateAgencyInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultRealEstateAgencyIn pagedResultRealEstateAgencyInfo = new NewstarPagedResultRealEstateAgencyIn();
        System.assertEquals(new List<NewstarRealEstateAgencyInfo>(), pagedResultRealEstateAgencyInfo.data);
        System.assertEquals(null, pagedResultRealEstateAgencyInfo.recordCount);
    }
}