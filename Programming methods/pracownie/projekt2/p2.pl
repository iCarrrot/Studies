:- op(200, fx, ~).
:- op(500, xfy, v).

literal( ~( ~X)):- literal(X).
literal(X):-atom(X);(X= ~Z,atom(Z)).
list(X,[X]):- literal(X).
list((Y v Z),[H|T]):-
	Y=H,
	literal(Y),
	list(Z,T),!.


zapytanie([L,X):-list(L,X),zapytanie(L,X,[]).
zapytanie(_, P v (~P)):-literal(P).
zapytanie(W,L,A):-
	member(X,L),
	atom(X),
	member(Y,L),
	Y= ~
