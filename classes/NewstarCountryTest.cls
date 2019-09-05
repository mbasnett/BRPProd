@isTest
private class NewstarCountryTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarCountry country1 = NewstarCountry.getExample();
        NewstarCountry country2 = country1;
        NewstarCountry country3 = new NewstarCountry();
        NewstarCountry country4 = country3;

        System.assert(country1.equals(country2));
        System.assert(country2.equals(country1));
        System.assert(country1.equals(country1));
        System.assert(country3.equals(country4));
        System.assert(country4.equals(country3));
        System.assert(country3.equals(country3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarCountry country1 = NewstarCountry.getExample();
        NewstarCountry country2 = NewstarCountry.getExample();
        NewstarCountry country3 = new NewstarCountry();
        NewstarCountry country4 = new NewstarCountry();

        System.assert(country1.equals(country2));
        System.assert(country2.equals(country1));
        System.assert(country3.equals(country4));
        System.assert(country4.equals(country3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarCountry country1 = NewstarCountry.getExample();
        NewstarCountry country2 = new NewstarCountry();

        System.assertEquals(false, country1.equals('foo'));
        System.assertEquals(false, country2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarCountry country1 = NewstarCountry.getExample();
        NewstarCountry country2 = new NewstarCountry();
        NewstarCountry country3;

        System.assertEquals(false, country1.equals(country3));
        System.assertEquals(false, country2.equals(country3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarCountry country1 = NewstarCountry.getExample();
        NewstarCountry country2 = new NewstarCountry();

        System.assertEquals(country1.hashCode(), country1.hashCode());
        System.assertEquals(country2.hashCode(), country2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarCountry country1 = NewstarCountry.getExample();
        NewstarCountry country2 = NewstarCountry.getExample();
        NewstarCountry country3 = new NewstarCountry();
        NewstarCountry country4 = new NewstarCountry();

        System.assert(country1.equals(country2));
        System.assert(country3.equals(country4));
        System.assertEquals(country1.hashCode(), country2.hashCode());
        System.assertEquals(country3.hashCode(), country4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarCountry country = new NewstarCountry();
        System.assertEquals(new List<NewstarStateProvince>(), country.statesProvinces);
        System.assertEquals(null, country.id);
        System.assertEquals(null, country.name);
        System.assertEquals(null, country.code);
    }
}