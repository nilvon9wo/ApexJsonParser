public class JSON_NumberMatcher implements JSON_MatchIntf {
	public JSON_ParseResult matchFor(String inputString) {
		return (this.isNumber(inputString))
			? this.findMatchFor(inputString)
			: new JSON_ParseResult(inputString);
	}
	
	@testVisible
	private Boolean isNumber(String character){
		return JSON_Characters.NUMBER_CHARACTERS_SET.contains(character.subString(0,1));
	}
	
	@testVisible
	private JSON_ParseResult findMatchFor(String inputString) {
		String token = '';
		String remainder = inputString;
		for (Integer i = 0; i < remainder.length(); i++) {
			String character = remainder.substring(i, i + 1);
			if (isNumber(character)) {
				token += character;
			}
			else {
				break;
			}
		}

		Object value;
		try {
			value = (token.contains(JSON_Characters.PERIOD)) 
				? Decimal.valueOf(token)
				: Integer.valueOf(token);
		}
		catch (TypeException ex) {
			throw new JSON_MatchersException('Bad number: ' + token, ex);
		}
		
		return new JSON_ParseResult(value, remainder.substring(token.length(), remainder.length())); 
	}
}