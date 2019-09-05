@isTest
private class NewstarSubdivisionSalesAgentRelationTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship1 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship2 = subdivisionSalesAgentRelationship1;
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship3 = new NewstarSubdivisionSalesAgentRelation();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship4 = subdivisionSalesAgentRelationship3;

        System.assert(subdivisionSalesAgentRelationship1.equals(subdivisionSalesAgentRelationship2));
        System.assert(subdivisionSalesAgentRelationship2.equals(subdivisionSalesAgentRelationship1));
        System.assert(subdivisionSalesAgentRelationship1.equals(subdivisionSalesAgentRelationship1));
        System.assert(subdivisionSalesAgentRelationship3.equals(subdivisionSalesAgentRelationship4));
        System.assert(subdivisionSalesAgentRelationship4.equals(subdivisionSalesAgentRelationship3));
        System.assert(subdivisionSalesAgentRelationship3.equals(subdivisionSalesAgentRelationship3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship1 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship2 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship3 = new NewstarSubdivisionSalesAgentRelation();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship4 = new NewstarSubdivisionSalesAgentRelation();

        System.assert(subdivisionSalesAgentRelationship1.equals(subdivisionSalesAgentRelationship2));
        System.assert(subdivisionSalesAgentRelationship2.equals(subdivisionSalesAgentRelationship1));
        System.assert(subdivisionSalesAgentRelationship3.equals(subdivisionSalesAgentRelationship4));
        System.assert(subdivisionSalesAgentRelationship4.equals(subdivisionSalesAgentRelationship3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship1 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship2 = new NewstarSubdivisionSalesAgentRelation();

        System.assertEquals(false, subdivisionSalesAgentRelationship1.equals('foo'));
        System.assertEquals(false, subdivisionSalesAgentRelationship2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship1 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship2 = new NewstarSubdivisionSalesAgentRelation();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship3;

        System.assertEquals(false, subdivisionSalesAgentRelationship1.equals(subdivisionSalesAgentRelationship3));
        System.assertEquals(false, subdivisionSalesAgentRelationship2.equals(subdivisionSalesAgentRelationship3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship1 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship2 = new NewstarSubdivisionSalesAgentRelation();

        System.assertEquals(subdivisionSalesAgentRelationship1.hashCode(), subdivisionSalesAgentRelationship1.hashCode());
        System.assertEquals(subdivisionSalesAgentRelationship2.hashCode(), subdivisionSalesAgentRelationship2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship1 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship2 = NewstarSubdivisionSalesAgentRelation.getExample();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship3 = new NewstarSubdivisionSalesAgentRelation();
        NewstarSubdivisionSalesAgentRelation subdivisionSalesAgentRelationship4 = new NewstarSubdivisionSalesAgentRelation();

        System.assert(subdivisionSalesAgentRelationship1.equals(subdivisionSalesAgentRelationship2));
        System.assert(subdivisionSalesAgentRelationship3.equals(subdivisionSalesAgentRelationship4));
        System.assertEquals(subdivisionSalesAgentRelationship1.hashCode(), subdivisionSalesAgentRelationship2.hashCode());
        System.assertEquals(subdivisionSalesAgentRelationship3.hashCode(), subdivisionSalesAgentRelationship4.hashCode());
    }
}