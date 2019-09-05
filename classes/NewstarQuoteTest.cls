@isTest
private class NewstarQuoteTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarQuote quote1 = NewstarQuote.getExample();
        NewstarQuote quote2 = quote1;
        NewstarQuote quote3 = new NewstarQuote();
        NewstarQuote quote4 = quote3;

        System.assert(quote1.equals(quote2));
        System.assert(quote2.equals(quote1));
        System.assert(quote1.equals(quote1));
        System.assert(quote3.equals(quote4));
        System.assert(quote4.equals(quote3));
        System.assert(quote3.equals(quote3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarQuote quote1 = NewstarQuote.getExample();
        NewstarQuote quote2 = NewstarQuote.getExample();
        NewstarQuote quote3 = new NewstarQuote();
        NewstarQuote quote4 = new NewstarQuote();

        System.assert(quote1.equals(quote2));
        System.assert(quote2.equals(quote1));
        System.assert(quote3.equals(quote4));
        System.assert(quote4.equals(quote3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarQuote quote1 = NewstarQuote.getExample();
        NewstarQuote quote2 = new NewstarQuote();

        System.assertEquals(false, quote1.equals('foo'));
        System.assertEquals(false, quote2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarQuote quote1 = NewstarQuote.getExample();
        NewstarQuote quote2 = new NewstarQuote();
        NewstarQuote quote3;

        System.assertEquals(false, quote1.equals(quote3));
        System.assertEquals(false, quote2.equals(quote3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarQuote quote1 = NewstarQuote.getExample();
        NewstarQuote quote2 = new NewstarQuote();

        System.assertEquals(quote1.hashCode(), quote1.hashCode());
        System.assertEquals(quote2.hashCode(), quote2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarQuote quote1 = NewstarQuote.getExample();
        NewstarQuote quote2 = NewstarQuote.getExample();
        NewstarQuote quote3 = new NewstarQuote();
        NewstarQuote quote4 = new NewstarQuote();

        System.assert(quote1.equals(quote2));
        System.assert(quote3.equals(quote4));
        System.assertEquals(quote1.hashCode(), quote2.hashCode());
        System.assertEquals(quote3.hashCode(), quote4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarQuote quote = new NewstarQuote();
        System.assertEquals(new List<NewstarCoBuyer>(), quote.coBuyers);
        System.assertEquals(new List<NewstarContingency>(), quote.contingencies);
        System.assertEquals(null, quote.id);
        System.assertEquals(null, quote.customer);
        System.assertEquals(null, quote.subdivisionId);
        System.assertEquals(null, quote.modelId);
        System.assertEquals(null, quote.lotId);
        System.assertEquals(null, quote.swing);
        System.assertEquals(null, quote.salesAgentId);
        System.assertEquals(null, quote.secondarySalesAgentId);
        System.assertEquals(null, quote.realEstateAgentId);
        System.assertEquals(null, quote.scenarioName);
        System.assertEquals(null, quote.isInvestment);
        System.assertEquals(null, quote.firstVisitDate);
        System.assertEquals(null, quote.externalId);
    }
}