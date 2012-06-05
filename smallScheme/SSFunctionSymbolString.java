package smallScheme;

import java.util.Vector;

public class SSFunctionSymbolString extends SSFunction {
	public static final SSFunctionSymbolString f = new SSFunctionSymbolString();

	private SSFunctionSymbolString() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return new SSString(SSSymbolVisitor.aspectOf().getValue(args.get(0)));
	}

}
