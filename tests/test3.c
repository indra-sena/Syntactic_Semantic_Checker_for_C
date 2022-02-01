struct point
{
    int x;
};


int main(){
    /*distance between points*/

    //point a
    struct point a;
    a.x = 1;

    //point b
    struct point b;
    b.x = 3;

    //distance
    printf("%d\n", b.x - a.x);

    return 0;
}