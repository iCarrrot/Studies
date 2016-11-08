if_list([_|_]).

flatt(X,Y):-flatt(X,Y,[]).

flatt([],Y,Y).

flatt([H|T],Y,Acc):-
	if_list(H),!,
	flatt(H,H1),
	append(Acc,H1,Z),
	flatt(T,Y,Z).

flatt([H|T],Y,Acc):-
	append(Acc,[H],S),
	flatt(T,Y,S).