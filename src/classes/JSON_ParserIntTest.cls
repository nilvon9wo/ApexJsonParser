@isTest
public class JSON_ParserIntTest {
	private static final User TEST_USER = TEST_DummyUserFactory.DEFAULT_USER;
	private static final JSON_Parser PARSER_UNDER_TEST = new JSON_Parser();
	
    @isTest public static void findTokensShouldReturnExpectedListOfTokens() {
    	// Arrange
    	String testInput = '{"foo": [1, 2, {"bar": 2}]}';
    	
    	// Act
    	IMUT_ImmutableMap resultMap;
    	Test.startTest();
    	System.runAs(TEST_USER) {
    		resultMap = PARSER_UNDER_TEST.parse(testInput);
    	}
    	Test.stopTest();	
    	
    	// Assert
    	Map<String, Object> expectedMap = new Map<String, Object>{
    		'foo' => new List<Object>{
	    				1, 
    					2, 
    					new Map<String, Object>{ 'bar' => 2}
		    		} 
    	};  
    	
    	for (String key : expectedMap.keySet()) {
	    	System.assertEquals(expectedMap.get(key), resultMap.get(key));
    	}

    	System.assertEquals(expectedMap.size(), resultMap.size());
    }
}