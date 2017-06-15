#include <stdio.h>
#include <stdlib.h>

extern unsigned long fib(unsigned long a);

int main(int argc, char* args[]){
	unsigned long x;
	if(argc != 2){
		fprintf(stderr,"blad:zle dane!\n");
		return 1;
	}
	sscanf(args[1], "%lu", &x);	
	a= fib(x);
	printf("%lu\n", x );
	
	return 0;
}
