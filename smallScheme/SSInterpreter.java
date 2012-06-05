package smallScheme;

import java.io.IOException;

public class SSInterpreter {
	protected SSReader ssr;
	
	public SSInterpreter() {
		ssr = new SSReader();
	}

	public void interpret() throws IOException {
		while(true) {
			try {
				SSData d = ssr.read();
				if(d == null) { // only toplevel
					System.err.println("Format mismatch : right parenthesis without left");
				}
				else {
					System.out.println(d.toString());
				}
			} catch (SSDotFormatException e) {
				System.err.println("Format mismatch : incorrect dotted form");
			} catch (SSTypeUnmatchException e) {
				System.err.println("Type mismatch : " + e.req + " is required, but given " + e.s);
			} catch (SSExpFormatException e) {
				System.err.println("Syntax error : " + e.type + "is required, but given " + e.given);
			} catch (SSUndefinedVariableException e) {
				System.err.println("Variable " + e.s + " is undefined");
			} catch (SSArgumentException e) {
				System.err.println("Number of arguments mismatch : " + (e.flag ? ("at least " + (e.req - 1)) : e.req) + " arguments are required, but given " + e.given);
			} catch (SSFileNotFoundException e) {
				System.err.println("File " + e.name + " is not found");
			}
		}
	}
}
