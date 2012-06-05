package smallScheme;

public class SSExpFormatException extends RuntimeException {

	/**
	 * ???
	 */
	private static final long serialVersionUID = 1L;
	public String type;
	public String given;
	public SSExpFormatException(String type, String given) {
		this.type = type;
		this.given = given;
	}

}
