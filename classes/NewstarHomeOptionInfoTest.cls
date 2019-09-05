@isTest
private class NewstarHomeOptionInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarHomeOptionInfo homeOptionInfo1 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo2 = homeOptionInfo1;
        NewstarHomeOptionInfo homeOptionInfo3 = new NewstarHomeOptionInfo();
        NewstarHomeOptionInfo homeOptionInfo4 = homeOptionInfo3;

        System.assert(homeOptionInfo1.equals(homeOptionInfo2));
        System.assert(homeOptionInfo2.equals(homeOptionInfo1));
        System.assert(homeOptionInfo1.equals(homeOptionInfo1));
        System.assert(homeOptionInfo3.equals(homeOptionInfo4));
        System.assert(homeOptionInfo4.equals(homeOptionInfo3));
        System.assert(homeOptionInfo3.equals(homeOptionInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarHomeOptionInfo homeOptionInfo1 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo2 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo3 = new NewstarHomeOptionInfo();
        NewstarHomeOptionInfo homeOptionInfo4 = new NewstarHomeOptionInfo();

        System.assert(homeOptionInfo1.equals(homeOptionInfo2));
        System.assert(homeOptionInfo2.equals(homeOptionInfo1));
        System.assert(homeOptionInfo3.equals(homeOptionInfo4));
        System.assert(homeOptionInfo4.equals(homeOptionInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarHomeOptionInfo homeOptionInfo1 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo2 = new NewstarHomeOptionInfo();

        System.assertEquals(false, homeOptionInfo1.equals('foo'));
        System.assertEquals(false, homeOptionInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarHomeOptionInfo homeOptionInfo1 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo2 = new NewstarHomeOptionInfo();
        NewstarHomeOptionInfo homeOptionInfo3;

        System.assertEquals(false, homeOptionInfo1.equals(homeOptionInfo3));
        System.assertEquals(false, homeOptionInfo2.equals(homeOptionInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarHomeOptionInfo homeOptionInfo1 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo2 = new NewstarHomeOptionInfo();

        System.assertEquals(homeOptionInfo1.hashCode(), homeOptionInfo1.hashCode());
        System.assertEquals(homeOptionInfo2.hashCode(), homeOptionInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarHomeOptionInfo homeOptionInfo1 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo2 = NewstarHomeOptionInfo.getExample();
        NewstarHomeOptionInfo homeOptionInfo3 = new NewstarHomeOptionInfo();
        NewstarHomeOptionInfo homeOptionInfo4 = new NewstarHomeOptionInfo();

        System.assert(homeOptionInfo1.equals(homeOptionInfo2));
        System.assert(homeOptionInfo3.equals(homeOptionInfo4));
        System.assertEquals(homeOptionInfo1.hashCode(), homeOptionInfo2.hashCode());
        System.assertEquals(homeOptionInfo3.hashCode(), homeOptionInfo4.hashCode());
    }
}