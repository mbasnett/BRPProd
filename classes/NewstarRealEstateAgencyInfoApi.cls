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

public class NewstarRealEstateAgencyInfoApi {
    NewstarClient client;

    public NewstarRealEstateAgencyInfoApi(NewstarClient client) {
        this.client = client;
    }

    public NewstarRealEstateAgencyInfoApi() {
        this.client = new NewstarClient();
    }

    public NewstarClient getClient() {
        return this.client;
    }

    /**
     * Returns a list of real estate agencies - brokerage organizations paid commission by the builder.\r\nsales office.
     * 
     * @param fetchSize Number of records to return in the request (used for paging, max 20). (optional, default to 10)
     * @param fetchOffset Number of records to skip from the start of the resulting data set (used for paging). (optional, default to 0)
     * @return NewstarPagedResultRealEstateAgencyIn
     * @throws OAS.ApiException if fails to make API call
     */
    public NewstarPagedResultRealEstateAgencyIn get(Map<String, Object> params) {
        List<OAS.Param> query = new List<OAS.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('fetchSize', (Integer) params.get('fetchSize')));
        query.addAll(client.makeParam('fetchOffset', (Integer) params.get('fetchOffset')));

        List<OAS.Param> form = new List<OAS.Param>();

        return (NewstarPagedResultRealEstateAgencyIn) client.invoke(
            'GET', '/api/RealEstateAgencyInfo', '',
            query, form,
            new Map<String, Object>(),
            new Map<String, Object>(),
            new List<String>{ 'text/plain', 'application/json', 'text/json' },
            new List<String>(),
            new List<String>(),
            NewstarPagedResultRealEstateAgencyIn.class
        );
    }
}