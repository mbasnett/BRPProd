@isTest
private class NewstarCustomerLotAssociationInfoTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo1 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo2 = customerLotAssociationInfo1;
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo3 = new NewstarCustomerLotAssociationInfo();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo4 = customerLotAssociationInfo3;

        System.assert(customerLotAssociationInfo1.equals(customerLotAssociationInfo2));
        System.assert(customerLotAssociationInfo2.equals(customerLotAssociationInfo1));
        System.assert(customerLotAssociationInfo1.equals(customerLotAssociationInfo1));
        System.assert(customerLotAssociationInfo3.equals(customerLotAssociationInfo4));
        System.assert(customerLotAssociationInfo4.equals(customerLotAssociationInfo3));
        System.assert(customerLotAssociationInfo3.equals(customerLotAssociationInfo3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo1 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo2 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo3 = new NewstarCustomerLotAssociationInfo();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo4 = new NewstarCustomerLotAssociationInfo();

        System.assert(customerLotAssociationInfo1.equals(customerLotAssociationInfo2));
        System.assert(customerLotAssociationInfo2.equals(customerLotAssociationInfo1));
        System.assert(customerLotAssociationInfo3.equals(customerLotAssociationInfo4));
        System.assert(customerLotAssociationInfo4.equals(customerLotAssociationInfo3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo1 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo2 = new NewstarCustomerLotAssociationInfo();

        System.assertEquals(false, customerLotAssociationInfo1.equals('foo'));
        System.assertEquals(false, customerLotAssociationInfo2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo1 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo2 = new NewstarCustomerLotAssociationInfo();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo3;

        System.assertEquals(false, customerLotAssociationInfo1.equals(customerLotAssociationInfo3));
        System.assertEquals(false, customerLotAssociationInfo2.equals(customerLotAssociationInfo3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo1 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo2 = new NewstarCustomerLotAssociationInfo();

        System.assertEquals(customerLotAssociationInfo1.hashCode(), customerLotAssociationInfo1.hashCode());
        System.assertEquals(customerLotAssociationInfo2.hashCode(), customerLotAssociationInfo2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo1 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo2 = NewstarCustomerLotAssociationInfo.getExample();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo3 = new NewstarCustomerLotAssociationInfo();
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo4 = new NewstarCustomerLotAssociationInfo();

        System.assert(customerLotAssociationInfo1.equals(customerLotAssociationInfo2));
        System.assert(customerLotAssociationInfo3.equals(customerLotAssociationInfo4));
        System.assertEquals(customerLotAssociationInfo1.hashCode(), customerLotAssociationInfo2.hashCode());
        System.assertEquals(customerLotAssociationInfo3.hashCode(), customerLotAssociationInfo4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarCustomerLotAssociationInfo customerLotAssociationInfo = new NewstarCustomerLotAssociationInfo();
        System.assertEquals(new List<NewstarContingency>(), customerLotAssociationInfo.contingencies);
        System.assertEquals(new List<NewstarCoBuyer>(), customerLotAssociationInfo.coBuyers);
        System.assertEquals(null, customerLotAssociationInfo.id);
        System.assertEquals(null, customerLotAssociationInfo.customerId);
        System.assertEquals(null, customerLotAssociationInfo.subdivisionId);
        System.assertEquals(null, customerLotAssociationInfo.lotId);
        System.assertEquals(null, customerLotAssociationInfo.swing);
        System.assertEquals(null, customerLotAssociationInfo.modelId);
        System.assertEquals(null, customerLotAssociationInfo.reservationDate);
        System.assertEquals(null, customerLotAssociationInfo.reservationExpirationDate);
        System.assertEquals(null, customerLotAssociationInfo.contractSubmissionDate);
        System.assertEquals(null, customerLotAssociationInfo.contractApprovalDate);
        System.assertEquals(null, customerLotAssociationInfo.actualClosingDate);
        System.assertEquals(null, customerLotAssociationInfo.cancellationDate);
        System.assertEquals(null, customerLotAssociationInfo.isContractReady);
        System.assertEquals(null, customerLotAssociationInfo.status);
    }
}