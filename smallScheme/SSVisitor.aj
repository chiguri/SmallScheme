package smallScheme;

public abstract aspect SSVisitor {
	public abstract void SSData.visit(SSVisitor v);
	public void SSNull.visit(SSVisitor v) {
		v.visitNull();
	}
	public void SSCons.visit(SSVisitor v) {
		v.visitCons(car, cdr);
	}
	public void SSSymbol.visit(SSVisitor v) {
		v.visitSymbol(label);
	}
	public void SSString.visit(SSVisitor v) {
		v.visitString(str);
	}
	public void SSInteger.visit(SSVisitor v) {
		v.visitInteger(i);
	}
	public void SSFunction.visit(SSVisitor v) {
		v.visitFunction(this);
	}
	public void SSBool.visit(SSVisitor v) {
		v.visitBool(b);
	}
	public void SSVoid.visit(SSVisitor v) {
		v.visitVoid();
	}
	
	
	public abstract void visitNull();
	public abstract void visitCons(SSData car, SSData cdr);
	public abstract void visitSymbol(String label);
	public abstract void visitString(String str);
	public abstract void visitInteger(int i);
	public abstract void visitFunction(SSFunction f);
	public abstract void visitBool(boolean b);
	public abstract void visitVoid();
}
