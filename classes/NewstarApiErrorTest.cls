@isTest
private class NewstarApiErrorTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarApiError apiError1 = NewstarApiError.getExample();
        NewstarApiError apiError2 = apiError1;
        NewstarApiError apiError3 = new NewstarApiError();
        NewstarApiError apiError4 = apiError3;

        System.assert(apiError1.equals(apiError2));
        System.assert(apiError2.equals(apiError1));
        System.assert(apiError1.equals(apiError1));
        System.assert(apiError3.equals(apiError4));
        System.assert(apiError4.equals(apiError3));
        System.assert(apiError3.equals(apiError3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarApiError apiError1 = NewstarApiError.getExample();
        NewstarApiError apiError2 = NewstarApiError.getExample();
        NewstarApiError apiError3 = new NewstarApiError();
        NewstarApiError apiError4 = new NewstarApiError();

        System.assert(apiError1.equals(apiError2));
        System.assert(apiError2.equals(apiError1));
        System.assert(apiError3.equals(apiError4));
        System.assert(apiError4.equals(apiError3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarApiError apiError1 = NewstarApiError.getExample();
        NewstarApiError apiError2 = new NewstarApiError();

        System.assertEquals(false, apiError1.equals('foo'));
        System.assertEquals(false, apiError2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarApiError apiError1 = NewstarApiError.getExample();
        NewstarApiError apiError2 = new NewstarApiError();
        NewstarApiError apiError3;

        System.assertEquals(false, apiError1.equals(apiError3));
        System.assertEquals(false, apiError2.equals(apiError3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarApiError apiError1 = NewstarApiError.getExample();
        NewstarApiError apiError2 = new NewstarApiError();

        System.assertEquals(apiError1.hashCode(), apiError1.hashCode());
        System.assertEquals(apiError2.hashCode(), apiError2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarApiError apiError1 = NewstarApiError.getExample();
        NewstarApiError apiError2 = NewstarApiError.getExample();
        NewstarApiError apiError3 = new NewstarApiError();
        NewstarApiError apiError4 = new NewstarApiError();

        System.assert(apiError1.equals(apiError2));
        System.assert(apiError3.equals(apiError4));
        System.assertEquals(apiError1.hashCode(), apiError2.hashCode());
        System.assertEquals(apiError3.hashCode(), apiError4.hashCode());
    }
}