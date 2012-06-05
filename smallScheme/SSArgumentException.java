package smallScheme;

public class SSArgumentException extends RuntimeException {

	/**
	 * 引数の数があってない
	 */
	private static final long serialVersionUID = 8L;
	public int req;
	public int given;
	public boolean flag;
	public SSArgumentException(boolean flag, int req, int given) {
		this.flag = flag;
		this.req = req;
		this.given = given;
	}
}
