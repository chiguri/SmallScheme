package smallScheme;

import java.util.Vector;

public class SSFunctionNumberString extends SSFunction {
	public static final SSFunctionNumberString f = new SSFunctionNumberString();

	private SSFunctionNumberString() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return new SSString(Integer.toString(SSIntegerVisitor.aspectOf().getValue(args.get(0))));
	}
	
}
