fill([]).
fill([0|X]):-
	fill(X).
fill([1|X]):-
	fill(X).

listMaker([_]).
listMaker([_|Y]):-
	listMaker(Y).


bin([0]).
bin([1]).
bin([1|X]):-
	listMaker(X),
	fill(X).


rfill([1]).
rfill([0|X]):-
	rfill(X).
rfill([1|X]):-
	rfill(X).

rbin([0]).
rbin(X):-
	listMaker(X),
	rfill(X).
