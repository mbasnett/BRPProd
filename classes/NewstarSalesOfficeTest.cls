@isTest
private class NewstarSalesOfficeTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarSalesOffice salesOffice1 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice2 = salesOffice1;
        NewstarSalesOffice salesOffice3 = new NewstarSalesOffice();
        NewstarSalesOffice salesOffice4 = salesOffice3;

        System.assert(salesOffice1.equals(salesOffice2));
        System.assert(salesOffice2.equals(salesOffice1));
        System.assert(salesOffice1.equals(salesOffice1));
        System.assert(salesOffice3.equals(salesOffice4));
        System.assert(salesOffice4.equals(salesOffice3));
        System.assert(salesOffice3.equals(salesOffice3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarSalesOffice salesOffice1 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice2 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice3 = new NewstarSalesOffice();
        NewstarSalesOffice salesOffice4 = new NewstarSalesOffice();

        System.assert(salesOffice1.equals(salesOffice2));
        System.assert(salesOffice2.equals(salesOffice1));
        System.assert(salesOffice3.equals(salesOffice4));
        System.assert(salesOffice4.equals(salesOffice3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarSalesOffice salesOffice1 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice2 = new NewstarSalesOffice();

        System.assertEquals(false, salesOffice1.equals('foo'));
        System.assertEquals(false, salesOffice2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarSalesOffice salesOffice1 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice2 = new NewstarSalesOffice();
        NewstarSalesOffice salesOffice3;

        System.assertEquals(false, salesOffice1.equals(salesOffice3));
        System.assertEquals(false, salesOffice2.equals(salesOffice3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarSalesOffice salesOffice1 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice2 = new NewstarSalesOffice();

        System.assertEquals(salesOffice1.hashCode(), salesOffice1.hashCode());
        System.assertEquals(salesOffice2.hashCode(), salesOffice2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarSalesOffice salesOffice1 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice2 = NewstarSalesOffice.getExample();
        NewstarSalesOffice salesOffice3 = new NewstarSalesOffice();
        NewstarSalesOffice salesOffice4 = new NewstarSalesOffice();

        System.assert(salesOffice1.equals(salesOffice2));
        System.assert(salesOffice3.equals(salesOffice4));
        System.assertEquals(salesOffice1.hashCode(), salesOffice2.hashCode());
        System.assertEquals(salesOffice3.hashCode(), salesOffice4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarSalesOffice salesOffice = new NewstarSalesOffice();
        System.assertEquals(new List<NewstarSalesOfficeSalesAgentRelation>(), salesOffice.salesAgents);
        System.assertEquals(null, salesOffice.id);
        System.assertEquals(null, salesOffice.name);
        System.assertEquals(null, salesOffice.isActive);
        System.assertEquals(null, salesOffice.reportingCity);
        System.assertEquals(null, salesOffice.reportingCommunity);
    }
}