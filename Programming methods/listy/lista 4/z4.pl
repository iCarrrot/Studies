node/3.
leaf/0.
node(leaf,5,node(leaf,6,leaf)).

mirror(leaf,leaf).
mirror(node(X,V,Z),node(Rz,V,Rx)):-
       mirror(X,Rx),
       mirror(Z,Rz).
flatten(leaf,[]).
flatten(node(X,V,Z),T):-
	flatten(X,XT),
	flatten(Z,ZT),
	append(XT,[V|ZT],T).
