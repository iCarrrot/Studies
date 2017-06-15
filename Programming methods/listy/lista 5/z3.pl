halve(List,Left,Right):-halve(List,List,Left,Right).
halve(Right,[],[],Right):-!.
halve(Right,[_],[],Right):-!.
halve([H|T],[_,_|Count],[H|Left],Right):-
	halve(T,Count,Left,Right).
