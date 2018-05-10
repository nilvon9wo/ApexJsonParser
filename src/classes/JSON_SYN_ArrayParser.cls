public class JSON_SYN_ArrayParser implements JSON_SYN_ParserIntf {
	JSON_SYN_PrimativeParser primativeParser;
	JSON_SYN_SyntacticAnalyzer syntacticAnalyzer; 
	
	public JSON_SYN_ArrayParser(JSON_SYN_PrimativeParser primativeParser, JSON_SYN_SyntacticAnalyzer syntacticAnalyzer) {
		this.primativeParser = primativeParser;
		this.syntacticAnalyzer = syntacticAnalyzer;
	}

	public JSON_SYN_ArrayParser() { 
		this(new JSON_SYN_PrimativeParser(), new JSON_SYN_SyntacticAnalyzer());
	}
	
    public JSON_SYN_ParseResultArray parse(IMUT_ImmutableList tokenList) {
		return (this.isBracketed(tokenList))
			? this.findMatchFor(tokenList.remove(0))
			: new JSON_SYN_ParseResultArray(tokenList);
    }

	private static final String UNEXPECTED_END_OF_TOKEN_LIST = 'Expected end-of-array bracket.';
	  
	@testVisible
	private Boolean isBracketed (IMUT_ImmutableList tokenList){ 
		String token;
		try {
			token = (String) tokenList.get(0);
		}
		catch (TypeException ex){
			return false;
		} 
		
		return JSON_Characters.LEFTBRACKET.equals(token);
	}
	  
	@testVisible  
	private JSON_SYN_ParseResultArray findMatchFor(IMUT_ImmutableList tokenList) {
		JSON_SYN_ParseResultPrimative firstResult = primativeParser.parse(tokenList);
		IMUT_ImmutableList remainingList = firstResult.getRemainder();
		if (this.isArrayFinished(firstResult)) {
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
		if (!remainingList.isEmpty()) {
			JSON_SYN_ParseResultPrimative syntaxResult = primativeParser.parse(remainingList);
			IMUT_ImmutableList postSyntaxList = syntaxResult.getRemainder();
			
			if (this.isArrayFinished(syntaxResult)) {
				return new JSON_SYN_ParseResultArray(valueList, postSyntaxList, JSON_SYN_ParseResultArray.IS_FINISHED);
			}
			else if (!JSON_Characters.COMMA.equals(syntaxResult.getValue())) {
				throw new JSON_SYN_ParserException ('Expected comma after object in array; found: ' + syntaxResult.getValue());
			}
			return new JSON_SYN_ParseResultArray(valueList, postSyntaxList, JSON_SYN_ParseResultArray.NOT_FINISHED);
		}
		
		throw new JSON_SYN_ParserException (UNEXPECTED_END_OF_TOKEN_LIST); 
	}

	
	@testVisible
	private Boolean isArrayFinished(JSON_SYN_ParseResultPrimative syntaxResult) {
		return JSON_Characters.RIGHTBRACKET.equals(syntaxResult.getValue());
	}
}