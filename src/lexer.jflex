import java.util.*;
import java.io.*;

%%
%class Lexer
%implements ParserTokens

%function yylex
%int
%{
    public int token;
    public helper semantic;
    // public int lineNum;
    // public int colNum;
    
    // public int getToken()
    // {
    //     return token;
    // }

    public int getlineNum()
    {
        return yyline;
    }

    public int getcolNum()
    {
        return yycolumn;
    }

    // public helper getSemantic()
    // {
    //     return semantic;
    // }

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

    "//"                            {yybegin(LCOMMENT);}
    "/*"[^*]*|[*]*"*/"              {yybegin(COMMENT);}

    "case"                          {semantic = new helper(yytext()); return CASE;}
    "char"                          {semantic = new helper(yytext()); return CHAR;}
    "break"                         {semantic = new helper(yytext()); return BREAK;}
    "auto"                          {semantic = new helper(yytext()); return AUTO;}
    "const"                         {semantic = new helper(yytext()); return CONST;}
    "continue"	                    {semantic = new helper(yytext()); return CONTINUE;}
    "default"	                    {semantic = new helper(yytext()); return DEFAULT;}
    "do"		                    {semantic = new helper(yytext()); return DO;}
    "double"	                    {semantic = new helper(yytext()); return DOUBLE;}
    "else"		                    {semantic = new helper(yytext()); return ELSE;}
    "enum"		                    {semantic = new helper(yytext()); return ENUM;}
    "extern"	                    {semantic = new helper(yytext()); return EXTERN;}
    "float"		                    {semantic = new helper(yytext()); return FLOAT;}
    "for"		                    {semantic = new helper(yytext()); return FOR;}
    "goto"		                    {semantic = new helper(yytext()); return GOTO;}
    "if"		                    {semantic = new helper(yytext()); return IF;}
    "int"		                    {semantic = new helper(yytext()); return INT;}
    "long"		                    {semantic = new helper(yytext()); return LONG;}
    "register"	                    {semantic = new helper(yytext()); return REGISTER;}
    "short"		                    {semantic = new helper(yytext()); return SHORT;}
    "signed"	                    {semantic = new helper(yytext()); return SIGNED;}
    "return"	                    {semantic = new helper(yytext()); return RETURN;}
    "sizeof"	                    {semantic = new helper(yytext()); return SIZEOF;}
    "static"	                    {semantic = new helper(yytext()); return STATIC;}
    "struct"	                    {semantic = new helper(yytext()); return STRUCT;}
    "switch"	                    {semantic = new helper(yytext()); return SWITCH;}
    "typedef"	                    {semantic = new helper(yytext()); return TYPEDEF;}
    "union"		                    {semantic = new helper(yytext()); return UNION;}
    "unsigned"	                    {semantic = new helper(yytext()); return UNSIGNED;}
    "void"		                    {semantic = new helper(yytext()); return VOID;}
    "volatile"	                    {semantic = new helper(yytext()); return VOLATILE;}
    "while"		                    {semantic = new helper(yytext()); return WHILE;}

    {letter}({letter}|{digit})*     {semantic = new helper(yytext()); return IDENTIFIER;}

    {digit}+{IS}?                   {semantic = new helper(yytext()); return I_CONSTANT;}
    0{digit}+{IS}?                  {semantic = new helper(yytext()); return I_CONSTANT;}
    L?'(\\.|[^\\'])'                {semantic = new helper(yytext()); return I_CONSTANT;}
    0[xX]{hexa}+{IS}?               {semantic = new helper(yytext()); return I_CONSTANT;}
    
    {digit}+{exp}{FS}?              {semantic = new helper(yytext()); return F_CONSTANT;}
    {digit}*"."{digit}+{exp}?{FS}?  {semantic = new helper(yytext()); return F_CONSTANT;}
    {digit}+"."{digit}*{exp}?{FS}?  {semantic = new helper(yytext()); return F_CONSTANT;}
    
    L?\"(\\.|[^\"])*\"              {semantic = new helper(yytext()); return STRING_LITERAL;}

    "..."                           {semantic = new helper(yytext()); return ELLIPSIS;}
    ">="                            {semantic = new helper(yytext()); return GE_OP;}
    "<="                            {semantic = new helper(yytext()); return LE_OP;}
    "+="                            {semantic = new helper(yytext()); return ADD_ASSIGN;}
    "-="                            {semantic = new helper(yytext()); return SUB_ASSIGN;}
    "*="                            {semantic = new helper(yytext()); return MUL_ASSIGN;}
    "/="                            {semantic = new helper(yytext()); return DIV_ASSIGN;}
    "%="                            {semantic = new helper(yytext()); return MOD_ASSIGN;}
    "&="                            {semantic = new helper(yytext()); return AND_ASSIGN;}
    "|="                            {semantic = new helper(yytext()); return OR_ASSIGN;}
    "^="                            {semantic = new helper(yytext()); return XOR_ASSIGN;}
    ">>"                            {semantic = new helper(yytext()); return RIGHT_OP;}
    "<<"                            {semantic = new helper(yytext()); return LEFT_OP;}
    "++"                            {semantic = new helper(yytext()); return INC_OP;}
    "--"                            {semantic = new helper(yytext()); return DEC_OP;}
    "->"                            {semantic = new helper(yytext()); return PTR_OP;}
    "&&"                            {semantic = new helper(yytext()); return AND_OP;}
    "||"                            {semantic = new helper(yytext()); return OR_OP;}
    "!="                            {semantic = new helper(yytext()); return NE_OP;}
    "=="                            {semantic = new helper(yytext()); return EQ_OP;}
    ";"                             {semantic = new helper(yytext()); return ';';}
    "{"                             {semantic = new helper(yytext()); return '{';}
    "}"                             {semantic = new helper(yytext()); return '}';}
    ","                             {semantic = new helper(yytext()); return ',';}
    ":"                             {semantic = new helper(yytext()); return ':';}
    "="			                    {semantic = new helper(yytext()); return '=';}
    "("			                    {semantic = new helper(yytext()); return '(';}
    ")"			                    {semantic = new helper(yytext()); return ')';}
    "["	                            {semantic = new helper(yytext()); return '[';}
    "]"	                            {semantic = new helper(yytext()); return ']';}
    "."			                    {semantic = new helper(yytext()); return '.';}
    "&"			                    {semantic = new helper(yytext()); return '&';}
    "!"			                    {semantic = new helper(yytext()); return '!';}
    "~"	                            {semantic = new helper(yytext()); return '~';}
    "-"		                        {semantic = new helper(yytext()); return '-';}
    "+"			                    {semantic = new helper(yytext()); return '+';}
    "*"			                    {semantic = new helper(yytext()); return '*';}
    "/"			                    {semantic = new helper(yytext()); return '/';}
    "%"			                    {semantic = new helper(yytext()); return '%';}
    "<"			                    {semantic = new helper(yytext()); return '<';}
    ">"			                    {semantic = new helper(yytext()); return '>';}
    "^"			                    {semantic = new helper(yytext()); return '^';}
    "|"			                    {semantic = new helper(yytext()); return '|';}
    "?"			                    {semantic = new helper(yytext()); return '?';}
    <<EOF>>                         {return ENDINPUT;}
    {whiteSpace}                    {;}
    [^]                             {;}
    
}


<COMMENT>{
    "*/"                            {yybegin(NORMAL);}
    <<EOF>>                         {return ENDINPUT;}
    [^]      {;}
    
}

<LCOMMENT>{
    [\n]                            {yybegin(NORMAL);}
    <<EOF>>                         {return ENDINPUT;}
    [^]     {;}
    
}

