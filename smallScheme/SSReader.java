package smallScheme;

import java.util.Queue;
import java.util.LinkedList;
import java.util.regex.*;
import java.io.*;

public class SSReader {
	protected Queue<String> tokens;
	protected String lastToken;
	protected BufferedReader in;
	protected Pattern inputPattern;

	public SSReader() {
		in = new BufferedReader(new InputStreamReader(System.in));
		tokens = new LinkedList<String>();
		inputPattern = Pattern.compile("\\(|\\)|[0-9A-Za-z\\Q!$%&*+-./<=>?@^_\\E]+");
	}

	public boolean endToken() {
		return tokens.isEmpty();
	}

	protected void lineLex() throws IOException {
		String line = in.readLine().split(";", 2)[0];
		Matcher m = inputPattern.matcher(line);
		int i = 0;
		try {
			while(true) {
				if(m.find(i)) {
					tokens.add(m.group());
					i = m.end();
				}
				else {
					++i;
				}
			}
		} catch(IndexOutOfBoundsException v) {
			
		}
	}

	public String nextToken() throws IOException {
		while (tokens.isEmpty()) {
			lineLex();
		}
		return tokens.poll();
	}

	protected SSData readList() throws IOException {
		return readList(nextToken());
	}

	protected SSData readList(String s) throws IOException {
		SSData temp;
		if (s.equals(".")) {
			// ドット記法
			temp = read();
			if (read() != null)
				throw new SSDotFormatException();
			else
				return temp;
		}
		temp = read(s);
		if (temp == null)
			return SSNull.n;
		else
			return new SSCons(temp, readList());
	}

	public SSData read() throws IOException {
		return read(nextToken());
	}

	protected SSData read(String s) throws IOException {
		if (s.equals("(")) {
			return readList();
		} else if (s.equals(")")) {
			return null;
		} else
			return new SSSymbol(s);
	}
}
