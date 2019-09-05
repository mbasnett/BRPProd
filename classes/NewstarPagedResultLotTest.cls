@isTest
private class NewstarPagedResultLotTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultLot pagedResultLot1 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot2 = pagedResultLot1;
        NewstarPagedResultLot pagedResultLot3 = new NewstarPagedResultLot();
        NewstarPagedResultLot pagedResultLot4 = pagedResultLot3;

        System.assert(pagedResultLot1.equals(pagedResultLot2));
        System.assert(pagedResultLot2.equals(pagedResultLot1));
        System.assert(pagedResultLot1.equals(pagedResultLot1));
        System.assert(pagedResultLot3.equals(pagedResultLot4));
        System.assert(pagedResultLot4.equals(pagedResultLot3));
        System.assert(pagedResultLot3.equals(pagedResultLot3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultLot pagedResultLot1 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot2 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot3 = new NewstarPagedResultLot();
        NewstarPagedResultLot pagedResultLot4 = new NewstarPagedResultLot();

        System.assert(pagedResultLot1.equals(pagedResultLot2));
        System.assert(pagedResultLot2.equals(pagedResultLot1));
        System.assert(pagedResultLot3.equals(pagedResultLot4));
        System.assert(pagedResultLot4.equals(pagedResultLot3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultLot pagedResultLot1 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot2 = new NewstarPagedResultLot();

        System.assertEquals(false, pagedResultLot1.equals('foo'));
        System.assertEquals(false, pagedResultLot2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultLot pagedResultLot1 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot2 = new NewstarPagedResultLot();
        NewstarPagedResultLot pagedResultLot3;

        System.assertEquals(false, pagedResultLot1.equals(pagedResultLot3));
        System.assertEquals(false, pagedResultLot2.equals(pagedResultLot3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultLot pagedResultLot1 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot2 = new NewstarPagedResultLot();

        System.assertEquals(pagedResultLot1.hashCode(), pagedResultLot1.hashCode());
        System.assertEquals(pagedResultLot2.hashCode(), pagedResultLot2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultLot pagedResultLot1 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot2 = NewstarPagedResultLot.getExample();
        NewstarPagedResultLot pagedResultLot3 = new NewstarPagedResultLot();
        NewstarPagedResultLot pagedResultLot4 = new NewstarPagedResultLot();

        System.assert(pagedResultLot1.equals(pagedResultLot2));
        System.assert(pagedResultLot3.equals(pagedResultLot4));
        System.assertEquals(pagedResultLot1.hashCode(), pagedResultLot2.hashCode());
        System.assertEquals(pagedResultLot3.hashCode(), pagedResultLot4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultLot pagedResultLot = new NewstarPagedResultLot();
        System.assertEquals(new List<NewstarLot>(), pagedResultLot.data);
        System.assertEquals(null, pagedResultLot.recordCount);
    }
}