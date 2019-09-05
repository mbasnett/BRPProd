@isTest
private class NewstarLoginCredentialsTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarLoginCredentials loginCredentials1 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials2 = loginCredentials1;
        NewstarLoginCredentials loginCredentials3 = new NewstarLoginCredentials();
        NewstarLoginCredentials loginCredentials4 = loginCredentials3;

        System.assert(loginCredentials1.equals(loginCredentials2));
        System.assert(loginCredentials2.equals(loginCredentials1));
        System.assert(loginCredentials1.equals(loginCredentials1));
        System.assert(loginCredentials3.equals(loginCredentials4));
        System.assert(loginCredentials4.equals(loginCredentials3));
        System.assert(loginCredentials3.equals(loginCredentials3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarLoginCredentials loginCredentials1 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials2 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials3 = new NewstarLoginCredentials();
        NewstarLoginCredentials loginCredentials4 = new NewstarLoginCredentials();

        System.assert(loginCredentials1.equals(loginCredentials2));
        System.assert(loginCredentials2.equals(loginCredentials1));
        System.assert(loginCredentials3.equals(loginCredentials4));
        System.assert(loginCredentials4.equals(loginCredentials3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarLoginCredentials loginCredentials1 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials2 = new NewstarLoginCredentials();

        System.assertEquals(false, loginCredentials1.equals('foo'));
        System.assertEquals(false, loginCredentials2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarLoginCredentials loginCredentials1 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials2 = new NewstarLoginCredentials();
        NewstarLoginCredentials loginCredentials3;

        System.assertEquals(false, loginCredentials1.equals(loginCredentials3));
        System.assertEquals(false, loginCredentials2.equals(loginCredentials3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarLoginCredentials loginCredentials1 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials2 = new NewstarLoginCredentials();

        System.assertEquals(loginCredentials1.hashCode(), loginCredentials1.hashCode());
        System.assertEquals(loginCredentials2.hashCode(), loginCredentials2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarLoginCredentials loginCredentials1 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials2 = NewstarLoginCredentials.getExample();
        NewstarLoginCredentials loginCredentials3 = new NewstarLoginCredentials();
        NewstarLoginCredentials loginCredentials4 = new NewstarLoginCredentials();

        System.assert(loginCredentials1.equals(loginCredentials2));
        System.assert(loginCredentials3.equals(loginCredentials4));
        System.assertEquals(loginCredentials1.hashCode(), loginCredentials2.hashCode());
        System.assertEquals(loginCredentials3.hashCode(), loginCredentials4.hashCode());
    }
}