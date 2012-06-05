package smallScheme;

import java.util.regex.Pattern;

public aspect SSBoolSupport {
	
	Pattern around(String str) : call(static Pattern Pattern.compile(String)) && within(SSReader) && args(str) {
		return proceed(str+"|#t|#f");
	}
	
	SSData around(String token) : call(SSData SSReader.read(String)) && args(token) {
		if(token.equals("#t")) return SSBool.t;
		else if(token.equals("#f")) return SSBool.f;
		else return proceed(token);
	}
}
