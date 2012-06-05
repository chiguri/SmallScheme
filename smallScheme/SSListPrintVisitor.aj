package smallScheme;

import java.util.Stack;

public aspect SSListPrintVisitor extends SSVisitor {
	Stack<String> s;
	String around(SSCons d) : execution(String *.toString()) && target(d) {
		Stack<String> temp = s;
		s = new Stack<String>();
		d.visit(this);
		String str = "";
		try {
			str = "(" + s.pop() + ")";
		} catch(Exception e) { }
		s = temp;
		return str;
	}
	
	@Override
	public void visitCons(SSData car, SSData cdr) {
		String str = car.toString();
		cdr.visit(this);
		try {
			String str2 = s.pop();
			if(!str2.equals("")) { // nullèIí[Ç≈Ç»Ç¢èÍçá
				str += " " + str2;
			}
			s.push(str);
		} catch(Exception e) { }
	}

	@Override
	public void visitNull() {
		s.push("");
	}

	@Override
	public void visitSymbol(String label) {
		s.push(". " + label);
	}
	
	@Override
	public void visitString(String str) {
		s.push(". " + str);
	}
	
	@Override
	public void visitInteger(int i) {
		s.push(". " + i);
	}
	
	@Override
	public void visitFunction(SSFunction f) {
		s.push("#<function>");
	}
	
	@Override
	public void visitBool(boolean b) {
		s.push(b ? "#t" : "#f");
	}
	
	@Override
	public void visitVoid() {
		s.push("#<void>");
	}

}
