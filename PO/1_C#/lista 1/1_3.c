#include "zespolone.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(){
  // double r=2.0;
  //  double i=3.0;
Zespolone a=zes(20.0,32.0);
Zespolone b=zes(4.0,4.0);

dod2(&a,&b);
printz(b);
b=zes(4.0,4.0);
a=zes(20.0,32.0);
printz(*dod(a,b));

od2(&a,&b);
printz(b);
b=zes(4.0,4.0);
a=zes(20.0,32.0);
printz(*od(a,b));

mn2(&a,&b);
printz(b);
b=zes(4.0,4.0);
a=zes(20.0,32.0);
printz(*mn(a,b));

dziel2(&a,&b);
printz(b);
b=zes(4.0,4.0);
a=zes(20.0,32.0);
printz(*dziel(a,b));

return 0;}
