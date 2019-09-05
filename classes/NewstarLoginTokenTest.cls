@isTest
private class NewstarLoginTokenTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarLoginToken loginToken1 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken2 = loginToken1;
        NewstarLoginToken loginToken3 = new NewstarLoginToken();
        NewstarLoginToken loginToken4 = loginToken3;

        System.assert(loginToken1.equals(loginToken2));
        System.assert(loginToken2.equals(loginToken1));
        System.assert(loginToken1.equals(loginToken1));
        System.assert(loginToken3.equals(loginToken4));
        System.assert(loginToken4.equals(loginToken3));
        System.assert(loginToken3.equals(loginToken3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarLoginToken loginToken1 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken2 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken3 = new NewstarLoginToken();
        NewstarLoginToken loginToken4 = new NewstarLoginToken();

        System.assert(loginToken1.equals(loginToken2));
        System.assert(loginToken2.equals(loginToken1));
        System.assert(loginToken3.equals(loginToken4));
        System.assert(loginToken4.equals(loginToken3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarLoginToken loginToken1 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken2 = new NewstarLoginToken();

        System.assertEquals(false, loginToken1.equals('foo'));
        System.assertEquals(false, loginToken2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarLoginToken loginToken1 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken2 = new NewstarLoginToken();
        NewstarLoginToken loginToken3;

        System.assertEquals(false, loginToken1.equals(loginToken3));
        System.assertEquals(false, loginToken2.equals(loginToken3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarLoginToken loginToken1 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken2 = new NewstarLoginToken();

        System.assertEquals(loginToken1.hashCode(), loginToken1.hashCode());
        System.assertEquals(loginToken2.hashCode(), loginToken2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarLoginToken loginToken1 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken2 = NewstarLoginToken.getExample();
        NewstarLoginToken loginToken3 = new NewstarLoginToken();
        NewstarLoginToken loginToken4 = new NewstarLoginToken();

        System.assert(loginToken1.equals(loginToken2));
        System.assert(loginToken3.equals(loginToken4));
        System.assertEquals(loginToken1.hashCode(), loginToken2.hashCode());
        System.assertEquals(loginToken3.hashCode(), loginToken4.hashCode());
    }
}