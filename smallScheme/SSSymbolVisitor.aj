package smallScheme;

public aspect SSSymbolVisitor extends SSValueVisitor {
	protected String label;
	
	public SSSymbolVisitor() {
		super();
		req = "symbol";
	}
	
	public String getValue(SSData d) {
		d.visit(this);
		String t = label;
		label = null;
		return t;
	}
	
	public void visitSymbol(String label) {
		this.label = label;
	}
	
}
