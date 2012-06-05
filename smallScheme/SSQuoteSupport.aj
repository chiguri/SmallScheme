package smallScheme;

import java.io.IOException;
import java.util.regex.Pattern;

public aspect SSQuoteSupport {
	
	// '�̓��͂��̂��̂ɂ���
	Pattern around(String str) : call(static Pattern Pattern.compile(String)) && within(SSReader) && args(str) {
		return proceed(str+"|'");
	}
	
	// '��(quote ...)�ɕύX
	SSData around(String token, SSReader reader) throws IOException
		: call(protected SSData SSReader.read(String)) && args(token) && target(reader) && if(token.equals("'")){
		return new SSCons(new SSSymbol("quote"), new SSCons(reader.read(), SSNull.n));
	}
	
	// �o�͂̃T�|�[�g
	String around() : get(String SSSymbol.label) && cflow(call(String *.toString())) {
		return "'"+proceed();
	}
}
