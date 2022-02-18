struct point
{
    int x;
};


int main(){
    /*distance between points*/
    
    struct point a[6];
    struct point b;
    *(a+2).x = 1;

    
    
    b.x = 3;

    //distance
    printf("%d\n", b.x - a[2].x);

    return 0;
}