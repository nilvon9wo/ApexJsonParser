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
	
	private static final List<User> STANDARD_TEST_USER_LIST = createStandardTestUserList();
	public static final User DEFAULT_USER = STANDARD_TEST_USER_LIST[0];
	
	private static List<User> createStandardTestUserList() {
		// NOTE: For efficency, order is important here!
		List<User> templateUserList = new List<User> {
			new User()
			// We can NOT include integration user, nor any user with a UserRole here
			// because of conflicts with ACN_AutomationSettingTestDummyFactory.createForStandardIntegrationTest();  :-(
			
			// TODO: Create Standard Contact User
		}; 
		return createBundle(templateUserList, TEST_InsertModeEnum.INSERT_NOW, TEST_InsertRelationshipsEnum.INCLUDE).userList;
	}

	public static final String DEFAULT_FIRST_NAME_PREFIX = 'User First Name ';
	public static final String DEFAULT_LAST_NAME_PREFIX = 'User Last Name ';
	public static final String DEFAULT_SCOPE = 'Scope_01';

    public static Bundle createBundle(
    		List<User> templateUserList,  
    		TEST_InsertModeEnum insertMode,
    		TEST_InsertRelationshipsEnum insertOptionalRelationships
    	) {
    	Integer quantity = templateUserList.size();
		Bundle bundle = new Bundle(quantity, insertMode, insertOptionalRelationships);
    		
        bundle.userList = new List<User>();
        Integer i = 0;
        for (User templateUser : templateUserList) { 
    		String randomCharacter = getRandomCharacter(); 
    		Integer randomNumber = getRandomNumber(999);
    		String randomValue = randomCharacter + randomNumber;
        	
			String defaultEmail = (String) TEST_DefaultHelper.valueOrDefault(templateUser.email, 'test.user.' + randomValue + '@example.com');
            bundle.userList.add(new User(
            	FirstName = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LastName, DEFAULT_FIRST_NAME_PREFIX + ' ' + i),
            	LastName = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LastName, DEFAULT_LAST_NAME_PREFIX + ' ' + i),
            	
            	FederationIdentifier = (String) TEST_DefaultHelper.valueOrDefault(templateUser.FederationIdentifier, defaultEmail),
            	
            	Email = defaultEmail,
            	Username = (String) TEST_DefaultHelper.valueOrDefault(templateUser.Username, defaultEmail),
            	Alias = (String) TEST_DefaultHelper.valueOrDefault(templateUser.Alias, 'testu' + i),
            	
            	ProfileId = (String) TEST_DefaultHelper.valueOrDefault(templateUser.ProfileId, SYSTEM_ADMIN_ID),
            	
            	// Creating UserRoleId causes conflicts with ACN_AutomationSettingTestDummyFactory.createForStandardIntegrationTest();
            	// If UserRoleId is needed, update users in tests BEFORE creating automation settings.  
            	
            	EmailEncodingKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.EmailEncodingKey, 'ISO-8859-1'),
            	LanguageLocaleKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LanguageLocaleKey, 'en_US'),
            	LocaleSidKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.LocaleSidKey, 'en_GB'),
            	TimeZoneSidKey = (String) TEST_DefaultHelper.valueOrDefault(templateUser.TimeZoneSidKey, 'GMT')

				// FIXME: Only Portal Users can be associated to a contact
            	// ContactId = (Id) TEST_DefaultHelper.valueOrDefault(templateUser.ContactId, null) 
            ));
            i++; 
        }

		bundle = createRelationships(bundle, insertOptionalRelationships);

        if (insertMode == TEST_InsertModeEnum.INSERT_NOW) {
            insert bundle.userList;
        } else if (insertMode == TEST_InsertModeEnum.MOCK_INSERT) {
            TEST_MockInsertHelper.addIds(bundle.userList);  
        }
        
        return bundle;
    }    

    public static Bundle createBundle(
    		Integer quantity,  
    		TEST_InsertModeEnum insertMode,
    		TEST_InsertRelationshipsEnum insertOptionalRelationships
    	) {
    	List<User> templateUserList = new List<User>();
        for (Integer i = 1; i <= quantity; i++) {
            templateUserList.add(new User());
        }
		return createBundle(templateUserList, insertMode, insertOptionalRelationships);
    }    

    public static Bundle createBundle(Integer quantity, TEST_InsertModeEnum insertMode) {
    	return createBundle(quantity, insertMode, TEST_InsertRelationshipsEnum.INCLUDE);
    }

    public static Bundle createBundle(Integer quantity) {
    	return createBundle(quantity, TEST_InsertModeEnum.MOCK_INSERT, TEST_InsertRelationshipsEnum.INCLUDE);
    }

    public static Bundle createBundle() {
    	Integer quantity = 1;
    	return createBundle(quantity, TEST_InsertModeEnum.MOCK_INSERT, TEST_InsertRelationshipsEnum.INCLUDE);
    }

	private static Bundle createRelationships(Bundle bundle, TEST_InsertRelationshipsEnum insertOptionalRelationships) {
		if (insertOptionalRelationships == TEST_InsertRelationshipsEnum.INCLUDE) {
			for (Integer i = 0; i < bundle.userList.size(); i++) {
				User user = bundle.userList[i];
				/* FIXME: Only Portal Users can be associated to a contact
				if (user.contactId == null && bundle.contactList != null && bundle.contactList[i] != null) {
					user.contactId = bundle.contactList[i].Id;
				}
				*/
			}
		}
		return bundle;
	}

    public static List<User> createList(
    		Integer quantity,  
    		TEST_InsertModeEnum insertMode
    	) {
    		return createBundle(quantity, insertMode, TEST_InsertRelationshipsEnum.EXCLUDE).userList;
    }    

    public static List<User> createList(Integer quantity){
    	return createList(quantity, TEST_InsertModeEnum.NEVER_INSERT);
    }

    public static List<User> createList(Integer quantity, List<Contact> contactList, TEST_InsertModeEnum insertMode){
    	Integer possibleContactValues = contactList.size();
    	
    	List<User> templateUserList = new List<User>();
    	for (Integer i = 0; i < quantity; i++) {
    		templateUserList.add(new User(
    			ContactId = contactList[Math.mod(i, possibleContactValues)].id
    		));
    	}
    	return createBundle(templateUserList, insertMode, TEST_InsertRelationshipsEnum.EXCLUDE).userList;
    }

    public static List<User> createList(Integer quantity, List<Contact> contactList){
    	return createList(quantity, contactList, TEST_InsertModeEnum.NEVER_INSERT);
    }
    
    public static User create(TEST_InsertModeEnum insertMode) {
    	Integer quantity = 1;
    	return createList(quantity, insertMode)[0];
    }

    public static User create() {
    	return create(TEST_InsertModeEnum.NEVER_INSERT);
    }
    
    public class Bundle {
		public Bundle(
			Integer quantity, 
			TEST_InsertModeEnum insertMode, 
			TEST_InsertRelationshipsEnum insertOptionalRelationships
		) {
			/* FIXME: Only Portal Users can be associated to a contact
			if (insertOptionalRelationships == TEST_InsertRelationshipsEnum.INCLUDE) {
				this.contactList = TEST_DummyContactFactory.createList(quantity, insertMode);
			}
			*/
		}
		
		public List<Contact> contactList;
		public List<User> userList;
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

	// WARNING: This will break many integration tests!!!!	
	public static User upgradeToIntegrationUser(User user) {
		user.UserRoleId = CEO_USERROLE_ID;
		update user;
		return user;
	}
	
	// Randomizer -----------------------------------------------------------------------------------------------------
	// This is INTENTIONAL duplicate code from UTIL_Randomizer in order for tests not to rely on code which it might be testing.
	    
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