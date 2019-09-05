@isTest
private class NewstarCoBuyerTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarCoBuyer coBuyer1 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer2 = coBuyer1;
        NewstarCoBuyer coBuyer3 = new NewstarCoBuyer();
        NewstarCoBuyer coBuyer4 = coBuyer3;

        System.assert(coBuyer1.equals(coBuyer2));
        System.assert(coBuyer2.equals(coBuyer1));
        System.assert(coBuyer1.equals(coBuyer1));
        System.assert(coBuyer3.equals(coBuyer4));
        System.assert(coBuyer4.equals(coBuyer3));
        System.assert(coBuyer3.equals(coBuyer3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarCoBuyer coBuyer1 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer2 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer3 = new NewstarCoBuyer();
        NewstarCoBuyer coBuyer4 = new NewstarCoBuyer();

        System.assert(coBuyer1.equals(coBuyer2));
        System.assert(coBuyer2.equals(coBuyer1));
        System.assert(coBuyer3.equals(coBuyer4));
        System.assert(coBuyer4.equals(coBuyer3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarCoBuyer coBuyer1 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer2 = new NewstarCoBuyer();

        System.assertEquals(false, coBuyer1.equals('foo'));
        System.assertEquals(false, coBuyer2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarCoBuyer coBuyer1 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer2 = new NewstarCoBuyer();
        NewstarCoBuyer coBuyer3;

        System.assertEquals(false, coBuyer1.equals(coBuyer3));
        System.assertEquals(false, coBuyer2.equals(coBuyer3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarCoBuyer coBuyer1 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer2 = new NewstarCoBuyer();

        System.assertEquals(coBuyer1.hashCode(), coBuyer1.hashCode());
        System.assertEquals(coBuyer2.hashCode(), coBuyer2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarCoBuyer coBuyer1 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer2 = NewstarCoBuyer.getExample();
        NewstarCoBuyer coBuyer3 = new NewstarCoBuyer();
        NewstarCoBuyer coBuyer4 = new NewstarCoBuyer();

        System.assert(coBuyer1.equals(coBuyer2));
        System.assert(coBuyer3.equals(coBuyer4));
        System.assertEquals(coBuyer1.hashCode(), coBuyer2.hashCode());
        System.assertEquals(coBuyer3.hashCode(), coBuyer4.hashCode());
    }
}