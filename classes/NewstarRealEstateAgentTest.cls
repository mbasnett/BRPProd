@isTest
private class NewstarRealEstateAgentTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarRealEstateAgent realEstateAgent1 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent2 = realEstateAgent1;
        NewstarRealEstateAgent realEstateAgent3 = new NewstarRealEstateAgent();
        NewstarRealEstateAgent realEstateAgent4 = realEstateAgent3;

        System.assert(realEstateAgent1.equals(realEstateAgent2));
        System.assert(realEstateAgent2.equals(realEstateAgent1));
        System.assert(realEstateAgent1.equals(realEstateAgent1));
        System.assert(realEstateAgent3.equals(realEstateAgent4));
        System.assert(realEstateAgent4.equals(realEstateAgent3));
        System.assert(realEstateAgent3.equals(realEstateAgent3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarRealEstateAgent realEstateAgent1 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent2 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent3 = new NewstarRealEstateAgent();
        NewstarRealEstateAgent realEstateAgent4 = new NewstarRealEstateAgent();

        System.assert(realEstateAgent1.equals(realEstateAgent2));
        System.assert(realEstateAgent2.equals(realEstateAgent1));
        System.assert(realEstateAgent3.equals(realEstateAgent4));
        System.assert(realEstateAgent4.equals(realEstateAgent3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarRealEstateAgent realEstateAgent1 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent2 = new NewstarRealEstateAgent();

        System.assertEquals(false, realEstateAgent1.equals('foo'));
        System.assertEquals(false, realEstateAgent2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarRealEstateAgent realEstateAgent1 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent2 = new NewstarRealEstateAgent();
        NewstarRealEstateAgent realEstateAgent3;

        System.assertEquals(false, realEstateAgent1.equals(realEstateAgent3));
        System.assertEquals(false, realEstateAgent2.equals(realEstateAgent3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarRealEstateAgent realEstateAgent1 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent2 = new NewstarRealEstateAgent();

        System.assertEquals(realEstateAgent1.hashCode(), realEstateAgent1.hashCode());
        System.assertEquals(realEstateAgent2.hashCode(), realEstateAgent2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarRealEstateAgent realEstateAgent1 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent2 = NewstarRealEstateAgent.getExample();
        NewstarRealEstateAgent realEstateAgent3 = new NewstarRealEstateAgent();
        NewstarRealEstateAgent realEstateAgent4 = new NewstarRealEstateAgent();

        System.assert(realEstateAgent1.equals(realEstateAgent2));
        System.assert(realEstateAgent3.equals(realEstateAgent4));
        System.assertEquals(realEstateAgent1.hashCode(), realEstateAgent2.hashCode());
        System.assertEquals(realEstateAgent3.hashCode(), realEstateAgent4.hashCode());
    }
}