// See: http://notes.eatonphil.com/writing-a-simple-json-parser.html
public class JSON_Parser {
    JSON_LEX_LexicalAnalyzer lexicalAnalyzer;
    JSON_SYN_SyntacticAnalyzer syntacticAnalyzer;
    
    public JSON_Parser(
    		JSON_LEX_LexicalAnalyzer lexicalAnalyzer, 
    		JSON_SYN_SyntacticAnalyzer syntacticAnalyzer
    	) {
    	this.lexicalAnalyzer = lexicalAnalyzer;
    	this.syntacticAnalyzer = syntacticAnalyzer;
    } 
    
    public JSON_Parser() { 
    	this(JSON_LEX_LexicalAnalyzer.getInstance(), JSON_SYN_SyntacticAnalyzer.getInstance());
    }
    
    public Object parse(String json) {
    	IMUT_ImmutableList tokenList = this.lexicalAnalyzer.findTokens(json);
    	return this.syntacticAnalyzer.findValue(tokenList);
    }
}