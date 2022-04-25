//fenwick tree


void update(int i,int val,int bit[],int n)
{
    while(i<=n)
    {
        bit[i]+=val;
        i+=i&(-i);
    }
    return;
}

int query(int i,int bit[])
{
    int res=0;
    while(i>0)
    {
        res+=bit[i];
        i-=i&(-i);
    }
    return res;
}

int main()
{
    int n=1e6;
    int i=0;
    int bit[n+1];
    int arr[]={1,2,3,4,5,6,7};

    for(i=1;i<=n;i++)
    {
        bit[i]=0;
    }

    for(i=0;i<sizeof(arr)/sizeof(int);i++)
    {
        update(i+1,arr[i],bit,n);
    }
    return 0;
}