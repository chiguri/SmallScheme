package smallScheme;

import java.util.Vector;

public class SSEnvironment {
	protected SSEnvironment parent;
	protected Vector<String> names;
	protected Vector<SSData> data;
	
	public SSEnvironment(SSEnvironment parent) {
		this.parent = parent;
		names = new Vector<String>();
		data = new Vector<SSData>();
	}
	public SSEnvironment(SSEnvironment parent, Vector<String> params, Vector<SSData> args) {
		this.parent = parent;
		names = params;
		data = args;
	}
	
	public SSData get(String name) {
		int i;
		if((i = names.indexOf(name)) == -1) {
			if(parent == null) {
				throw new SSUndefinedVariableException(name);
			}
			return parent.get(name);
		}
		else {
			return data.get(i);
		}
	}
	
	public void add(String name, SSData d) {
		names.add(0, name);
		data.add(0, d);
	}
	
	public void set(String name, SSData d) {
		int i;
		if((i = names.indexOf(name)) == -1) {
			if(parent == null) {
				throw new SSUndefinedVariableException(name);
			}
			parent.set(name, d);
		}
		else {
			data.set(i, d);
		}
	}
	
}
