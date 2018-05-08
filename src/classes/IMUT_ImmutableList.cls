public class IMUT_ImmutableList  implements Iterable<Object> {
    private List<Object> seedList;
    
    public IMUT_ImmutableList(List<Object> seedList) {
    	this.seedList = seedList;
    }
    
    public static final Boolean PRESERVE_ID = true;
    public static final Boolean PRESERVE_READONLY_TIMESTAMPS = true;
    public static final Boolean PRESERVE_AUTONUMBER = true;    
    
    public IMUT_ImmutableList perfectClone() {
    	return new IMUT_ImmutableList(this.rawClone());
    }
    
	public Boolean isSObjectList() {
		return this.seedList instanceof List<SObject>;
	}    
    
    private List<Object> rawClone() {
    	return (this.isSObjectList())
    			? ((List<SObject>) this.seedList).deepClone(PRESERVE_ID, PRESERVE_READONLY_TIMESTAMPS, PRESERVE_AUTONUMBER)
    			: this.seedList.clone();
    }

    public IMUT_ImmutableList deepClone(Boolean preserveId, Boolean preserveReadonlyTimestamps, Boolean preserveAutonumber) {
    	List<Object> cloneList;
		try {
			cloneList = ((List<SObject>) this.seedList).deepClone(preserveId, preserveReadonlyTimestamps, preserveAutonumber);
		}
		catch (System.TypeException ex) {
			throw new IMUT_ImmutableListException('deepClone() is only supported for List<SObject>', ex); 
		}
    	return new IMUT_ImmutableList(cloneList);
    }
    
    public IMUT_ImmutableList add(Object value) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.add(value);
    	return new IMUT_ImmutableList(cloneList);
    }
    
    public IMUT_ImmutableList add(Integer index, Object value) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.add(index, value);
    	return new IMUT_ImmutableList(cloneList);
    }

    public IMUT_ImmutableList addAll(IMUT_ImmutableList immutableList) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.addAll(immutableList.toList());
    	return new IMUT_ImmutableList(cloneList);
    }

    public IMUT_ImmutableList addAll(List<Object> valueList) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.addAll(valueList);
    	return new IMUT_ImmutableList(cloneList);
    }

    public IMUT_ImmutableList addAll(Set<Object> valueSet) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.addAll(valueSet);
    	return new IMUT_ImmutableList(cloneList);
    }
    
    public IMUT_ImmutableList clear() {
    	List<Object> cloneList = this.rawClone();
    	cloneList.clear();
    	return new IMUT_ImmutableList(cloneList);
    }

    public Boolean contains(Object value) {
    	return this.seedList.contains(value);
    }

    public Boolean equals(List<Object> valueList) {
    	return this.seedList.equals(valueList);
    }

    public Object get(Integer index) {
    	return this.rawClone().get(index);
    }

    public SObjectType getSObjectType() {
		try {
			return ((List<SObject>) this.seedList).getSObjectType();
		}
		catch (System.TypeException ex) {
			throw new IMUT_ImmutableListException('getSObjectType() is only supported for List<SObject>', ex); 
		}
    }

    public Integer getSeedListHashCode() {
    	return this.seedList.hashCode();
    }

    public Integer indexOf(Object value) {
    	return this.seedList.indexOf(value);
    }

    public Boolean isEmpty() {
    	return this.seedList.isEmpty();
    }

    public IMUT_ImmutableList remove(Integer index) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.remove(index);
    	return new IMUT_ImmutableList(cloneList);
    }

    public IMUT_ImmutableList set(Integer index, Object value) {
    	List<Object> cloneList = this.rawClone();
    	cloneList.set(index, value);
    	return new IMUT_ImmutableList(cloneList);
    }
    
    public Integer size() {
    	return this.seedList.size();
    }

    public IMUT_ImmutableList sort() {
    	List<Object> cloneList = this.rawClone();
    	cloneList.sort();
    	return new IMUT_ImmutableList(cloneList);
    }
    
    public List<Object> toList() {
    	return this.rawClone();
    }
    
    public Iterator<Object> iterator() { 
    	return toList().iterator();  
    }   
}