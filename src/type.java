import java.util.*;

public class type extends symtable{

    // String s;

    boolean isInt(String t)
    {
        if(t.equals("int") || t.equals("long") || t.equals("long long") || t.equals("long long int") || t.equals("long int")) return true;
        if(t.equals("signed int") || t.equals("signed long") || t.equals("signed long long") || t.equals("signed long long int") || t.equals("signed long int")) return true;
        if(t.equals("unsigned int") || t.equals("unsigned long") || t.equals("unsigned long long") || t=="unsigned long long int" || t.equals("unsigned long int")) return true;
        if(t.equals("short") || t.equals("short int") || t.equals("signed short") || t.equals("unsigned short") || t.equals("unsigned short int") || t.equals("signed short int")) return true;
        return false;
    }


    boolean isFloat(String t)
    {
    if(t.equals("float") || t.equals("double") || t.equals("long double") || t.equals("unsigned float") || t.equals("unsigned double") ) return true;
    if(t.equals("unsigned long double") || t.equals("signed float") ||t.equals("signed double") || t.equals("signed long double")) return true;
    return false;
    }


    boolean isNum(String t)
    {
        return isInt(t) || isFloat(t);
    }


    String postfix(String t, int num)
    {
        if(num==1)  // postfix_expression '[' expression ']' 
        {
            if(t.charAt(t.length()-1)=='*')
            {
                // ArrayList<Character> temp = new ArrayList<Character>();
                // int temp_len = t.length()-1;
                // for(int i=0; i<temp_len; i++){
                //     temp.add(t.charAt(i));
                // }
                // t = Arrays.toString(temp.toArray()); 
                return t.substring(0,t.length()-1);
            }
            return "";
        }
        if (num==3)
        { // postfix_expression INC_OP/DEC_OP
            if(isInt(t))
            {
                return t;
            } 
            return "";
        }
        return t;

    }


    String validAssign(String t1, String t2)
    {
        if(t1.equals("") || t2.equals("")) return "";
        if(t1.equals(t2)) return "true";
        if((isNum(t1) || t1.equals("char")) && isNum(t2)|| t1.equals("char")) return "true";
        if(t1.charAt(t1.length()-1)=='*' && isInt(t2)) return "warning";
        if(t2.charAt(t2.length()-1)=='*' && isInt(t1)) return "warning";
        if(t1.equals("void*") && t2.charAt(t2.length()-1)=='*') return "true";
        if(t2.equals("void*") && t1.charAt(t1.length()-1)=='*') return "true";
        if(t1.charAt(t1.length()-1)=='*' && t2.charAt(t2.length()-1)=='*') return "void*";
        return "";
    }

    String func_check(String user_arg, String func_arg){
        if(user_arg.equals(func_arg)) return "";
        String s;
        ArrayList<String> v1 = new ArrayList<String>();
        ArrayList<String> v2 = new ArrayList<String>();
        String x = "";
        for(int i=0;i<user_arg.length();i++)
        {
            if(user_arg.charAt(i)==','){
                v1.add(x);
                x="";
            }
            else x+=user_arg.charAt(i);
        }
        if(!x.equals("")) v1.add(x);
        x = "";
        for(int i=0;i<func_arg.length();i++)
        {
            if(func_arg.charAt(i)==','){
                v2.add(x);
                x = "";
            }
            else x += func_arg.charAt(i);
        }
        if(!x.equals("")) v2.add(x);
        if(v1.size()>v2.size())
        {
            s = "Error: too many arguments are provided to function";
            return s;
        }
        else if(v1.size()<v2.size())
        {
            s="Error:  few arguments are provided to function";
            return s;
        }
        boolean warn=false;
        for(int i=0;i<v1.size();i++)
        {
            if(validAssign(v1.get(i),v2.get(i))==""){
                s= "Error: invalid type of arguments to function";
                return s;
            }
            else if(validAssign(v1.get(i),v2.get(i))=="warning") warn=true;
        }
        if(warn){
            s = "Warning: function call with incompatible type ";
            return s;
        }
        return "";
    }

    String unary(String t, String op){
        if(op.equals("&")) return t+"*";
        if(op.equals("*")) return postfix(t,1);
        if(op.equals("+")) {
            if(!isNum(t)) return "";
        }
        if(op.equals("-")){
            if(!isNum(t)) return "";
        }
        if(op.equals("~")){
            if(!isInt(t) && !t.equals("bool")) return "";
        }
        if(op.equals("!")){
            if(!isInt(t) && !t.equals("bool")) return "";
        }
        return t;
    }
    
    String multiply(String t1, String t2, char op)
    {
        if(isNum(t1) && isNum(t2))
        {
            if(isInt(t1) && isInt(t2)) return "int";
            if(op=='*' || op=='/') return "float";
        }
        return "";
    }

    String addition(String t1, String t2)
    {
        if(isNum(t1) && isNum(t2))
        {
            if(isInt(t1) && isInt(t2)) return "int";
            return "float";
        }

        else if(t1.equals("char") && isInt(t2)) return "char";
        else if(t2.equals("char") && isInt(t1)) return "char";
        else if(t1.charAt(t1.length()-1)=='*' && isInt(t2)) return t1;
        else if(t2.charAt(t2.length()-1)=='*' && isInt(t1)) return t2;
        else return "";

    }

    String relational(String t1, String t2)
    {
        // System.err.println("$$$$ "+ t1 + " $$$$ "+ t2);
        if(isNum(t1) || t1.equals("char"))
        {
            
            if(isNum(t2) || t2.equals("char")){
                
                return "bool";
            } 
            else if(t2.charAt(t2.length()-1)=='*'){
                if(isFloat(t1)) return "";
                return "Bool";
            }
        }
        if(t1.charAt(t1.length()-1)=='*'){
            if(isInt(t2) || t2.equals("char")) return "Bool";
        }
        return "";
    }


    String equality(String t1,String t2)
    {
        if(t1.equals(t2)) return "bool";
        if((isNum(t1) || t1.equals("char")) && isNum(t2)|| t1.equals("char")) return "bool";
        if(t1.charAt(t1.length()-1)=='*' && isInt(t2)) return "Bool";
        if(t2.charAt(t2.length()-1)=='*' && isInt(t1)) return "Bool";
        return "";
    }

    String bitwise(String t1, String t2)
    {
        if(t1.equals("bool") && t2.equals("bool")) return "bool";
        if((isInt(t1) || t1.equals("bool")) && (isInt(t2) || t2.equals("bool"))) return "Bool";
        return "";
    }

    String condition(String t1, String t2)
    {

        if(t1.equals(t2))
        {
            if(isInt(t1)) return "long long";
            if(isFloat(t1)) return "long double";
            return t1;
        }
        if(t1.charAt(t1.length()-1)=='*' && t2.charAt(t2.length()-1)=='*') return "void*";
        return "";
    }

    String assign(String t1, String t2, String op)
    {
        // System.err.println("1 " + t1 + " 2 " + t2 + " 3 " + op);
        if(op.equals("=")){
            return validAssign(t1,t2);
        }
        if(op.equals("*=") || op.equals("/=") || op.equals("%=")){
            return multiply(t1, t1, op.charAt(0));
        }
        if(op.equals("+=") || op.equals("-=") ){
            return addition(t1,t2);
        }
        if(op.equals(">>=") || op.equals("<<=") ){
            if(isInt(t1) && isInt(t2)) return "true";
            else return "";
        }
        if(op.equals("&=") || op.equals("^=") || op.equals("|=") ){
            return bitwise(t1,t2);
        }
        return "";
    }
}