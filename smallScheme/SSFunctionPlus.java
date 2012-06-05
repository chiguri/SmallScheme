package smallScheme;

import java.util.Vector;

public class SSFunctionPlus extends SSFunction {
	public static final SSFunctionPlus f = new SSFunctionPlus();
	
	private SSFunctionPlus() {}
	@Override
	public SSData apply(Vector<SSData> args) {
		int i = 0;
		for(int j = 0; j < args.size(); ++j) {
			i += SSIntegerVisitor.aspectOf().getValue(args.get(j));
		}
		return new SSInteger(i);
	}

}
