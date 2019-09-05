@isTest
private class NewstarSalesOfficeSalesAgentRelationTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship1 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship2 = salesOfficeSalesAgentRelationship1;
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship3 = new NewstarSalesOfficeSalesAgentRelation();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship4 = salesOfficeSalesAgentRelationship3;

        System.assert(salesOfficeSalesAgentRelationship1.equals(salesOfficeSalesAgentRelationship2));
        System.assert(salesOfficeSalesAgentRelationship2.equals(salesOfficeSalesAgentRelationship1));
        System.assert(salesOfficeSalesAgentRelationship1.equals(salesOfficeSalesAgentRelationship1));
        System.assert(salesOfficeSalesAgentRelationship3.equals(salesOfficeSalesAgentRelationship4));
        System.assert(salesOfficeSalesAgentRelationship4.equals(salesOfficeSalesAgentRelationship3));
        System.assert(salesOfficeSalesAgentRelationship3.equals(salesOfficeSalesAgentRelationship3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship1 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship2 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship3 = new NewstarSalesOfficeSalesAgentRelation();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship4 = new NewstarSalesOfficeSalesAgentRelation();

        System.assert(salesOfficeSalesAgentRelationship1.equals(salesOfficeSalesAgentRelationship2));
        System.assert(salesOfficeSalesAgentRelationship2.equals(salesOfficeSalesAgentRelationship1));
        System.assert(salesOfficeSalesAgentRelationship3.equals(salesOfficeSalesAgentRelationship4));
        System.assert(salesOfficeSalesAgentRelationship4.equals(salesOfficeSalesAgentRelationship3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship1 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship2 = new NewstarSalesOfficeSalesAgentRelation();

        System.assertEquals(false, salesOfficeSalesAgentRelationship1.equals('foo'));
        System.assertEquals(false, salesOfficeSalesAgentRelationship2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship1 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship2 = new NewstarSalesOfficeSalesAgentRelation();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship3;

        System.assertEquals(false, salesOfficeSalesAgentRelationship1.equals(salesOfficeSalesAgentRelationship3));
        System.assertEquals(false, salesOfficeSalesAgentRelationship2.equals(salesOfficeSalesAgentRelationship3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship1 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship2 = new NewstarSalesOfficeSalesAgentRelation();

        System.assertEquals(salesOfficeSalesAgentRelationship1.hashCode(), salesOfficeSalesAgentRelationship1.hashCode());
        System.assertEquals(salesOfficeSalesAgentRelationship2.hashCode(), salesOfficeSalesAgentRelationship2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship1 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship2 = NewstarSalesOfficeSalesAgentRelation.getExample();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship3 = new NewstarSalesOfficeSalesAgentRelation();
        NewstarSalesOfficeSalesAgentRelation salesOfficeSalesAgentRelationship4 = new NewstarSalesOfficeSalesAgentRelation();

        System.assert(salesOfficeSalesAgentRelationship1.equals(salesOfficeSalesAgentRelationship2));
        System.assert(salesOfficeSalesAgentRelationship3.equals(salesOfficeSalesAgentRelationship4));
        System.assertEquals(salesOfficeSalesAgentRelationship1.hashCode(), salesOfficeSalesAgentRelationship2.hashCode());
        System.assertEquals(salesOfficeSalesAgentRelationship3.hashCode(), salesOfficeSalesAgentRelationship4.hashCode());
    }
}