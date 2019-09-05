@isTest
private class NewstarApiVersionInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarApiVersionInfo apiVersionInfo1 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo2 = apiVersionInfo1;
        NewstarApiVersionInfo apiVersionInfo3 = new NewstarApiVersionInfo();
        NewstarApiVersionInfo apiVersionInfo4 = apiVersionInfo3;

        System.assert(apiVersionInfo1.equals(apiVersionInfo2));
        System.assert(apiVersionInfo2.equals(apiVersionInfo1));
        System.assert(apiVersionInfo1.equals(apiVersionInfo1));
        System.assert(apiVersionInfo3.equals(apiVersionInfo4));
        System.assert(apiVersionInfo4.equals(apiVersionInfo3));
        System.assert(apiVersionInfo3.equals(apiVersionInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarApiVersionInfo apiVersionInfo1 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo2 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo3 = new NewstarApiVersionInfo();
        NewstarApiVersionInfo apiVersionInfo4 = new NewstarApiVersionInfo();

        System.assert(apiVersionInfo1.equals(apiVersionInfo2));
        System.assert(apiVersionInfo2.equals(apiVersionInfo1));
        System.assert(apiVersionInfo3.equals(apiVersionInfo4));
        System.assert(apiVersionInfo4.equals(apiVersionInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarApiVersionInfo apiVersionInfo1 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo2 = new NewstarApiVersionInfo();

        System.assertEquals(false, apiVersionInfo1.equals('foo'));
        System.assertEquals(false, apiVersionInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarApiVersionInfo apiVersionInfo1 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo2 = new NewstarApiVersionInfo();
        NewstarApiVersionInfo apiVersionInfo3;

        System.assertEquals(false, apiVersionInfo1.equals(apiVersionInfo3));
        System.assertEquals(false, apiVersionInfo2.equals(apiVersionInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarApiVersionInfo apiVersionInfo1 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo2 = new NewstarApiVersionInfo();

        System.assertEquals(apiVersionInfo1.hashCode(), apiVersionInfo1.hashCode());
        System.assertEquals(apiVersionInfo2.hashCode(), apiVersionInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarApiVersionInfo apiVersionInfo1 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo2 = NewstarApiVersionInfo.getExample();
        NewstarApiVersionInfo apiVersionInfo3 = new NewstarApiVersionInfo();
        NewstarApiVersionInfo apiVersionInfo4 = new NewstarApiVersionInfo();

        System.assert(apiVersionInfo1.equals(apiVersionInfo2));
        System.assert(apiVersionInfo3.equals(apiVersionInfo4));
        System.assertEquals(apiVersionInfo1.hashCode(), apiVersionInfo2.hashCode());
        System.assertEquals(apiVersionInfo3.hashCode(), apiVersionInfo4.hashCode());
    }
}