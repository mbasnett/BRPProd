public class NewstarDataConversionHelper {

    public static Decimal decimalFromString(String str){
        return Decimal.valueOf(str);
    }

    public static Date dateFromString(String str){
        return Date.valueOf(str);
    }

    public static Boolean booleanFromString(string str){
        return Boolean.valueOf(str);
    }

    public static String generateUniqueId()
    {
        String rawId = EncodingUtil.ConvertTohex(Crypto.GenerateAESKey(128));
        
        return String.join(new List<String> {
            rawId.subString(0,8),
            rawId.subString(8,12),
            rawId.subString(12,16),
            rawId.subString(16,20),
            rawId.substring(20)
        }, '-');
    }


    public static String normalizeEnumValue(string enumValue) {
      
        if(enumValue==null || enumValue.length()<1){
            return null;
        }

        Integer strLength=enumValue.length();

        enumValue=enumValue.toLowerCase();

        enumValue=enumValue.substring(0,1).toUpperCase()+enumValue.substring(1,strLength).toLowerCase();

        return enumValue;

    }


    public static Boolean getBoolWithNull(Boolean value) {
        if(value==null) {
            return false;
        }

        return value;
    }
}