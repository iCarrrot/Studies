leaf.
tree(leaf)  --> [*] , ! .
tree(node(A,B)) -->
					['('],
					tree(A),
					tree(B),
					[')'].
/*
?- phrase ( t r e e ( node ( node ( l e a f , l e a f ) , l e a f ) ) ,
[ ’ ( ’ , ’ ( ’ ,  ,  , ’ ) ’ ,  , ’ ) ’ ] ) */
% Pr zyk lad uz y c i a :
