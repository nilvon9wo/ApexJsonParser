public class JSON_SYN_ParseResult {
    public IMUT_ImmutableMap valueMap {get; private set;}
    public IMUT_ImmutableList remainder {get; private set;}
    
     public JSON_SYN_ParseResult(IMUT_ImmutableMap valueMap, IMUT_ImmutableList remainder) {
    	this.valueMap = valueMap; 
    	this.remainder = remainder;
    }   

     public JSON_SYN_ParseResult(Map<String, Object> mapValueByToken, IMUT_ImmutableList remainder, UTIL_MapHelper mapHelper) {
    	this(
    		new IMUT_ImmutableMap(mapHelper.convertToObjectByObjectMap(mapValueByToken)), 
    		remainder
    	);
    }   
    
     public JSON_SYN_ParseResult(Map<String, Object> mapValueByToken, IMUT_ImmutableList remainder) {
    	this(mapValueByToken, remainder, new UTIL_MapHelper());
    }   

    public JSON_SYN_ParseResult(IMUT_ImmutableList remainder) {
    	this(new IMUT_ImmutableMap(new Map<Object, Object>()), remainder);
    }    
}