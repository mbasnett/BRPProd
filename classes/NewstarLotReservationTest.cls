@isTest
private class NewstarLotReservationTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarLotReservation lotReservation1 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation2 = lotReservation1;
        NewstarLotReservation lotReservation3 = new NewstarLotReservation();
        NewstarLotReservation lotReservation4 = lotReservation3;

        System.assert(lotReservation1.equals(lotReservation2));
        System.assert(lotReservation2.equals(lotReservation1));
        System.assert(lotReservation1.equals(lotReservation1));
        System.assert(lotReservation3.equals(lotReservation4));
        System.assert(lotReservation4.equals(lotReservation3));
        System.assert(lotReservation3.equals(lotReservation3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarLotReservation lotReservation1 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation2 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation3 = new NewstarLotReservation();
        NewstarLotReservation lotReservation4 = new NewstarLotReservation();

        System.assert(lotReservation1.equals(lotReservation2));
        System.assert(lotReservation2.equals(lotReservation1));
        System.assert(lotReservation3.equals(lotReservation4));
        System.assert(lotReservation4.equals(lotReservation3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarLotReservation lotReservation1 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation2 = new NewstarLotReservation();

        System.assertEquals(false, lotReservation1.equals('foo'));
        System.assertEquals(false, lotReservation2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarLotReservation lotReservation1 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation2 = new NewstarLotReservation();
        NewstarLotReservation lotReservation3;

        System.assertEquals(false, lotReservation1.equals(lotReservation3));
        System.assertEquals(false, lotReservation2.equals(lotReservation3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarLotReservation lotReservation1 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation2 = new NewstarLotReservation();

        System.assertEquals(lotReservation1.hashCode(), lotReservation1.hashCode());
        System.assertEquals(lotReservation2.hashCode(), lotReservation2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarLotReservation lotReservation1 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation2 = NewstarLotReservation.getExample();
        NewstarLotReservation lotReservation3 = new NewstarLotReservation();
        NewstarLotReservation lotReservation4 = new NewstarLotReservation();

        System.assert(lotReservation1.equals(lotReservation2));
        System.assert(lotReservation3.equals(lotReservation4));
        System.assertEquals(lotReservation1.hashCode(), lotReservation2.hashCode());
        System.assertEquals(lotReservation3.hashCode(), lotReservation4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarLotReservation lotReservation = new NewstarLotReservation();
        System.assertEquals(new List<NewstarCoBuyer>(), lotReservation.coBuyers);
        System.assertEquals(new List<NewstarContingency>(), lotReservation.contingencies);
        System.assertEquals(null, lotReservation.id);
        System.assertEquals(null, lotReservation.customer);
        System.assertEquals(null, lotReservation.subdivisionId);
        System.assertEquals(null, lotReservation.modelId);
        System.assertEquals(null, lotReservation.lotId);
        System.assertEquals(null, lotReservation.swing);
        System.assertEquals(null, lotReservation.isInvestment);
        System.assertEquals(null, lotReservation.salesAgentId);
        System.assertEquals(null, lotReservation.secondarySalesAgentId);
        System.assertEquals(null, lotReservation.holdPeriodInDays);
        System.assertEquals(null, lotReservation.realEstateAgentId);
        System.assertEquals(null, lotReservation.firstVisitDate);
        System.assertEquals(null, lotReservation.externalId);
    }
}