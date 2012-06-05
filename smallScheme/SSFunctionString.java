package smallScheme;

import java.util.Vector;

public class SSFunctionString extends SSFunction {
	public static final SSFunctionString f = new SSFunctionString();
	
	private SSFunctionString() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		try {
			SSStringVisitor.aspectOf().getValue(args.get(0));
			return SSBool.t;
		} catch(SSTypeUnmatchException e) {
			return SSBool.f;
		}
	}

}
