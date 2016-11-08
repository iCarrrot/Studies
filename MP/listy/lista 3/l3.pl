
%1
permutacja(X,Y):- var(X), permutacja(Y,X).

permutacja([],[]).
permutacja([H|T],X):-
	var(X),
	permutacja(T,Y),
	select(H,X,Y).




%2
exp(0,0,0):-!.
exp(0,_,0):-!.
exp(_,0,1):-!.
exp(Base, Exp, Res):-
	Exp1 is Exp-1,
	exp(Base,Exp1,Res1),
	Res is Res1*Base,!.

count(_,[],0).
count(X,[X],1).
count(X,[H],0):-X\=H.
count(Elem, [H|T], Count):-
	count(Elem,[H],A),
	count(Elem,T,B),
	Count is A+B,!.

/*
count1(_,[],0).
count1(H,[H|T],Count):-
	count1(H,T,PrevCount),
	Count is PrevCount +1,!.
count1(Elem, [_|T],Count):-
	count1(Elem,T,Count).

*/

filter([],[]).
filter([X],[X]):- X >=0.
filter([X],[]):- X < 0.
filter([H|T],X):-
	filter([H],A),
	filter(T,B),
	append(A,B,X),!.

%3
factorial(0,1).
factorial(N, M):-
	N1 is N-1,
	factorial(N1,M1),
	M is N*M1,!.

concat_number(Digits, Num):-
	concat_number(Digits, 0, Num).
concat_number([], X, X).
concat_number([H|T], N, X):-
	N1 is (N * 10) + H,
	concat_number(T, N1, X).

decimal(X,[X]):-X1 is X mod 10, X1 = X.
decimal(Num, X):-
	B is Num mod 10,
	Num1 is Num // 10,
	append(A,[B],X),
	decimal(Num1,A),!.

%4
find_min([H], H).
find_min([H|T], X) :- find_min(T, Y), Y<H, !, X is Y.
find_min([H|T], X) :- find_min(T, Y), H=<Y, X is H.

select_min(List,Min,Rest):-find_min(List,Min),select(Min,List,Rest),!.

ssort([],[]).
ssort(L,[H|T]):-select_min(L,H,Rest),ssort(Rest,T),!.

%select_min([],_,[]).
%select_min([X],X,[]).
% select_min([H|T],X,R):- select_min(T,Y,_),Y<H,!,X is
% Y,select([X],[H|T],R) .
% select_min([H|T],X,R):-
%select_min(T,Y,_),Y>=H,X is  H,select([X],[H|T],R) .


%5
insert([],H,[H]).
insert([H|L],Elem, Res):-
	Elem=<H, !,
	append([Elem],[H|L],Res).
insert([H|L],Elem, Res):-
	insert(L,Elem,Res1),
	append([H],Res1,Res).
isort([],[]).
isort([H|T],R):-
	isort(T,R1),
	insert(R1,H,R).
%6
%w sumie to �le jest
reverse1(X,Y) :-
	reverse1(X,[],Y),!.

reverse1(X,Y):-reverse1(Y,X).

reverse1([],A,A).
reverse1([H|T],A,Y) :-
	reverse1(T,[H|A],Y).