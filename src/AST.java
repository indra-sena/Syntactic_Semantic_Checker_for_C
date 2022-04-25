import java.util.*;
import java.io.*;

public class AST extends type{
    int nodeId = 0;

    int getNodeId()
    {
        nodeId++;
        return nodeId;
    }

    void BeginGraph()
    {
        System.out.println("digraph G{");
    }

    void EndGraph()
    {
        System.out.println("}");
    }

    // node add(String str, node x1=null, node x2=null, node x3=null, node x4=null)
    helper add(helper... args) {
        helper n = new helper(new node());
        node nd = n.nd;
        nd.is_union = 2;
        // String s = "";
        String str = args[0].str;

        node x1 = null, x2 = null, x3 = null, x4 = null;

        if(args.length >= 2){
            x1 = args[1].nd;
            if(args.length >= 3){
                x2 = args[2].nd;
                if(args.length >= 4){
                    x3 = args[3].nd;
                    if(args.length >= 5){
                        x4 = args[4].nd;
                    }
                }
            }
        }

        // // ------- shouldn't k start with 0? ----------
        // // ------- k = 0 didn't worked (smile in pain). but why? ------------
        // int k = 1;
        // for (helper arg : args) {
        //     if (k == 1)
        //         x1 = arg.nd;
        //     else if (k == 2)
        //         x2 = arg.nd;
        //     else if (k == 3)
        //         x3 = arg.nd;
        //     else if (k == 4)
        //         x4 = arg.nd;
        //     else
        //         break;
        //     k++;
        // }

        // if (x1 == null) {
        //     // for (int i = 0; i < str.length(); i++) {
        //     //     // if (str.charAt(i) == '\\') {
        //     //     //     s += '\\';
        //     //     // }
        //     //     s += str.charAt(i);
        //     // }

        //     s = str;
        // }


        // --------- test this; what does this do -------------
        if (str.charAt(0) == '"') {
            // str = "\\\"" + s.substring(1, s.length() - 1) + "\\\"";
            str = "\\\"" + str.substring(1, str.length() - 1) + "\\\"";
        }

        nd.name = str;
        nd.id = getNodeId();

        System.out.println("\t" + nd.id + " [label=\"" + nd.name + "\"; style=filled; color=\"#cfe2f3\"];");

        if (x1 != null)
            System.out.println("\t" + nd.id + " -> " + x1.id + ";");
        if (x2 != null)
            System.out.println("\t" + nd.id + " -> " + x2.id + ";");
        if (x3 != null)
            System.out.println("\t" + nd.id + " -> " + x3.id + ";");
        if (x4 != null)
            System.out.println("\t" + nd.id + " -> " + x4.id + ";");

        return n;
    }

}