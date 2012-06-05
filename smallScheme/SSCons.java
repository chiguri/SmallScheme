package smallScheme;

public class SSCons extends SSData {
	protected SSData car;
	protected SSData cdr;

	public SSCons(SSData car, SSData cdr) {
		this.car = car;
		this.cdr = cdr;
	}
	
	public String toString() {
		return "(" + car.toString() + " . " + cdr.toString() + ")";
	}
}
