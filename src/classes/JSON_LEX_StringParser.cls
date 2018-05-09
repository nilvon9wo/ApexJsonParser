public class JSON_LEX_StringParser implements JSON_LEX_ParserIntf {
	public JSON_LEX_ParseResult parse(String inputString) { 
		return (this.isQuoted(inputString))
			? this.findMatchFor(inputString)
			: new JSON_LEX_ParseResult(inputString);
	}
	  
	@testVisible
	private Boolean isQuoted (String inputString){
		return JSON_Characters.QUOTE.equals(inputString.subString(0,1));
	}
	
	@testVisible
	private JSON_LEX_ParseResult findMatchFor(String inputString) {
		String token = '';
		String remainder = inputString.substring(1, inputString.length());
		for (Integer i = 0; i < remainder.length(); i++) {
			String character = remainder.substring(i, i + 1);
			if (JSON_Characters.QUOTE.equals(character)) {
				return new JSON_LEX_ParseResult(token, remainder.substring(i + 1, remainder.length()));
			}
			else {
				token += character;
			}
		}
		
		throw new JSON_LEX_ParsersException('Expected end-of-string quote');
	}
}