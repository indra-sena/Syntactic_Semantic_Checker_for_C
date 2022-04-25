//testing data types and operations

typedef unsigned char BYTE;

struct point{
    int x;
    int y;
};

static int num = 6;
extern int var;
int k = 9;

int main(){
    int a = 5;
    int b = 5;
    char c = 'c';
    double d1 = 7.0000000;
    double d2 = 7.3e-10;
    double d3 = 7.3e11;
    unsigned int e = 11;
    short f = 12;
    long g = 133333;
    int arr[5] = {1,2,3,4,5};

    auto x = 7;


    int k = a++;
    b-=a;
    a+=b;
    a*=b;
    a/=b;
    a--;
    --a;
    ++b;

    //binary operators


    a = a|b;
    b = a&b;
    e = a^b;
    e = ~a;
    return 0;
}