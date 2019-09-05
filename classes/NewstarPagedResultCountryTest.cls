@isTest
private class NewstarPagedResultCountryTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultCountry pagedResultCountry1 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry2 = pagedResultCountry1;
        NewstarPagedResultCountry pagedResultCountry3 = new NewstarPagedResultCountry();
        NewstarPagedResultCountry pagedResultCountry4 = pagedResultCountry3;

        System.assert(pagedResultCountry1.equals(pagedResultCountry2));
        System.assert(pagedResultCountry2.equals(pagedResultCountry1));
        System.assert(pagedResultCountry1.equals(pagedResultCountry1));
        System.assert(pagedResultCountry3.equals(pagedResultCountry4));
        System.assert(pagedResultCountry4.equals(pagedResultCountry3));
        System.assert(pagedResultCountry3.equals(pagedResultCountry3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultCountry pagedResultCountry1 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry2 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry3 = new NewstarPagedResultCountry();
        NewstarPagedResultCountry pagedResultCountry4 = new NewstarPagedResultCountry();

        System.assert(pagedResultCountry1.equals(pagedResultCountry2));
        System.assert(pagedResultCountry2.equals(pagedResultCountry1));
        System.assert(pagedResultCountry3.equals(pagedResultCountry4));
        System.assert(pagedResultCountry4.equals(pagedResultCountry3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultCountry pagedResultCountry1 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry2 = new NewstarPagedResultCountry();

        System.assertEquals(false, pagedResultCountry1.equals('foo'));
        System.assertEquals(false, pagedResultCountry2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultCountry pagedResultCountry1 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry2 = new NewstarPagedResultCountry();
        NewstarPagedResultCountry pagedResultCountry3;

        System.assertEquals(false, pagedResultCountry1.equals(pagedResultCountry3));
        System.assertEquals(false, pagedResultCountry2.equals(pagedResultCountry3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultCountry pagedResultCountry1 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry2 = new NewstarPagedResultCountry();

        System.assertEquals(pagedResultCountry1.hashCode(), pagedResultCountry1.hashCode());
        System.assertEquals(pagedResultCountry2.hashCode(), pagedResultCountry2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultCountry pagedResultCountry1 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry2 = NewstarPagedResultCountry.getExample();
        NewstarPagedResultCountry pagedResultCountry3 = new NewstarPagedResultCountry();
        NewstarPagedResultCountry pagedResultCountry4 = new NewstarPagedResultCountry();

        System.assert(pagedResultCountry1.equals(pagedResultCountry2));
        System.assert(pagedResultCountry3.equals(pagedResultCountry4));
        System.assertEquals(pagedResultCountry1.hashCode(), pagedResultCountry2.hashCode());
        System.assertEquals(pagedResultCountry3.hashCode(), pagedResultCountry4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultCountry pagedResultCountry = new NewstarPagedResultCountry();
        System.assertEquals(new List<NewstarCountry>(), pagedResultCountry.data);
        System.assertEquals(null, pagedResultCountry.recordCount);
    }
}