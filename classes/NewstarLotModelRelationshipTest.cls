@isTest
private class NewstarLotModelRelationshipTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarLotModelRelationship lotModelRelationship1 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship2 = lotModelRelationship1;
        NewstarLotModelRelationship lotModelRelationship3 = new NewstarLotModelRelationship();
        NewstarLotModelRelationship lotModelRelationship4 = lotModelRelationship3;

        System.assert(lotModelRelationship1.equals(lotModelRelationship2));
        System.assert(lotModelRelationship2.equals(lotModelRelationship1));
        System.assert(lotModelRelationship1.equals(lotModelRelationship1));
        System.assert(lotModelRelationship3.equals(lotModelRelationship4));
        System.assert(lotModelRelationship4.equals(lotModelRelationship3));
        System.assert(lotModelRelationship3.equals(lotModelRelationship3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarLotModelRelationship lotModelRelationship1 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship2 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship3 = new NewstarLotModelRelationship();
        NewstarLotModelRelationship lotModelRelationship4 = new NewstarLotModelRelationship();

        System.assert(lotModelRelationship1.equals(lotModelRelationship2));
        System.assert(lotModelRelationship2.equals(lotModelRelationship1));
        System.assert(lotModelRelationship3.equals(lotModelRelationship4));
        System.assert(lotModelRelationship4.equals(lotModelRelationship3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarLotModelRelationship lotModelRelationship1 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship2 = new NewstarLotModelRelationship();

        System.assertEquals(false, lotModelRelationship1.equals('foo'));
        System.assertEquals(false, lotModelRelationship2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarLotModelRelationship lotModelRelationship1 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship2 = new NewstarLotModelRelationship();
        NewstarLotModelRelationship lotModelRelationship3;

        System.assertEquals(false, lotModelRelationship1.equals(lotModelRelationship3));
        System.assertEquals(false, lotModelRelationship2.equals(lotModelRelationship3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarLotModelRelationship lotModelRelationship1 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship2 = new NewstarLotModelRelationship();

        System.assertEquals(lotModelRelationship1.hashCode(), lotModelRelationship1.hashCode());
        System.assertEquals(lotModelRelationship2.hashCode(), lotModelRelationship2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarLotModelRelationship lotModelRelationship1 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship2 = NewstarLotModelRelationship.getExample();
        NewstarLotModelRelationship lotModelRelationship3 = new NewstarLotModelRelationship();
        NewstarLotModelRelationship lotModelRelationship4 = new NewstarLotModelRelationship();

        System.assert(lotModelRelationship1.equals(lotModelRelationship2));
        System.assert(lotModelRelationship3.equals(lotModelRelationship4));
        System.assertEquals(lotModelRelationship1.hashCode(), lotModelRelationship2.hashCode());
        System.assertEquals(lotModelRelationship3.hashCode(), lotModelRelationship4.hashCode());
    }
}