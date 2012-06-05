package smallScheme;

import java.util.Vector;

public class SSFunctionNull extends SSFunction {
	public static final SSFunctionNull f = new SSFunctionNull();
	
	private SSFunctionNull() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return SSBool.boolToSSBool(args.get(0) == SSNull.n);
	}
}
