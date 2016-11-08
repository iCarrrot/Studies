insert(leaf,Value,node(leaf,Value,leaf)).
insert(node(L,V,R),Val,node(L,V,IR)):-
	Val >V,!,
	insert(R,Val,IR).
insert(node(L,V,R),Val,node(IL,V,R)):-
	Val<V,!,
	insert(L,Val,IL).
insert(node(L,V,R),Val,node(L,V,R)):-
	Val == V.
find(El,node(_,V,_)):-
	El==V,!.
find(El,node(_,Val,Right)):-
	El>Val,!,
	find(El,Right).
find(El,node(Left,_,_)):-
	find(El,Left).

findMax(node(_, Value, leaf), Value):- !.
findMax(node(_, _, Right), Max):-
  findMax(Right, Max).
findMin(node(leaf, Value, _), Value):- !.
findMin(node(Left, _, _), Min):-
  findMin(Left, Min).

delMax(Tree,Max,NTree):-
	findMax(Tree,Max),
	delete(Tree,Max,NTree).


delete(_,leaf,leaf):-!.
delete(Value,node(leaf,Value,leaf),leaf):- !.
delete(Value,node(Left,Value,leaf),Left):- !.
delete(Value,node(leaf,Value,Right),Right):- !.
delete(Value,node(Left,Value,Right),node(Left,RightMin,RightWithoutMin)):-
  findMin(Right, RightMin),
  delete(RightMin,Right,RightWithoutMin),
  !.

delete(Element,node(Left,Value,Right),node(Left,Value,ResRight)):-
 Element>Value,!,
 delete(Element,Right,ResRight).

delete(Element,node(Left,Value,Right),node(ResLeft,Value,Right)):-
	Element<Value,!,
	delete(Element,Left,ResLeft),


empty(leaf).
