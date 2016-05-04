Flags = -Og -Wall -Wextra

main: main.o fun.o
	gcc $(Flags) -o main main.o fun.o
fun.o: fun.s
	gcc  -c $(Flags) -Og -Wall -Wextra fun.s -o fun.o
main.o: main.c
	gcc -c $(Flags) main.c -o main.o
clean:
	rm -f main.o fun.o main