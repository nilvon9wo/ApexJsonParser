// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public class JSON_Parser {
    JSON_LexicalAnalyzer lexicalAnalyzer;
    JSON_SyntacticAnalyzer syntacticAnalyzer;
    
    public JSON_Parser(
    		JSON_LexicalAnalyzer lexicalAnalyzer,
    		JSON_SyntacticAnalyzer syntacticAnalyzer
    	) {
    	this.lexicalAnalyzer = lexicalAnalyzer;
    	this.syntacticAnalyzer = syntacticAnalyzer;
    }
    
    public JSON_Parser() {
    	this(new JSON_LexicalAnalyzer(), new JSON_SyntacticAnalyzer());
    }
    
    public IMUT_ImmutableMap parse(String json) {
    	IMUT_ImmutableList tokenList = this.lexicalAnalyzer.findTokens(json);
    	return this.syntacticAnalyzer.parse(tokenList);
    }
}