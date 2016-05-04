#include <stdio.h>
#include <stdlib.h>

typedef struct{
	unsigned long nww,nwd;
} result_t;

extern result_t nww_nwd(unsigned long x,unsigned long y);

int main(int argc, char* args[]){
	long x,y;
	if(argc != 3){
		fprintf(stderr,"Blad, zle dane!\n");
		return 1;
	}
	sscanf(args[1], "%ld", &y);
	sscanf(args[2], "%ld", &y);	
	result_t res = nww_nwd(x,y);
	printf("nww:%lu\tnwd:%lu\n",res.nww,res.nwd);
	
	return 0;
}
