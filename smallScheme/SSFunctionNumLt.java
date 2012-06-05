package smallScheme;

import java.util.Vector;

public class SSFunctionNumLt extends SSFunction {
	public static final SSFunctionNumLt f = new SSFunctionNumLt();
	
	private SSFunctionNumLt() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 2);
		return SSBool.boolToSSBool(SSIntegerVisitor.aspectOf().getValue(args.get(0)) < SSIntegerVisitor.aspectOf().getValue(args.get(1)));
	}

}
