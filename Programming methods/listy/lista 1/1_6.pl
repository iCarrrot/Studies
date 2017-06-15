con/2.
connection/2.
ran2/2.
con(wroclaw,warszawa).
con(wroclaw,krakow).
con(wroclaw,szczecin).
con(szczecin,lublin).
con(szczecin,gniezno).
con(warszawa,katowice).
con(gniezno,gliwice).
con(lublin,gliwice).
%con(gliwice,wroclaw).

connection(X,Y):-con(X,Z),connection(Z,Y).
connection(X,Y):-con(X,Y).
%con(wroclaw,lublin).
%con(wroclaw,X).
%con(Y,X),con(X,gliwice).
%ran2(X,gliwice).
ran2(X,Y):- con(X,Y);(con(X,Z),con(Z,Y));(con(X,Z),con(Z,W),con(W,Y)).
