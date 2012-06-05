package smallScheme;

import java.util.Vector;

public class SSFunctionSymbol extends SSFunction {
	public static final SSFunctionSymbol f = new SSFunctionSymbol();
	
	private SSFunctionSymbol() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		try {
			SSSymbolVisitor.aspectOf().getValue(args.get(0));
			return SSBool.t;
		} catch(SSTypeUnmatchException e) {
			return SSBool.f;
		}
	}

}
