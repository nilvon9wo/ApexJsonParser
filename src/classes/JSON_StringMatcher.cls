public class JSON_StringMatcher implements JSON_MatchIntf {
	public JSON_ParseResult matchFor(String inputString) {
		return (this.isQuoted(inputString))
			? this.findMatchFor(inputString)
			: new JSON_ParseResult(inputString);
	}
	
	@testVisible
	private Boolean isQuoted (String inputString){
		return JSON_Characters.QUOTE.equals(inputString.subString(0,1));
	}
	
	@testVisible
	private JSON_ParseResult findMatchFor(String inputString) {
		String token = '';
		String remainder = inputString.substring(1, inputString.length());
		for (Integer i = 0; i < remainder.length(); i++) {
			String character = remainder.substring(i, i + 1);
			if (JSON_Characters.QUOTE.equals(character)) {
				return new JSON_ParseResult(token, remainder.substring(i + 1, remainder.length()));
			}
			else {
				token += character;
			}
		}
		
		throw new JSON_MatchersException('Expected end-of-string quote');
	}
}