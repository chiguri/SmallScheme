package smallScheme;

public aspect SSConsVisitor extends SSValueVisitor {
	protected SSData car, cdr;

	public SSConsVisitor() {
		super();
		req = "pair";
	}
	
	public SSData getValueCar(SSData d) {
		d.visit(this);
		SSData t = car;
		car = null; cdr = null;
		return t;
	}
	public SSData getValueCdr(SSData d) {
		d.visit(this);
		SSData t = cdr;
		car = null; cdr = null;
		return t;
	}
	
	public void visitCons(SSData car, SSData cdr) {
		this.car = car;
		this.cdr = cdr;
	}
}
