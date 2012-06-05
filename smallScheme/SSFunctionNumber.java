package smallScheme;

import java.util.Vector;

public class SSFunctionNumber extends SSFunction {
	public static final SSFunctionNumber f = new SSFunctionNumber();
	
	private SSFunctionNumber() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		try {
			SSIntegerVisitor.aspectOf().getValue(args.get(0));
			return SSBool.t;
		} catch(SSTypeUnmatchException e) {
			return SSBool.f;
		}
	}

}
