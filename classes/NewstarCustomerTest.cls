@isTest
private class NewstarCustomerTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarCustomer customer1 = NewstarCustomer.getExample();
        NewstarCustomer customer2 = customer1;
        NewstarCustomer customer3 = new NewstarCustomer();
        NewstarCustomer customer4 = customer3;

        System.assert(customer1.equals(customer2));
        System.assert(customer2.equals(customer1));
        System.assert(customer1.equals(customer1));
        System.assert(customer3.equals(customer4));
        System.assert(customer4.equals(customer3));
        System.assert(customer3.equals(customer3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarCustomer customer1 = NewstarCustomer.getExample();
        NewstarCustomer customer2 = NewstarCustomer.getExample();
        NewstarCustomer customer3 = new NewstarCustomer();
        NewstarCustomer customer4 = new NewstarCustomer();

        System.assert(customer1.equals(customer2));
        System.assert(customer2.equals(customer1));
        System.assert(customer3.equals(customer4));
        System.assert(customer4.equals(customer3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarCustomer customer1 = NewstarCustomer.getExample();
        NewstarCustomer customer2 = new NewstarCustomer();

        System.assertEquals(false, customer1.equals('foo'));
        System.assertEquals(false, customer2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarCustomer customer1 = NewstarCustomer.getExample();
        NewstarCustomer customer2 = new NewstarCustomer();
        NewstarCustomer customer3;

        System.assertEquals(false, customer1.equals(customer3));
        System.assertEquals(false, customer2.equals(customer3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarCustomer customer1 = NewstarCustomer.getExample();
        NewstarCustomer customer2 = new NewstarCustomer();

        System.assertEquals(customer1.hashCode(), customer1.hashCode());
        System.assertEquals(customer2.hashCode(), customer2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarCustomer customer1 = NewstarCustomer.getExample();
        NewstarCustomer customer2 = NewstarCustomer.getExample();
        NewstarCustomer customer3 = new NewstarCustomer();
        NewstarCustomer customer4 = new NewstarCustomer();

        System.assert(customer1.equals(customer2));
        System.assert(customer3.equals(customer4));
        System.assertEquals(customer1.hashCode(), customer2.hashCode());
        System.assertEquals(customer3.hashCode(), customer4.hashCode());
    }
}