flatten1(leaf,[]).
flatten1(node(X,V,Z),T):-
	flatten1(X,XT),
	flatten1(Z,ZT),
	append(XT,[V|ZT],T).


insert1(leaf,X,node(leaf,X,leaf)).
insert1(node(Left,Val,Right),El,node(Left,Val,InsRight)):-
	El>=Val,
	insert1(Right,El,InsRight).
insert1(node(Left,Val,Right),El,node(InsLeft,Val,Right)):-
	El<Val,
	insert1(Left,El,InsLeft).


treesort(L,Sl):-
	treesort(L,STree,leaf),
	flatten1(STree,Sl),!.
treesort([],X,X).
treesort([H|T],STree,X):-
	insert1(X,H,Z),
	treesort(T,STree,Z).
zrob_liste([_]).
zrob_liste([_|Y]):-
  zrob_liste(Y).



