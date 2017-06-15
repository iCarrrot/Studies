#include <iostream>
using namespace std;
void rot (int a)
{
}
void fd (int a)
{
}
int H (int n, int i)
{
    if (n==0)
    {
        return 0;
    }
    else
    {
        if (n%2)
        {
            rot (90);
        }
     H (n-1,-1*i);
     fd;
     H (n-1,1);
     rot (90*i)
    fd;
    H (n-1,1);
     rot (90*i)
     fd;
     H (n-1, -1*i);
    }
}
int main ()
{
    cout<<"a";
    return 0;
}
