parent/2.
male/1.
female/1.
sibling/2.
sister/2.
grandson/2.
cousin/2.
des/2.
is_mother/1.
is_father/1.


sibling(X,Y):-parent(Z,X),parent(Z,Y), not(X=Y).
sister(X,Y):- sibling(X,Y),female(X).
grandson(X,Y):-parent(Y,Z),parent(Z,X).
cousin(X,Y):-parent(W,X),parent(Z,Y),sibling(W,Z).
des(X,Y):-parent(X,Z),des(Z,Y).
des(X,Y):- parent(X,Y).
is_mother(X):-female(X),parent(X,_).
is_father(X):-male(X),parent(X,_).

male(adam).
female(eve).
male(john).
female(helen).
male(mark).
female(ivonne).
male(david).
female(ivonne).
male(joshua).
parent(adam, helen).
parent(adam, ivonne).
parent(adam, anna).
parent(eve, helen).
parent(eve, ivonne).
parent(eve, anna).
parent(john, joshua).
parent(helen, joshua).
parent(ivonne,david).
parent(mark,david).


%




