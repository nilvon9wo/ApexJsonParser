public abstract class OPT_Option implements Iterable<Object> {
 
	protected OPT_Option() {} 

    public abstract Object get(); 
    public abstract Object getOrElse(Object orElse);
    public abstract OPT_Option orElse(Object orElse);

    public abstract Boolean isDefined(); 
    public Boolean isEmpty() { return !isDefined(); }
    public abstract Boolean exists(FUNC_ObjectToBooleanIntf trueExpression);
    public abstract OPT_Option filter(FUNC_ObjectToBooleanIntf trueExpression);

    public abstract List<Object> toList();
    public Iterator<Object> iterator() { 
    	return toList().iterator();  
    }   

    public abstract void foreach(FUNC_ObjectToVoidIntf unitExpression);

    public abstract OPT_Option nestedMap(FUNC_ObjectToOptionIntf mapExpression);
    public abstract OPT_Option flatMap(FUNC_ObjectToOptionIntf flatMapExpression);
 
    public static OPT_Option some(Object value) { 
    	return new OPT_Some(value); 
    }  
    public static OPT_Option none() {  
    	return new OPT_None(); 
    }

    public static OPT_Option option(Object value) { 
    	return value == null 
    		? OPT_Option.none() 
    		: OPT_Option.some(value); 
    }
}