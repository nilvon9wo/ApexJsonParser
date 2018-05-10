public class JSON_SYN_ParseResultObject implements JSON_SYN_ParseResultIntf{
	public static Boolean IS_FINISHED = true;
	public static Boolean NOT_FINISHED = false;

	OPT_Option value;
	IMUT_ImmutableList remainder;
	Boolean isFinished;

	public JSON_SYN_ParseResultObject(OPT_Option value, IMUT_ImmutableList remainder, Boolean isFinished) {
		this.value = value;
		this.remainder = remainder;
		this.isFinished = isFinished;
	}

	public JSON_SYN_ParseResultObject(IMUT_ImmutableMap value, IMUT_ImmutableList remainder, Boolean isFinished) {
		this(OPT_Option.option(value), remainder, isFinished);
	}
	
	public JSON_SYN_ParseResultObject(IMUT_ImmutableList remainder) {
		this(new OPT_None(), remainder, NOT_FINISHED); 
	}
    
    public IMUT_ImmutableMap getValue() {
    	return (IMUT_ImmutableMap) this.value.get();
    }
    
    public IMUT_ImmutableMap getIncompleteMap() {
    	return (this.value.isDefined())
    		? (IMUT_ImmutableMap) this.value.get()
    		: new IMUT_ImmutableMap();
    }
        
    public IMUT_ImmutableList getRemainder() {
    	return this.remainder;
    }
    
    public Boolean isDefined() {
    	return this.value.isDefined();
    }
    
    public Boolean isFinished() {
    	return this.isFinished();
    }
}