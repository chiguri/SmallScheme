package smallScheme;

public aspect SSIntegerVisitor extends SSValueVisitor {
	protected int i;
	
	public SSIntegerVisitor() {
		super();
		req = "number";
		i = 0;
	}
	
	public int getValue(SSData d) {
		d.visit(this);
		return i;
	}
	
	public void visitInteger(int i) {
		this.i = i;
	}
	
}
