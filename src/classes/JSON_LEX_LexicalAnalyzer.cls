// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public virtual class JSON_LEX_LexicalAnalyzer { 
	List<JSON_LEX_MatchIntf> matcherList; 
	
	public JSON_LEX_LexicalAnalyzer(List<JSON_LEX_MatchIntf> matcherList) {
		this.matcherList = matcherList;
	}
 
	public JSON_LEX_LexicalAnalyzer() {
		this(new List<JSON_LEX_MatchIntf>{
				new JSON_LEX_StringMatcher(), 
				new JSON_LEX_NumberMatcher(),
				new JSON_LEX_BooleanMatcher(),
				new JSON_LEX_NullMatcher(),
				new JSON_LEX_SyntaxMatcher()
		});
	}
	
    public virtual IMUT_ImmutableList findTokens(String inputString) {
    	return this.match(inputString).tokenList;
    } 
    
	public JSON_LEX_ParseResult match(String inputString) {
    	JSON_LEX_ParseResult parseResult = new JSON_LEX_ParseResult(inputString);
    	while (parseResult.remainder.isDefined()) {
    		String remainder = ((String) parseResult.remainder.get()).trim();
    		parseResult = this.match(parseResult, remainder);
    	}
    	return parseResult;
	}

	public JSON_LEX_ParseResult match(JSON_LEX_ParseResult parseResult, String remainder) {
		for (JSON_LEX_MatchIntf matcher : this.matcherList) {
			JSON_LEX_ParseResult result = matcher.matchFor(remainder);
			if (!result.tokenList.isEmpty()) {
				return new JSON_LEX_ParseResult(
					parseResult.tokenList.addAll(result.tokenList), 
					result.remainder
				);
			}
		}
		
		String nextCharacter = remainder.substring(0, 1);
		throw new JSON_LEX_LexicalAnalyzerException('Unexpected character: ' + nextCharacter);
	}
}