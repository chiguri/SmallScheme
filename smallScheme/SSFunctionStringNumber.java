package smallScheme;

import java.util.Vector;

public class SSFunctionStringNumber extends SSFunction {
	public static final SSFunctionStringNumber f = new SSFunctionStringNumber();

	private SSFunctionStringNumber() { }
	
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 1);
		return new SSInteger(Integer.parseInt(SSStringVisitor.aspectOf().getValue(args.get(0))));
	}
	
}
