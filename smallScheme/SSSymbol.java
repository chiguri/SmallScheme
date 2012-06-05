package smallScheme;

public class SSSymbol extends SSData {
	public final String label;

	public SSSymbol(String s) {
		label = s;
	}

	public String toString() {
		return label;
	}
}
