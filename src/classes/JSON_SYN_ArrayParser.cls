public class JSON_SYN_ArrayParser implements JSON_SYN_ParserIntf {
	JSON_SYN_SyntacticAnalyzer syntacticAnalyzer;
	
	public JSON_SYN_ArrayParser(JSON_SYN_SyntacticAnalyzer syntacticAnalyzer) {
		this.syntacticAnalyzer = syntacticAnalyzer;
	}

	public JSON_SYN_ArrayParser() {
		this(new JSON_SYN_SyntacticAnalyzer());
	}
	
    public JSON_SYN_ParseValueResult parse(IMUT_ImmutableList tokenList) {
		return (this.isBracketed(tokenList))
			? this.findMatchFor(tokenList)
			: new JSON_SYN_ParseValueResult(tokenList);
	}
	  
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
	private JSON_SYN_ParseValueResult findMatchFor(IMUT_ImmutableList tokenList) {
		List<Object> objectList = new List<Object>();
 
		IMUT_ImmutableList.PopResult emptyCheckPopResult = tokenList.pop(); 
		if (isArrayFinished(emptyCheckPopResult)) {
			return new JSON_SYN_ParseValueResult(objectList, emptyCheckPopResult.reducedList); 
		}

		IMUT_ImmutableList remainingList = tokenList.remove(0);
		while(!remainingList.isEmpty()) {
			JSON_SYN_ParseValueResult result = parseArray(remainingList);
			objectList.add(result.value);
			remainingList = result.remainder;
		}
		
		throw new JSON_LEX_ParsersException ('Expected end-of-array bracket');
	}
	
	@testVisible
	private JSON_SYN_ParseValueResult parseArray(IMUT_ImmutableList remainingList) {
		List<Object> objectList = new List<Object>();
		JSON_SYN_ParseKeyedResult content = this.syntacticAnalyzer.parse(remainingList);
		objectList.add(content.valueMap);
		remainingList = content.remainder; 
		
		IMUT_ImmutableList.PopResult syntaxPopResult = remainingList.pop();
		if (isArrayFinished(syntaxPopResult)) {
			return new JSON_SYN_ParseValueResult(objectList, syntaxPopResult.reducedList); 
		}
		else if (!JSON_Characters.COMMA.equals(syntaxPopResult.topObject)) {
			throw new JSON_LEX_ParsersException ('Expected comma after object in array; found: ' + syntaxPopResult.topObject);
		}
		
		return new JSON_SYN_ParseValueResult(objectList, syntaxPopResult.reducedList);
	}
	
	@testVisible
	private Boolean isArrayFinished(IMUT_ImmutableList.PopResult popResult) {
		return JSON_Characters.RIGHTBRACKET.equals(popResult.topObject);
	}     
}