struct xyz{
    int x;
    int y;
}; 

int main(){
    struct xyz temp;
    int i;
    temp.x=0; temp.y=0;
    for( i = 0; i < 5; i++){
        if(i%2!=0)
        {
            temp.y++;
        }
        else temp.x++;
    }
    return 0;
}