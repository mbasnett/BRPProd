@isTest
private class NewstarHomeInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarHomeInfo homeInfo1 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo2 = homeInfo1;
        NewstarHomeInfo homeInfo3 = new NewstarHomeInfo();
        NewstarHomeInfo homeInfo4 = homeInfo3;

        System.assert(homeInfo1.equals(homeInfo2));
        System.assert(homeInfo2.equals(homeInfo1));
        System.assert(homeInfo1.equals(homeInfo1));
        System.assert(homeInfo3.equals(homeInfo4));
        System.assert(homeInfo4.equals(homeInfo3));
        System.assert(homeInfo3.equals(homeInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarHomeInfo homeInfo1 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo2 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo3 = new NewstarHomeInfo();
        NewstarHomeInfo homeInfo4 = new NewstarHomeInfo();

        System.assert(homeInfo1.equals(homeInfo2));
        System.assert(homeInfo2.equals(homeInfo1));
        System.assert(homeInfo3.equals(homeInfo4));
        System.assert(homeInfo4.equals(homeInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarHomeInfo homeInfo1 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo2 = new NewstarHomeInfo();

        System.assertEquals(false, homeInfo1.equals('foo'));
        System.assertEquals(false, homeInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarHomeInfo homeInfo1 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo2 = new NewstarHomeInfo();
        NewstarHomeInfo homeInfo3;

        System.assertEquals(false, homeInfo1.equals(homeInfo3));
        System.assertEquals(false, homeInfo2.equals(homeInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarHomeInfo homeInfo1 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo2 = new NewstarHomeInfo();

        System.assertEquals(homeInfo1.hashCode(), homeInfo1.hashCode());
        System.assertEquals(homeInfo2.hashCode(), homeInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarHomeInfo homeInfo1 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo2 = NewstarHomeInfo.getExample();
        NewstarHomeInfo homeInfo3 = new NewstarHomeInfo();
        NewstarHomeInfo homeInfo4 = new NewstarHomeInfo();

        System.assert(homeInfo1.equals(homeInfo2));
        System.assert(homeInfo3.equals(homeInfo4));
        System.assertEquals(homeInfo1.hashCode(), homeInfo2.hashCode());
        System.assertEquals(homeInfo3.hashCode(), homeInfo4.hashCode());
    }
}