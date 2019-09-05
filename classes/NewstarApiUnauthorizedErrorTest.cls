@isTest
private class NewstarApiUnauthorizedErrorTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarApiUnauthorizedError apiUnauthorizedError1 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError2 = apiUnauthorizedError1;
        NewstarApiUnauthorizedError apiUnauthorizedError3 = new NewstarApiUnauthorizedError();
        NewstarApiUnauthorizedError apiUnauthorizedError4 = apiUnauthorizedError3;

        System.assert(apiUnauthorizedError1.equals(apiUnauthorizedError2));
        System.assert(apiUnauthorizedError2.equals(apiUnauthorizedError1));
        System.assert(apiUnauthorizedError1.equals(apiUnauthorizedError1));
        System.assert(apiUnauthorizedError3.equals(apiUnauthorizedError4));
        System.assert(apiUnauthorizedError4.equals(apiUnauthorizedError3));
        System.assert(apiUnauthorizedError3.equals(apiUnauthorizedError3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarApiUnauthorizedError apiUnauthorizedError1 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError2 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError3 = new NewstarApiUnauthorizedError();
        NewstarApiUnauthorizedError apiUnauthorizedError4 = new NewstarApiUnauthorizedError();

        System.assert(apiUnauthorizedError1.equals(apiUnauthorizedError2));
        System.assert(apiUnauthorizedError2.equals(apiUnauthorizedError1));
        System.assert(apiUnauthorizedError3.equals(apiUnauthorizedError4));
        System.assert(apiUnauthorizedError4.equals(apiUnauthorizedError3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarApiUnauthorizedError apiUnauthorizedError1 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError2 = new NewstarApiUnauthorizedError();

        System.assertEquals(false, apiUnauthorizedError1.equals('foo'));
        System.assertEquals(false, apiUnauthorizedError2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarApiUnauthorizedError apiUnauthorizedError1 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError2 = new NewstarApiUnauthorizedError();
        NewstarApiUnauthorizedError apiUnauthorizedError3;

        System.assertEquals(false, apiUnauthorizedError1.equals(apiUnauthorizedError3));
        System.assertEquals(false, apiUnauthorizedError2.equals(apiUnauthorizedError3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarApiUnauthorizedError apiUnauthorizedError1 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError2 = new NewstarApiUnauthorizedError();

        System.assertEquals(apiUnauthorizedError1.hashCode(), apiUnauthorizedError1.hashCode());
        System.assertEquals(apiUnauthorizedError2.hashCode(), apiUnauthorizedError2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarApiUnauthorizedError apiUnauthorizedError1 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError2 = NewstarApiUnauthorizedError.getExample();
        NewstarApiUnauthorizedError apiUnauthorizedError3 = new NewstarApiUnauthorizedError();
        NewstarApiUnauthorizedError apiUnauthorizedError4 = new NewstarApiUnauthorizedError();

        System.assert(apiUnauthorizedError1.equals(apiUnauthorizedError2));
        System.assert(apiUnauthorizedError3.equals(apiUnauthorizedError4));
        System.assertEquals(apiUnauthorizedError1.hashCode(), apiUnauthorizedError2.hashCode());
        System.assertEquals(apiUnauthorizedError3.hashCode(), apiUnauthorizedError4.hashCode());
    }
}