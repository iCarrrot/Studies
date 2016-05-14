/*assemble(CharCodeList,Exit):-
	parse(CharCodeList,(Dec,Tree)),
	var_list(Dec,Vars),
	instructions(Tree, List,Number).*/

assembly(CharCodeList,Exit):-
	parse(CharCodeList,(Vars,Tree)),
	var_list(Vars,Var_list),
	%write(Tree),
	instructions(Tree, List,End),
	%write(List),
	End_of_program=[const, num(0),syscall],
	append(List,End_of_program,List2),
	czysc([const,num(65535),swapa,const,num(65533),store|List2],Czysta),
	%write(Czysta),
	podstaw(Czysta,Podstawiona,End),
	make_fours(Podstawiona,Exit,0,Plength),
	make_adress
	/*write(Czworki),
	slownik_etykiet(Czworki,Dic),
	write(Dic),
	zamiana_etykiet(Czworki,Dic,_)*/
	.
	%write(Exit)
	%Exit=List

var_list(EnterL,List):-flatten(EnterL,List).
make_adress(Plength,[H|List],[H2|List2]):-
	P2 is Plength+1,
	H2=[H,P2],
	make_adress(P2,List,List2).
make_adress(_,[],[]).

zamiana_etykiet([H|List],Dic,[H1|Exit]):-
	H=[lin(L),where_jump(X)],!,
	member([num(A),here_jump(X)],Dic),
	H1=[lin(L),num(A)],
	zamiana_etykiet(List,Dic,Exit),!.

zamiana_etykiet([H|List],Dic,[H|Exit]):-
	zamiana_etykiet(List,Dic,Exit),!.
zamiana_etykiet([],_,[]):-!.

slownik_etykiet([H|List],[H1|Dic]):-
	H=[lin(X),here_jump(A)|_],!,
	H1=[num(X),here_jump(A)],
	slownik_etykiet(List,Dic).
slownik_etykiet([_|List],Dic):-
	slownik_etykiet(List,Dic),!.
slownik_etykiet([],[]).



make_fours([],[],X,X):-!.	

make_fours(Lista,Exit,N,NumberBack):- 
	czworka(Lista,Exit3,X,4,End),
	drop(X,Lista,Lista2),
	L=[lin(N)|Exit3],
	N1 is N +1,
	sep(End,N1,NB,End2),
	make_fours(Lista2,Exit2,NB,NumberBack),

	append([L|End2],Exit2,Exit).




sep([H|List],N,NB,[[lin(N),H]|List2]):-
	N1 is N + 1,
	sep(List,N1,NB,List2),!.
sep([],N,N,[]):-!.



czworka([H|Lista],Exit,X,Y,End):-
	(H=here_jump(_),Y=4),!,
	Exit=[H|Exit2],
	czworka(Lista,Exit2,X1,Y,End),
	X is X1 +1.

czworka([H|_],Exit,X,Y,End):-
	H=here_jump(_),!,
	X =0,
	noping(Y,Exit),
	End=[].

czworka([H|_],[H|Exit],X,Y,End):-
	H=branchz,Y=\=0,!,
	Y1 is Y-1,
	X =1,
	noping(Y1,Exit),
	End=[].

czworka([H|_],[H|Exit],X,Y,End):-
	H=jump,Y=\=0,!,
	Y1 is Y-1,
	X =1,
	noping(Y1,Exit),
	End=[].

czworka([H|_],[H|Exit],X,Y,End):-
	H=branchn,Y=\=0,!,
	Y1 is Y-1,
	X =1,
	noping(Y1,Exit),
	End=[].

czworka([H1,H2|Lista],Exit,X,Y,End):-
	H1=const,Y=\=0,!,
	Y1 is Y-1,
	czworka(Lista,Exit1,X1,Y1,End1),
	X is X1+2,
	End=[H2|End1],
	Exit=[H1|Exit1].

czworka([H|Lista],Exit,X,Y,End):-
	Y=\=0,!,
	Y1 is Y-1,
	czworka(Lista,Exit2,X1,Y1,End),
	X is X1 + 1,
	Exit=[H|Exit2].

czworka([],Exit,0,Y,[]):-
	noping(Y,Exit),Y=\=0,!.
czworka(_,[],0,0,[]).
noping(C,List):-
	C < 1,!,
	List=[].

noping(C,List):-
	C =1,!,
	List=[nop].

noping(C,List):-
	C =2,!,
	List=[nop,nop].

noping(C,List):-
	C=3,
	List=[nop,nop,nop].

instructions(X,Y,Z):-instructions(X,Y,1,Z).

podstaw([H|T],Exit,Number):-
	H=pop,!,
	List=[const, num(65535),swapa,load,swapd,swapa,const,num(1),add,swapa,swapd,const,num(65535),swapa, store,swapd,swapa,const, num(1),swapd,sub,swapa,swapd,load],
	podstaw(T,Exit2,Number),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=push,!,
	List=[swapd,const,num(65535),swapa,load,swapd,swapa,const,num(1),swapd,sub,swapa,store,const,num(65535),swapa,store],
	podstaw(T,Exit2,Number),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=lt,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	End is Number +5,
	List=[swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E3),swapa,jump,here_jump(E2),const,where_jump(End),swapa,const,num(0),jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapa, const,num(1),jump,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,const,where_jump(End),swapa,const,num(0),jump,here_jump(E4),const,num(1),here_jump(End)],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=gt,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	End is Number +5,
	List=[swapd,swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E3),swapa,jump,here_jump(E2),const,where_jump(End),swapa,const,num(0),jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapa, const,num(1),jump,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,const,where_jump(End),swapa,const,num(0),jump,here_jump(E4),const,num(1),here_jump(End)],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=leq,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	End is Number +5,
	List=[swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E3),swapa,jump,here_jump(E2),const,where_jump(End),swapa,const,num(0),jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapa, const,num(1),jump,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,branchz,const,where_jump(End),swapa,const,num(0),jump,here_jump(E4),const,num(1),here_jump(End)],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=geq,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	End is Number +5,
	List=[swapd,swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E3),swapa,jump,here_jump(E2),const,where_jump(End),swapa,const,num(0),jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapa, const,num(1),jump,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,branchz,const,where_jump(End),swapa,const,num(0),jump,here_jump(E4),const,num(1),here_jump(End)],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=neq,!,
	E1 is Number +1,
	End is Number +2,
	List=[swapa,const,where_jump(E1),swapa, sub,branchz,const,where_jump(End),swapa,const,num(1),jump,here_jump(E1),const,num(0),here_jump(End)],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=eq,!,
	E1 is Number +1,
	End is Number +2,
	List=[swapa,const,where_jump(E1),swapa, sub,branchz,const,where_jump(End),swapa,const,num(0),jump,here_jump(E1),const,num(1),here_jump(End)],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],[H|Exit],Number):-
	podstaw(T,Exit,Number).

podstaw([],[],_).

take(0, _, []) :- !.
take(N, [H|TA], [H|TB]) :-
 	N > 0,
 	N2 is N - 1,
 	take(N2, TA, TB).

drop(0,LastElements,LastElements) :- !.
drop(N,[_|Tail],LastElements) :-
	N > 0,
	N1 is N  - 1,
 	drop(N1,Tail,LastElements).
