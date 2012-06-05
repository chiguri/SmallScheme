package smallScheme;

import java.util.Vector;

public class SSFunctionNumEq extends SSFunction {
	public static final SSFunctionNumEq f = new SSFunctionNumEq();
	
	private SSFunctionNumEq() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 2);
		return SSBool.boolToSSBool(SSIntegerVisitor.aspectOf().getValue(args.get(0)) == SSIntegerVisitor.aspectOf().getValue(args.get(1)));
	}

}
