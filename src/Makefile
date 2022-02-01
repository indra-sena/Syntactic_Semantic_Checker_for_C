all: check

check: lexer.jflex
	jflex lexer.jflex
	javac lexer.java
	mv lexer?Yytoken.class ../bin/
	mv lexer.class ../bin/