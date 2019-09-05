@isTest
private class NewstarPagedResultSalesOfficeTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice1 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice2 = pagedResultSalesOffice1;
        NewstarPagedResultSalesOffice pagedResultSalesOffice3 = new NewstarPagedResultSalesOffice();
        NewstarPagedResultSalesOffice pagedResultSalesOffice4 = pagedResultSalesOffice3;

        System.assert(pagedResultSalesOffice1.equals(pagedResultSalesOffice2));
        System.assert(pagedResultSalesOffice2.equals(pagedResultSalesOffice1));
        System.assert(pagedResultSalesOffice1.equals(pagedResultSalesOffice1));
        System.assert(pagedResultSalesOffice3.equals(pagedResultSalesOffice4));
        System.assert(pagedResultSalesOffice4.equals(pagedResultSalesOffice3));
        System.assert(pagedResultSalesOffice3.equals(pagedResultSalesOffice3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice1 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice2 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice3 = new NewstarPagedResultSalesOffice();
        NewstarPagedResultSalesOffice pagedResultSalesOffice4 = new NewstarPagedResultSalesOffice();

        System.assert(pagedResultSalesOffice1.equals(pagedResultSalesOffice2));
        System.assert(pagedResultSalesOffice2.equals(pagedResultSalesOffice1));
        System.assert(pagedResultSalesOffice3.equals(pagedResultSalesOffice4));
        System.assert(pagedResultSalesOffice4.equals(pagedResultSalesOffice3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice1 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice2 = new NewstarPagedResultSalesOffice();

        System.assertEquals(false, pagedResultSalesOffice1.equals('foo'));
        System.assertEquals(false, pagedResultSalesOffice2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice1 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice2 = new NewstarPagedResultSalesOffice();
        NewstarPagedResultSalesOffice pagedResultSalesOffice3;

        System.assertEquals(false, pagedResultSalesOffice1.equals(pagedResultSalesOffice3));
        System.assertEquals(false, pagedResultSalesOffice2.equals(pagedResultSalesOffice3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice1 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice2 = new NewstarPagedResultSalesOffice();

        System.assertEquals(pagedResultSalesOffice1.hashCode(), pagedResultSalesOffice1.hashCode());
        System.assertEquals(pagedResultSalesOffice2.hashCode(), pagedResultSalesOffice2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice1 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice2 = NewstarPagedResultSalesOffice.getExample();
        NewstarPagedResultSalesOffice pagedResultSalesOffice3 = new NewstarPagedResultSalesOffice();
        NewstarPagedResultSalesOffice pagedResultSalesOffice4 = new NewstarPagedResultSalesOffice();

        System.assert(pagedResultSalesOffice1.equals(pagedResultSalesOffice2));
        System.assert(pagedResultSalesOffice3.equals(pagedResultSalesOffice4));
        System.assertEquals(pagedResultSalesOffice1.hashCode(), pagedResultSalesOffice2.hashCode());
        System.assertEquals(pagedResultSalesOffice3.hashCode(), pagedResultSalesOffice4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultSalesOffice pagedResultSalesOffice = new NewstarPagedResultSalesOffice();
        System.assertEquals(new List<NewstarSalesOffice>(), pagedResultSalesOffice.data);
        System.assertEquals(null, pagedResultSalesOffice.recordCount);
    }
}