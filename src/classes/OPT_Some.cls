public virtual class OPT_Some extends OPT_Option {  
	private final Object value; 
	 
	public OPT_Some(Object value) {  
	   	this.value = value; 
	}
	
	public override Object get() { return this.value; }
    public override Object getOrElse(Object orElse) { return this.get(); }
    public override OPT_Option orElse(Object orElse) { return this; }
    public override Boolean isDefined() { return true; }

    public override Boolean exists(FUNC_ObjectToBooleanIntf trueExpression) { 
    	return trueExpression.applyFor(this.value); 
    }

    public override OPT_Option filter(FUNC_ObjectToBooleanIntf trueExpression) { 
    	return !this.exists(trueExpression) 
        	? none() 
        	: this;   
    } 

    public override void foreach(FUNC_ObjectToVoidIntf unitExpression) {
	    unitExpression.applyFor(this.get());
    }

    public override OPT_Option nestedMap(FUNC_ObjectToOptionIntf mapExpression) {
       	return some(mapExpression.applyFor(this.get()));
    }

    public override OPT_Option flatMap(FUNC_ObjectToOptionIntf flatMapExpression) {
       	return flatMapExpression.applyFor(this.get());  
    }

    public override List<Object> toList() {
        return new List<Object>{
        	this.get()
        };
    }
 

    public override String toString() {
        return String.format('Some({0})', new List<String>{this.get().toString()});
    }
}