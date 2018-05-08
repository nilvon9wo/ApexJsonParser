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
    	return this.matchers.match(inputString).tokenList;
    } 
}