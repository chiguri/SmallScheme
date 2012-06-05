package smallScheme;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.util.Vector;

public aspect SSEval {
	protected SSEnvironment top = new SSEnvironment(null);
	protected SSEnvironment macro = new SSEnvironment(null);
	
	// 最低限度の関数のみ  残りの関数やマクロは全てpreludeファイルで実装
	before() : call(void SSInterpreter.interpret()) && within(Main) {
		top.add("+", SSFunctionPlus.f);
		top.add("-", SSFunctionMinus.f);
		top.add("*", SSFunctionMult.f);
		top.add("/", SSFunctionDiv.f);
		top.add("=", SSFunctionNumEq.f);
		top.add("<", SSFunctionNumLt.f);
		
		top.add("cons", SSFunctionCons.f);
		top.add("car", SSFunctionCar.f);
		top.add("cdr", SSFunctionCdr.f);
		
		top.add("set-car!", SSFunctionSetCar.aspectOf());
		top.add("set-cdr!", SSFunctionSetCdr.aspectOf());
		
		top.add("string-append", SSFunctionStringAppend.f);
		top.add("symbol->string", SSFunctionSymbolString.f);
		top.add("string->symbol", SSFunctionStringSymbol.f);
		top.add("string->number", SSFunctionStringNumber.f);
		top.add("number->string", SSFunctionNumberString.f);
		
		top.add("number?", SSFunctionNumber.f);
		top.add("null?", SSFunctionNull.f);
		top.add("pair?", SSFunctionPair.f);
		top.add("boolean?", SSFunctionBoolean.f);
		top.add("symbol?", SSFunctionSymbol.f);
		top.add("string?", SSFunctionString.f);
		top.add("procedure?", SSFunctionProcedure.f);
		
		top.add("eq?", SSFunctionEq.f);
		
		top.add("gensym", SSFunctionGensym.f);
		evalLoad("smallScheme/prelude.scm");
	}
	
	// TODO : 以下の全てに対して、文法チェッカーの導入
	// 現状はoptimisticな実装をしているため、へんな構文を入れるとよくわからないエラーが出る。
	SSData around() : call(SSData SSReader.read()) && within(SSInterpreter) {
		SSData d = proceed();
		if(d != null) {
			switch(SSSyntaxTypeVisitor.aspectOf().getSyntax(d)) {
			case DEFINE:
				evalDefine(d, top);
				d = SSVoid.v;
				break;
			case DEFINEMACRO:
				evalDefineMacro(d);
				d = SSVoid.v;
				break;
			case LOAD:
				evalLoad(SSStringVisitor.aspectOf().getValue(SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(d))));
				d = SSVoid.v;
				break;
			default:
				d = evalExp(d, top);
				break;
			}
		}
		return d;
	}
	
	
	void evalDefine(SSData d, SSEnvironment env) {
		String id;
		d = SSConsVisitor.aspectOf().getValueCdr(d);
		SSData t = SSConsVisitor.aspectOf().getValueCar(d);
		d = SSConsVisitor.aspectOf().getValueCdr(d);
		try {
			id = SSSymbolVisitor.aspectOf().getValue(SSConsVisitor.aspectOf().getValueCar(t));
			t = new SSFunctionLambda(env, SSConsVisitor.aspectOf().getValueCdr(t), d);
		} catch(SSTypeUnmatchException e) {
			id = SSSymbolVisitor.aspectOf().getValue(t);
			t = SSConsVisitor.aspectOf().getValueCar(d);
		}
		env.add(id, evalExp(t, env));
	}
	
	void evalDefineMacro(SSData d) {
		String id;
		d = SSConsVisitor.aspectOf().getValueCdr(d);
		SSData t = SSConsVisitor.aspectOf().getValueCar(d);
		d = SSConsVisitor.aspectOf().getValueCdr(d);
		id = SSSymbolVisitor.aspectOf().getValue(SSConsVisitor.aspectOf().getValueCar(t));
		macro.add(id, new SSFunctionLambda(top, SSConsVisitor.aspectOf().getValueCdr(t), d));
	}

	void evalLoad(String s) {
		try {
			new SSInterpreter().interpret();
		} catch(IOException e) {
			// anything to do?
		} catch(NullPointerException e) {
			// TODO : readLineが失敗した場合。実際はもう少し真っ当にすべき。
		}
	}
	InputStreamReader around(String s) : call(InputStreamReader.new(InputStream)) && cflow(call(void SSEval.evalLoad(String)) && args(s)) {
		try {
			return new FileReader(s);
		} catch(FileNotFoundException e) {
			throw new SSFileNotFoundException(s);
		}
	}
	
	SSData evalExp(SSData d, SSEnvironment env) {
		while(true) {
			try {
				SSData t;
				Vector<SSData> x;
				String s;
				switch(SSSyntaxTypeVisitor.aspectOf().getSyntax(d)) {
				case SYMBOL:
					return env.get(SSSymbolVisitor.aspectOf().getValue(d));
				case INTEGER:
				case STRING:
				case NULL:
				case VOID:
				case FUNCTION:
				case BOOL:
					return d;
				case DEFINE:
					throw new SSExpFormatException("expression", "define");
				case DEFINEMACRO:
					throw new SSExpFormatException("expression", "define-macro");
				case LOAD:
					throw new SSExpFormatException("expression", "load");
				case LAMBDA:
					return new SSFunctionLambda(env, SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(d)), SSConsVisitor.aspectOf().getValueCdr(SSConsVisitor.aspectOf().getValueCdr(d)));
				case QUOTE:
					return SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(d));
				case SET:
					t = evalExp(SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(SSConsVisitor.aspectOf().getValueCdr(d))), env);
					env.set(SSSymbolVisitor.aspectOf().getValue(SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(d))), t);
					return SSVoid.v;
					
				case IF:
					t = evalExp(SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(d)), env);
					if(t != SSBool.f) {
						d = SSConsVisitor.aspectOf().getValueCar(SSConsVisitor.aspectOf().getValueCdr(SSConsVisitor.aspectOf().getValueCdr(d)));
					}
					else {
						t = null;
						d = SSConsVisitor.aspectOf().getValueCdr(SSConsVisitor.aspectOf().getValueCdr(SSConsVisitor.aspectOf().getValueCdr(d)));
						if(d == SSNull.n) {
							d = SSVoid.v;
						}
						else {
							d = SSConsVisitor.aspectOf().getValueCar(d);
						}
					}
					break;
				case BEGIN:
					t = SSConsVisitor.aspectOf().getValueCdr(d);
					try {
						d = SSConsVisitor.aspectOf().getValueCar(t);
						t = SSConsVisitor.aspectOf().getValueCdr(t);
					} catch(SSTypeUnmatchException e) {
						return SSVoid.v;
					}
					while(t != SSNull.n) {
						evalExp(d, env);
						d = SSConsVisitor.aspectOf().getValueCar(t);
						t = SSConsVisitor.aspectOf().getValueCdr(t);
					}
					break;
				case WHILE:
					throw new SSNotImplementedException();
				case MACRO:
					s = SSSymbolVisitor.aspectOf().getValue(SSConsVisitor.aspectOf().getValueCar(d));
					try {
						t = macro.get(s);
					} catch(SSUndefinedVariableException e) {
						t = null;
					}
					if(t != null) {
						d = new SSCons(t, quoteArgs(SSConsVisitor.aspectOf().getValueCdr(d)));
						t = null;
						d = evalExp(d, top);
						break;
					}
				case PAIR:
					x = new Vector<SSData>();
					t = evalExp(SSConsVisitor.aspectOf().getValueCar(d), env);
					d = SSConsVisitor.aspectOf().getValueCdr(d);
					while(d != SSNull.n) {
						x.add(evalExp(SSConsVisitor.aspectOf().getValueCar(d), env));
						d = SSConsVisitor.aspectOf().getValueCdr(d);
					}
					return SSFunctionVisitor.aspectOf().getValue(t).apply(x);
				}
			} catch(SSTailCallException e) {
				d = e.d;
				env = e.env;
			}
		}
	}
	
	SSData evalBody(SSData d, SSEnvironment env) {
		SSData t = SSConsVisitor.aspectOf().getValueCar(d);
		d = SSConsVisitor.aspectOf().getValueCdr(d);
		while(SSSyntaxTypeVisitor.aspectOf().getSyntax(t) == SSSyntax.DEFINE) {
			evalDefine(t, env);
			t = SSConsVisitor.aspectOf().getValueCar(d);
			d = SSConsVisitor.aspectOf().getValueCdr(d);
		}
		while(d != SSNull.n) {
			evalExp(t, env);
			t = SSConsVisitor.aspectOf().getValueCar(d);
			d = SSConsVisitor.aspectOf().getValueCdr(d);
		}
		throw new SSTailCallException(t, env);
	}
	
	
	static private SSData quoteArgs(SSData d) {
		try {
			return new SSCons(new SSCons(new SSSymbol("quote"), new SSCons(SSConsVisitor.aspectOf().getValueCar(d), SSNull.n)), quoteArgs(SSConsVisitor.aspectOf().getValueCdr(d)));
		} catch(SSTypeUnmatchException e) {
			return SSNull.n;
		}
	}
}


class SSTailCallException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9L;
	public SSData d;
	public SSEnvironment env;

	public SSTailCallException(SSData d, SSEnvironment env) {
		this.d = d;
		this.env = env;
	}
}
