import java.util.*;
import java.io.FileWriter;
import java.io.IOException;

class Pair {
    int first;
    int second;

    Pair(int a, int b) {
        first = a;
        second = b;
    }
}

class symEntry {
    String type;
    int init;

    symEntry(String s, int n) {
        type = s;
        init = n;
    }
}

class symTable_h {
    HashMap<String, symEntry> symTable;

    symTable_h() {
        symTable = new HashMap<String, symEntry>();
    }
}

class struct_table{
    HashMap<String, Pair> struct_table;

    struct_table() {
        struct_table = new HashMap<String, Pair>();
    }
}

public class symtable{

    HashMap <symTable_h, symTable_h> parent = new HashMap<>();
    HashMap <String, String> funcMap = new HashMap<>();
    symTable_h curr_table = new symTable_h();
    symTable_h GST = curr_table;
    struct_table curr_struct_table = new struct_table();
    HashMap <struct_table, struct_table> struct_parent = new HashMap<>();
    HashMap <String, symTable_h> id_to_struct = new HashMap<>();
    static FileWriter Fwrite;
    // String filename = "All_symbolTable.txt";
    HashMap <symTable_h, String> symTable_type = new HashMap<>();
    HashMap <String, String> id_to_struct_name = new HashMap<>();

    static void symtable_2(){
        try{
            // System.err.println("qwer");
            Fwrite = new FileWriter("All_symbolTable.csv");
        }
        catch (IOException e) {
        // System.out.print(e.getMessage());
        }
    }

    static void fileClose(){
        try{
            // System.err.println("qwer");
            Fwrite.close();
        }
        catch (IOException e) {
        // System.out.print(e.getMessage());
        }
    }

    void make_symTable_entry(String name, String type, int init){
        symEntry p = new symEntry(type, init);
        curr_table.symTable.put(name, p);
    }

    void make_symTable_entry2(symTable_h table, String name, String type, int init){
        symEntry p = new symEntry(type, init);
        table.symTable.put(name, p);
    }

    symEntry lookup(String a){
        symTable_h t = curr_table;
        while(t != null)
        {
            if(t.symTable.containsKey(a))
                return t.symTable.get(a);
            
            t = parent.getOrDefault(t, null);
            
            // if(parent.containsKey(t))
            //     t = parent.get(t);
            // else
            //     return null;
        }
        return null;
    }

    symEntry lookup_in_curr(String a){
        return curr_table.symTable.get(a);    // --------- if a is not present, .get(a) returns null --------
        // return (curr_table.symTable.containsKey(a)) ? curr_table.symTable.get(a) : null;
    }

    boolean lookup_in_struct_curr_scope(String a){
        return curr_struct_table.struct_table.containsKey(a);
    }

    int lookup_struct(String name, int is_union){
        struct_table temp = curr_struct_table;
        while(temp != null){
            if(temp.struct_table.containsKey(name) && temp.struct_table.get(name).second == is_union)
                return temp.struct_table.get(name).first;
            else{
                temp = struct_parent.getOrDefault(temp, null);
            }
        }
        return 0;
    }

    void start_new_block(String block_name, String block_type, int sline, int eline) {
        try{
            Fwrite.write("\n_________________________________________________________________,,\n");
            Fwrite.write("      "+ block_name + " with type " + block_type + "  from line " + sline + "  to line " + eline + "        ,,\n");
            Fwrite.write("-----------------------------------------------------------------\n");
        }
        catch (IOException e) {
            // System.out.print(e.getMessage());
        }
    }

    void printSymTable(symTable_h table, String block_name, String block_type, int sline, int eline){
        start_new_block(block_name, symTable_type.get(table), sline, eline);
        try{
            // -------------------need to change this-------------------------------
            // System.err.println("asdf");
            Fwrite.write("str");
            Fwrite.write(String.format("%s,%s,%s\n\n", "Key", "Type", "Is_initialized"));
        }
        catch (IOException e){
            ;
        }
        for (Map.Entry<String, symEntry> it : table.symTable.entrySet()) {
            String type = it.getValue().type;
            if (id_to_struct_name.containsKey(type)) {
                type = id_to_struct_name.get(type);
            }
            try{
                // ----------------------------------need to change this-----------------------------------
                Fwrite.write(String.format("%s,%s,%d\n", it.getKey(), type, it.getValue().init));
            }
            catch (IOException e) {
                ;
            }
        }
    }

    symEntry lookup_in_table(symTable_h table, String name){
        return table.symTable.get(name);    // if name is not present, .get(name) returns null
        // return (table.symTable.containsKey(name)) ? table.symTable.get(name) : null;
    }

    void update_init(String name, int init){
        symEntry find = lookup(name);
        
        if(find == null)
            return;
        
        find.init = init;
    }

    boolean is_struct(String type1){
        if(type1.equals(""))
            return false;
        
        for(char a : type1.toCharArray()){
            if(a < '0' || a > '9')
                return false;
        }
        return true;
    }

    boolean check_type(String type1, String type2) {
        return (is_struct(type1) || is_struct(type2)) ? type1.equals(type2) : true;
    }
    
}