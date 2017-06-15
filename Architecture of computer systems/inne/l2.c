#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <limits.h>


int main()
{
//int8_t x=-129;
//printf("%d",x);
int a=0;
int8_t x=-50;
int8_t b,c,d,e;

while (a<2*128+20){
uint8_t y=(uint8_t)x;
    printf ("y=%d,x=%d\n", y,x);
    if ((x>0||-x>=0)==0){
       // printf("b:%d, c=%d, d=%d\n",b,c,d);
        printf ("x:%d\n",x);
    }

    x++;
    a++;
}

    return 0;
}
