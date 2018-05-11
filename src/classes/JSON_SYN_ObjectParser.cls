public class JSON_SYN_ObjectParser implements JSON_SYN_ParserIntf {
	// Singleton
	@testVisible private static JSON_SYN_ObjectParser instance;
	public static JSON_SYN_ObjectParser getInstance() {
		if (instance == null) {
			instance = new JSON_SYN_ObjectParser();		
		}
		return instance;
	} 
	
	// --------------------------------------------------------------------------------

	JSON_SYN_SyntacticAnalyzer syntacticAnalyzer; 
	JSON_SYN_SyntaxEvaluator syntacticEvaluator;
	
	@testVisible
	private JSON_SYN_ObjectParser(JSON_SYN_SyntacticAnalyzer syntacticAnalyzer, JSON_SYN_SyntaxEvaluator syntacticEvaluator) {
		this.syntacticAnalyzer = syntacticAnalyzer;
		this.syntacticEvaluator = syntacticEvaluator;
	}

	@testVisible
	private JSON_SYN_ObjectParser() { 
		this(JSON_SYN_SyntacticAnalyzer.getInstance(), JSON_SYN_SyntaxEvaluator.getInstance());
	}

	private static final String UNEXPECTED_END_OF_TOKEN_LIST = 'Expected end-of-object brace; Token list exhausted.';

    public JSON_SYN_ParseResultObject parse(IMUT_ImmutableList tokenList) {
		return (this.isBraced(tokenList))
			? this.findMatchFor(tokenList)
			: new JSON_SYN_ParseResultObject(tokenList);
    }

	@testVisible  
	private JSON_SYN_ParseResultObject findMatchFor(IMUT_ImmutableList tokenList) {
		IMUT_ImmutableList.ShiftResult firstTokenResult = tokenList.shift();
		IMUT_ImmutableList remainingList = (IMUT_ImmutableList) firstTokenResult.getRemainder();
		if (this.isObjectFinished(firstTokenResult)) {
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
		IMUT_ImmutableList.ShiftResult keyResult = this.findKey(accumulatedResultObject.getRemainder());
		JSON_SYN_ParseResultIntf valueResult = findValue(keyResult);

		IMUT_ImmutableMap valueMap = accumulatedResultObject.getIncompleteMap().put(keyResult.getValue(), valueResult.getValue());

		IMUT_ImmutableList postValueList = valueResult.getRemainder();
		return this.createResult(accumulatedResultObject, valueMap, postValueList);
	}
	
	@testVisible IMUT_ImmutableList.ShiftResult findKey(IMUT_ImmutableList tokenList){
    	IMUT_ImmutableList.ShiftResult shiftResult = tokenList.shift(); 
    	Object value = shiftResult.getValue();
    	if (!(value instanceof String)) {
    		throw new JSON_SYN_ParserException('Expected String key, got: ' + value);
    	}
		return shiftResult;
	} 
	
	@testVisible JSON_SYN_ParseResultIntf findValue(IMUT_ImmutableList.ShiftResult keyResult) {
		IMUT_ImmutableList postKeyList = (IMUT_ImmutableList) keyResult.getRemainder();
		
		if (postKeyList.isEmpty()) {
			throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST);
		}
		
		IMUT_ImmutableList.ShiftResult separatorResult = postKeyList.shift();
		if (!JSON_Characters.COLON.equals(separatorResult.getValue())) {
			throw new JSON_SYN_ParserException ('Expected colon after key in object, got: ' + separatorResult.getValue());
		}
		
		IMUT_ImmutableList postSeparatorList = (IMUT_ImmutableList) separatorResult.getRemainder();
		if (postSeparatorList.isEmpty()) {
			throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST);
		}
		
    	JSON_SYN_ParseResultIntf result = syntacticAnalyzer.parse(postSeparatorList); 
		return result;
	}

	@testVisible
	private JSON_SYN_ParseResultObject createResult(
			JSON_SYN_ParseResultObject accumulatedResultObject, 
			IMUT_ImmutableMap valueMap, 
			IMUT_ImmutableList postValueList
		) {
			IMUT_ImmutableList.ShiftResult syntaxTokenResult = postValueList.shift();
			this.checkPostObjectToken(syntaxTokenResult);
			
			IMUT_ImmutableList postSyntaxList = (IMUT_ImmutableList) syntaxTokenResult.getRemainder();
			return new JSON_SYN_ParseResultObject(valueMap, postSyntaxList, this.isObjectFinished(syntaxTokenResult));
	}	
	
	
	// Syntax checks --------------------------------------------------------------------

	@testVisible
	private Boolean isBraced (IMUT_ImmutableList tokenList){ 
		return this.syntacticEvaluator.isStarting(JSON_Characters.LEFTBRACE, tokenList);
	}
	  
	@testVisible
	private Boolean checkPostObjectToken(IMUT_ImmutableList.ShiftResult syntaxTokenResult) {
		Set<String> allowedPostObjectSet = new Set<String>{
			JSON_Characters.COMMA, JSON_Characters.RIGHTBRACE 
		};
		return this.syntacticEvaluator.checkPostObjectToken(allowedPostObjectSet, syntaxTokenResult); 
	}
	  
	@testVisible
	private Boolean isObjectFinished(IMUT_ImmutableList.ShiftResult syntaxTokenResult) {
		return this.syntacticEvaluator.isFinished(JSON_Characters.RIGHTBRACE, syntaxTokenResult);
	}
}