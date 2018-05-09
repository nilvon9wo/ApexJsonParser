public class JSON_SYN_ParseValueResult {
    public Object value {get; private set;}
    public IMUT_ImmutableList remainder {get; private set;}
    
    public JSON_SYN_ParseValueResult(Object value, IMUT_ImmutableList remainder) {
    	this.value = value; 
    	this.remainder = remainder;
    }   

    public JSON_SYN_ParseValueResult(IMUT_ImmutableList remainder) {
    	this(null, remainder);
    }    
}