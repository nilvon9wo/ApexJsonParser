public class JSON_SYN_ParseResultString implements JSON_SYN_ParseResultIntf{
	OPT_Option value;
	IMUT_ImmutableList remainder;

	public JSON_SYN_ParseResultString(String value, IMUT_ImmutableList remainder) {
		this.value = OPT_Option.option(value);
		this.remainder = remainder;
	} 

    public String getValue() {
    	return (String) this.value.get();
    }
    
    public IMUT_ImmutableList getRemainder() {
    	return this.remainder;
    }
    
    public Boolean isDefined() {
    	return true;
    }
}