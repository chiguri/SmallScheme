package smallScheme;

public aspect SSFunctionVisitor extends SSValueVisitor {
	protected SSFunction f;
	
	public SSFunctionVisitor() {
		super();
		req = "#<function>";
	}
	
	public SSFunction getValue(SSData d) {
		d.visit(this);
		SSFunction t = f;
		f = null;
		return t;
	}
	
	public void visitFunction(SSFunction f) {
		this.f = f;
	}
}
