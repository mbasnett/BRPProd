@isTest
private class NewstarModelTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarModel model1 = NewstarModel.getExample();
        NewstarModel model2 = model1;
        NewstarModel model3 = new NewstarModel();
        NewstarModel model4 = model3;

        System.assert(model1.equals(model2));
        System.assert(model2.equals(model1));
        System.assert(model1.equals(model1));
        System.assert(model3.equals(model4));
        System.assert(model4.equals(model3));
        System.assert(model3.equals(model3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarModel model1 = NewstarModel.getExample();
        NewstarModel model2 = NewstarModel.getExample();
        NewstarModel model3 = new NewstarModel();
        NewstarModel model4 = new NewstarModel();

        System.assert(model1.equals(model2));
        System.assert(model2.equals(model1));
        System.assert(model3.equals(model4));
        System.assert(model4.equals(model3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarModel model1 = NewstarModel.getExample();
        NewstarModel model2 = new NewstarModel();

        System.assertEquals(false, model1.equals('foo'));
        System.assertEquals(false, model2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarModel model1 = NewstarModel.getExample();
        NewstarModel model2 = new NewstarModel();
        NewstarModel model3;

        System.assertEquals(false, model1.equals(model3));
        System.assertEquals(false, model2.equals(model3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarModel model1 = NewstarModel.getExample();
        NewstarModel model2 = new NewstarModel();

        System.assertEquals(model1.hashCode(), model1.hashCode());
        System.assertEquals(model2.hashCode(), model2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarModel model1 = NewstarModel.getExample();
        NewstarModel model2 = NewstarModel.getExample();
        NewstarModel model3 = new NewstarModel();
        NewstarModel model4 = new NewstarModel();

        System.assert(model1.equals(model2));
        System.assert(model3.equals(model4));
        System.assertEquals(model1.hashCode(), model2.hashCode());
        System.assertEquals(model3.hashCode(), model4.hashCode());
    }
}