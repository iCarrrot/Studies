/*assemble(CharCodeList,Exit):-
	parse(CharCodeList,(Dec,Tree)),
	var_list(Dec,Vars),
	instructions(Tree, List,Number).*/





main(FileName):-!,
	readfile(FileName, CharCodeList),
	assembly(CharCodeList,Exit),
	writefile('result',Exit),!
	.



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
	make_fours(Podstawiona,Czworki,0,Plength),
	%write(Czworki),
	make_adress(Plength,Var_list,Var_Dic),
	slownik_etykiet(Czworki,Dic),
	zamiana_etykiet(Czworki,Dic,Po_Et),
	%write(Po_Et),
	zamiana_etykiet_var(Po_Et,Var_Dic,Po_var),
	%write(Po_var),
	na_numerki(Po_var,Decimal),
	printHex(Decimal,Exit)
	.
	%write(Exit)
	%Exit=List

printHex([],[]):-!.
printHex([H|T],[A|Exit]) :-
  format(atom(A),'~|~`0t~16r~4+', H),
  printHex(T,Exit).


na_numerki([H|T],[X2|Exit]):-
	H=[lin(_),num(X)],
	X<0,!,
	X2 is 32768+(32768+X),
	na_numerki(T,Exit),!.

na_numerki([H|T],[X|Exit]):-
	H=[lin(_),num(X)],!,
	na_numerki(T,Exit),!.

na_numerki([H|T],[X|Exit]):-
	take_last(H,4,List),!,
	List=[H1,H2,H3,H4],
	numer_rozkazu(H1,H11),
	numer_rozkazu(H2,H21),
	numer_rozkazu(H3,H31),
	numer_rozkazu(H4,H41),
	X is H11*16*16*16+H21*16*16+H31*16+H41,
	na_numerki(T,Exit),!.
na_numerki([],[]):-!.



var_list(EnterL,List):-flatten(EnterL,List),!.
make_adress(Plength,[H|List],[H2|List2]):-
	P2 is Plength+1,
	H=var(_),
	H2=[num(P2),H],
	make_adress(P2,List,List2).
make_adress(_,[],[]):-!.

zamiana_etykiet([H|List],Dic,[H1|Exit]):-
	H=[lin(L),where_jump(X)],!,
	member([num(A),here_jump(X)],Dic),
	H1=[lin(L),num(A)],
	zamiana_etykiet(List,Dic,Exit),!.

zamiana_etykiet([H|List],Dic,[H|Exit]):-
	zamiana_etykiet(List,Dic,Exit),!.
zamiana_etykiet([],_,[]):-!.


zamiana_etykiet_var([H|List],Dic,[H1|Exit]):-
	H=[lin(L),var(X)],!,
	member([num(A),var(X)],Dic),
	H1=[lin(L),num(A)],
	zamiana_etykiet_var(List,Dic,Exit),!.

zamiana_etykiet_var([H|List],Dic,[H|Exit]):-
	zamiana_etykiet_var(List,Dic,Exit),!.
zamiana_etykiet_var([],_,[]):-!.

slownik_etykiet([H|List],[H1|Dic]):-
	H=[lin(X),here_jump(A)|_],!,
	H1=[num(X),here_jump(A)],
	slownik_etykiet(List,Dic).
slownik_etykiet([_|List],Dic):-
	slownik_etykiet(List,Dic),!.
slownik_etykiet([],[]):-!.



numer_rozkazu(nop,0):-!.
numer_rozkazu(syscall,1):-!.
numer_rozkazu(load,2):-!.
numer_rozkazu(store,3):-!.
numer_rozkazu(swapa,4):-!.
numer_rozkazu(swapd,5):-!.
numer_rozkazu(branchz,6):-!.
numer_rozkazu(branchn,7):-!.
numer_rozkazu(jump,8):-!.
numer_rozkazu(const,9):-!.
numer_rozkazu(add,10):-!.
numer_rozkazu(sub,11):-!.
numer_rozkazu(mul,12):-!.
numer_rozkazu(div,13):-!.
numer_rozkazu(shift,14):-!. 
numer_rozkazu(nand,15):-!. 


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

czworka(_,[],0,0,[]):-!.

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
	E5 is Number +5,
	End is Number +6,
	List=[swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E5),jump,here_jump(E2),const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapd, const,num(1),swapd,jump,here_jump(E5),swapa,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E4),const,num(1),here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=gt,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	E5 is Number +5,
	End is Number +6,
	List=[swapd,swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E5),jump,here_jump(E2),const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapd, const,num(1),swapd,jump,here_jump(E5),swapa,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E4),const,num(1),here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=leq,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	E5 is Number +5,
	End is Number +6,
	List=[swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E5),jump,here_jump(E2),const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapd, const,num(1),swapd,jump,here_jump(E5),swapa,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,branchz,const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E4),const,num(1),here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=geq,!,
	E1 is Number +1,
	E2 is Number +2,
	E3 is Number +3,
	E4 is Number +4,
	E5 is Number +5,
	End is Number +6,
	List=[swapd,swapa, const, where_jump(E1),swapa,branchn,swapd,swapa,const,where_jump(E2),swapa,branchn,swapa,const,where_jump(E5),jump,here_jump(E2),const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E1),swapd,swapa,const,where_jump(E3),swapa,branchn,const,where_jump(End),swapd, const,num(1),swapd,jump,here_jump(E5),swapa,here_jump(E3),swapd,sub,swapd,const,where_jump(E4),swapa,swapd,branchn,branchz,const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E4),const,num(1),here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=neq,!,
	E1 is Number +1,
	End is Number +2,
	List=[swapa,const,where_jump(E1),swapa, sub,branchz,const,where_jump(End),swapd,const,num(1),swapd,jump,here_jump(E1),const,num(0),swapd,here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=eq,!,
	E1 is Number +1,
	End is Number +2,
	List=[swapa,const,where_jump(E1),swapa, sub,branchz,const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E1),const,num(1),here_jump(End),swapd],
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
 	drop(N1,Tail,LastElements),!.

 countin([_|T],N):-
 	countin(T,N1),
 	N is N1+1.
 countin([],0).

 take_last(List,Number,Exit):-
 	countin(List,X),
 	X2 is X-Number,
 	drop(X2,List,Exit),!.



writefile(FileName,List):-
	open(FileName,write,Stream),
	loop(Stream,List),
	close(Stream).

loop(_,[]):-!.
loop(Stream,[H|T]):-
	write(Stream,H),
	write(Stream,' '),
	loop(Stream, T).

writefile2(FileName,List):-
	open(FileName,write,Stream),
	loop2(Stream,List),
	close(Stream).

loop2(_,[]):-!.
loop2(Stream,[num(A)|T]):-!,
	write(Stream,num(A)),
	write(Stream,'\n'),
	loop2(Stream, T).
loop2(Stream,[A,B,C,D|T]):-
	loop(Stream,[A,B,C,D]),
	write(Stream,'\n'),
	loop2(Stream,T).
	
readfile(FileName, List) :-
	open(FileName, read, Stream),
	createlist(Stream,List),
	close(Stream).

createlist(Stream, T):-
	get_code(Stream, H),
	coss(H,T,Stream).
coss(H,T,_):-
	H = -1,!,
	T = [].
coss(H, [H|T],Stream):-
	createlist(Stream,T).