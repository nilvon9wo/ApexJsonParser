public class JSON_SYN_ParseKeyedResult {
    public IMUT_ImmutableMap valueMap {get; private set;}
    public IMUT_ImmutableList remainder {get; private set;}
    
    public JSON_SYN_ParseKeyedResult(IMUT_ImmutableMap valueMap, IMUT_ImmutableList remainder) {
    	this.valueMap = valueMap; 
    	this.remainder = remainder;  
    }   

    public JSON_SYN_ParseKeyedResult(Map<String, Object> mapValueByToken, IMUT_ImmutableList remainder, UTIL_MapConverter mapConverter) {
    	this(
    		new IMUT_ImmutableMap(mapConverter.convertToObjectByObjectMap(mapValueByToken)), 
    		remainder
    	);
    }   
    
    public JSON_SYN_ParseKeyedResult(Map<String, Object> mapValueByToken, IMUT_ImmutableList remainder) {
    	this(mapValueByToken, remainder, new UTIL_MapConverter());
    }   

    public JSON_SYN_ParseKeyedResult(IMUT_ImmutableList remainder) {
    	this(new IMUT_ImmutableMap(new Map<Object, Object>()), remainder);
    }    
}