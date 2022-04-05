import java.util.*;
import java.io.*;

public class AST {
    int nodeId = 0;

    int getNodeId() {
        nodeId++;
        return nodeId;
    }

    void BeginGraph() {
        System.out.println("digraph G{");
    }

    void EndGraph() {
        System.out.println("}");
    }

    // node add(String str, node x1=null, node x2=null, node x3=null, node x4=null)
    helper add(helper... args) {
        helper n = new helper(new node());
        node nd = n.nd;
        nd.is_union = 2;
        String s = "";
        String str = args[0].str;

        node x1 = null, x2 = null, x3 = null, x4 = null;

        int k = 1;
        for (helper arg : args) {
            if (k == 1)
                x1 = arg.nd;
            else if (k == 2)
                x2 = arg.nd;
            else if (k == 3)
                x3 = arg.nd;
            else if (k == 4)
                x4 = arg.nd;
            else
                break;
            k++;
        }

        if (x1 == null) {
            for (int i = 0; i < str.length(); i++) {
                // if (str.charAt(i) == '\\') {
                //     s += '\\';
                // }
                s += str.charAt(i);
            }
        }

        if (str.charAt(0) == '"') {
            str = "\\\"" + s.substring(1, s.length() - 1) + "\\\"";
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