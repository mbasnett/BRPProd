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

/**
 * NewstarRealEstateAgencyInfo
 */
public class NewstarRealEstateAgencyInfo {
    /**
     * Get id
     * @return id
     */
    public Integer id { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get streetAddress
     * @return streetAddress
     */
    public String streetAddress { get; set; }

    /**
     * Get city
     * @return city
     */
    public String city { get; set; }

    /**
     * Get stateProvinceCode
     * @return stateProvinceCode
     */
    public String stateProvinceCode { get; set; }

    /**
     * Get zipPostalCode
     * @return zipPostalCode
     */
    public String zipPostalCode { get; set; }

    /**
     * Get phoneNumber
     * @return phoneNumber
     */
    public String phoneNumber { get; set; }

   public static NewstarRealEstateAgencyInfo getExample() {
        NewstarRealEstateAgencyInfo realEstateAgencyInfo = new NewstarRealEstateAgencyInfo();
          realEstateAgencyInfo.id = 0;
          realEstateAgencyInfo.name = '';
          realEstateAgencyInfo.streetAddress = '';
          realEstateAgencyInfo.city = '';
          realEstateAgencyInfo.stateProvinceCode = '';
          realEstateAgencyInfo.zipPostalCode = '';
          realEstateAgencyInfo.phoneNumber = '';
        return realEstateAgencyInfo;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarRealEstateAgencyInfo) {           
            NewstarRealEstateAgencyInfo realEstateAgencyInfo = (NewstarRealEstateAgencyInfo) obj;
            return this.id == realEstateAgencyInfo.id
                && this.name == realEstateAgencyInfo.name
                && this.streetAddress == realEstateAgencyInfo.streetAddress
                && this.city == realEstateAgencyInfo.city
                && this.stateProvinceCode == realEstateAgencyInfo.stateProvinceCode
                && this.zipPostalCode == realEstateAgencyInfo.zipPostalCode
                && this.phoneNumber == realEstateAgencyInfo.phoneNumber;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (streetAddress == null ? 0 : System.hashCode(streetAddress));
        hashCode = (17 * hashCode) + (city == null ? 0 : System.hashCode(city));
        hashCode = (17 * hashCode) + (stateProvinceCode == null ? 0 : System.hashCode(stateProvinceCode));
        hashCode = (17 * hashCode) + (zipPostalCode == null ? 0 : System.hashCode(zipPostalCode));
        hashCode = (17 * hashCode) + (phoneNumber == null ? 0 : System.hashCode(phoneNumber));
        return hashCode;
    }
}