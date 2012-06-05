package smallScheme;

import java.util.Vector;

public class SSFunctionDiv extends SSFunction {
	public static final SSFunctionDiv f = new SSFunctionDiv();
	
	private SSFunctionDiv() {}

	@Override // TODO : 0���Z���ǂ��������E�E�E
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, true, 1);
		int i = SSIntegerVisitor.aspectOf().getValue(args.get(0));
		if(args.size() == 1) {
			return new SSInteger(1/i); // ���͗L�������������Ȃ��̂Ŗ��Ӗ��B����0�B
		}
		int j;
		for(j = 1; j < args.size(); ++j) {
			i /= SSIntegerVisitor.aspectOf().getValue(args.get(j));
		}
		// TODO Auto-generated method stub
		return new SSInteger(i);
	}

}
