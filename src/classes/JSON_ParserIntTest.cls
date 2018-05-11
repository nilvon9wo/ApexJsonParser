@isTest
public class JSON_ParserIntTest {
	private static final User TEST_USER = TEST_DummyUserFactory.DEFAULT_USER;
	private static final JSON_Parser PARSER_UNDER_TEST = new JSON_Parser();
	
    @isTest public static void findTokensShouldReturnExpectedListOfTokens() {
    	// Arrange
    	String testInput = '{"foo": [1, 2, {"bar": 2}]}';
    	
    	// Act
    	Object result;
    	Test.startTest(); 
    	System.runAs(TEST_USER) {
    		result = PARSER_UNDER_TEST.parse(testInput); 
    	}
    	Test.stopTest();	
    	
    	// Assert
    	IMUT_ImmutableMap resultMap = (IMUT_ImmutableMap) result;
    	IMUT_ImmutableList resultList = (IMUT_ImmutableList) resultMap.get('foo');
    	System.assertEquals(1, (Decimal) ((OPT_Some)resultList.get(0)).get());
    	System.assertEquals(2, (Decimal) ((OPT_Some)resultList.get(1)).get());
    	
    	IMUT_ImmutableMap innerResultMap = (IMUT_ImmutableMap) resultList.get(2);
    	System.assertEquals(2, (Decimal) ((OPT_Some)innerResultMap.get('bar')).get());
   }
}