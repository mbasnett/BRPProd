@isTest
private class NewstarQuoteToLotReservationTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarQuoteToLotReservation quoteToLotReservation1 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation2 = quoteToLotReservation1;
        NewstarQuoteToLotReservation quoteToLotReservation3 = new NewstarQuoteToLotReservation();
        NewstarQuoteToLotReservation quoteToLotReservation4 = quoteToLotReservation3;

        System.assert(quoteToLotReservation1.equals(quoteToLotReservation2));
        System.assert(quoteToLotReservation2.equals(quoteToLotReservation1));
        System.assert(quoteToLotReservation1.equals(quoteToLotReservation1));
        System.assert(quoteToLotReservation3.equals(quoteToLotReservation4));
        System.assert(quoteToLotReservation4.equals(quoteToLotReservation3));
        System.assert(quoteToLotReservation3.equals(quoteToLotReservation3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarQuoteToLotReservation quoteToLotReservation1 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation2 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation3 = new NewstarQuoteToLotReservation();
        NewstarQuoteToLotReservation quoteToLotReservation4 = new NewstarQuoteToLotReservation();

        System.assert(quoteToLotReservation1.equals(quoteToLotReservation2));
        System.assert(quoteToLotReservation2.equals(quoteToLotReservation1));
        System.assert(quoteToLotReservation3.equals(quoteToLotReservation4));
        System.assert(quoteToLotReservation4.equals(quoteToLotReservation3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarQuoteToLotReservation quoteToLotReservation1 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation2 = new NewstarQuoteToLotReservation();

        System.assertEquals(false, quoteToLotReservation1.equals('foo'));
        System.assertEquals(false, quoteToLotReservation2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarQuoteToLotReservation quoteToLotReservation1 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation2 = new NewstarQuoteToLotReservation();
        NewstarQuoteToLotReservation quoteToLotReservation3;

        System.assertEquals(false, quoteToLotReservation1.equals(quoteToLotReservation3));
        System.assertEquals(false, quoteToLotReservation2.equals(quoteToLotReservation3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarQuoteToLotReservation quoteToLotReservation1 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation2 = new NewstarQuoteToLotReservation();

        System.assertEquals(quoteToLotReservation1.hashCode(), quoteToLotReservation1.hashCode());
        System.assertEquals(quoteToLotReservation2.hashCode(), quoteToLotReservation2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarQuoteToLotReservation quoteToLotReservation1 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation2 = NewstarQuoteToLotReservation.getExample();
        NewstarQuoteToLotReservation quoteToLotReservation3 = new NewstarQuoteToLotReservation();
        NewstarQuoteToLotReservation quoteToLotReservation4 = new NewstarQuoteToLotReservation();

        System.assert(quoteToLotReservation1.equals(quoteToLotReservation2));
        System.assert(quoteToLotReservation3.equals(quoteToLotReservation4));
        System.assertEquals(quoteToLotReservation1.hashCode(), quoteToLotReservation2.hashCode());
        System.assertEquals(quoteToLotReservation3.hashCode(), quoteToLotReservation4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarQuoteToLotReservation quoteToLotReservation = new NewstarQuoteToLotReservation();
        System.assertEquals(new List<NewstarCoBuyer>(), quoteToLotReservation.coBuyers);
        System.assertEquals(new List<NewstarContingency>(), quoteToLotReservation.contingencies);
        System.assertEquals(null, quoteToLotReservation.id);
        System.assertEquals(null, quoteToLotReservation.customer);
        System.assertEquals(null, quoteToLotReservation.salesAgentId);
        System.assertEquals(null, quoteToLotReservation.secondarySalesAgentId);
        System.assertEquals(null, quoteToLotReservation.holdPeriodInDays);
        System.assertEquals(null, quoteToLotReservation.realEstateAgentId);
        System.assertEquals(null, quoteToLotReservation.swing);
        System.assertEquals(null, quoteToLotReservation.isInvestment);
        System.assertEquals(null, quoteToLotReservation.firstVisitDate);
        System.assertEquals(null, quoteToLotReservation.externalId);
    }
}