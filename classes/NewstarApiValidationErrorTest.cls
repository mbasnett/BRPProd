@isTest
private class NewstarApiValidationErrorTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarApiValidationError apiValidationError1 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError2 = apiValidationError1;
        NewstarApiValidationError apiValidationError3 = new NewstarApiValidationError();
        NewstarApiValidationError apiValidationError4 = apiValidationError3;

        System.assert(apiValidationError1.equals(apiValidationError2));
        System.assert(apiValidationError2.equals(apiValidationError1));
        System.assert(apiValidationError1.equals(apiValidationError1));
        System.assert(apiValidationError3.equals(apiValidationError4));
        System.assert(apiValidationError4.equals(apiValidationError3));
        System.assert(apiValidationError3.equals(apiValidationError3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarApiValidationError apiValidationError1 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError2 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError3 = new NewstarApiValidationError();
        NewstarApiValidationError apiValidationError4 = new NewstarApiValidationError();

        System.assert(apiValidationError1.equals(apiValidationError2));
        System.assert(apiValidationError2.equals(apiValidationError1));
        System.assert(apiValidationError3.equals(apiValidationError4));
        System.assert(apiValidationError4.equals(apiValidationError3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarApiValidationError apiValidationError1 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError2 = new NewstarApiValidationError();

        System.assertEquals(false, apiValidationError1.equals('foo'));
        System.assertEquals(false, apiValidationError2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarApiValidationError apiValidationError1 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError2 = new NewstarApiValidationError();
        NewstarApiValidationError apiValidationError3;

        System.assertEquals(false, apiValidationError1.equals(apiValidationError3));
        System.assertEquals(false, apiValidationError2.equals(apiValidationError3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarApiValidationError apiValidationError1 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError2 = new NewstarApiValidationError();

        System.assertEquals(apiValidationError1.hashCode(), apiValidationError1.hashCode());
        System.assertEquals(apiValidationError2.hashCode(), apiValidationError2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarApiValidationError apiValidationError1 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError2 = NewstarApiValidationError.getExample();
        NewstarApiValidationError apiValidationError3 = new NewstarApiValidationError();
        NewstarApiValidationError apiValidationError4 = new NewstarApiValidationError();

        System.assert(apiValidationError1.equals(apiValidationError2));
        System.assert(apiValidationError3.equals(apiValidationError4));
        System.assertEquals(apiValidationError1.hashCode(), apiValidationError2.hashCode());
        System.assertEquals(apiValidationError3.hashCode(), apiValidationError4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarApiValidationError apiValidationError = new NewstarApiValidationError();
        System.assertEquals(new List<NewstarValidationError>(), apiValidationError.validationErrors);
        System.assertEquals(null, apiValidationError.message);
        System.assertEquals(null, apiValidationError.debugInfo);
    }
}