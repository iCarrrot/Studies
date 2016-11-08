:- op(200, fx, ~).
:- op(500, xfy, v).
literal(X):-atom(X);(X= ~Z,atom(Z)).
literal( ~( ~X)):- literal(X).
list(X,[X]):- literal(X).
list((Y v Z),[H|T]):-
	Y=H,
	literal(Y),
	list(Z,T).


list2(Clouses,List):-list2(Clouses,List,[]).
list2([H|T],[H2|L],Acc):-
	list(H,[H2]),
	list2(T,L).


convertionLtoC(List, Clauses):-
	convertionLtoC(List, Clauses, []).
convertionLtoC([], X, X).
convertionLtoC([[List,_,From1,From2]|T], Clauses, Acc):-
	%reverse(List, [H | T]),
	create_id(From1, From2, Id),
	list_to_claus(List, C),
	convertionLtoC(T,Clauses, [(C,Id) | Acc]).
