package smallScheme;

import java.util.Vector;

public class SSFunctionPair extends SSFunction {
	public static final SSFunctionPair f = new SSFunctionPair();
	
	private SSFunctionPair() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		try {
			SSConsVisitor.aspectOf().getValueCar(args.get(0));
			return SSBool.t;
		} catch (SSTypeUnmatchException e) {
			return SSBool.f;
		}
	}

}
