public class JSON_SYN_PrimativeParser implements JSON_SYN_ParserIntf {
	// Singleton
	@testVisible private static JSON_SYN_PrimativeParser instance;
	public static JSON_SYN_PrimativeParser getInstance() {
		if (instance == null) {
			instance = new JSON_SYN_PrimativeParser();		 
		}
		return instance;
	}
	
	// --------------------------------------------------------------------------------

    public JSON_SYN_ParseResultPrimative parse(IMUT_ImmutableList tokenList) {
    	IMUT_ImmutableList.ShiftResult shiftResult = tokenList.shift(); 
    	return new JSON_SYN_ParseResultPrimative(shiftResult.getValue(), (IMUT_ImmutableList) shiftResult.getRemainder());
    }   
}