package smallScheme;

public class SSInteger extends SSData {
	protected int i;
	
	public SSInteger(int i) {
		this.i = i;
	}
	
	public String toString() {
		return Integer.toString(i);
	}
}
