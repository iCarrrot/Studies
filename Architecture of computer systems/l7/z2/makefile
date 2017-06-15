
Flags = -Og -Wall -Wextra

z2: z2.o nww_nwd.o
	gcc $(Flags) -o z2 z2.o nww_nwd.o
nww_nwd.o: nww_nwd.s
	gcc  -c $(Flags) -Og -Wall -Wextra nww_nwd.s -o nww_nwd.o
z2.o: z2.c
	gcc -c $(Flags) z2.c -o z2.o
clean:
	rm -f z2.o nww_nwd.o z2