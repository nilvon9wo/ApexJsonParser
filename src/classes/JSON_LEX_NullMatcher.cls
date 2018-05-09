public class JSON_LEX_NullMatcher implements JSON_LEX_MatchIntf { 
	
	private static final String NULL_STRING = 'NULL';
	private static final Integer NULL_STRING_LENGTH = NULL_STRING.length(); 
	private static final JSON_LEX_ParseResult NO_MATCH = null; 
	
	public JSON_LEX_ParseResult matchFor(String inputString) {
		String remainder = inputString.trim();
		JSON_LEX_ParseResult parseResult = this.findMatchFor(remainder); 
		
		return (parseResult != null)
			? parseResult
			: new JSON_LEX_ParseResult(remainder);
	}
	
	@testVisible
	private JSON_LEX_ParseResult findMatchFor(String remainder){
		if (remainder.length() >= NULL_STRING_LENGTH) {
			String start = remainder.substring(0, NULL_STRING_LENGTH).toUpperCase();
			if (NULL_STRING.equals(start)) {
				return new JSON_LEX_ParseResult(
					new List<Object>{null}, 
					remainder.substring(NULL_STRING_LENGTH, remainder.length())
				);
			}
		}
		
		return NO_MATCH;
	}
}