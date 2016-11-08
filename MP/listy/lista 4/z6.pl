concat_number(Digits, Num):-
	concat_number(Digits, 0, Num).
concat_number([], X, X).
concat_number([H|T], N, X):-
	N1 is (N * 10) + H,
	concat_number(T, N1, X).

sublist(_,[]).

sublist([X|Y], [X|Z]):-
    sublist(Y,Z).

sublist([_|X],Y):-
    sublist(X,Y).

% ?-

% ?-
b(L,A,C,E,P,R,S,U):-
	length(L,7),
	sublist([0,1,2,3,4,5,6,7,8,9],L),
	permutation([A,C,E,P,R,S,U],L),
	U\=0,
	P\=0,
	concat_number([U,S,A],USA),
	concat_number([U,S,S,R],USSR),
	concat_number([P,E,A,C,E],PEACE),
	PEACE is USA+USSR.
%
% % ?-
a(L,W,H,A,T,E,R):-
	length(L,6),sublist([0,1,2,3,4,5,6,7,8,9],L),permutation([W,H,A,T,E,R],L),W\=0,T\=0,concat_number([W,H,A,T],WHAT),concat_number([T,H,A,T],THAT),concat_number([H,E,R,E],HERE),HERE is WHAT + THAT,!.

