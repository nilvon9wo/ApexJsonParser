@isTest
public class TEST_DummyUserFactory { 
    public static final String PREFIX = User.SObjectType.getDescribe().getKeyPrefix();
    public static final Id EXAMPLE_ID = PREFIX + '3E000003NYTS';
	
	private static final String SYSTEM_ADMIN = 'System Administrator';
	private static final Map<String, Id> PROFILE_ID_BY_PROFILE_NAME_MAP = createProfileIdByProfileNameMap(); 
	private static final Id SYSTEM_ADMIN_ID = PROFILE_ID_BY_PROFILE_NAME_MAP.get(SYSTEM_ADMIN);

	private static final String CEO = 'CEO';
	private static final Map<String, Id> USERROLE_ID_BY_USERROLE_NAME_MAP = createUserRoleIdByUserRoleNameMap(); 
	private static final Id CEO_USERROLE_ID = USERROLE_ID_BY_USERROLE_NAME_MAP.get(CEO);
	
	public static final User DEFAULT_USER = create(TEST_InsertModeEnum.INSERT_NOW);
	
	public static final String DEFAULT_FIRST_NAME_PREFIX = 'User First Name ';
	public static final String DEFAULT_LAST_NAME_PREFIX = 'User Last Name ';

    public static List<User> createList(
    		List<User> templateUserList,  
    		TEST_InsertModeEnum insertMode
    	) {
    	Integer quantity = templateUserList.size();
        List<User> userList = new List<User>();
        Integer i = 0;
        for (User templateUser : templateUserList) { 
    		String randomCharacter = getRandomCharacter(); 
    		Integer randomNumber = getRandomNumber(999);
    		String randomValue = randomCharacter + randomNumber;
        	
			String defaultEmail = (String) TEST_DefaultHelper.valueOrDefault(templateUser.email, 'test.user.' + randomValue + '@example.com');
            userList.add(new User(
            	FirstName = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LastName, DEFAULT_FIRST_NAME_PREFIX + ' ' + i),
            	LastName = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LastName, DEFAULT_LAST_NAME_PREFIX + ' ' + i),
            	
            	FederationIdentifier = (String) TEST_DefaultHelper.valueOrDefault(templateUser.FederationIdentifier, defaultEmail),
            	
            	Email = defaultEmail,
            	Username = (String) TEST_DefaultHelper.valueOrDefault(templateUser.Username, defaultEmail),
            	Alias = (String) TEST_DefaultHelper.valueOrDefault(templateUser.Alias, 'testu' + i),
            	
            	ProfileId = (String) TEST_DefaultHelper.valueOrDefault(templateUser.ProfileId, SYSTEM_ADMIN_ID),

            	EmailEncodingKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.EmailEncodingKey, 'ISO-8859-1'),
            	LanguageLocaleKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LanguageLocaleKey, 'en_US'),
            	LocaleSidKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LocaleSidKey, 'en_GB'),
            	TimeZoneSidKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.TimeZoneSidKey, 'GMT')
            ));
            i++; 
        }

        if (insertMode == TEST_InsertModeEnum.INSERT_NOW) {
            insert userList;
        } else if (insertMode == TEST_InsertModeEnum.MOCK_INSERT) {
            TEST_MockInsertHelper.addIds(userList);  
        }
        
        return userList;
    }    

    public static List<User> createList(
    		Integer quantity,  
    		TEST_InsertModeEnum insertMode
    	) {
    	List<User> templateUserList = new List<User>();
        for (Integer i = 1; i <= quantity; i++) {
            templateUserList.add(new User());
        }
		return createList(templateUserList, insertMode);
    }    

    public static List<User> createList(Integer quantity){
    	return createList(quantity, TEST_InsertModeEnum.NEVER_INSERT);
    }

    public static User create(TEST_InsertModeEnum insertMode) {
    	Integer quantity = 1;
    	return createList(quantity, insertMode)[0];
    }

    public static User create() {
    	return create(TEST_InsertModeEnum.NEVER_INSERT);
    }
    
	// Helpers ----------------------------------------------------------------------------------------------
	
	private static Map<String, Id> createProfileIdByProfileNameMap() {
		Set<String> profileNameSet = new Set<String>{SYSTEM_ADMIN};
		List<Profile> profileList = [
			SELECT id, name
			FROM Profile
			WHERE name IN :profileNameSet
		]; 
		
		Map<String, Id> profileIdByProfileNameMap = new Map<String, Id>();
		for (Profile profile : profileList) {
			profileIdByProfileNameMap.put(profile.name, profile.id);
		}
		return profileIdByProfileNameMap;
	}

	private static Map<String, Id> createUserRoleIdByUserRoleNameMap() {
		Set<String> userroleNameSet = new Set<String>{CEO};
		List<UserRole> userRoleList = [
			SELECT id, name
			FROM UserRole
			WHERE name IN :userroleNameSet
		]; 
		
		Map<String, Id> userRoleIdByUserRoleNameMap = new Map<String, Id>();
		for (UserRole userRole : userRoleList) { 
			userRoleIdByUserRoleNameMap.put(userRole.name, userRole.id);
		}
		return userRoleIdByUserRoleNameMap;
	}

	// Randomizer -----------------------------------------------------------------------------------------------------
	    
    // @see: // @see: http://www.codebycody.com/2012/02/sfdc-randomizer.html
	private static final String CHARACTERS = 'abcdefghijklmnopqrstuvwxyz0123456789';

    public static Integer getRandomNumber(Integer maxValue) {
    	Integer size = maxValue + 1;
    	Double randomDouble = Math.random() * size;
    	return randomDouble.intValue();
    }    

    public static String getRandomCharacter() {
		Integer random = getRandomNumber(CHARACTERS.length() - 1);
		return CHARACTERS.substring(random, random + 1);
    }	
}