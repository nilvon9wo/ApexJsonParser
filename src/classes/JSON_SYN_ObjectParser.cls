public class JSON_SYN_ObjectParser implements JSON_SYN_ParserIntf {
	JSON_SYN_PrimativeParser primativeParser;
	JSON_SYN_StringParser stringParser;
	JSON_SYN_SyntacticAnalyzer syntacticAnalyzer; 
	
	public JSON_SYN_ObjectParser(
			JSON_SYN_PrimativeParser primativeParser, 
			JSON_SYN_StringParser stringParser,
			JSON_SYN_SyntacticAnalyzer syntacticAnalyzer
		) {
		this.primativeParser = primativeParser;
		this.stringParser = stringParser;
		this.syntacticAnalyzer = syntacticAnalyzer;
	}

	public JSON_SYN_ObjectParser() { 
		this(new JSON_SYN_PrimativeParser(), new JSON_SYN_StringParser(), new JSON_SYN_SyntacticAnalyzer());
	}
	
    public JSON_SYN_ParseResultObject parse(IMUT_ImmutableList tokenList) {
		return (this.isBraced(tokenList))
			? this.findMatchFor(tokenList.remove(0))
			: new JSON_SYN_ParseResultObject(tokenList);
    }

	private static final String UNEXPECTED_END_OF_TOKEN_LIST = 'Expected end-of-object brace.';

	@testVisible
	private Boolean isBraced (IMUT_ImmutableList tokenList){ 
		String token;
		try {
			token = (String) tokenList.get(0);
		}
		catch (TypeException ex){
			return false;
		} 
		
		return JSON_Characters.LEFTBRACE.equals(token);
	}
	  
	@testVisible  
	private JSON_SYN_ParseResultObject findMatchFor(IMUT_ImmutableList tokenList) {
		JSON_SYN_ParseResultPrimative firstResult = primativeParser.parse(tokenList);
		IMUT_ImmutableList remainingList = firstResult.getRemainder();
		if (this.isObjectFinished(firstResult)) {
			return new JSON_SYN_ParseResultObject(remainingList);   
		}
		
 		JSON_SYN_ParseResultObject accumulatedResultObject = new JSON_SYN_ParseResultObject(remainingList);  
		while(!accumulatedResultObject.getRemainder().isEmpty()) {
			accumulatedResultObject = this.parse(accumulatedResultObject); 
			if (accumulatedResultObject.isFinished()) {
				return accumulatedResultObject;
			}
		}
		
		throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST);
	} 
	
	@testVisible
	private JSON_SYN_ParseResultObject parse(JSON_SYN_ParseResultObject accumulatedResultObject) {
		JSON_SYN_ParseResultString keyResult = stringParser.parse(accumulatedResultObject.getRemainder());

		JSON_SYN_ParseResultIntf valueResult = findValue(keyResult);
		IMUT_ImmutableMap valueMap = accumulatedResultObject.getValue().put(keyResult.getValue(), valueResult.getValue());
		IMUT_ImmutableList postValueList = valueResult.getRemainder();
		
		if (!postValueList.isEmpty()) {
			JSON_SYN_ParseResultPrimative syntaxResult = primativeParser.parse(postValueList);
			IMUT_ImmutableList postSyntaxList = syntaxResult.getRemainder();
			
			if (this.isObjectFinished(syntaxResult)) {
				return new JSON_SYN_ParseResultObject(valueMap, postSyntaxList, JSON_SYN_ParseResultObject.IS_FINISHED);
			}
			else if (!JSON_Characters.COMMA.equals(syntaxResult.getValue())) {
				throw new JSON_SYN_ParserException ('Expected comma after pair in object; found: ' + syntaxResult.getValue());
			}
			return new JSON_SYN_ParseResultObject(valueMap, postSyntaxList, JSON_SYN_ParseResultObject.NOT_FINISHED);
		}
		
		throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST); 
	}
	
	@testVisible JSON_SYN_ParseResultIntf findValue(JSON_SYN_ParseResultString keyResult) {
		IMUT_ImmutableList postKeyList = keyResult.getRemainder();
		
		if (postKeyList.isEmpty()) {
			throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST);
		}
		
		JSON_SYN_ParseResultPrimative separatorResult = primativeParser.parse(postKeyList);
		IMUT_ImmutableList postSeparatorList = separatorResult.getRemainder();
		if (JSON_Characters.COLON.equals(separatorResult.getValue())) {
			throw new JSON_SYN_ParserException ('Expected colon after key in object, got: ' + separatorResult.getValue());
		}
		
		if (postSeparatorList.isEmpty()) {
			throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST);
		}
		
		return syntacticAnalyzer.parse(postSeparatorList);
	}
	
	
	@testVisible
	private Boolean isObjectFinished(JSON_SYN_ParseResultPrimative syntaxResult) {
		return JSON_Characters.RIGHTBRACE.equals(syntaxResult.getValue());
	}
}