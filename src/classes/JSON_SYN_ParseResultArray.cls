public class JSON_SYN_ParseResultArray implements JSON_SYN_ParseResultIntf{
	public static Boolean IS_FINISHED = true;
	public static Boolean NOT_FINISHED = false;
	
	OPT_Option value;
	IMUT_ImmutableList remainder;
	Boolean isFinished;

	public JSON_SYN_ParseResultArray(OPT_Option value, IMUT_ImmutableList remainder, Boolean isFinished) {
		this.value = value;
		this.remainder = remainder;
		this.isFinished = isFinished;
	}

	public JSON_SYN_ParseResultArray(IMUT_ImmutableList value, IMUT_ImmutableList remainder, Boolean isFinished) {
		this(OPT_Option.option(value), remainder, isFinished);
	}

	public JSON_SYN_ParseResultArray(IMUT_ImmutableList remainder) {
		this(new OPT_None(), remainder, NOT_FINISHED);
	}
    
    public IMUT_ImmutableList getValue() {
    	return (IMUT_ImmutableList) this.value.get();
    }
    
    public IMUT_ImmutableList getIncompleteList() {
    	return (this.value.isDefined())
    		? (IMUT_ImmutableList) this.value.get()
    		: new IMUT_ImmutableList();
    }
    
    public IMUT_ImmutableList getRemainder() {
    	return this.remainder;
    }
    
    public Boolean isDefined() {
    	return this.value.isDefined();
    }

    public Boolean isFinished() {
    	return this.isFinished;
    }
}