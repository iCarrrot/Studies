
:- module(instrukcje, [instructions/4,czysc/2]).

licz([H|T],Acc):-H=var(X),!,
	Acc1=[const,var(X),swapa, load,push],
	append(Acc1,A,Acc),
	licz(T,A).
licz([H|T],Acc):-H=num(X),!,
	Acc1=[const,num(X),push],
		append(Acc1,A,Acc),
		licz(T,A).

licz([H|T],Acc):-
	count(Acc1,H),!,
		append(Acc1,A,Acc),
		licz(T,A).
licz([H|T],[H|Acc]):-licz(T,Acc).
licz([],[]).


count(Acc,Op):-
	Op=plus,!,
	Acc=[pop,swapd,pop,add,push].

count(Acc,Op):-
	Op=minus,!,
	Acc=[pop,swapd,pop,sub,push].

count(Acc,Op):-
	Op=div,!,
	Acc=[pop,swapd,pop,div,push].

count(Acc,Op):-
	Op=mul,!,
	Acc=[pop,swapd,pop,mul,push].

count(Acc,Op):-
	Op=mod,!,
	Acc=[pop,swapd,pop,div,const,num(-16),swapd,shift,push].

count(Acc,Op):-
	Op=negat,!,
	Acc=[pop,swapd,const,num(-1),mul,push].

count(Acc,Op):-
	Op=and,!,
	Acc=[pop,swapd,pop,mul,push].

count(Acc,Op):-
	Op=or,!,
	Acc=[pop,swapd,pop,add,push].

count(Acc,Op):-
	Op=lt,!,
	Acc=[pop,swapd,pop,lt,push].

count(Acc,Op):-
	Op=gt,!,
	Acc=[pop,swapd,pop,gt,push].

count(Acc,Op):-
	Op=geq,!,
	Acc=[pop,swapd,pop,geq,push].

count(Acc,Op):-
	Op=leq,!,
	Acc=[pop,swapd,pop,leq,push].

count(Acc,Op):-
	Op=neq,!,
	Acc=[pop,swapd,pop,neq,push].

count(Acc,Op):-
	Op=eq,!,
	Acc=[pop,swapd,pop,eq,push].

count(Acc,Op):-
	Op=not,!,
	Acc=[pop,swapd,const,num(1),nand,push].


liczenie(List,X):-
	licz(List,Acc),
	czysc(Acc,X).

czysc([H1,H2|List],List2):-
	H1=push,
	H2=pop,!,
	czysc(List,List2).
czysc([H1,H2|List],List2):-
	H1=pop,
	H2=push,!,
	czysc(List,List2),!.
czysc([H1,H2|List],[H1|List2]):-
	czysc([H2|List],List2),!.
czysc([X],[X]):-!.






instructions([H|Tree], Exit,Number,NumberBack):-
	H=while(Bool,Instruction_list),!,
	liczenie(Bool,Bool_List),
	Number2 is Number + 1,  
	After_Bool=[pop,swapd,const,where_jump(Number2),swapa,swapd,branchz],
	Number3 is Number2 + 1,
	instructions(Instruction_list,Done_List,Number3,NumberBack3),
	After_ins=[const,where_jump(Number),jump],
	List2=[here_jump(Number),Bool_List,After_Bool,Done_List,After_ins,here_jump(Number2)],
	Number4 is NumberBack3 + 1, 
	instructions(Tree,Exit2,Number4,NumberBack),
	flatten(List2,Exit3),
	append(Exit3,Exit2,Exit).

instructions([H|Tree],Exit,Number,NumberBack):-
	H=assgn(X,List),!,
	liczenie(List,FinList),
	AfterLicz=[pop,swapd,const,X,swapa,swapd,store],
	append(FinList,AfterLicz,Exit3),		
	instructions(Tree,Exit2,Number,NumberBack),
	append(Exit3,Exit2,Exit).
	
instructions([H|Tree],Exit,Number,NumberBack):-
		H=return(X),!,
		liczenie(X,List),
		instructions(Tree,Exit2,Number,NumberBack),
		append(List,Exit2,Exit).

instructions([H|Tree],Exit,Number,NumberBack):-
		H=call(_),!,
		instructions(Tree,Exit,Number,NumberBack).	

instructions([H|Tree],Exit,Number,NumberBack):-
		H=read(var(X)),!,
		Lista=[const,var(X),swapa,const, num(1),syscall,store],
		instructions(Tree,Exit2,Number,NumberBack),
		append(Lista,Exit2,Exit).

instructions([H|Tree],Exit,Number,NumberBack):-
		H=ioWrite(List),!,
		liczenie(List,To_write),
		Instukcje=[pop,swapd,const, num(2),syscall],
		append(To_write,Instukcje, Exit3),
		instructions(Tree,Exit2,Number,NumberBack),
		append(Exit3,Exit2,Exit).

instructions([H|Tree],Exit,Number,NumberBack):-
		H=if(Bool,Ins),!,
		liczenie(Bool,Bool_List),
		N is Number+2,
		instructions(Ins,Ins_Exit,N,NB),
		Number2 is Number + 1,
		After_Bool=[pop,swapd,const, where_jump(Number2),swapa,swapd,branchz],
		flatten([Bool_List,After_Bool,Ins_Exit,here_jump(Number2)],Exit2),
		instructions(Tree,Exit3,NB,NumberBack),
		append(Exit2,Exit3,Exit).

instructions([H|Tree],Exit,Number,NumberBack):-
		H=ifElse(Bool,If,Else),!,
		liczenie(Bool,Bool_List),
		Number2 is Number + 3,
		E1 is Number + 1,
		E2 is Number + 2, 
		instructions(If,If_List,Number2,NumberBack2),
		instructions(Else,Else_List,NumberBack2,NumberBack3),
		After_Bool=[pop,swapd,const,where_jump(E1),swapa,swapd,branchz],
		After_If=[const, where_jump(E2),jump,here_jump(E1)],
		After_Else=[here_jump(E2)],
		Ins=[Bool_List,After_Bool,If_List,After_If,Else_List,After_Else],
		flatten(Ins,Exit2),
		instructions(Tree,Exit3,NumberBack3,NumberBack),
		append(Exit2,Exit3,Exit).

instructions([_|Tree],Exit,Number,NumberBack):-
		instructions(Tree,Exit,Number,NumberBack).			


instructions([],[],X,X).
