public class JSON_LEX_BooleanParser implements JSON_LEX_ParserIntf {
	// Singleton
	@testVisible private static JSON_LEX_BooleanParser instance;
	public static JSON_LEX_BooleanParser getInstance() {
		if (instance == null) {
			instance = new JSON_LEX_BooleanParser();		
		}
		return instance;
	}
	
	// --------------------------------------------------------------------------------	 
	
	private static final String TRUE_STRING = 'TRUE';
	private static final String FALSE_STRING = 'FALSE'; 
	private static final JSON_LEX_ParseResult NO_MATCH = null; 
	 
	private static final Map<String, Integer> LENGTH_BY_STRING_MAP = new Map<String, Integer> {
		TRUE_STRING => TRUE_STRING.length(),
		FALSE_STRING => FALSE_STRING.length()
	};

	private static final Map<String, Boolean> BOOLEAN_BY_STRING_MAP = new Map<String, Boolean> {
		TRUE_STRING => true,
		FALSE_STRING => false
	};
	
	public JSON_LEX_ParseResult parse(String inputString) {
		String remainder = inputString.trim();
		JSON_LEX_ParseResult parseResult = this.findMatchFor(remainder);
		
		return (parseResult != null)
			? parseResult
			: new JSON_LEX_ParseResult(remainder);
	}
	
	@testVisible
	private JSON_LEX_ParseResult findMatchFor(String remainder){
		for (String value : LENGTH_BY_STRING_MAP.keySet()) {
			JSON_LEX_ParseResult parseResult = this.findMatchFor(remainder, value);
			if (parseResult != null) {
				return parseResult;
			}
		}
		
		return NO_MATCH; 
	}
	
	@testVisible
	private JSON_LEX_ParseResult findMatchFor(String remainder, String value){
		Integer booleanLength = LENGTH_BY_STRING_MAP.get(value);
		
		if (remainder.length() >= booleanLength) {
			String start = remainder.substring(0, booleanLength).toUpperCase();
			if (value.equals(start)) {
				return new JSON_LEX_ParseResult(
					BOOLEAN_BY_STRING_MAP.get(value), 
					remainder.substring(booleanLength, remainder.length())
				);
			}
		}
		
		return NO_MATCH;
	}
}