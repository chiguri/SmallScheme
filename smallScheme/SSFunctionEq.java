package smallScheme;

import java.util.Vector;

public class SSFunctionEq extends SSFunction {
	public static final SSFunctionEq f = new SSFunctionEq();
	
	private SSFunctionEq() { }
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 2);
		try {
			return SSBool.boolToSSBool(SSSymbolVisitor.aspectOf().getValue(args.get(0)).equals(SSSymbolVisitor.aspectOf().getValue(args.get(1))));
		} catch(SSTypeUnmatchException e) { }
		try {
			return SSBool.boolToSSBool(SSIntegerVisitor.aspectOf().getValue(args.get(0)) == SSIntegerVisitor.aspectOf().getValue(args.get(1)));
		} catch(SSTypeUnmatchException e) { }
		
		return SSBool.boolToSSBool(args.get(0) == args.get(1));
	}

}
