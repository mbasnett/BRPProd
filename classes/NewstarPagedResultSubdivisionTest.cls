@isTest
private class NewstarPagedResultSubdivisionTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultSubdivision pagedResultSubdivision1 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision2 = pagedResultSubdivision1;
        NewstarPagedResultSubdivision pagedResultSubdivision3 = new NewstarPagedResultSubdivision();
        NewstarPagedResultSubdivision pagedResultSubdivision4 = pagedResultSubdivision3;

        System.assert(pagedResultSubdivision1.equals(pagedResultSubdivision2));
        System.assert(pagedResultSubdivision2.equals(pagedResultSubdivision1));
        System.assert(pagedResultSubdivision1.equals(pagedResultSubdivision1));
        System.assert(pagedResultSubdivision3.equals(pagedResultSubdivision4));
        System.assert(pagedResultSubdivision4.equals(pagedResultSubdivision3));
        System.assert(pagedResultSubdivision3.equals(pagedResultSubdivision3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultSubdivision pagedResultSubdivision1 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision2 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision3 = new NewstarPagedResultSubdivision();
        NewstarPagedResultSubdivision pagedResultSubdivision4 = new NewstarPagedResultSubdivision();

        System.assert(pagedResultSubdivision1.equals(pagedResultSubdivision2));
        System.assert(pagedResultSubdivision2.equals(pagedResultSubdivision1));
        System.assert(pagedResultSubdivision3.equals(pagedResultSubdivision4));
        System.assert(pagedResultSubdivision4.equals(pagedResultSubdivision3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultSubdivision pagedResultSubdivision1 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision2 = new NewstarPagedResultSubdivision();

        System.assertEquals(false, pagedResultSubdivision1.equals('foo'));
        System.assertEquals(false, pagedResultSubdivision2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultSubdivision pagedResultSubdivision1 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision2 = new NewstarPagedResultSubdivision();
        NewstarPagedResultSubdivision pagedResultSubdivision3;

        System.assertEquals(false, pagedResultSubdivision1.equals(pagedResultSubdivision3));
        System.assertEquals(false, pagedResultSubdivision2.equals(pagedResultSubdivision3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultSubdivision pagedResultSubdivision1 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision2 = new NewstarPagedResultSubdivision();

        System.assertEquals(pagedResultSubdivision1.hashCode(), pagedResultSubdivision1.hashCode());
        System.assertEquals(pagedResultSubdivision2.hashCode(), pagedResultSubdivision2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultSubdivision pagedResultSubdivision1 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision2 = NewstarPagedResultSubdivision.getExample();
        NewstarPagedResultSubdivision pagedResultSubdivision3 = new NewstarPagedResultSubdivision();
        NewstarPagedResultSubdivision pagedResultSubdivision4 = new NewstarPagedResultSubdivision();

        System.assert(pagedResultSubdivision1.equals(pagedResultSubdivision2));
        System.assert(pagedResultSubdivision3.equals(pagedResultSubdivision4));
        System.assertEquals(pagedResultSubdivision1.hashCode(), pagedResultSubdivision2.hashCode());
        System.assertEquals(pagedResultSubdivision3.hashCode(), pagedResultSubdivision4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultSubdivision pagedResultSubdivision = new NewstarPagedResultSubdivision();
        System.assertEquals(new List<NewstarSubdivision>(), pagedResultSubdivision.data);
        System.assertEquals(null, pagedResultSubdivision.recordCount);
    }
}