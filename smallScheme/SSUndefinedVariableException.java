package smallScheme;

public class SSUndefinedVariableException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4L;
	public String s;
	public SSUndefinedVariableException(String v) {
		s = v;
	}
}
