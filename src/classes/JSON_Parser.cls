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
    	this(new JSON_LEX_LexicalAnalyzer(), new JSON_SYN_SyntacticAnalyzer());
    }
    
    public OPT_Option parse(String json) {
    	IMUT_ImmutableList tokenList = this.lexicalAnalyzer.findTokens(json);
    	return this.syntacticAnalyzer.findValue(tokenList);
    }
}