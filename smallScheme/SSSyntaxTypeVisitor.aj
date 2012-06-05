package smallScheme;

public aspect SSSyntaxTypeVisitor extends SSVisitor {
	boolean check;
	SSSyntax ret;
	public SSSyntax getSyntax(SSData d) {
		check = false;
		d.visit(this);
		return ret;
	}
	
	@Override
	public void visitBool(boolean b) {
		if(check) {
			throw new SSTypeUnmatchException("#<function>", b ? "#t" : "#f");
		}
		ret = SSSyntax.BOOL;
	}

	@Override
	public void visitCons(SSData car, SSData cdr) {
		if(check) {
			ret = SSSyntax.PAIR;
		}
		else {
			check = true;
			car.visit(this);
		}
	}

	@Override
	public void visitFunction(SSFunction f) {
		if(check) {
			ret = SSSyntax.PAIR;
		}
		else {
			ret = SSSyntax.FUNCTION;
		}
	}

	@Override
	public void visitInteger(int i) {
		if(check) {
			throw new SSTypeUnmatchException("#<function>", Integer.toString(i));
		}
		ret = SSSyntax.INTEGER;
	}

	@Override
	public void visitNull() {
		if(check) {
			throw new SSTypeUnmatchException("#<function>", "()");
		}
		ret = SSSyntax.NULL;
	}

	@Override
	public void visitString(String str) {
		if(check) {
			throw new SSTypeUnmatchException("#<function>", "\""+str+"\"");
		}
		ret = SSSyntax.STRING;
	}

	@Override
	public void visitSymbol(String label) {
		if(check) {
			ret =
				(label.equals("define")) ? SSSyntax.DEFINE :
				(label.equals("define-macro")) ? SSSyntax.DEFINEMACRO :
				(label.equals("load")) ? SSSyntax.LOAD :
				(label.equals("lambda")) ? SSSyntax.LAMBDA :
				(label.equals("quote")) ? SSSyntax.QUOTE :
				(label.equals("set!")) ? SSSyntax.SET :
				(label.equals("if")) ? SSSyntax.IF :
				(label.equals("begin")) ? SSSyntax.BEGIN :
				(label.equals("while")) ? SSSyntax.WHILE :
					SSSyntax.MACRO;
		}
		else {
			ret = SSSyntax.SYMBOL;
		}

	}

	@Override
	public void visitVoid() {
		if(check) {
			throw new SSTypeUnmatchException("#<function>", "#<void>");
		}
		ret = SSSyntax.VOID;
	}

}
