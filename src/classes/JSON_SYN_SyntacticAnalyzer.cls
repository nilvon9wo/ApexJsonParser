// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public virtual class JSON_SYN_SyntacticAnalyzer {
	
	// We can't inject these because the codependcy with JSON_SYN_SyntacticAnalyzer either  
	// results in the parser list being unpopulated at parse time; or or it
	// results in an infinite loop. 
	
	@testVisible
	private static final List<JSON_SYN_ParserIntf> DEFAULT_PARSER_LIST = new List<JSON_SYN_ParserIntf>{
			JSON_SYN_ArrayParser.getInstance(), 
			JSON_SYN_ObjectParser.getInstance(),
			JSON_SYN_PrimativeParser.getInstance()
	};
	 
	// Singleton
	@testVisible private static JSON_SYN_SyntacticAnalyzer instance;
	public static JSON_SYN_SyntacticAnalyzer getInstance() {
		if (instance == null) {
			instance = new JSON_SYN_SyntacticAnalyzer();		
		}
		return instance;
	}
	
	// --------------------------------------------------------------------------------

	
    public virtual Object findValue(IMUT_ImmutableList tokenList) {
	    return this.parse(tokenList).getValue(); 
    }

    public virtual JSON_SYN_ParseResultIntf parse(IMUT_ImmutableList tokenList) {
    	JSON_SYN_ParseResultIntf parseResult = new JSON_SYN_ParseResultObject(tokenList);
    	while (!parseResult.getRemainder().isEmpty()) {
    		parseResult = this.parse(parseResult.getRemainder(), parseResult);
    		if (parseResult.isDefined()) {
    			return parseResult;
    		}
    	}
    	return parseResult;
    }
 
    @testVisible  
	private virtual JSON_SYN_ParseResultIntf parse (IMUT_ImmutableList tokenList, JSON_SYN_ParseResultIntf parseResult) {
		for (JSON_SYN_ParserIntf parser : DEFAULT_PARSER_LIST) {
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