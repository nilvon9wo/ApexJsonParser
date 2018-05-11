public class JSON_SYN_SyntaxEvaluator {
	// Singleton
	@testVisible private static JSON_SYN_SyntaxEvaluator instance;
	public static JSON_SYN_SyntaxEvaluator getInstance() {
		if (instance == null) {
			instance = new JSON_SYN_SyntaxEvaluator();		
		}
		return instance;
	} 
	
	// --------------------------------------------------------------------------------

	private static final Boolean TOKEN_OK = true;

	public Boolean isStarting(String openCharacter, IMUT_ImmutableList tokenList){ 
		String token;
		try {
			token = (String) tokenList.get(0);
		}
		catch (TypeException ex){
			return false;
		} 
		
		return openCharacter.equals(token);
	}
	  
	public Boolean checkPostObjectToken(Set<String> allowedPostValueCharacterSet, IMUT_ImmutableList.ShiftResult syntaxTokenResult) {
		String value;
		try {
			value = (String) syntaxTokenResult.getValue();
		}
		catch (TypeException ex) {
			this.throwPostObjectTokenErrorMessage(allowedPostValueCharacterSet, syntaxTokenResult.getValue(), ex);
		}
		
		if (!allowedPostValueCharacterSet.contains(value)) {
			this.throwPostObjectTokenErrorMessage(allowedPostValueCharacterSet, value, null);
		}
		return TOKEN_OK;		
	}
	
	@testVisible String throwPostObjectTokenErrorMessage(Set<String> allowedPostValueCharacterSet, Object value, Exception ex) {
		String errorMessage = 'Expected '
			+ String.join(new List<String>(allowedPostValueCharacterSet), ' or ')
			+ '; found: '
			+ value;
		throw new JSON_SYN_ParserException (errorMessage, ex);
	}
		

	public Boolean isFinished(String closeCharacter, IMUT_ImmutableList.ShiftResult syntaxTokenResult) {
		return closeCharacter.equals(syntaxTokenResult.getValue());
	}
    
}