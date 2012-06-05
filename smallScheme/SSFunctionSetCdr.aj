package smallScheme;

import java.util.Vector;

public aspect SSFunctionSetCdr extends SSFunction {

	void SSCons.setCdr(SSData d) {
		cdr = d;
	}
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 2);
		SSData d = args.get(0);
		SSConsVisitor.aspectOf().getValueCdr(d);
		((SSCons)d).setCdr(args.get(1));
		return SSVoid.v;
	}

}
