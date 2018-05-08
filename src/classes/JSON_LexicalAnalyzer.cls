// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public virtual class JSON_LexicalAnalyzer { 
	JSON_Matchers matchers;
	public JSON_LexicalAnalyzer(JSON_Matchers matchers) {
		this.matchers = matchers;
	}
 
	public JSON_LexicalAnalyzer() {
		this(new JSON_Matchers());
	}
	
    public virtual IMUT_ImmutableList findTokens(String inputString) {
    	JSON_ParseResult parseResult = new JSON_ParseResult(null, inputString);
    	while (parseResult.remainder.isDefined()) {
    		parseResult = this.parse(this.matchers.matchString((String) parseResult.remainder.get()));
    	}
    	return parseResult.tokenList;
    } 

	@testVisible 
	private JSON_ParseResult parse(JSON_ParseResult parseResult) {
		JSON_ParsePopResult parsePopResult = parseResult.popRemainder(); 
		
		OPT_Option nextCharacter = parsePopResult.nextCharacter; 
		JSON_ParseResult nextParseResult = parsePopResult.parseResult; 
		
		JSON_ParseResult returnParseResult = nextParseResult;
		if (nextCharacter.isDefined()) {
			JSON_ParseResult syntaxResult = parse(nextParseResult, (String) nextCharacter.get());
			if (!syntaxResult.tokenList.isEmpty()) {
				returnParseResult = nextParseResult.pushTokenList(syntaxResult.tokenList);
			}
		}
		return returnParseResult;
	}     
	
	@testVisible
	private JSON_ParseResult parse(JSON_ParseResult parseResult, String nextCharacterString) {
		if (JSON_Characters.WHITESPACE_SET.contains(nextCharacterString)) {
			// Do nothing.
		}
		
		return this.matchers.matchSyntax(nextCharacterString);
	}
}