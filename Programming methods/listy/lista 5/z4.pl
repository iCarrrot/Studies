merge(X,[],X):-!.
merge([],X,X):-!.
merge([H1|T1],[H2|T2],[H1|W]):-
	H1 =< H2,!,
	merge(T1,[H2|T2],W).
merge([H1|T1],[H2|T2],[H2|W]):-
	merge([H1|T1],T2,W).

halve1(List,Left,Right):-halve1(List,List,Left,Right).
halve1(Right,[],[],Right):-!.
halve1(Right,[_],[],Right):-!.
halve1([H|T],[_,_|Count],[H|Left],Right):-
	halve1(T,Count,Left,Right).

merge_sort([],[]):-!.
merge_sort([X],[X]):-!.
merge_sort(List,Sorted):-
	halve1(List,Left,Right),
	merge_sort(Left,SLeft),
	merge_sort(Right,SRight),
	merge(SLeft,SRight,Sorted).
