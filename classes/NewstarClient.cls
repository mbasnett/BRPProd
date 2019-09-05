global class NewstarClient extends OAS.ApiClient {
    public NewstarClient() {
        basePath = 'http://localhost';
        calloutName = 'Constellation_SFDC_Integration_API';
        authentications.put('Bearer', new OAS.ApiKeyHeaderAuth('Authorization'));
    }
}