public class JSON_BooleanMatcher implements JSON_MatchIntf {
	
	private static final String TRUE_STRING = 'TRUE';
	private static final String FALSE_STRING = 'FALSE';
	private static final JSON_ParseResult NO_MATCH = null;
	
	private static final Map<String, Integer> LENGTH_BY_STRING_MAP = new Map<String, Integer> {
		TRUE_STRING => TRUE_STRING.length(),
		FALSE_STRING => FALSE_STRING.length()
	};

	private static final Map<String, Boolean> BOOLEAN_BY_STRING_MAP = new Map<String, Boolean> {
		TRUE_STRING => true,
		FALSE_STRING => false
	};
	
	public JSON_ParseResult matchFor(String inputString) {
		String remainder = inputString.trim();
		JSON_ParseResult parseResult = this.findMatchFor(remainder);
		
		return (parseResult != null)
			? parseResult
			: new JSON_ParseResult(remainder);
	}
	
	@testVisible
	private JSON_ParseResult findMatchFor(String remainder){
		for (String value : LENGTH_BY_STRING_MAP.keySet()) {
			JSON_ParseResult parseResult = this.findMatchFor(remainder, value);
			if (parseResult != null) {
				return parseResult;
			}
		}
		
		return NO_MATCH; 
	}
	
	@testVisible
	private JSON_ParseResult findMatchFor(String remainder, String value){
		Integer booleanLength = LENGTH_BY_STRING_MAP.get(value);
		
		if (remainder.length() >= booleanLength) {
			String start = remainder.substring(0, booleanLength).toUpperCase();
			if (value.equals(start)) {
				return new JSON_ParseResult(
					BOOLEAN_BY_STRING_MAP.get(value), 
					remainder.substring(booleanLength, remainder.length())
				);
			}
		}
		
		return NO_MATCH;
	}
}
