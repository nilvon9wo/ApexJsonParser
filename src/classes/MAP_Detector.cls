public class MAP_Detector {
    public Boolean isMap(Object obj) {
    	String str = String.valueOf(obj);
    	String firstCharacter = str.substring(0, 1);
    	String lastCharacter = str.substring(str.length() - 1, str.length());
    	return !(obj instanceof String)
    		&& '{'.equals(firstCharacter)
    		&& '}'.equals(lastCharacter);
    }
}