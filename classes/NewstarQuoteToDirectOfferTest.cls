@isTest
private class NewstarQuoteToDirectOfferTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarQuoteToDirectOffer quoteToDirectOffer1 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer2 = quoteToDirectOffer1;
        NewstarQuoteToDirectOffer quoteToDirectOffer3 = new NewstarQuoteToDirectOffer();
        NewstarQuoteToDirectOffer quoteToDirectOffer4 = quoteToDirectOffer3;

        System.assert(quoteToDirectOffer1.equals(quoteToDirectOffer2));
        System.assert(quoteToDirectOffer2.equals(quoteToDirectOffer1));
        System.assert(quoteToDirectOffer1.equals(quoteToDirectOffer1));
        System.assert(quoteToDirectOffer3.equals(quoteToDirectOffer4));
        System.assert(quoteToDirectOffer4.equals(quoteToDirectOffer3));
        System.assert(quoteToDirectOffer3.equals(quoteToDirectOffer3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarQuoteToDirectOffer quoteToDirectOffer1 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer2 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer3 = new NewstarQuoteToDirectOffer();
        NewstarQuoteToDirectOffer quoteToDirectOffer4 = new NewstarQuoteToDirectOffer();

        System.assert(quoteToDirectOffer1.equals(quoteToDirectOffer2));
        System.assert(quoteToDirectOffer2.equals(quoteToDirectOffer1));
        System.assert(quoteToDirectOffer3.equals(quoteToDirectOffer4));
        System.assert(quoteToDirectOffer4.equals(quoteToDirectOffer3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarQuoteToDirectOffer quoteToDirectOffer1 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer2 = new NewstarQuoteToDirectOffer();

        System.assertEquals(false, quoteToDirectOffer1.equals('foo'));
        System.assertEquals(false, quoteToDirectOffer2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarQuoteToDirectOffer quoteToDirectOffer1 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer2 = new NewstarQuoteToDirectOffer();
        NewstarQuoteToDirectOffer quoteToDirectOffer3;

        System.assertEquals(false, quoteToDirectOffer1.equals(quoteToDirectOffer3));
        System.assertEquals(false, quoteToDirectOffer2.equals(quoteToDirectOffer3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarQuoteToDirectOffer quoteToDirectOffer1 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer2 = new NewstarQuoteToDirectOffer();

        System.assertEquals(quoteToDirectOffer1.hashCode(), quoteToDirectOffer1.hashCode());
        System.assertEquals(quoteToDirectOffer2.hashCode(), quoteToDirectOffer2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarQuoteToDirectOffer quoteToDirectOffer1 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer2 = NewstarQuoteToDirectOffer.getExample();
        NewstarQuoteToDirectOffer quoteToDirectOffer3 = new NewstarQuoteToDirectOffer();
        NewstarQuoteToDirectOffer quoteToDirectOffer4 = new NewstarQuoteToDirectOffer();

        System.assert(quoteToDirectOffer1.equals(quoteToDirectOffer2));
        System.assert(quoteToDirectOffer3.equals(quoteToDirectOffer4));
        System.assertEquals(quoteToDirectOffer1.hashCode(), quoteToDirectOffer2.hashCode());
        System.assertEquals(quoteToDirectOffer3.hashCode(), quoteToDirectOffer4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarQuoteToDirectOffer quoteToDirectOffer = new NewstarQuoteToDirectOffer();
        System.assertEquals(new List<NewstarCoBuyer>(), quoteToDirectOffer.coBuyers);
        System.assertEquals(new List<NewstarContingency>(), quoteToDirectOffer.contingencies);
        System.assertEquals(null, quoteToDirectOffer.id);
        System.assertEquals(null, quoteToDirectOffer.customer);
        System.assertEquals(null, quoteToDirectOffer.salesAgentId);
        System.assertEquals(null, quoteToDirectOffer.secondarySalesAgentId);
        System.assertEquals(null, quoteToDirectOffer.realEstateAgentId);
        System.assertEquals(null, quoteToDirectOffer.swing);
        System.assertEquals(null, quoteToDirectOffer.isInvestment);
        System.assertEquals(null, quoteToDirectOffer.firstVisitDate);
        System.assertEquals(null, quoteToDirectOffer.externalId);
    }
}