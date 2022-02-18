#include<stdlib.h>
struct point
{
    int x;
};


int main(){
    /*distance between points*/

    //point a
    struct point a[6];
    struct point b;
    *(a+2).x = 1;
    
    b.x = 3;

    //distance
    printf("%d\n", b.x - a[2].x);

    return 0;
}