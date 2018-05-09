// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public virtual class JSON_SYN_SyntacticAnalyzer {
	List<JSON_SYN_ParserIntf> parserList;
	
	public JSON_SYN_SyntacticAnalyzer(List<JSON_SYN_ParserIntf> parserList) {
		this.parserList = parserList;
	}
	 
	public JSON_SYN_SyntacticAnalyzer() {
		this(new List<JSON_SYN_ParserIntf>{
				new JSON_SYN_ArrayParser(), 
				new JSON_SYN_ObjectParser(),
				new JSON_SYN_PrimativeParser()
		});
	}
	
    public virtual IMUT_ImmutableMap findValues (IMUT_ImmutableList tokenList) {
    	return this.parse(tokenList).valueMap; // TODO: convert Map to Object?
    }

    public virtual JSON_SYN_ParseKeyedResult parse (IMUT_ImmutableList tokenList) {
    	JSON_SYN_ParseKeyedResult parseResult = new JSON_SYN_ParseKeyedResult(tokenList);
    	while (!parseResult.remainder.isEmpty()) {
    		parseResult = this.parse(parseResult, parseResult.remainder);
    	}
    	return parseResult;
    }
 
    @testVisible
	private virtual JSON_SYN_ParseKeyedResult parse (JSON_SYN_ParseKeyedResult parseResult, IMUT_ImmutableList tokenList) {
		for (JSON_SYN_ParserIntf parser : this.parserList) {
			String key = null; // TODO: Get the key
			JSON_SYN_ParseValueResult result = parser.parse(tokenList);
			return new JSON_SYN_ParseKeyedResult(  
				parseResult.valueMap.putAll(new Map<Object, Object>{ key => result.value }),  
				result.remainder 
			);
		}
		
		Object nextToken = tokenList.get(0);
		throw new JSON_SYN_SyntacticAnalyzerException('Unexpected token: ' + nextToken);
    }
}