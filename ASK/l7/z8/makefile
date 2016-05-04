Flags = -Og -Wall -Wextra

main: main.o app.o
	gcc $(Flags) -o main main.o app.o
app.o: app.s
	gcc  -c $(Flags) -Og -Wall -Wextra app.s -o app.o
main.o: main.c
	gcc -c $(Flags) main.c -o main.o
clean:
	rm -f main.o app.o main