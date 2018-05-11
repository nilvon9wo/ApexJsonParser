public class JSON_SYN_ArrayParser implements JSON_SYN_ParserIntf {
	// Singleton
	@testVisible private static JSON_SYN_ArrayParser instance;
	public static JSON_SYN_ArrayParser getInstance() {
		if (instance == null) {
			instance = new JSON_SYN_ArrayParser();		
		}
		return instance;
	} 
	
	// --------------------------------------------------------------------------------

	JSON_SYN_SyntacticAnalyzer syntacticAnalyzer; 
	JSON_SYN_SyntaxEvaluator syntacticEvaluator;
	
	@testVisible
	private JSON_SYN_ArrayParser(JSON_SYN_SyntacticAnalyzer syntacticAnalyzer, JSON_SYN_SyntaxEvaluator syntacticEvaluator) {
		this.syntacticAnalyzer = syntacticAnalyzer;
		this.syntacticEvaluator = syntacticEvaluator;
	}

	@testVisible
	private JSON_SYN_ArrayParser() { 
		this(JSON_SYN_SyntacticAnalyzer.getInstance(), JSON_SYN_SyntaxEvaluator.getInstance());
	}

	private static final String UNEXPECTED_END_OF_TOKEN_LIST = 'Expected end-of-array bracket; Token list exhausted.';
	
    public JSON_SYN_ParseResultArray parse(IMUT_ImmutableList tokenList) {
		return (this.isBracketed(tokenList))
			? this.findMatchFor(tokenList)
			: new JSON_SYN_ParseResultArray(tokenList);
    }
	  
	@testVisible  
	private JSON_SYN_ParseResultArray findMatchFor(IMUT_ImmutableList tokenList) {
		IMUT_ImmutableList.ShiftResult firstTokenResult = tokenList.shift();
		IMUT_ImmutableList remainingList = (IMUT_ImmutableList) firstTokenResult.getRemainder();
		if (this.isArrayFinished(firstTokenResult)) {
			return new JSON_SYN_ParseResultArray(remainingList);   
		}
  
 		JSON_SYN_ParseResultArray accumulatedResultArray = new JSON_SYN_ParseResultArray(remainingList);  
		while(!accumulatedResultArray.getRemainder().isEmpty()) {
			accumulatedResultArray = this.parse(accumulatedResultArray); 
			if (accumulatedResultArray.isFinished()) {
				return accumulatedResultArray;
			}
		}
		
		throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST);
	} 
	 

	@testVisible
	private JSON_SYN_ParseResultArray parse(JSON_SYN_ParseResultArray accumulatedResultArray) {
		JSON_SYN_ParseResultIntf valueResult = syntacticAnalyzer.parse(accumulatedResultArray.getRemainder());
		IMUT_ImmutableList valueList = accumulatedResultArray.getIncompleteList().add(valueResult.getValue());

		IMUT_ImmutableList remainingList = valueResult.getRemainder();
		return this.createResult(accumulatedResultArray, valueList, remainingList);
	}
	
	@testVisible
	private JSON_SYN_ParseResultArray createResult(
			JSON_SYN_ParseResultArray accumulatedResultArray, 
			IMUT_ImmutableList valueList, 
			IMUT_ImmutableList remainingList
		) {
		IMUT_ImmutableList.ShiftResult syntaxTokenResult = remainingList.shift();
		this.checkPostObjectToken(syntaxTokenResult);
		
		IMUT_ImmutableList postSyntaxList = (IMUT_ImmutableList) syntaxTokenResult.getRemainder();
		return new JSON_SYN_ParseResultArray(valueList, postSyntaxList, this.isArrayFinished(syntaxTokenResult));
	}

	// Syntax Checks --------------------------------------------------------------------------------

	@testVisible
	private Boolean isBracketed (IMUT_ImmutableList tokenList){ 
		return this.syntacticEvaluator.isStarting(JSON_Characters.LEFTBRACKET, tokenList);
	}
	  
	@testVisible
	private Boolean checkPostObjectToken(IMUT_ImmutableList.ShiftResult syntaxTokenResult) {
		Set<String> allowedPostObjectSet = new Set<String>{
			JSON_Characters.COMMA, JSON_Characters.RIGHTBRACKET 
		};
		return this.syntacticEvaluator.checkPostObjectToken(allowedPostObjectSet, syntaxTokenResult); 
	}

	@testVisible
	private Boolean isArrayFinished(IMUT_ImmutableList.ShiftResult syntaxTokenResult) {
		return this.syntacticEvaluator.isFinished(JSON_Characters.RIGHTBRACKET, syntaxTokenResult);
	}
}