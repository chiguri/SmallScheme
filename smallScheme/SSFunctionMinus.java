package smallScheme;

import java.util.Vector;

public class SSFunctionMinus extends SSFunction {
	public static final SSFunctionMinus f = new SSFunctionMinus();
	
	private SSFunctionMinus() {}

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, true, 1);
		int i = SSIntegerVisitor.aspectOf().getValue(args.get(0));
		if(args.size() == 1) {
			return new SSInteger(-i);
		}
		int j;
		for(j = 1; j < args.size(); ++j) {
			i -= SSIntegerVisitor.aspectOf().getValue(args.get(j));
		}
		// TODO Auto-generated method stub
		return new SSInteger(i);
	}

}
