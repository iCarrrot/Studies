prime(X):-prime(X,[2],2).
prime(X,List,Y):- X <( Y * Y ), member(X,List),!.

prime(X,List,C):-
	member(A,List),
	C1 is C div A,
	C2 is C / A,
	C2 == C1,!,
	C3 is C + 1,
	prime(X,List,C3),!.
prime(X,List,C):-
	append(List,[C],List1),
	prime(X,List1,C),!.
