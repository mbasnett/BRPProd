@isTest
private class NewstarPagedResultSalesAgentTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent1 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent2 = pagedResultSalesAgent1;
        NewstarPagedResultSalesAgent pagedResultSalesAgent3 = new NewstarPagedResultSalesAgent();
        NewstarPagedResultSalesAgent pagedResultSalesAgent4 = pagedResultSalesAgent3;

        System.assert(pagedResultSalesAgent1.equals(pagedResultSalesAgent2));
        System.assert(pagedResultSalesAgent2.equals(pagedResultSalesAgent1));
        System.assert(pagedResultSalesAgent1.equals(pagedResultSalesAgent1));
        System.assert(pagedResultSalesAgent3.equals(pagedResultSalesAgent4));
        System.assert(pagedResultSalesAgent4.equals(pagedResultSalesAgent3));
        System.assert(pagedResultSalesAgent3.equals(pagedResultSalesAgent3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent1 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent2 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent3 = new NewstarPagedResultSalesAgent();
        NewstarPagedResultSalesAgent pagedResultSalesAgent4 = new NewstarPagedResultSalesAgent();

        System.assert(pagedResultSalesAgent1.equals(pagedResultSalesAgent2));
        System.assert(pagedResultSalesAgent2.equals(pagedResultSalesAgent1));
        System.assert(pagedResultSalesAgent3.equals(pagedResultSalesAgent4));
        System.assert(pagedResultSalesAgent4.equals(pagedResultSalesAgent3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent1 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent2 = new NewstarPagedResultSalesAgent();

        System.assertEquals(false, pagedResultSalesAgent1.equals('foo'));
        System.assertEquals(false, pagedResultSalesAgent2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent1 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent2 = new NewstarPagedResultSalesAgent();
        NewstarPagedResultSalesAgent pagedResultSalesAgent3;

        System.assertEquals(false, pagedResultSalesAgent1.equals(pagedResultSalesAgent3));
        System.assertEquals(false, pagedResultSalesAgent2.equals(pagedResultSalesAgent3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent1 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent2 = new NewstarPagedResultSalesAgent();

        System.assertEquals(pagedResultSalesAgent1.hashCode(), pagedResultSalesAgent1.hashCode());
        System.assertEquals(pagedResultSalesAgent2.hashCode(), pagedResultSalesAgent2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent1 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent2 = NewstarPagedResultSalesAgent.getExample();
        NewstarPagedResultSalesAgent pagedResultSalesAgent3 = new NewstarPagedResultSalesAgent();
        NewstarPagedResultSalesAgent pagedResultSalesAgent4 = new NewstarPagedResultSalesAgent();

        System.assert(pagedResultSalesAgent1.equals(pagedResultSalesAgent2));
        System.assert(pagedResultSalesAgent3.equals(pagedResultSalesAgent4));
        System.assertEquals(pagedResultSalesAgent1.hashCode(), pagedResultSalesAgent2.hashCode());
        System.assertEquals(pagedResultSalesAgent3.hashCode(), pagedResultSalesAgent4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultSalesAgent pagedResultSalesAgent = new NewstarPagedResultSalesAgent();
        System.assertEquals(new List<NewstarSalesAgent>(), pagedResultSalesAgent.data);
        System.assertEquals(null, pagedResultSalesAgent.recordCount);
    }
}