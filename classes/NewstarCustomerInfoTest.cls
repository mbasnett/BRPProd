@isTest
private class NewstarCustomerInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarCustomerInfo customerInfo1 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo2 = customerInfo1;
        NewstarCustomerInfo customerInfo3 = new NewstarCustomerInfo();
        NewstarCustomerInfo customerInfo4 = customerInfo3;

        System.assert(customerInfo1.equals(customerInfo2));
        System.assert(customerInfo2.equals(customerInfo1));
        System.assert(customerInfo1.equals(customerInfo1));
        System.assert(customerInfo3.equals(customerInfo4));
        System.assert(customerInfo4.equals(customerInfo3));
        System.assert(customerInfo3.equals(customerInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarCustomerInfo customerInfo1 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo2 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo3 = new NewstarCustomerInfo();
        NewstarCustomerInfo customerInfo4 = new NewstarCustomerInfo();

        System.assert(customerInfo1.equals(customerInfo2));
        System.assert(customerInfo2.equals(customerInfo1));
        System.assert(customerInfo3.equals(customerInfo4));
        System.assert(customerInfo4.equals(customerInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarCustomerInfo customerInfo1 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo2 = new NewstarCustomerInfo();

        System.assertEquals(false, customerInfo1.equals('foo'));
        System.assertEquals(false, customerInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarCustomerInfo customerInfo1 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo2 = new NewstarCustomerInfo();
        NewstarCustomerInfo customerInfo3;

        System.assertEquals(false, customerInfo1.equals(customerInfo3));
        System.assertEquals(false, customerInfo2.equals(customerInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarCustomerInfo customerInfo1 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo2 = new NewstarCustomerInfo();

        System.assertEquals(customerInfo1.hashCode(), customerInfo1.hashCode());
        System.assertEquals(customerInfo2.hashCode(), customerInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarCustomerInfo customerInfo1 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo2 = NewstarCustomerInfo.getExample();
        NewstarCustomerInfo customerInfo3 = new NewstarCustomerInfo();
        NewstarCustomerInfo customerInfo4 = new NewstarCustomerInfo();

        System.assert(customerInfo1.equals(customerInfo2));
        System.assert(customerInfo3.equals(customerInfo4));
        System.assertEquals(customerInfo1.hashCode(), customerInfo2.hashCode());
        System.assertEquals(customerInfo3.hashCode(), customerInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarCustomerInfo customerInfo = new NewstarCustomerInfo();
        System.assertEquals(new List<NewstarCustomerLotAssociationInfo>(), customerInfo.lotAssociations);
        System.assertEquals(new List<NewstarCoBuyer>(), customerInfo.coBuyers);
        System.assertEquals(null, customerInfo.id);
        System.assertEquals(null, customerInfo.salesOfficeId);
        System.assertEquals(null, customerInfo.firstName);
        System.assertEquals(null, customerInfo.lastName);
        System.assertEquals(null, customerInfo.streetAddress1);
        System.assertEquals(null, customerInfo.streetAddress2);
        System.assertEquals(null, customerInfo.city);
        System.assertEquals(null, customerInfo.stateProvinceId);
        System.assertEquals(null, customerInfo.zipPostalCode);
        System.assertEquals(null, customerInfo.homeEmail);
        System.assertEquals(null, customerInfo.workEmail);
        System.assertEquals(null, customerInfo.homePhone);
        System.assertEquals(null, customerInfo.workPhone);
        System.assertEquals(null, customerInfo.mobilePhone);
        System.assertEquals(null, customerInfo.isArchived);
        System.assertEquals(null, customerInfo.isOptOut);
        System.assertEquals(null, customerInfo.lastModifiedDate);
        System.assertEquals(null, customerInfo.salesAgentId);
        System.assertEquals(null, customerInfo.realEstateAgentId);
    }
}