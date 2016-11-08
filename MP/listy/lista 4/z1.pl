length1(X,Y):-
	length1(X,Y,0).
length1([],Y,Y).
length1([_|T],Y,N):-
	N\==Y,
	N1 is N+1,
	length1(T,Y,N1),!.
