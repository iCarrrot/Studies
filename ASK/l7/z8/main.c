#include <stdio.h>
#include <stdlib.h>

double app_sqrt(double x, double e);

int main(int argc, char**argv)
{
	if(argc != 3) return 1;
	double x = atof(argv[1]);
	double e = atof(argv[2]);
	printf("%g\n", app_sqrt(x,e));
	return 0;	
}
