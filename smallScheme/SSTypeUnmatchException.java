package smallScheme;

public class SSTypeUnmatchException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2L;
	public String req;
	public String s;
	
	public SSTypeUnmatchException(String req, String s) {
		this.req = req;
		this.s = s;
	}

}
