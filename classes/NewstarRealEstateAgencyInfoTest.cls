@isTest
private class NewstarRealEstateAgencyInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo1 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo2 = realEstateAgencyInfo1;
        NewstarRealEstateAgencyInfo realEstateAgencyInfo3 = new NewstarRealEstateAgencyInfo();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo4 = realEstateAgencyInfo3;

        System.assert(realEstateAgencyInfo1.equals(realEstateAgencyInfo2));
        System.assert(realEstateAgencyInfo2.equals(realEstateAgencyInfo1));
        System.assert(realEstateAgencyInfo1.equals(realEstateAgencyInfo1));
        System.assert(realEstateAgencyInfo3.equals(realEstateAgencyInfo4));
        System.assert(realEstateAgencyInfo4.equals(realEstateAgencyInfo3));
        System.assert(realEstateAgencyInfo3.equals(realEstateAgencyInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo1 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo2 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo3 = new NewstarRealEstateAgencyInfo();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo4 = new NewstarRealEstateAgencyInfo();

        System.assert(realEstateAgencyInfo1.equals(realEstateAgencyInfo2));
        System.assert(realEstateAgencyInfo2.equals(realEstateAgencyInfo1));
        System.assert(realEstateAgencyInfo3.equals(realEstateAgencyInfo4));
        System.assert(realEstateAgencyInfo4.equals(realEstateAgencyInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo1 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo2 = new NewstarRealEstateAgencyInfo();

        System.assertEquals(false, realEstateAgencyInfo1.equals('foo'));
        System.assertEquals(false, realEstateAgencyInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo1 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo2 = new NewstarRealEstateAgencyInfo();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo3;

        System.assertEquals(false, realEstateAgencyInfo1.equals(realEstateAgencyInfo3));
        System.assertEquals(false, realEstateAgencyInfo2.equals(realEstateAgencyInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo1 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo2 = new NewstarRealEstateAgencyInfo();

        System.assertEquals(realEstateAgencyInfo1.hashCode(), realEstateAgencyInfo1.hashCode());
        System.assertEquals(realEstateAgencyInfo2.hashCode(), realEstateAgencyInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo1 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo2 = NewstarRealEstateAgencyInfo.getExample();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo3 = new NewstarRealEstateAgencyInfo();
        NewstarRealEstateAgencyInfo realEstateAgencyInfo4 = new NewstarRealEstateAgencyInfo();

        System.assert(realEstateAgencyInfo1.equals(realEstateAgencyInfo2));
        System.assert(realEstateAgencyInfo3.equals(realEstateAgencyInfo4));
        System.assertEquals(realEstateAgencyInfo1.hashCode(), realEstateAgencyInfo2.hashCode());
        System.assertEquals(realEstateAgencyInfo3.hashCode(), realEstateAgencyInfo4.hashCode());
    }
}