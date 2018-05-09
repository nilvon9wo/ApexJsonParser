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
	
    public IMUT_ImmutableMap findValues (IMUT_ImmutableList tokenList) {
    	return null; // TODO
    }
} 