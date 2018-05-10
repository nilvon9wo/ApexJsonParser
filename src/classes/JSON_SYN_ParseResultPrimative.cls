public class JSON_SYN_ParseResultPrimative implements JSON_SYN_ParseResultIntf{
	OPT_Option value;
	IMUT_ImmutableList remainder;

	public JSON_SYN_ParseResultPrimative(OPT_Option value, IMUT_ImmutableList remainder) {
		this.value = value; 
		this.remainder = remainder;
	}

	public JSON_SYN_ParseResultPrimative(Object value, IMUT_ImmutableList remainder) {
		this(OPT_Option.option(value), remainder);
	}
	
	public JSON_SYN_ParseResultPrimative(IMUT_ImmutableList remainder) {
		this(new OPT_None(), remainder);
	}
    
    public OPT_Option getValue() {
    	return this.value;
    }
    
    public IMUT_ImmutableList getRemainder() {
    	return this.remainder;
    }
    
    public Boolean isDefined() {
    	return true;
    }
}