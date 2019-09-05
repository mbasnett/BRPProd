@isTest
private class NewstarOperationResultTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarOperationResult operationResult1 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult2 = operationResult1;
        NewstarOperationResult operationResult3 = new NewstarOperationResult();
        NewstarOperationResult operationResult4 = operationResult3;

        System.assert(operationResult1.equals(operationResult2));
        System.assert(operationResult2.equals(operationResult1));
        System.assert(operationResult1.equals(operationResult1));
        System.assert(operationResult3.equals(operationResult4));
        System.assert(operationResult4.equals(operationResult3));
        System.assert(operationResult3.equals(operationResult3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarOperationResult operationResult1 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult2 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult3 = new NewstarOperationResult();
        NewstarOperationResult operationResult4 = new NewstarOperationResult();

        System.assert(operationResult1.equals(operationResult2));
        System.assert(operationResult2.equals(operationResult1));
        System.assert(operationResult3.equals(operationResult4));
        System.assert(operationResult4.equals(operationResult3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarOperationResult operationResult1 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult2 = new NewstarOperationResult();

        System.assertEquals(false, operationResult1.equals('foo'));
        System.assertEquals(false, operationResult2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarOperationResult operationResult1 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult2 = new NewstarOperationResult();
        NewstarOperationResult operationResult3;

        System.assertEquals(false, operationResult1.equals(operationResult3));
        System.assertEquals(false, operationResult2.equals(operationResult3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarOperationResult operationResult1 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult2 = new NewstarOperationResult();

        System.assertEquals(operationResult1.hashCode(), operationResult1.hashCode());
        System.assertEquals(operationResult2.hashCode(), operationResult2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarOperationResult operationResult1 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult2 = NewstarOperationResult.getExample();
        NewstarOperationResult operationResult3 = new NewstarOperationResult();
        NewstarOperationResult operationResult4 = new NewstarOperationResult();

        System.assert(operationResult1.equals(operationResult2));
        System.assert(operationResult3.equals(operationResult4));
        System.assertEquals(operationResult1.hashCode(), operationResult2.hashCode());
        System.assertEquals(operationResult3.hashCode(), operationResult4.hashCode());
    }
}