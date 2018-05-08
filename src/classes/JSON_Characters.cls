public class JSON_Characters {
    public static final String COMMA = ',';
	public static final String COLON = ':';
	public static final String LEFTBRACKET = '[';
	public static final String RIGHTBRACKET = ']';
	public static final String LEFTBRACE = '{';
	public static final String RIGHTBRACE = '}';
	public static final String PERIOD = '.';
	public static final String QUOTE = '"';

	public static final String SPACE = ' ';
	public static final String BACKSPACE = '\b';
	public static final String TAB = '\t';
	public static final String NEWLINE = '\n';
	public static final String CARRIAGE_RETURN = '\r';
	
	public static final Set<String> SYNTAX_SET = new Set<String>{
		COMMA, 
		COLON, 
		LEFTBRACKET, 
		RIGHTBRACKET,
        LEFTBRACE, 
        RIGHTBRACE
	}; 
	
	public static final Set<String> WHITESPACE_SET  = new Set<String>{
		SPACE,
		BACKSPACE,
		TAB,
		NEWLINE,
		CARRIAGE_RETURN
	}; 

	public static final Set<String> NUMBER_CHARACTERS_SET  = new Set<String>{
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'-', 'e', 'E', PERIOD
	}; 
}