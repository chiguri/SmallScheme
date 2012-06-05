package smallScheme;

public abstract aspect SSValueVisitor extends SSVisitor {

	protected String req = "";
	
	@Override
	public void visitCons(SSData car, SSData cdr) {
		throw new SSTypeUnmatchException(req, "pair");
	}

	@Override
	public void visitFunction(SSFunction f) {
		throw new SSTypeUnmatchException(req, "#<function>");
	}

	@Override
	public void visitInteger(int i) {
		throw new SSTypeUnmatchException(req, Integer.toString(i));
	}

	@Override
	public void visitNull() {
		throw new SSTypeUnmatchException(req, "()");
	}

	@Override
	public void visitString(String str) {
		throw new SSTypeUnmatchException(req,"\""+str+"\"");
	}

	@Override
	public void visitSymbol(String label) {
		throw new SSTypeUnmatchException(req, "\'"+label);
	}
	
	@Override
	public void visitBool(boolean b) {
		throw new SSTypeUnmatchException(req, b ? "#t" : "#f");
	}
	
	@Override
	public void visitVoid() {
		throw new SSTypeUnmatchException(req, "#<void>");
	}
	
}
