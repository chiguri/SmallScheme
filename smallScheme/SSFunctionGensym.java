package smallScheme;

import java.util.Vector;

public class SSFunctionGensym extends SSFunction {
	public static SSFunctionGensym f = new SSFunctionGensym();
	protected int i = 0;
	private SSFunctionGensym() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 0);
		return new SSSymbol("#<VAR"+(i++)+">");
	}
	
}
