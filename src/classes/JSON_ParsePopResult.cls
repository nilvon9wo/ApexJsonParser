public class JSON_ParsePopResult {
	public OPT_Option nextCharacter;
	public JSON_ParseResult parseResult;
	
	public JSON_ParsePopResult(JSON_ParseResult parseResult) {
		if (parseResult.remainder.isDefined()) {
			String remainder = (String) parseResult.remainder.get(); 
			this.nextCharacter = OPT_Option.option(remainder.substring(0,1));
			this.parseResult = new JSON_ParseResult(
				parseResult.tokenList, 
				OPT_Option.option(remainder.substring(1, remainder.length()))
			);
		} 
	}
}

