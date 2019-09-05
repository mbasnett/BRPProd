@isTest
private class NewstarContingencyTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarContingency contingency1 = NewstarContingency.getExample();
        NewstarContingency contingency2 = contingency1;
        NewstarContingency contingency3 = new NewstarContingency();
        NewstarContingency contingency4 = contingency3;

        System.assert(contingency1.equals(contingency2));
        System.assert(contingency2.equals(contingency1));
        System.assert(contingency1.equals(contingency1));
        System.assert(contingency3.equals(contingency4));
        System.assert(contingency4.equals(contingency3));
        System.assert(contingency3.equals(contingency3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarContingency contingency1 = NewstarContingency.getExample();
        NewstarContingency contingency2 = NewstarContingency.getExample();
        NewstarContingency contingency3 = new NewstarContingency();
        NewstarContingency contingency4 = new NewstarContingency();

        System.assert(contingency1.equals(contingency2));
        System.assert(contingency2.equals(contingency1));
        System.assert(contingency3.equals(contingency4));
        System.assert(contingency4.equals(contingency3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarContingency contingency1 = NewstarContingency.getExample();
        NewstarContingency contingency2 = new NewstarContingency();

        System.assertEquals(false, contingency1.equals('foo'));
        System.assertEquals(false, contingency2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarContingency contingency1 = NewstarContingency.getExample();
        NewstarContingency contingency2 = new NewstarContingency();
        NewstarContingency contingency3;

        System.assertEquals(false, contingency1.equals(contingency3));
        System.assertEquals(false, contingency2.equals(contingency3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarContingency contingency1 = NewstarContingency.getExample();
        NewstarContingency contingency2 = new NewstarContingency();

        System.assertEquals(contingency1.hashCode(), contingency1.hashCode());
        System.assertEquals(contingency2.hashCode(), contingency2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarContingency contingency1 = NewstarContingency.getExample();
        NewstarContingency contingency2 = NewstarContingency.getExample();
        NewstarContingency contingency3 = new NewstarContingency();
        NewstarContingency contingency4 = new NewstarContingency();

        System.assert(contingency1.equals(contingency2));
        System.assert(contingency3.equals(contingency4));
        System.assertEquals(contingency1.hashCode(), contingency2.hashCode());
        System.assertEquals(contingency3.hashCode(), contingency4.hashCode());
    }
}