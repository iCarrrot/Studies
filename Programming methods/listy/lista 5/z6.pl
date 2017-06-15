merge(X,[],X):-!.
merge([],X,X):-!.
merge([H1|T1],[H2|T2],[H1|W]):-
	H1 =< H2,!,
	merge(T1,[H2|T2],W).
merge([H1|T1],[H2|T2],[H2|W]):-
	merge([H1|T1],T2,W).
lists([],[]):-!.
lists([H|L],[[H]|T]):-
	lists(L,T).

msort1(List,Srtd):-
	lists(List,Listd),
	mc(Listd,Srtd),!.
mc(L,S):-
	mc(L,S,[]).

mc([],S,[S]):-!.
mc([X],S,Acc):-
	mc([X|Acc],S,[]).
mc([],S,Acc):-
	mc(Acc,S,[]).

mc([L1,L2|T],S,Acc):-
	merge(L1,L2,X),
	mc(T,S,[X|Acc]).
