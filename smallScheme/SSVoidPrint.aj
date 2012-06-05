package smallScheme;

public aspect SSVoidPrint {
	void around(String s) : call(void *.println(*)) && args(s) && within(SSInterpreter) {
		if(!s.equals("#<void>")) {
			proceed(s);
		}
	}
}
