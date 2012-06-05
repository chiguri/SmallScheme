package smallScheme;

import java.util.Vector;

public aspect SSFunctionSetCar extends SSFunction {

	void SSCons.setCar(SSData d) {
		car = d;
	}
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 2);
		SSData d = args.get(0);
		SSConsVisitor.aspectOf().getValueCar(d);
		((SSCons)d).setCar(args.get(1));
		return SSVoid.v;
	}

}
