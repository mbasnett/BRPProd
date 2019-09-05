@isTest
private class NewstarRealEstateAgentInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarRealEstateAgentInfo realEstateAgentInfo1 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo2 = realEstateAgentInfo1;
        NewstarRealEstateAgentInfo realEstateAgentInfo3 = new NewstarRealEstateAgentInfo();
        NewstarRealEstateAgentInfo realEstateAgentInfo4 = realEstateAgentInfo3;

        System.assert(realEstateAgentInfo1.equals(realEstateAgentInfo2));
        System.assert(realEstateAgentInfo2.equals(realEstateAgentInfo1));
        System.assert(realEstateAgentInfo1.equals(realEstateAgentInfo1));
        System.assert(realEstateAgentInfo3.equals(realEstateAgentInfo4));
        System.assert(realEstateAgentInfo4.equals(realEstateAgentInfo3));
        System.assert(realEstateAgentInfo3.equals(realEstateAgentInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarRealEstateAgentInfo realEstateAgentInfo1 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo2 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo3 = new NewstarRealEstateAgentInfo();
        NewstarRealEstateAgentInfo realEstateAgentInfo4 = new NewstarRealEstateAgentInfo();

        System.assert(realEstateAgentInfo1.equals(realEstateAgentInfo2));
        System.assert(realEstateAgentInfo2.equals(realEstateAgentInfo1));
        System.assert(realEstateAgentInfo3.equals(realEstateAgentInfo4));
        System.assert(realEstateAgentInfo4.equals(realEstateAgentInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarRealEstateAgentInfo realEstateAgentInfo1 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo2 = new NewstarRealEstateAgentInfo();

        System.assertEquals(false, realEstateAgentInfo1.equals('foo'));
        System.assertEquals(false, realEstateAgentInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarRealEstateAgentInfo realEstateAgentInfo1 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo2 = new NewstarRealEstateAgentInfo();
        NewstarRealEstateAgentInfo realEstateAgentInfo3;

        System.assertEquals(false, realEstateAgentInfo1.equals(realEstateAgentInfo3));
        System.assertEquals(false, realEstateAgentInfo2.equals(realEstateAgentInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarRealEstateAgentInfo realEstateAgentInfo1 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo2 = new NewstarRealEstateAgentInfo();

        System.assertEquals(realEstateAgentInfo1.hashCode(), realEstateAgentInfo1.hashCode());
        System.assertEquals(realEstateAgentInfo2.hashCode(), realEstateAgentInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarRealEstateAgentInfo realEstateAgentInfo1 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo2 = NewstarRealEstateAgentInfo.getExample();
        NewstarRealEstateAgentInfo realEstateAgentInfo3 = new NewstarRealEstateAgentInfo();
        NewstarRealEstateAgentInfo realEstateAgentInfo4 = new NewstarRealEstateAgentInfo();

        System.assert(realEstateAgentInfo1.equals(realEstateAgentInfo2));
        System.assert(realEstateAgentInfo3.equals(realEstateAgentInfo4));
        System.assertEquals(realEstateAgentInfo1.hashCode(), realEstateAgentInfo2.hashCode());
        System.assertEquals(realEstateAgentInfo3.hashCode(), realEstateAgentInfo4.hashCode());
    }
}