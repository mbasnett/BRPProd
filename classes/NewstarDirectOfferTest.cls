@isTest
private class NewstarDirectOfferTest {
    @isTest
    private static void equalsSameInstance() {
        NewstarDirectOffer directOffer1 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer2 = directOffer1;
        NewstarDirectOffer directOffer3 = new NewstarDirectOffer();
        NewstarDirectOffer directOffer4 = directOffer3;

        System.assert(directOffer1.equals(directOffer2));
        System.assert(directOffer2.equals(directOffer1));
        System.assert(directOffer1.equals(directOffer1));
        System.assert(directOffer3.equals(directOffer4));
        System.assert(directOffer4.equals(directOffer3));
        System.assert(directOffer3.equals(directOffer3));
    }

    @isTest
    private static void equalsIdenticalInstance() {
        NewstarDirectOffer directOffer1 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer2 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer3 = new NewstarDirectOffer();
        NewstarDirectOffer directOffer4 = new NewstarDirectOffer();

        System.assert(directOffer1.equals(directOffer2));
        System.assert(directOffer2.equals(directOffer1));
        System.assert(directOffer3.equals(directOffer4));
        System.assert(directOffer4.equals(directOffer3));
    }

    @isTest
    private static void notEqualsDifferentType() {
        NewstarDirectOffer directOffer1 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer2 = new NewstarDirectOffer();

        System.assertEquals(false, directOffer1.equals('foo'));
        System.assertEquals(false, directOffer2.equals('foo'));
    }

    @isTest
    private static void notEqualsNull() {
        NewstarDirectOffer directOffer1 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer2 = new NewstarDirectOffer();
        NewstarDirectOffer directOffer3;

        System.assertEquals(false, directOffer1.equals(directOffer3));
        System.assertEquals(false, directOffer2.equals(directOffer3));
    }

    @isTest
    private static void consistentHashCodeValue() {
        NewstarDirectOffer directOffer1 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer2 = new NewstarDirectOffer();

        System.assertEquals(directOffer1.hashCode(), directOffer1.hashCode());
        System.assertEquals(directOffer2.hashCode(), directOffer2.hashCode());
    }

    @isTest
    private static void equalInstancesHaveSameHashCode() {
        NewstarDirectOffer directOffer1 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer2 = NewstarDirectOffer.getExample();
        NewstarDirectOffer directOffer3 = new NewstarDirectOffer();
        NewstarDirectOffer directOffer4 = new NewstarDirectOffer();

        System.assert(directOffer1.equals(directOffer2));
        System.assert(directOffer3.equals(directOffer4));
        System.assertEquals(directOffer1.hashCode(), directOffer2.hashCode());
        System.assertEquals(directOffer3.hashCode(), directOffer4.hashCode());
    }

    @isTest
    private static void defaultValuesPopulated() {
        NewstarDirectOffer directOffer = new NewstarDirectOffer();
        System.assertEquals(new List<NewstarCoBuyer>(), directOffer.coBuyers);
        System.assertEquals(new List<NewstarContingency>(), directOffer.contingencies);
        System.assertEquals(null, directOffer.id);
        System.assertEquals(null, directOffer.customer);
        System.assertEquals(null, directOffer.subdivisionId);
        System.assertEquals(null, directOffer.modelId);
        System.assertEquals(null, directOffer.lotId);
        System.assertEquals(null, directOffer.swing);
        System.assertEquals(null, directOffer.isInvestment);
        System.assertEquals(null, directOffer.salesAgentId);
        System.assertEquals(null, directOffer.secondarySalesAgentId);
        System.assertEquals(null, directOffer.realEstateAgentId);
        System.assertEquals(null, directOffer.selectionDate);
        System.assertEquals(null, directOffer.closingTargetDate);
        System.assertEquals(null, directOffer.closingType);
        System.assertEquals(null, directOffer.firstVisitDate);
        System.assertEquals(null, directOffer.externalId);
    }
}