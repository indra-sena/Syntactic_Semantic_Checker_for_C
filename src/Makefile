all: lexer parser compilation

lexer: lexer.jflex
	jflex lexer.jflex
parser: parser.jacc
	jacc -v parser.jacc
compilation: ./*java
	javac ./*java
