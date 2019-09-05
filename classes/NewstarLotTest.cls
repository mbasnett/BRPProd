@isTest
private class NewstarLotTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarLot lot1 = NewstarLot.getExample();
        NewstarLot lot2 = lot1;
        NewstarLot lot3 = new NewstarLot();
        NewstarLot lot4 = lot3;

        System.assert(lot1.equals(lot2));
        System.assert(lot2.equals(lot1));
        System.assert(lot1.equals(lot1));
        System.assert(lot3.equals(lot4));
        System.assert(lot4.equals(lot3));
        System.assert(lot3.equals(lot3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarLot lot1 = NewstarLot.getExample();
        NewstarLot lot2 = NewstarLot.getExample();
        NewstarLot lot3 = new NewstarLot();
        NewstarLot lot4 = new NewstarLot();

        System.assert(lot1.equals(lot2));
        System.assert(lot2.equals(lot1));
        System.assert(lot3.equals(lot4));
        System.assert(lot4.equals(lot3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarLot lot1 = NewstarLot.getExample();
        NewstarLot lot2 = new NewstarLot();

        System.assertEquals(false, lot1.equals('foo'));
        System.assertEquals(false, lot2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarLot lot1 = NewstarLot.getExample();
        NewstarLot lot2 = new NewstarLot();
        NewstarLot lot3;

        System.assertEquals(false, lot1.equals(lot3));
        System.assertEquals(false, lot2.equals(lot3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarLot lot1 = NewstarLot.getExample();
        NewstarLot lot2 = new NewstarLot();

        System.assertEquals(lot1.hashCode(), lot1.hashCode());
        System.assertEquals(lot2.hashCode(), lot2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarLot lot1 = NewstarLot.getExample();
        NewstarLot lot2 = NewstarLot.getExample();
        NewstarLot lot3 = new NewstarLot();
        NewstarLot lot4 = new NewstarLot();

        System.assert(lot1.equals(lot2));
        System.assert(lot3.equals(lot4));
        System.assertEquals(lot1.hashCode(), lot2.hashCode());
        System.assertEquals(lot3.hashCode(), lot4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarLot lot = new NewstarLot();
        System.assertEquals(new List<NewstarLotModelRelationship>(), lot.applicableModels);
        System.assertEquals(null, lot.id);
        System.assertEquals(null, lot.subdivisionId);
        System.assertEquals(null, lot.lotNumber);
        System.assertEquals(null, lot.address);
        System.assertEquals(null, lot.city);
        System.assertEquals(null, lot.lotType);
        System.assertEquals(null, lot.availabilityStatus);
        System.assertEquals(null, lot.releasedForSale);
        System.assertEquals(null, lot.releasedForConstruction);
        System.assertEquals(null, lot.releaseDate);
        System.assertEquals(null, lot.modelId);
        System.assertEquals(null, lot.totalOptionsAmount);
    }
}