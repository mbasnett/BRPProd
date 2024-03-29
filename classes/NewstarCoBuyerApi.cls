/*
 * Constellation SFDC Integration API
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * OpenAPI spec version: v1
 * 
 *
 * NOTE: This class is auto generated by the OAS code generator program.
 * https://github.com/OAS-api/OAS-codegen.git
 * Do not edit the class manually.
 */

public class NewstarCoBuyerApi {
    NewstarClient client;

    public NewstarCoBuyerApi(NewstarClient client) {
        this.client = client;
    }

    public NewstarCoBuyerApi() {
        this.client = new NewstarClient();
    }

    public NewstarClient getClient() {
        return this.client;
    }

    /**
     * Creates a new cobuyer in NEWSTAR Sales for the specified existing lot reservation.
     * 
     * @param lotReservationId ID of the existing lot reservation previously submitted to NEWSTAR Sales. (optional)
     * @param newstarCoBuyer Cobuyer record object. (optional)
     * @return NewstarCoBuyer
     * @throws OAS.ApiException if fails to make API call
     */
    public NewstarCoBuyer post(Map<String, Object> params) {
        List<OAS.Param> query = new List<OAS.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('lotReservationId', (Integer) params.get('lotReservationId')));

        List<OAS.Param> form = new List<OAS.Param>();

        return (NewstarCoBuyer) client.invoke(
            'POST', '/api/CoBuyer',
            (NewstarCoBuyer) params.get('newstarCoBuyer'),
            query, form,
            new Map<String, Object>(),
            new Map<String, Object>(),
            new List<String>{ 'text/plain', 'application/json', 'text/json' },
            new List<String>{ 'application/json-patch+json', 'application/json', 'text/json', 'application/_*+json' },
            new List<String>(),
            NewstarCoBuyer.class
        );
    }
    /**
     * Updates an existing cobuyer record in NEWSTAR Sales.
     * This operation does NOT re-associate the cobuyer with any existing lot reservations.
     * @param newstarCoBuyer Cobuyer record object. (optional)
     * @return NewstarCoBuyer
     * @throws OAS.ApiException if fails to make API call
     */
    public NewstarCoBuyer put(Map<String, Object> params) {
        List<OAS.Param> query = new List<OAS.Param>();
        List<OAS.Param> form = new List<OAS.Param>();

        return (NewstarCoBuyer) client.invoke(
            'PUT', '/api/CoBuyer',
            (NewstarCoBuyer) params.get('newstarCoBuyer'),
            query, form,
            new Map<String, Object>(),
            new Map<String, Object>(),
            new List<String>{ 'text/plain', 'application/json', 'text/json' },
            new List<String>{ 'application/json-patch+json', 'application/json', 'text/json', 'application/_*+json' },
            new List<String>(),
            NewstarCoBuyer.class
        );
    }
}