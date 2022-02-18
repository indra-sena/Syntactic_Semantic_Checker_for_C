import java.util.*;
import java.io.*;

%%
%class Lexer
%implements ParserTokens

%function yylex
%int
%{
    private int token;
    private String semantic;
    public int lineNum;
    public int colNum;
    
    public int getToken()
    {
        return token;
    }

    public int getlineNum()
    {
        return lineNum;
    }

    public int getcolNum()
    {
        return colNum;
    }

    public String getSemantic()
    {
        return semantic;
    }

    public int nextToken()
    {
        try
        {
            token = yylex();
        }
        catch (java.io.IOException e)
        {
            System.out.println(
                "IO exception occured:\n" + e);
        }
        return token;
    }

    public boolean getzzAtEOF()
    {
        return zzAtEOF;
    }
%}
%line
%column
%init{
    yybegin(NORMAL);
%init}



%state NORMAL COMMENT LCOMMENT CODESTRING

digit = [0-9]
letter = [a-zA-Z_]
hexa = [a-fA-F0-9]
exp = [Ee][+-]?{digit}+
whiteSpace = [ \t\n]
FS = (f|F|l|L)
IS = (u|U|l|L)*


%%
<NORMAL>{
    // "/*"                             {yybegin(COMMENT);}
    // // "\/\/"(.*)                   {System.out.println("jbks");yybegin(LCOMMENT);}
    // // ^"//"    {;}
    // "//"                             {yybegin(LCOMMENT);}

    "//"    {yybegin(LCOMMENT);}
    "/*"[^*]*|[*]*"*/" {;}

    "break"                          {semantic = yytext(); return BREAK;}
    "case"                           {semantic = yytext(); return CASE;}
    "char"                           {semantic = yytext(); return CHAR;}
    "auto"                           {semantic = yytext(); return AUTO;}
    "const"                          {semantic = yytext(); return CONST;}
    "continue"	                     {semantic = yytext(); return CONTINUE;}
    "default"	                     {semantic = yytext(); return DEFAULT;}
    "do"		                     {semantic = yytext(); return DO;}
    "double"	                     {semantic = yytext(); return DOUBLE;}
    "else"		                     {semantic = yytext(); return ELSE;}
    "enum"		                     {semantic = yytext(); return ENUM;}
    "extern"	                     {semantic = yytext(); return EXTERN;}
    "float"		                     {semantic = yytext(); return FLOAT;}
    "for"		                     {semantic = yytext(); return FOR;}
    "goto"		                     {semantic = yytext(); return GOTO;}
    "if"		                     {semantic = yytext(); return IF;}
    "int"		                     {semantic = yytext(); return INT;}
    "long"		                     {semantic = yytext(); return LONG;}
    "register"	                     {semantic = yytext(); return REGISTER;}
    "return"	                     {semantic = yytext(); return RETURN;}
    "short"		                     {semantic = yytext(); return SHORT;}
    "signed"	                     {semantic = yytext(); return SIGNED;}
    "sizeof"	                     {semantic = yytext(); return SIZEOF;}
    "static"	                     {semantic = yytext(); return STATIC;}
    "struct"	                     {semantic = yytext(); return STRUCT;}
    "switch"	                     {semantic = yytext(); return SWITCH;}
    "typedef"	                     {semantic = yytext(); return TYPEDEF;}
    "union"		                     {semantic = yytext(); return UNION;}
    "unsigned"	                     {semantic = yytext(); return UNSIGNED;}
    "void"		                     {semantic = yytext(); return VOID;}
    "volatile"	                     {semantic = yytext(); return VOLATILE;}
    "while"		                     {semantic = yytext(); return WHILE;}
    {letter}({letter}|{digit})*      {semantic = yytext(); return IDENTIFIER;}
    {digit}+{IS}?                    {semantic = yytext(); return CONSTANT;}
    '(\\.|[^\\'])'                   {semantic = yytext(); return CONSTANT;}
    0[xX]{hexa}+{IS}?                {semantic = yytext(); return CONSTANT;}
    {digit}+{exp}{FS}?               {semantic = yytext(); return CONSTANT;}
    {digit}*"."{digit}+{exp}?{FS}?   {semantic = yytext(); return CONSTANT;}
    {digit}+"."{digit}*{exp}?{FS}?   {semantic = yytext(); return CONSTANT;}
    \"(\\.|[^\"])*\"                 {semantic = yytext(); return STRING_LITERAL;}
    ">="                             {semantic = yytext(); return GE_OP;}
    "<="                             {semantic = yytext(); return LE_OP;}
    "+="                             {semantic = yytext(); return ADD_ASSIGN;}
    "-="                             {semantic = yytext(); return SUB_ASSIGN;}
    "*="                             {semantic = yytext(); return MUL_ASSIGN;}
    "/="                             {semantic = yytext(); return DIV_ASSIGN;}
    "%="                             {semantic = yytext(); return MOD_ASSIGN;}
    "&="                             {semantic = yytext(); return AND_ASSIGN;}
    "|="                             {semantic = yytext(); return OR_ASSIGN;}
    "^="                             {semantic = yytext(); return XOR_ASSIGN;}
    ">>"                             {semantic = yytext(); return RIGHT_OP;}
    "<<"                             {semantic = yytext(); return LEFT_OP;}
    "++"                             {semantic = yytext(); return INC_OP;}
    "--"                             {semantic = yytext(); return DEC_OP;}
    "->"                             {semantic = yytext(); return PTR_OP;}
    "&&"                             {semantic = yytext(); return AND_OP;}
    "||"                             {semantic = yytext(); return OR_OP;}
    "!="                             {semantic = yytext(); return NE_OP;}
    "=="                             {semantic = yytext(); return EQ_OP;}
    ";"                              {semantic = yytext(); return ';';}
    "{"                              {semantic = yytext(); return '{';}
    "}"                              {semantic = yytext(); return '}';}
    ","                              {semantic = yytext(); return ',';}
    ":"                              {semantic = yytext(); return ':';}
    "="			                     {semantic = yytext(); return '=';}
    "("			                     {semantic = yytext(); return '(';}
    ")"			                     {semantic = yytext(); return ')';}
    "["	                             {semantic = yytext(); return '[';}
    "]"	                             {semantic = yytext(); return ']';}
    "."			                     {semantic = yytext(); return '.';}
    "&"			                     {semantic = yytext(); return '&';}
    "!"			                     {semantic = yytext(); return '!';}
    "~"	                             {semantic = yytext(); return '~';}
    "-"		                         {semantic = yytext(); return '-';}
    "+"			                     {semantic = yytext(); return '+';}
    "*"			                     {semantic = yytext(); return '*';}
    "/"			                     {semantic = yytext(); return '/';}
    "%"			                     {semantic = yytext(); return '%';}
    "<"			                     {semantic = yytext(); return '<';}
    ">"			                     {semantic = yytext(); return '>';}
    "^"			                     {semantic = yytext(); return '^';}
    "|"			                     {semantic = yytext(); return '|';}
    "?"			                     {semantic = yytext(); return '?';}
    <<EOF>>                          {return ENDINPUT;}
    {whiteSpace} {;}
    [^] {;}
    
}


<COMMENT>{
    "*/"   {yybegin( NORMAL );}
    <<EOF>>                          {return ENDINPUT;}
    [^]      {;}
    
}

<LCOMMENT>{
    [\n]  {yybegin(NORMAL);}
    <<EOF>>                          {return ENDINPUT;}
    [^]     {;}
    
}

