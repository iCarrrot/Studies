con/2.
connection/2.
ran2/2.
con(wroclaw,warszawa).
con(wroclaw,krakow).
con(wroclaw,szczecin).
con(wroclaw,katowice).
con(katowice,warszawa).
con(wroclaw,gliwice).
con(szczecin,lublin).
con(szczecin,gniezno).
con(warszawa,katowice).
con(gniezno,gliwice).
con(lublin,gliwice).
con(gliwice,wroclaw).

connection(X,Y):-con(X,Z),connection(Z,Y).
connection(X,Y):-con(X,Y).
ran2(X,Y):- con(X,Y);(con(X,Z),con(Z,Y));(con(X,Z),con(Z,W),con(W,Y)).


trip(So,Des,[So|R]):-trip(So,Des,R,[Des]).
trip(X,Y,T,T):-
	con(X,Y).
trip(X,Y,T,Z):-
	con(W,Y),
	\+ member(W,Z),
	trip(X,W,T,[W|Z]).


