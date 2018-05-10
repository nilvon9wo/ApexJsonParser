public class MAP_StringSObjectItererableCollection extends MAP_KeyValueItererableCollectionAbs {
	Map<String, SObject> mapValues;
	List<String> keyList;
	
	public MAP_StringSObjectItererableCollection(Map<String, SObject> sObjectByStringMap) {
		this.mapValues = sObjectByStringMap;
	}   

	public MAP_StringSObjectItererableCollection(MAP_StringSObjectItererableCollection copiedMap) {
		this.mapValues = copiedMap.mapValues;
		this.keyList = new List<String>(this.mapValues.keySet());
	}   

	// Iterable<MAP_KeyValue> --------------------------------------
	
	public Boolean hasNext() {
		return !keyList.isEmpty();
	}
	
	public MAP_KeyValue next() {
		String key = keyList.remove(0);
		return new MAP_KeyValue(key, this.mapValues.get(key));
	}

	// Iterator<MAP_KeyValue> --------------------------------------
	
	public Iterator<MAP_KeyValue> iterator() { 
		return new MAP_StringSObjectItererableCollection(this);
	}
	
	// MAP_KeyValueMapIntf --------------------------------------
	
    public Set<Object> getKeys() {
    	return new Set<Object>((List<Object>) new List<String>(this.mapValues.keySet())); 
    }
    
    public List<Object> getValues() {
    	return this.mapValues.values();
    }
    
    public Object getKey(Object key) {
    	return this.mapValues.get((String) key); 
    }
     
    public Object setKey(Object key, Object value) {
    	return this.mapValues.put((String) key, (SObject) value);
    }
	
}