public class helper {
    public String str;
    public node nd;

    helper(String str) {
        this.str = str;
        nd = null;
    }

    helper(node nd) {
        this.nd = nd;
        str = null;
    }
}
