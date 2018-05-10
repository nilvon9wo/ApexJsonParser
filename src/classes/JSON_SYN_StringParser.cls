public class JSON_SYN_StringParser implements JSON_SYN_ParserIntf {
    public JSON_SYN_ParseResultString parse(IMUT_ImmutableList tokenList) {
    	IMUT_ImmutableList.ShiftResult shiftResult = tokenList.shift(); 
    	Object value = shiftResult.getValue();
    	if (!(value instanceof String)) {
    		throw new JSON_SYN_ParserException('Expected String, got: ' + value);
    	}
    	return new JSON_SYN_ParseResultString((String) value, (IMUT_ImmutableList) shiftResult.getRemainder());
    }   
}