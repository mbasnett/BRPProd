@isTest
private class NewstarContigencyTypeInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarContigencyTypeInfo contigencyTypeInfo1 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo2 = contigencyTypeInfo1;
        NewstarContigencyTypeInfo contigencyTypeInfo3 = new NewstarContigencyTypeInfo();
        NewstarContigencyTypeInfo contigencyTypeInfo4 = contigencyTypeInfo3;

        System.assert(contigencyTypeInfo1.equals(contigencyTypeInfo2));
        System.assert(contigencyTypeInfo2.equals(contigencyTypeInfo1));
        System.assert(contigencyTypeInfo1.equals(contigencyTypeInfo1));
        System.assert(contigencyTypeInfo3.equals(contigencyTypeInfo4));
        System.assert(contigencyTypeInfo4.equals(contigencyTypeInfo3));
        System.assert(contigencyTypeInfo3.equals(contigencyTypeInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarContigencyTypeInfo contigencyTypeInfo1 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo2 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo3 = new NewstarContigencyTypeInfo();
        NewstarContigencyTypeInfo contigencyTypeInfo4 = new NewstarContigencyTypeInfo();

        System.assert(contigencyTypeInfo1.equals(contigencyTypeInfo2));
        System.assert(contigencyTypeInfo2.equals(contigencyTypeInfo1));
        System.assert(contigencyTypeInfo3.equals(contigencyTypeInfo4));
        System.assert(contigencyTypeInfo4.equals(contigencyTypeInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarContigencyTypeInfo contigencyTypeInfo1 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo2 = new NewstarContigencyTypeInfo();

        System.assertEquals(false, contigencyTypeInfo1.equals('foo'));
        System.assertEquals(false, contigencyTypeInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarContigencyTypeInfo contigencyTypeInfo1 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo2 = new NewstarContigencyTypeInfo();
        NewstarContigencyTypeInfo contigencyTypeInfo3;

        System.assertEquals(false, contigencyTypeInfo1.equals(contigencyTypeInfo3));
        System.assertEquals(false, contigencyTypeInfo2.equals(contigencyTypeInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarContigencyTypeInfo contigencyTypeInfo1 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo2 = new NewstarContigencyTypeInfo();

        System.assertEquals(contigencyTypeInfo1.hashCode(), contigencyTypeInfo1.hashCode());
        System.assertEquals(contigencyTypeInfo2.hashCode(), contigencyTypeInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarContigencyTypeInfo contigencyTypeInfo1 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo2 = NewstarContigencyTypeInfo.getExample();
        NewstarContigencyTypeInfo contigencyTypeInfo3 = new NewstarContigencyTypeInfo();
        NewstarContigencyTypeInfo contigencyTypeInfo4 = new NewstarContigencyTypeInfo();

        System.assert(contigencyTypeInfo1.equals(contigencyTypeInfo2));
        System.assert(contigencyTypeInfo3.equals(contigencyTypeInfo4));
        System.assertEquals(contigencyTypeInfo1.hashCode(), contigencyTypeInfo2.hashCode());
        System.assertEquals(contigencyTypeInfo3.hashCode(), contigencyTypeInfo4.hashCode());
    }
}