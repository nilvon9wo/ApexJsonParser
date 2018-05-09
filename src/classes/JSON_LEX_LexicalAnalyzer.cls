// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public virtual class JSON_LEX_LexicalAnalyzer { 
	List<JSON_LEX_ParserIntf> ParserList; 
	
	public JSON_LEX_LexicalAnalyzer(List<JSON_LEX_ParserIntf> ParserList) {
		this.ParserList = ParserList;
	}
 
	public JSON_LEX_LexicalAnalyzer() {
		this(new List<JSON_LEX_ParserIntf>{
				new JSON_LEX_StringParser(), 
				new JSON_LEX_NumberParser(),
				new JSON_LEX_BooleanParser(),
				new JSON_LEX_NullParser(),
				new JSON_LEX_SyntaxParser()
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
		for (JSON_LEX_ParserIntf Parser : this.ParserList) {
			JSON_LEX_ParseResult result = Parser.parseFor(remainder);
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