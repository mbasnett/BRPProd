@isTest
private class NewstarRealEstateAgencyTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarRealEstateAgency realEstateAgency1 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency2 = realEstateAgency1;
        NewstarRealEstateAgency realEstateAgency3 = new NewstarRealEstateAgency();
        NewstarRealEstateAgency realEstateAgency4 = realEstateAgency3;

        System.assert(realEstateAgency1.equals(realEstateAgency2));
        System.assert(realEstateAgency2.equals(realEstateAgency1));
        System.assert(realEstateAgency1.equals(realEstateAgency1));
        System.assert(realEstateAgency3.equals(realEstateAgency4));
        System.assert(realEstateAgency4.equals(realEstateAgency3));
        System.assert(realEstateAgency3.equals(realEstateAgency3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarRealEstateAgency realEstateAgency1 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency2 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency3 = new NewstarRealEstateAgency();
        NewstarRealEstateAgency realEstateAgency4 = new NewstarRealEstateAgency();

        System.assert(realEstateAgency1.equals(realEstateAgency2));
        System.assert(realEstateAgency2.equals(realEstateAgency1));
        System.assert(realEstateAgency3.equals(realEstateAgency4));
        System.assert(realEstateAgency4.equals(realEstateAgency3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarRealEstateAgency realEstateAgency1 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency2 = new NewstarRealEstateAgency();

        System.assertEquals(false, realEstateAgency1.equals('foo'));
        System.assertEquals(false, realEstateAgency2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarRealEstateAgency realEstateAgency1 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency2 = new NewstarRealEstateAgency();
        NewstarRealEstateAgency realEstateAgency3;

        System.assertEquals(false, realEstateAgency1.equals(realEstateAgency3));
        System.assertEquals(false, realEstateAgency2.equals(realEstateAgency3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarRealEstateAgency realEstateAgency1 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency2 = new NewstarRealEstateAgency();

        System.assertEquals(realEstateAgency1.hashCode(), realEstateAgency1.hashCode());
        System.assertEquals(realEstateAgency2.hashCode(), realEstateAgency2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarRealEstateAgency realEstateAgency1 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency2 = NewstarRealEstateAgency.getExample();
        NewstarRealEstateAgency realEstateAgency3 = new NewstarRealEstateAgency();
        NewstarRealEstateAgency realEstateAgency4 = new NewstarRealEstateAgency();

        System.assert(realEstateAgency1.equals(realEstateAgency2));
        System.assert(realEstateAgency3.equals(realEstateAgency4));
        System.assertEquals(realEstateAgency1.hashCode(), realEstateAgency2.hashCode());
        System.assertEquals(realEstateAgency3.hashCode(), realEstateAgency4.hashCode());
    }
}