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
	 
    public virtual OPT_Option findValue(IMUT_ImmutableList tokenList) {
    	return OPT_Option.option(this.parse(tokenList).getValue()); 
    }

    public virtual JSON_SYN_ParseResultIntf parse(IMUT_ImmutableList tokenList) {
    	JSON_SYN_ParseResultIntf parseResult = new JSON_SYN_ParseResultObject(tokenList);
    	while (!parseResult.getRemainder().isEmpty()) {
    		parseResult = this.parse(parseResult.getRemainder(), parseResult);
    	}
    	return parseResult;
    }
 
    @testVisible  
	private virtual JSON_SYN_ParseResultIntf parse (IMUT_ImmutableList tokenList, JSON_SYN_ParseResultIntf parseResult) {
		for (JSON_SYN_ParserIntf parser : this.parserList) {
			JSON_SYN_ParseResultIntf result = parser.parse(tokenList);
			if (result.isDefined()) {
				return result;
			} 
		}
		
		if (tokenList.isEmpty()) {
			throw new JSON_SYN_SyntacticAnalyzerException('Token list exhaustion unexpected.');
		}
		else {
			Object nextToken = tokenList.get(0);
			throw new JSON_SYN_SyntacticAnalyzerException('Unexpected token: ' + nextToken);
		}
    }
}