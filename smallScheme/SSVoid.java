package smallScheme;

public class SSVoid extends SSData {
	public static final SSVoid v = new SSVoid();
	
	private SSVoid() { }
	public String toString() {
		return "#<void>";
	}
}
