package smallScheme;

import java.util.Vector;

public class SSFunctionCdr extends SSFunction {
	public static final SSFunctionCdr f = new SSFunctionCdr();
	
	private SSFunctionCdr() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return SSConsVisitor.aspectOf().getValueCdr(args.get(0));
	}

}
