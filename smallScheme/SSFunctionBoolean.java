package smallScheme;

import java.util.Vector;

public class SSFunctionBoolean extends SSFunction {
	public static final SSFunctionBoolean f = new SSFunctionBoolean();
	
	private SSFunctionBoolean() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return SSBool.boolToSSBool(args.get(0) == SSBool.t || args.get(0) == SSBool.f);
	}

}
