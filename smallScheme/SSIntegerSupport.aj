package smallScheme;

public aspect SSIntegerSupport {
	SSData around(String token) : call(SSData SSReader.read(String)) && args(token) && if(token.matches("-?[0-9]+")) {
		return new SSInteger(Integer.parseInt(token));
	}
}
