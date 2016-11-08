appn(X,Y):-appn(X,Y,[]).
appn([],Y,Y).
appn([H|T],Y,Exit):-
	append(Exit,H,Z),
	appn(T,Y,Z).
