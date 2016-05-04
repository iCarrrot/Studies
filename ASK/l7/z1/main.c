#include <stdio.h>
#include <stdlib.h>

extern int fun(long a);

int main(int argc, char* args[]){
	long a,b;
	if(argc != 2){
		fprintf(stderr,"Zle dane wejscia, plik liczba\n");
		return 1;
	}
	sscanf(args[1], "%lx", &a);
	printf("%d\n", fun(a) );
	
	return 0;
}
