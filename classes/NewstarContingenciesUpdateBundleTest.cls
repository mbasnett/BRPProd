@isTest
private class NewstarContingenciesUpdateBundleTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle1 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle2 = contingenciesUpdateBundle1;
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle3 = new NewstarContingenciesUpdateBundle();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle4 = contingenciesUpdateBundle3;

        System.assert(contingenciesUpdateBundle1.equals(contingenciesUpdateBundle2));
        System.assert(contingenciesUpdateBundle2.equals(contingenciesUpdateBundle1));
        System.assert(contingenciesUpdateBundle1.equals(contingenciesUpdateBundle1));
        System.assert(contingenciesUpdateBundle3.equals(contingenciesUpdateBundle4));
        System.assert(contingenciesUpdateBundle4.equals(contingenciesUpdateBundle3));
        System.assert(contingenciesUpdateBundle3.equals(contingenciesUpdateBundle3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle1 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle2 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle3 = new NewstarContingenciesUpdateBundle();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle4 = new NewstarContingenciesUpdateBundle();

        System.assert(contingenciesUpdateBundle1.equals(contingenciesUpdateBundle2));
        System.assert(contingenciesUpdateBundle2.equals(contingenciesUpdateBundle1));
        System.assert(contingenciesUpdateBundle3.equals(contingenciesUpdateBundle4));
        System.assert(contingenciesUpdateBundle4.equals(contingenciesUpdateBundle3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle1 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle2 = new NewstarContingenciesUpdateBundle();

        System.assertEquals(false, contingenciesUpdateBundle1.equals('foo'));
        System.assertEquals(false, contingenciesUpdateBundle2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle1 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle2 = new NewstarContingenciesUpdateBundle();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle3;

        System.assertEquals(false, contingenciesUpdateBundle1.equals(contingenciesUpdateBundle3));
        System.assertEquals(false, contingenciesUpdateBundle2.equals(contingenciesUpdateBundle3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle1 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle2 = new NewstarContingenciesUpdateBundle();

        System.assertEquals(contingenciesUpdateBundle1.hashCode(), contingenciesUpdateBundle1.hashCode());
        System.assertEquals(contingenciesUpdateBundle2.hashCode(), contingenciesUpdateBundle2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle1 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle2 = NewstarContingenciesUpdateBundle.getExample();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle3 = new NewstarContingenciesUpdateBundle();
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle4 = new NewstarContingenciesUpdateBundle();

        System.assert(contingenciesUpdateBundle1.equals(contingenciesUpdateBundle2));
        System.assert(contingenciesUpdateBundle3.equals(contingenciesUpdateBundle4));
        System.assertEquals(contingenciesUpdateBundle1.hashCode(), contingenciesUpdateBundle2.hashCode());
        System.assertEquals(contingenciesUpdateBundle3.hashCode(), contingenciesUpdateBundle4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarContingenciesUpdateBundle contingenciesUpdateBundle = new NewstarContingenciesUpdateBundle();
        System.assertEquals(new List<NewstarContingency>(), contingenciesUpdateBundle.contingencies);
        System.assertEquals(null, contingenciesUpdateBundle.lotReservationId);
    }
}