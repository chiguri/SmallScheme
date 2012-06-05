package smallScheme;

import java.util.Vector;

public class SSFunctionMult extends SSFunction {
	public static final SSFunctionMult f = new SSFunctionMult();
	
	private SSFunctionMult() {}
	@Override
	public SSData apply(Vector<SSData> args) {
		int i = 1;
		for(int j = 0; j < args.size(); ++j) {
			i *= SSIntegerVisitor.aspectOf().getValue(args.get(j));
		}
		return new SSInteger(i);
	}

}
