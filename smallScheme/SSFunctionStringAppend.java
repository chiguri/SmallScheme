package smallScheme;

import java.util.Vector;

public class SSFunctionStringAppend extends SSFunction {
	public static final SSFunctionStringAppend f = new SSFunctionStringAppend();
	
	private SSFunctionStringAppend() { }

	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, false, 2);
		return new SSString(SSStringVisitor.aspectOf().getValue(args.get(0)) + SSStringVisitor.aspectOf().getValue(args.get(1)));
	}

}
