package smallScheme;

import java.util.regex.Pattern;

public aspect SSStringSupport {
	Pattern around(String str) : call(static Pattern Pattern.compile(String)) && within(SSReader) && args(str) {
		return proceed(str+"|(\\\"([^\\\\\\\"]|(\\\\\\\")|(\\\\\\\\))*\\\")");
	}
	
	// 普段はダブルクオートを意識せずに扱いたい
	SSData around(String s) : call(SSData SSReader.read(String)) && args(s) && if(s.matches("\\\"([^\\\\\\\"]|(\\\\\\\")|(\\\\\\\\))*\\\"")) {
		String[] t = s.substring(1,s.length()-1).split("\\\\", -1);
		s = t[0];
		for(int i = 1; i < t.length; ++i) {
			s += (t[i].equals("") ? "\\" : t[i]);
		}
		return new SSString(s);
	}
	
	String around() : get(protected String SSString.str) && (cflow(call(String *.toString()))) {
		return "\""+proceed()+"\"";
	}
}
