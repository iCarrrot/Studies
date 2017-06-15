put_s(E,S,[E|S]).
get_s([H|T],H,T).
empty_s([]).
addall_s(E,G,S,R):-
	findall(E,G,L),
	append(L,S,R).
empty(X-X).
get([H|T]-X,H,T-X).
put(E,X-[E|Y],X-Y).
addall(E, Goal, S, R):-
	findall(E,Goal, W),
	append_f(W,S,R).
append_f([],S,S).
append_f([H|T],S,W):-
	put(H,S,NS),
	append_f(T,NS,W).
