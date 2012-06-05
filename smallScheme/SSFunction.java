package smallScheme;

import java.util.Vector;

public abstract class SSFunction extends SSData {
	
	public abstract SSData apply(Vector<SSData> args);
	protected void argsCheck(Vector<SSData> args, boolean flag, int req) {
		if(flag && args.size() < req - 1) {
			throw new SSArgumentException(flag, req, args.size());
		} else if(!flag && args.size() != req) {
			throw new SSArgumentException(flag, req, args.size());
		}
	}
	public String toString() {
		return "#<function>";
	}
}
