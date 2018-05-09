public class JSON_SYN_ParseResult {
    public IMUT_ImmutableMap valueMap {get; private set;}
    public IMUT_ImmutableList remainder {get; private set;}
    
     public JSON_SYN_ParseResult(IMUT_ImmutableMap valueMap, IMUT_ImmutableList remainder) {
    	this.valueMap = valueMap; 
    	this.remainder = remainder;
    }   
    
    public JSON_SYN_ParseResult(IMUT_ImmutableList remainder) {
    	this.valueMap = this.createMapFor(null);
    	this.remainder = remainder;
    }    
    
    @testVisible 
    private IMUT_ImmutableList createMapFor(Map<String, Object> value) {
    	return new IMUT_ImmutableMap(
    		(value == null)
	    		? new Map<Object, Object>{}
	    		: value
    	);
    }    
}