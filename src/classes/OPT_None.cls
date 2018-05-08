public virtual class OPT_None extends OPT_Option {  
	public OPT_None() {}    
	
    public override Object get() { 
    	throw new OPT_UnsupportedOperationException('Cannot resolve value on None');
    }
 
    public override Object getOrElse(Object orElse) { return orElse; }
    public override OPT_Option orElse(Object orElse) { return some(orElse); }
    public override Boolean isDefined() { return false; }
    public override Boolean exists(FUNC_ObjectToBooleanIntf trueExpression) { return false; }
    public override OPT_Option filter(FUNC_ObjectToBooleanIntf trueExpression) { return this; }
    public override void foreach(FUNC_ObjectToVoidIntf unitExpression) { }

    public override OPT_Option nestedMap(FUNC_ObjectToOptionIntf mapExpression) { return none(); }
    public override OPT_Option flatMap(FUNC_ObjectToOptionIntf flatMapExpression) { return none(); }
	    
	public override List<Object> toList() { 
	   	return new List<Object>(); 
	}

	public override String toString() { return 'None'; }  
}   