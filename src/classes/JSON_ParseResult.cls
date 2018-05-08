public class JSON_ParseResult {
    public IMUT_ImmutableList tokenList {get; private set;}
    public OPT_Option remainder {get; private set;}

    public JSON_ParseResult(IMUT_ImmutableList tokenList, OPT_Option remainder) {
    	this.tokenList = tokenList;
    	this.remainder = remainder;
    }

    public JSON_ParseResult(List<Object> objectList, String remainder) {
    	this.tokenList = new IMUT_ImmutableList(objectList);
    	this.remainder = this.createOptionFor(remainder);
    }
    
    public JSON_ParseResult(Object token, String remainder) {
    	this.tokenList = this.createListFor(token);
    	this.remainder = this.createOptionFor(remainder);
    }

    public JSON_ParseResult(String remainder) {
    	this.tokenList = this.createListFor(null);
    	this.remainder = this.createOptionFor(remainder);
    }
    
    @testVisible 
    private IMUT_ImmutableList createListFor(Object token) {
    	Boolean isBlank = token == null
    		|| token instanceof String && String.isBlank((String) token);
    		
    	return new IMUT_ImmutableList(
    		(isBlank)
	    		? new List<Object>{}
	    		: new List<Object>{token}
    	);
    }
    
    @testVisible
    private OPT_Option createOptionFor(String remainder) {
    	return (String.isBlank(remainder))
    		? new OPT_None()
    		: OPT_Option.option(remainder);
    }
    
    public JSON_ParsePopResult popRemainder() {
    	return new JSON_ParsePopResult(this);
    }
    
    public JSON_ParseResult pushToken(String token) {
    	return new JSON_ParseResult(this.tokenList.add(token), this.remainder);
    }
    
    public JSON_ParseResult pushTokenList(IMUT_ImmutableList tokenList) {
    	return new JSON_ParseResult(this.tokenList.addAll(tokenList), this.remainder); 
    }

} 