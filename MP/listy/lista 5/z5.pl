merge(X,[],X):-!.
merge([],X,X):-!.
merge([H1|T1],[H2|T2],[H1|W]):-
	H1 =< H2,!,
	merge(T1,[H2|T2],W).
merge([H1|T1],[H2|T2],[H2|W]):-
	merge([H1|T1],T2,W).
get_n(_,0,[]):-!.
get_n([H|List],N,[H|Got]):-
	N1 is N-1,
	get_n(List,N1,Got).
merge_sort([H|_],1,[H]):-!.
merge_sort(List,N,Sorted):-
	N1 is N div 2,
	get_n(List,N1,Left),
	merge_sort(Left,N1,SL),
	N2 is N - N1,
	append(Left,BRight,List),
	get_n(BRight,N2,Right),
	merge_sort(Right,N2,SR),
	merge(SL,SR,Sorted).
