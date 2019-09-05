@isTest
private class NewstarStateProvinceTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarStateProvince stateProvince1 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince2 = stateProvince1;
        NewstarStateProvince stateProvince3 = new NewstarStateProvince();
        NewstarStateProvince stateProvince4 = stateProvince3;

        System.assert(stateProvince1.equals(stateProvince2));
        System.assert(stateProvince2.equals(stateProvince1));
        System.assert(stateProvince1.equals(stateProvince1));
        System.assert(stateProvince3.equals(stateProvince4));
        System.assert(stateProvince4.equals(stateProvince3));
        System.assert(stateProvince3.equals(stateProvince3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarStateProvince stateProvince1 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince2 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince3 = new NewstarStateProvince();
        NewstarStateProvince stateProvince4 = new NewstarStateProvince();

        System.assert(stateProvince1.equals(stateProvince2));
        System.assert(stateProvince2.equals(stateProvince1));
        System.assert(stateProvince3.equals(stateProvince4));
        System.assert(stateProvince4.equals(stateProvince3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarStateProvince stateProvince1 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince2 = new NewstarStateProvince();

        System.assertEquals(false, stateProvince1.equals('foo'));
        System.assertEquals(false, stateProvince2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarStateProvince stateProvince1 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince2 = new NewstarStateProvince();
        NewstarStateProvince stateProvince3;

        System.assertEquals(false, stateProvince1.equals(stateProvince3));
        System.assertEquals(false, stateProvince2.equals(stateProvince3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarStateProvince stateProvince1 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince2 = new NewstarStateProvince();

        System.assertEquals(stateProvince1.hashCode(), stateProvince1.hashCode());
        System.assertEquals(stateProvince2.hashCode(), stateProvince2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarStateProvince stateProvince1 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince2 = NewstarStateProvince.getExample();
        NewstarStateProvince stateProvince3 = new NewstarStateProvince();
        NewstarStateProvince stateProvince4 = new NewstarStateProvince();

        System.assert(stateProvince1.equals(stateProvince2));
        System.assert(stateProvince3.equals(stateProvince4));
        System.assertEquals(stateProvince1.hashCode(), stateProvince2.hashCode());
        System.assertEquals(stateProvince3.hashCode(), stateProvince4.hashCode());
    }
}