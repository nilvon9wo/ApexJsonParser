public virtual class JSON_Matchers {
	
	private static final JSON_StringMatcher STRING_MATCHER = new JSON_StringMatcher();
	private static final JSON_NumberMatcher NUMBER_MATCHER = new JSON_NumberMatcher();
	private static final JSON_BooleanMatcher BOOLEAN_MATCHER = new JSON_BooleanMatcher();
	private static final JSON_NullMatcher NULL_MATCHER = new JSON_NullMatcher();
	private static final JSON_SyntaxMatcher SYNTAX_MATCHER = new JSON_SyntaxMatcher();
	
	private static final List<JSON_MatchIntf> MATCHER_LIST = new List<JSON_MatchIntf>{
		STRING_MATCHER,
		NUMBER_MATCHER,
		BOOLEAN_MATCHER,
		NULL_MATCHER, 
		SYNTAX_MATCHER	// This must be last! 
	};
	
	public JSON_ParseResult match(String inputString) {
    	JSON_ParseResult parseResult = new JSON_ParseResult(inputString);
    	while (parseResult.remainder.isDefined()) {
    		String remainder = ((String) parseResult.remainder.get()).trim();
    		parseResult = this.match(parseResult, remainder);
    	}
    	return parseResult;
	}

	public JSON_ParseResult match(JSON_ParseResult parseResult, String remainder) {
		for (JSON_MatchIntf matcher : MATCHER_LIST) {
			JSON_ParseResult result = matcher.matchFor(remainder);
			if (!result.tokenList.isEmpty()) {
				parseResult = new JSON_ParseResult(
					parseResult.tokenList.addAll(result.tokenList), 
					result.remainder
				);
				break; 
			}
		}
		return parseResult;
	}

	public JSON_ParseResult matchString(String inputString) {
    	return STRING_MATCHER.matchFor(inputString);
    }    

	public JSON_ParseResult matchNumber(String inputString) {
    	return NUMBER_MATCHER.matchFor(inputString);
    }    

	public JSON_ParseResult matchBoolean(String inputString) {
    	return BOOLEAN_MATCHER.matchFor(inputString);
    }    

	public JSON_ParseResult matchNull(String inputString) {
    	return NULL_MATCHER.matchFor(inputString);
    }    

	public JSON_ParseResult matchSyntax(String inputString) {
    	return SYNTAX_MATCHER.matchFor(inputString);
    }    
}