package smallScheme;

import java.util.Vector;

public class SSFunctionStringSymbol extends SSFunction {
	public static final SSFunctionStringSymbol f = new SSFunctionStringSymbol();

	private SSFunctionStringSymbol() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return new SSSymbol(SSStringVisitor.aspectOf().getValue(args.get(0)));
	}

}
