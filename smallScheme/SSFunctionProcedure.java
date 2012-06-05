package smallScheme;

import java.util.Vector;

public class SSFunctionProcedure extends SSFunction {
	public static final SSFunctionProcedure f = new SSFunctionProcedure();
	
	private SSFunctionProcedure() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		try {
			SSFunctionVisitor.aspectOf().getValue(args.get(0));
			return SSBool.t;
		} catch(SSTypeUnmatchException e) {
			return SSBool.f;
		}
	}

}
