all: lexer parser compilation move

lexer: lexer.jflex
	jflex lexer.jflex
parser: parser.jacc
	jacc -v parser.jacc
compilation: ./*.java
	javac ./*.java
move:
	mv -t ../bin *.class

run:
	java Parser ../tests/test1.c
	dot -Tpdf ast.dot -o ast.pdf
	xdg-open ast.pdf

clean:
	rm -rf ../bin/*
	rm -rf *.output Lexer.java Parser.java ParserTokens.java