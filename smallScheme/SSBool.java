package smallScheme;

public class SSBool extends SSData {

	public static final SSBool t = new SSBool(true);
	public static final SSBool f = new SSBool(false);
	protected boolean b;
	
	private SSBool(boolean b) {
		this.b = b;
	}
	public String toString() {
		return b ? "#t" : "#f";
	}
	public static SSBool boolToSSBool(boolean b) {
		return b ? t : f;
	}
}
