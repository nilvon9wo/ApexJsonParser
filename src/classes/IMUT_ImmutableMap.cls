public class IMUT_ImmutableMap {
    private Map<Object, Object> seedMap;
    
    public IMUT_ImmutableMap(Map<Object, Object> seedMap) {
    	this.seedMap = seedMap;
    }

    public IMUT_ImmutableMap(Map<String, SObject> seedMap) {
    	this.seedMap = this.convert(seedMap);
    }
    
    @testVisible
    private Map<Object, Object> convert(Map<String, SObject> seedMap) {
    	Map<Object, Object> objectMap = new Map<Object, Object>();
		for (String key : seedMap.keySet()) {
			objectMap.put(key, seedMap.get(key));
		}
    	return objectMap;
    }

    public IMUT_ImmutableMap perfectClone() {
    	return new IMUT_ImmutableMap(this.rawClone());
    }
    
	public Boolean isSObjectMap() {
		return this.seedMap.values() instanceof List<SObject>;
	}    
    
    private Map<Object, Object> rawClone() { 
    	return (this.isSObjectMap())
    			? ((Map<Object, SObject>) this.seedMap).deepClone()
    			: this.seedMap.clone();
    }

    public IMUT_ImmutableMap deepClone() {
    	Map<Object, Object> cloneMap;
		try {
			cloneMap = ((Map<Object, SObject>) this.seedMap).deepClone();
		}
		catch (System.TypeException ex) { 
			throw new IMUT_ImmutableMapException('deepClone() is only supported for SObject record values', ex); 
		}
    	return new IMUT_ImmutableMap(cloneMap);
    }

    public IMUT_ImmutableMap clear() {
    	Map<Object, Object> cloneMap = this.rawClone();
    	cloneMap.clear();
    	return new IMUT_ImmutableMap(cloneMap);
    }

    public Boolean containsKey(Object key) {
    	return this.seedMap.containsKey(key);
    }

    public Boolean equals(Map<Object, Object> thatMap) {
    	return this.seedMap.equals(thatMap);
    }

    public Object get(Object key) {
    	Map<Object, Object> cloneMap = this.rawClone();
    	return cloneMap.get(key);
    }

    public SObjectType getSObjectType() {
		try {
			return ((Map<Object, SObject>) this.seedMap).getSObjectType();
		}
		catch (System.TypeException ex) {
			throw new IMUT_ImmutableListException('getSObjectType() is only supported for SObject record values', ex);  
		}
    }

    public Integer getSeedMapHashCode() {
    	return this.seedMap.hashCode();
    }

    public Boolean isEmpty() {
    	return this.seedMap.isEmpty();
    }

    public Set<Object> keySet(Object key) {
    	Map<Object, Object> cloneMap = this.rawClone();
    	return cloneMap.keySet();
    }

    public IMUT_ImmutableMap put(Object key, Object value) {
    	Map<Object, Object> cloneMap = this.rawClone();
    	cloneMap.put(key, value);
    	return new IMUT_ImmutableMap(cloneMap);
    } 

    public IMUT_ImmutableMap put(Map<Object, Object> objectMap) {
    	Map<Object, Object> cloneMap = this.rawClone();
    	cloneMap.putAll(objectMap);
    	return new IMUT_ImmutableMap(cloneMap);
    } 

    public IMUT_ImmutableMap putAll(IMUT_ImmutableMap immutableMap) {
    	Map<Object, Object> cloneMap = this.rawClone();
    	cloneMap.putAll(immutableMap.toMap());
    	return new IMUT_ImmutableMap(cloneMap);
    }

    public IMUT_ImmutableMap putAll(List<SObject> sObjectList) {
		Map<String, SObject> sObjectByStringMap = new Map<String, SObject>(sObjectList);
    	Map<String, SObject> convertedSObjectMap = this.createSObjectByStringMap();
    	
		try {
			convertedSObjectMap.putAll(sObjectByStringMap);
		}
		catch (System.TypeException ex) {
			throw new IMUT_ImmutableListException('getSObjectType() is only supported for SObject record values', ex);  
		}
    	return new IMUT_ImmutableMap(convertedSObjectMap); 
    }

	@testVisible
	private Map<String, SObject> createSObjectByStringMap() {
    	Map<Object, Object> cloneMap = this.rawClone();
		Map<String, SObject> sObjectByStringMap = new Map<String, SObject>(); 
		for (Object key : cloneMap.keySet()) {
			try {
				sObjectByStringMap.put((String) key, (SObject) cloneMap.get(key));
			}
			catch (System.TypeException ex) {
				throw new IMUT_ImmutableListException('putAll(List<SObject> sObjectList) is only supported for String, SObject mapping', ex);  
			}
		}
		return sObjectByStringMap;
	}

    public IMUT_ImmutableMap remove(Object value) {
    	Map<Object, Object> cloneMap = this.rawClone();
    	cloneMap.remove(value);
    	return new IMUT_ImmutableMap(cloneMap);
    } 

    public Integer size() {
    	return this.seedMap.size();
    } 

    public List<Object> values() {
    	Map<Object, Object> cloneMap = this.rawClone();
    	return this.seedMap.values();
    } 

    public IMUT_ImmutableList immutableValues() {
    	Map<Object, Object> cloneMap = this.rawClone();
    	return new IMUT_ImmutableList(this.seedMap.values());
    } 
    
    public Map<Object, Object> toMap() {
    	return this.rawClone();
    }

}