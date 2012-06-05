package smallScheme;

public class SSFileNotFoundException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 13L;
	public String name;
	
	public SSFileNotFoundException(String s) {
		name = s;
	}

}
