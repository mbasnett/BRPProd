@isTest
private class NewstarValidationErrorTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarValidationError validationError1 = NewstarValidationError.getExample();
        NewstarValidationError validationError2 = validationError1;
        NewstarValidationError validationError3 = new NewstarValidationError();
        NewstarValidationError validationError4 = validationError3;

        System.assert(validationError1.equals(validationError2));
        System.assert(validationError2.equals(validationError1));
        System.assert(validationError1.equals(validationError1));
        System.assert(validationError3.equals(validationError4));
        System.assert(validationError4.equals(validationError3));
        System.assert(validationError3.equals(validationError3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarValidationError validationError1 = NewstarValidationError.getExample();
        NewstarValidationError validationError2 = NewstarValidationError.getExample();
        NewstarValidationError validationError3 = new NewstarValidationError();
        NewstarValidationError validationError4 = new NewstarValidationError();

        System.assert(validationError1.equals(validationError2));
        System.assert(validationError2.equals(validationError1));
        System.assert(validationError3.equals(validationError4));
        System.assert(validationError4.equals(validationError3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarValidationError validationError1 = NewstarValidationError.getExample();
        NewstarValidationError validationError2 = new NewstarValidationError();

        System.assertEquals(false, validationError1.equals('foo'));
        System.assertEquals(false, validationError2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarValidationError validationError1 = NewstarValidationError.getExample();
        NewstarValidationError validationError2 = new NewstarValidationError();
        NewstarValidationError validationError3;

        System.assertEquals(false, validationError1.equals(validationError3));
        System.assertEquals(false, validationError2.equals(validationError3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarValidationError validationError1 = NewstarValidationError.getExample();
        NewstarValidationError validationError2 = new NewstarValidationError();

        System.assertEquals(validationError1.hashCode(), validationError1.hashCode());
        System.assertEquals(validationError2.hashCode(), validationError2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarValidationError validationError1 = NewstarValidationError.getExample();
        NewstarValidationError validationError2 = NewstarValidationError.getExample();
        NewstarValidationError validationError3 = new NewstarValidationError();
        NewstarValidationError validationError4 = new NewstarValidationError();

        System.assert(validationError1.equals(validationError2));
        System.assert(validationError3.equals(validationError4));
        System.assertEquals(validationError1.hashCode(), validationError2.hashCode());
        System.assertEquals(validationError3.hashCode(), validationError4.hashCode());
    }
}