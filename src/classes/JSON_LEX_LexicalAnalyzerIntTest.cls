@isTest
public class JSON_LEX_LexicalAnalyzerIntTest {
	private static final User TEST_USER = TEST_DummyUserFactory.DEFAULT_USER;
	private static final JSON_LEX_LexicalAnalyzer ANALYZER_UNDER_TEST = new JSON_LEX_LexicalAnalyzer();
	
    @isTest public static void findTokensShouldReturnExpectedListOfTokens() {
    	// Arrange
    	String testInput = '{"foo": [1, 2, {"bar": 2}]}';
    	
    	// Act
    	IMUT_ImmutableList resultList;
    	Test.startTest();
    	System.runAs(TEST_USER) {
    		resultList = ANALYZER_UNDER_TEST.findTokens(testInput);
    	}
    	Test.stopTest();	
    	
    	// Assert
    	List<Object> expectedTokenList = new List<Object>{
    		'{', 'foo', ':', '[', 1, ',', 2, ',', '{', 'bar', ':', 2, '}', ']', '}'
    	}; 
    	
    	for (Integer i = 0; i < resultList.size(); i++) {
	    	System.assertEquals(expectedTokenList.get(i), resultList.get(i));
    	}
    	
    	System.assertEquals(expectedTokenList.size(), resultList.size());
    }
} 