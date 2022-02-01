import java.util.*;
// class Yytoken{
//     public int Yytoken,lineNum,colNum;
//     public String lexeme,tName;
//     public Yytoken(int tc,int ln,int cn,String lex,String tnam){
//         this.Yytoken=tc;
//         this.lineNum=ln;
//         this.colNum=cn;
//         this.lexeme=lex;
//         this.tName=tnam;
//     }
// }
// class sym{
//     static AUTO=300;
//     static BREAK=301;

// }




%%
%class lexer
%{
    public static int commentline;
    public static class Yytoken{
        // public int Yytoken,lineNum,colNum;
        // public String lexeme,tName;
        // public Yytoken(int tc,int ln,int cn,String lex,String tnam){
        // this.Yytoken=tc;
        // this.lineNum=ln;
        // this.colNum=cn;
        // this.lexeme=lex;
        // this.tName=tnam;
        // }
    }
    public static void main(String[] argv) {
        commentline=0;
        if (argv.length == 0) {
            System.out.println("Usage : java lexer [ --encoding <name> ] <inputfile(s)>");
        }
        else {
        int firstFilePos = 0;
        String encodingName = "UTF-8";
        if (argv[0].equals("--encoding")) {
            firstFilePos = 2;
            encodingName = argv[1];
            try {
                // Side-effect: is encodingName valid?
                java.nio.charset.Charset.forName(encodingName);
            } catch (Exception e) {
                System.out.println("Invalid encoding '" + encodingName + "'");
                return;
            }
        }
        System.out.println("Yytoken                        Lexeme  Line#   Column#");
        for (int i = firstFilePos; i < argv.length; i++) {
            lexer scanner = null;
            try {
                java.io.FileInputStream stream = new java.io.FileInputStream(argv[i]);
                java.io.Reader reader = new java.io.InputStreamReader(stream, encodingName);
                scanner = new lexer(reader);
                while ( !scanner.zzAtEOF ) scanner.yylex();
            }
            catch (java.io.FileNotFoundException e) {
                System.out.println("File not found : \""+argv[i]+"\"");
            }
            catch (java.io.IOException e) {
                System.out.println("IO error scanning file \""+argv[i]+"\"");
                System.out.println(e);
            }
            catch (Exception e) {
                System.out.println("Unexpected exception:");
                e.printStackTrace();
            }
        }
        }
    }
%}
%unicode
%line
%column
%{
    ArrayList<Yytoken> alLexemes = new ArrayList<Yytoken>();
%}

%init{
    yybegin(NORMAL);
%init}



%state NORMAL COMMENT LCOMMENT CODESTRING

digit = [0-9]
letter = [a-zA-Z_]
hexa = [a-fA-F0-9]
exp = [Ee][+-]?{digit}+
whiteSpace = [ \0\t\v\n\f]
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

    "break"                          {System.out.println("BREAK" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "case"                           {System.out.println("CASE" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "char"                           {System.out.println("CHAR" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "auto"                           {System.out.println("AUTO" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "const"                          {System.out.println("CONST" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "continue"	                     {System.out.println("CONTINUE" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "default"	                     {System.out.println("DEFAULT" + "                  " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "do"		                     {System.out.println("DO" + "                       " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "double"	                     {System.out.println("DOUBLE" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "else"		                     {System.out.println("ELSE" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "enum"		                     {System.out.println("ENUM" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "extern"	                     {System.out.println("EXTERN" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "float"		                     {System.out.println("FLOAT" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "for"		                     {System.out.println("FOR" + "                      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "goto"		                     {System.out.println("GOTO" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "if"		                     {System.out.println("IF" + "                       " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "int"		                     {System.out.println("INT" + "                      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "long"		                     {System.out.println("LONG" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "register"	                     {System.out.println("REGISTER" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "return"	                     {System.out.println("RETURN" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "short"		                     {System.out.println("SHORT" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "signed"	                     {System.out.println("SIGNED" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "sizeof"	                     {System.out.println("SIZEOF" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "static"	                     {System.out.println("STATIC" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "struct"	                     {System.out.println("STRUCT" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "switch"	                     {System.out.println("SWITCH" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "typedef"	                     {System.out.println("TYPEDEF" + "                  " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "union"		                     {System.out.println("UNION" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "unsigned"	                     {System.out.println("UNSIGNED" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "void"		                     {System.out.println("VOID" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "bool"		                     {System.out.println("BOOL" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "volatile"	                     {System.out.println("VOLATILE" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "while"		                     {System.out.println("WHILE" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    {letter}({letter}|{digit})*      {System.out.println("IDENTIFIER" + "               " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    {digit}+{IS}?                    {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    '(\\.|[^\\'])'                   {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    0[xX]{hexa}+{IS}?                {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    {digit}+{exp}{FS}?               {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    {digit}*"."{digit}+{exp}?{FS}?   {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    {digit}+"."{digit}*{exp}?{FS}?   {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    \"(\\.|[^\"])*\"                 {System.out.println("CONSTANT" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ">="                             {System.out.println("Greater_Than_Equal" + "       " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "<="                             {System.out.println("Less_Than_Equal" + "          " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "+="                             {System.out.println("Add_and_Assign" + "           " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "-="                             {System.out.println("Subtract_and_Assign" + "      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "*="                             {System.out.println("Multiply_and_Assign" + "      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "/="                             {System.out.println("Divide_and_Assign" + "        " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "%="                             {System.out.println("Modulo_and_Assign" + "        " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "&="                             {System.out.println("Bitwise_AND_and_Assign" + "   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "|="                             {System.out.println("Bitwise_OR_and_Assign" + "    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "^="                             {System.out.println("Bitwise_XOR_and_Assign" + "   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ">>"                             {System.out.println("Bitwise_Right_Shift" + "      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "<<"                             {System.out.println("Bitwise_Left_Shift" + "       " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "++"                             {System.out.println("Increment" + "                " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "--"                             {System.out.println("Decrement" + "                " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "->"                             {System.out.println("Right_Arrow" + "              " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "&&"                             {System.out.println("Logical_AND" + "              " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "||"                             {System.out.println("Logical_OR" + "               " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "!="                             {System.out.println("Not_Equal" + "                " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "=="                             {System.out.println("Equal" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ";"                              {System.out.println("Semi_Colon" + "               " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "{"                              {System.out.println("Left_Curly_Bracket" + "       " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "}"                              {System.out.println("Right_Curly_Bracket" + "      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ","                              {System.out.println("Comma" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ":"                              {System.out.println("Colon" + "                    " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "="			                     {System.out.println("Assignment" + "               " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "("			                     {System.out.println("Left_Round_Bracket" + "       " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ")"			                     {System.out.println("Right_Round_Bracket" + "      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "["	                             {System.out.println("Left_Square_Bracket" + "      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "]"	                             {System.out.println("Right_Square_Bracket" + "     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "."			                     {System.out.println("Dot" + "                      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "&"			                     {System.out.println("Bitwise_AND" + "              " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "!"			                     {System.out.println("Not" + "                      " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "~"	                             {System.out.println("Bitwise_NOT" + "              " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "-"		                         {System.out.println("Subtraction" + "              " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "+"			                     {System.out.println("Addition" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "*"			                     {System.out.println("Multiplication" + "           " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "/"			                     {System.out.println("Division" + "                 " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "%"			                     {System.out.println("Modulo" + "                   " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "<"			                     {System.out.println("Less_Than" + "                " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    ">"			                     {System.out.println("Greater_Than" + "             " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "^"			                     {System.out.println("Bitwise_XOR" + "              " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "|"			                     {System.out.println("Bitwise_OR" + "               " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}
    "?"			                     {System.out.println("dbsc" + "                     " + '\t' + yytext() + '\t' + yyline + '\t' + yycolumn);}

    {whiteSpace} {;}
    [^] {;}
}


<COMMENT>{
    "*/"   {yybegin( NORMAL );}
    .      {;}
}

<LCOMMENT>{
    [\n]  {yybegin(NORMAL);}
    .     {;}
}

