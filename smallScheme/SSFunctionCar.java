package smallScheme;

import java.util.Vector;

public class SSFunctionCar extends SSFunction {
	public static final SSFunctionCar f = new SSFunctionCar();
	
	private SSFunctionCar() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return SSConsVisitor.aspectOf().getValueCar(args.get(0));
	}

}
