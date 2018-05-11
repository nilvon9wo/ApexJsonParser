public class JSON_LEX_SyntaxParser implements JSON_LEX_ParserIntf {
	// Singleton
	@testVisible private static JSON_LEX_SyntaxParser instance;
	public static JSON_LEX_SyntaxParser getInstance() {
		if (instance == null) {
			instance = new JSON_LEX_SyntaxParser();		
		}
		return instance;
	}
	
	// --------------------------------------------------------------------------------	 

	public JSON_LEX_ParseResult parse(String inputString) {
		String nextCharacter = inputString.substring(0, 1);
		return (JSON_Characters.SYNTAX_SET.contains(nextCharacter)) 
			? new JSON_LEX_ParseResult(nextCharacter, inputString.substring(1, inputString.length()).trim())
			: new JSON_LEX_ParseResult(inputString);
	} 
}