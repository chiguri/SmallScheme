package smallScheme;

import java.util.Vector;

public class SSFunctionCons extends SSFunction {
	public static final SSFunctionCons f = new SSFunctionCons();
	
	private SSFunctionCons() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args,false, 2);
		return new SSCons(args.get(0), args.get(1));
	}

}
