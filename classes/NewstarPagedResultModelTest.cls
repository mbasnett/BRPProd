@isTest
private class NewstarPagedResultModelTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarPagedResultModel pagedResultModel1 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel2 = pagedResultModel1;
        NewstarPagedResultModel pagedResultModel3 = new NewstarPagedResultModel();
        NewstarPagedResultModel pagedResultModel4 = pagedResultModel3;

        System.assert(pagedResultModel1.equals(pagedResultModel2));
        System.assert(pagedResultModel2.equals(pagedResultModel1));
        System.assert(pagedResultModel1.equals(pagedResultModel1));
        System.assert(pagedResultModel3.equals(pagedResultModel4));
        System.assert(pagedResultModel4.equals(pagedResultModel3));
        System.assert(pagedResultModel3.equals(pagedResultModel3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarPagedResultModel pagedResultModel1 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel2 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel3 = new NewstarPagedResultModel();
        NewstarPagedResultModel pagedResultModel4 = new NewstarPagedResultModel();

        System.assert(pagedResultModel1.equals(pagedResultModel2));
        System.assert(pagedResultModel2.equals(pagedResultModel1));
        System.assert(pagedResultModel3.equals(pagedResultModel4));
        System.assert(pagedResultModel4.equals(pagedResultModel3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarPagedResultModel pagedResultModel1 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel2 = new NewstarPagedResultModel();

        System.assertEquals(false, pagedResultModel1.equals('foo'));
        System.assertEquals(false, pagedResultModel2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarPagedResultModel pagedResultModel1 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel2 = new NewstarPagedResultModel();
        NewstarPagedResultModel pagedResultModel3;

        System.assertEquals(false, pagedResultModel1.equals(pagedResultModel3));
        System.assertEquals(false, pagedResultModel2.equals(pagedResultModel3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarPagedResultModel pagedResultModel1 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel2 = new NewstarPagedResultModel();

        System.assertEquals(pagedResultModel1.hashCode(), pagedResultModel1.hashCode());
        System.assertEquals(pagedResultModel2.hashCode(), pagedResultModel2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarPagedResultModel pagedResultModel1 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel2 = NewstarPagedResultModel.getExample();
        NewstarPagedResultModel pagedResultModel3 = new NewstarPagedResultModel();
        NewstarPagedResultModel pagedResultModel4 = new NewstarPagedResultModel();

        System.assert(pagedResultModel1.equals(pagedResultModel2));
        System.assert(pagedResultModel3.equals(pagedResultModel4));
        System.assertEquals(pagedResultModel1.hashCode(), pagedResultModel2.hashCode());
        System.assertEquals(pagedResultModel3.hashCode(), pagedResultModel4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarPagedResultModel pagedResultModel = new NewstarPagedResultModel();
        System.assertEquals(new List<NewstarModel>(), pagedResultModel.data);
        System.assertEquals(null, pagedResultModel.recordCount);
    }
}