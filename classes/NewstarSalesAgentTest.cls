@isTest
private class NewstarSalesAgentTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarSalesAgent salesAgent1 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent2 = salesAgent1;
        NewstarSalesAgent salesAgent3 = new NewstarSalesAgent();
        NewstarSalesAgent salesAgent4 = salesAgent3;

        System.assert(salesAgent1.equals(salesAgent2));
        System.assert(salesAgent2.equals(salesAgent1));
        System.assert(salesAgent1.equals(salesAgent1));
        System.assert(salesAgent3.equals(salesAgent4));
        System.assert(salesAgent4.equals(salesAgent3));
        System.assert(salesAgent3.equals(salesAgent3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarSalesAgent salesAgent1 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent2 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent3 = new NewstarSalesAgent();
        NewstarSalesAgent salesAgent4 = new NewstarSalesAgent();

        System.assert(salesAgent1.equals(salesAgent2));
        System.assert(salesAgent2.equals(salesAgent1));
        System.assert(salesAgent3.equals(salesAgent4));
        System.assert(salesAgent4.equals(salesAgent3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarSalesAgent salesAgent1 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent2 = new NewstarSalesAgent();

        System.assertEquals(false, salesAgent1.equals('foo'));
        System.assertEquals(false, salesAgent2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarSalesAgent salesAgent1 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent2 = new NewstarSalesAgent();
        NewstarSalesAgent salesAgent3;

        System.assertEquals(false, salesAgent1.equals(salesAgent3));
        System.assertEquals(false, salesAgent2.equals(salesAgent3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarSalesAgent salesAgent1 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent2 = new NewstarSalesAgent();

        System.assertEquals(salesAgent1.hashCode(), salesAgent1.hashCode());
        System.assertEquals(salesAgent2.hashCode(), salesAgent2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarSalesAgent salesAgent1 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent2 = NewstarSalesAgent.getExample();
        NewstarSalesAgent salesAgent3 = new NewstarSalesAgent();
        NewstarSalesAgent salesAgent4 = new NewstarSalesAgent();

        System.assert(salesAgent1.equals(salesAgent2));
        System.assert(salesAgent3.equals(salesAgent4));
        System.assertEquals(salesAgent1.hashCode(), salesAgent2.hashCode());
        System.assertEquals(salesAgent3.hashCode(), salesAgent4.hashCode());
    }
}