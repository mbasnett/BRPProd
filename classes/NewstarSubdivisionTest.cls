@isTest
private class NewstarSubdivisionTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarSubdivision subdivision1 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision2 = subdivision1;
        NewstarSubdivision subdivision3 = new NewstarSubdivision();
        NewstarSubdivision subdivision4 = subdivision3;

        System.assert(subdivision1.equals(subdivision2));
        System.assert(subdivision2.equals(subdivision1));
        System.assert(subdivision1.equals(subdivision1));
        System.assert(subdivision3.equals(subdivision4));
        System.assert(subdivision4.equals(subdivision3));
        System.assert(subdivision3.equals(subdivision3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarSubdivision subdivision1 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision2 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision3 = new NewstarSubdivision();
        NewstarSubdivision subdivision4 = new NewstarSubdivision();

        System.assert(subdivision1.equals(subdivision2));
        System.assert(subdivision2.equals(subdivision1));
        System.assert(subdivision3.equals(subdivision4));
        System.assert(subdivision4.equals(subdivision3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarSubdivision subdivision1 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision2 = new NewstarSubdivision();

        System.assertEquals(false, subdivision1.equals('foo'));
        System.assertEquals(false, subdivision2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarSubdivision subdivision1 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision2 = new NewstarSubdivision();
        NewstarSubdivision subdivision3;

        System.assertEquals(false, subdivision1.equals(subdivision3));
        System.assertEquals(false, subdivision2.equals(subdivision3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarSubdivision subdivision1 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision2 = new NewstarSubdivision();

        System.assertEquals(subdivision1.hashCode(), subdivision1.hashCode());
        System.assertEquals(subdivision2.hashCode(), subdivision2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarSubdivision subdivision1 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision2 = NewstarSubdivision.getExample();
        NewstarSubdivision subdivision3 = new NewstarSubdivision();
        NewstarSubdivision subdivision4 = new NewstarSubdivision();

        System.assert(subdivision1.equals(subdivision2));
        System.assert(subdivision3.equals(subdivision4));
        System.assertEquals(subdivision1.hashCode(), subdivision2.hashCode());
        System.assertEquals(subdivision3.hashCode(), subdivision4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarSubdivision subdivision = new NewstarSubdivision();
        System.assertEquals(new List<NewstarSubdivisionSalesAgentRelation>(), subdivision.salesAgents);
        System.assertEquals(null, subdivision.id);
        System.assertEquals(null, subdivision.salesOfficeId);
        System.assertEquals(null, subdivision.name);
        System.assertEquals(null, subdivision.isActive);
        System.assertEquals(null, subdivision.adjLumpSum);
        System.assertEquals(null, subdivision.adjLotPrice);
        System.assertEquals(null, subdivision.adjLotPremium);
        System.assertEquals(null, subdivision.adjModelPrice);
        System.assertEquals(null, subdivision.adjOptions);
        System.assertEquals(null, subdivision.adjMortgage);
        System.assertEquals(null, subdivision.salesPriceType);
    }
}