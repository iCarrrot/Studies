split([],_,[],[]).
split([H|T],M,[H|S],B):-H<M,!,split(T,M,S,B).
split([H|T],M,S,[H|B]):-split(T,M,S,B).
qsor(X,S):-qsor(X,[],S).
qsor([],A,A).
qsor([H|T],A,E):-
	split(T,H,S,B),
	qsor(B,A,S1),
	qsor(S,[H|S1],E).