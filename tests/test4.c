struct abc{
    int a;
    struct abc{
        char c;
    } b;
};

int f(char **f, int *t[]){
    return 1;
}

int main(){
    struct abc p;
    p.a = 5;
    p.b.c = 'q';
    return 0;
}