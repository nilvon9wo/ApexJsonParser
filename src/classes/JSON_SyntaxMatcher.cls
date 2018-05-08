public class JSON_SyntaxMatcher implements JSON_MatchIntf {
	public JSON_ParseResult matchFor(String inputString) {
		String nextCharacter = inputString.substring(0, 1);
		if (JSON_Characters.SYNTAX_SET.contains(nextCharacter)) {
			return new JSON_ParseResult(nextCharacter, inputString.substring(1, inputString.length()).trim());
		}
		else {
			throw new JSON_MatchersException('Unexpected character: ' + nextCharacter);
		}
	}
}