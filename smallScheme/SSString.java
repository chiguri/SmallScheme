package smallScheme;

public class SSString extends SSData {
	protected String str;
	
	public SSString(String s) {
		str = s;
	}
	
	public String toString(){
		return str;
	}
}
