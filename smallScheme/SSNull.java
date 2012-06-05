package smallScheme;

public class SSNull extends SSData {
	public static final SSNull n = new SSNull();
	
	private SSNull() { }
	public String toString() {
		return "()";
	}
}
