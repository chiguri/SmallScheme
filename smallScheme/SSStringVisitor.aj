package smallScheme;

public aspect SSStringVisitor extends SSValueVisitor {
	protected String s;

	public SSStringVisitor() {
		super();
		req = "string";
	}
	
	String getValue(SSData d) {
		d.visit(this);
		String t = s;
		s = null;
		return t;
	}
	
	public void visitString(String str) {
		s = str;
	}
}
