package smallScheme;

import java.util.Vector;

public class SSFunctionLambda extends SSFunction {
	protected Vector<String> params;
	protected SSData body;
	protected SSEnvironment env; // êeä¬ã´
	protected boolean dot;
	
	public SSFunctionLambda(SSEnvironment env, SSData params, SSData body) {
		// defineópÇ…ï™âÇµÇΩÇ‡ÇÃÇìnÇ∑
		// TODO é¿ëï
		this.env = env;
		this.body = body;
		this.params = new Vector<String>();
		try {
			while(params != SSNull.n) {
				this.params.add(SSSymbolVisitor.aspectOf().getValue(SSConsVisitor.aspectOf().getValueCar(params)));
				params = SSConsVisitor.aspectOf().getValueCdr(params);
			}
			dot = false;
		} catch(SSTypeUnmatchException e) {
			this.params.add(SSSymbolVisitor.aspectOf().getValue(params));
			dot = true;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public SSData apply(Vector<SSData> args) {
		argsCheck(args, dot, params.size());

		if(dot && (params.size()-1 <= args.size())) {
			SSData d = SSNull.n;
			while(args.size() >= params.size()) {
				d = new SSCons(args.lastElement(),d);
				args.remove(args.size()-1);
			}
			args.add(d);
		}

		return SSEval.aspectOf().evalBody(body, new SSEnvironment(env, (Vector<String>)(params.clone()), args));
	}

}
