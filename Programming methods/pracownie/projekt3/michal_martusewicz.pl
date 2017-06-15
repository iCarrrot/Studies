/*
Michał Martusewicz, 282023

Lexer jest praktycznie całkowicie przepisany z while parsera by TWI, parser własny, niektóre rozwiązania zainspirowane 
rozwiązaniami znalezionymi w źródłach wszelakich.

Jest to implementacja najprostszej wersji za 22 punkty.

Jak to działa:
1. lekser tworzy listę tokenów;
2. parser tworzy "drzewo" operacji, wszelkie operatory i działania (zarówno porównania, operacje arytmetyczne, jak i logiczne) 
są zapisywane w ONP;
3. var_list() tworzy listę zmiennych, będzie potrzebna przy wstawianiu adresów za zmienne;
4. instructions() tworzy uproszczoną listę instrukcji, tzn. używając instrukcji dostępnych i np. pop, push;
5. czysc() robi małą optymalizację: usówa występujące po sobie push i pop;
6. podstaw() zamienia instrukcje skrócone (np. lt, geq) na te dostępne w procesorze;
7. make_fours() tworzy właściwe czwórki instrukcji wraz z numerami linii, przesówając stałe za te czwórki i dopełnia nopami w odpowiednich miejscach;
8. make_adress() wstawia do słownika zmiennych odpowiednie adresy;
9. slownik_etykiet() tworzy słownik etykiet skoków ;
10. zamiana_etykiet() zamienia adresy where_jump(X) na odpowiednie numery linii przy etykietach here_jump(X);
11. zamiana_etykiet_var() zamienia var(_) na adresy docelowe;
12. na_numerki() zamienia czwórki instrukcji na liczby;
13. printHex() zamienia liczby dziesiętna na szesnastkowe.

Więcej objaśnień może być przy konkretnych predykatach.

*/



algol16(Source,SextiumBin):-
	assembly(Source,SextiumBin).

%predykat do wczytywania programu z pliku FileName i zapisywania do "program":
main(FileName):-!,
	readfile(FileName, CharCodeList),
	assembly(CharCodeList,Dec),
	printHex(Dec,Exit),
	writefile('program',Exit),!.
	


assembly(CharCodeList,Exit):-
	parse(CharCodeList,(Vars,Tree)),
	%write(Tree),
	var_list(Vars,Var_list),
	%write(Tree),
	instructions(Tree, List,End),
	%write(List),
	End_of_program=[const, num(0),syscall], %koniec programu
	append(List,End_of_program,List2),
	czysc([const,num(65535),swapa,const,num(65533),store|List2],Czysta), %inicjacja stosu
	%write(Czysta),
	podstaw(Czysta,Podstawiona,End),
	make_fours(Podstawiona,Czworki,0,Plength),
	%write(Czworki),
	make_adress(Plength,Var_list,Var_Dic),
	%write(Var_Dic),
	slownik_etykiet(Czworki,Dic),
	%write(Dic),
	zamiana_etykiet(Czworki,Dic,Po_Et),
	%write(Po_Et),
	zamiana_etykiet_var(Po_Et,Var_Dic,Po_var),
	%write(Po_var),
	na_numerki(Po_var,Exit) %treść polecenie nakazuje wypisać liczby dziesiętne, jednak treść całego zadania sugeruje wypisywanie słów szesnastkowych. Jeżeli autor zadania jednak wymagał wypisanie słów szesnastkowych, wystarczy zamienić Exit na Decimal i odkomentować printHex.
	%,printHex(Decimal,Exit)
	.
	%write(Exit)
	%Exit=List


parse(CharCodeList, Absynt) :-
   phrase(lexer(TokList), CharCodeList),
   %write(TokList),
   phrase(program(Absynt), TokList).

%koniec parsera około linii 404

lexer(Tokens) -->
   white_space,
   (  (  ":=",      !, { Token = tokAssgn }
      ;  ";",       !, { Token = tokSColon }
      ;  "(",       !, { Token = tokLParen }
      ;  ")",       !, { Token = tokRParen }
      ;  "+",       !, { Token = tokPlus }
      ;  "-",       !, { Token = tokMinus }
      ;  "*",       !, { Token = tokTimes }
      ;  "=",       !, { Token = tokEq }
      ;  "<>",      !, { Token = tokNeq }
      ;  "<=",      !, { Token = tokLeq }
      ;  "<",       !, { Token = tokLt }
      ;  ">=",      !, { Token = tokGeq }
      ;  ">",       !, { Token = tokGt }
      ;  ",",		!, { Token = tokComma }
      ;  digit(D),  !,
            number(D, N),
            { Token = tokNumber(N) }
      ;  letter(L), !, identifier(L, Id),
            {  member((Id, Token), [ (and, tokAnd),
            						 (begin, tokBegin),
            						 (call, tokCall),
                                     (div, tokDiv),
                                     (do, tokDo),
                                     (done, tokDone),
                                     (else, tokElse),
                                     (end, tokEnd),
                                     (fi, tokFi),
                                     (if, tokIf),
                                     (local, tokLocal),
                                     (mod, tokMod),
                                     (not, tokNot),
                                     (or, tokOr),
                                     (procedure, tokProcedure),
                                     (program,tokProgram),
                                     (read, tokRead),
                                     (return, tokReturn),
                                     (then, tokThen),
                                     (value, tokValue),
                                     (while, tokWhile),
                                     (write, tokWrite)]),
               !
            ;  Token = tokId(Id)
            }
      ;  [_],
            { Token = tokUnknown } 
      ),
      !,
         { Tokens = [Token | TokList] },
      lexer(TokList)
   ;  [],
         { Tokens = [] }
   ).


white_space -->(
	"(*",!,comment,white_space
	; [Char], { code_type(Char, space) }, !, white_space
	;[]).

comment -->("*)",!;
			[_],comment).
  
digit(D) -->
   [D],
      { code_type(D, digit) }.

digits([D|T]) -->
   digit(D),
   !,
   digits(T).
digits([]) -->
   [].

number(D, N) -->
   digits(Ds),
      { number_chars(N, [D|Ds]) }.

letter(L) -->
   [L], { code_type(L, alpha) }.

alphanum([A|T]) -->
   [A], { code_type(A, alnum) ;A is 95 ;A is 39 }, !, alphanum(T).
alphanum([]) -->
   [].

identifier(L, Id) -->
   alphanum(As),
      { atom_codes(Id, [L|As]) }.


%parser

program(Sth)-->[tokProgram],
				[tokId(_)],
				blok(Rest),
				{Sth=Rest}.
blok(Bst)-->deklaracje(Dekclarations),
				[tokBegin],
				instrukcja_zlozona(Instructions),!,
				[tokEnd],
				{Bst=(Dekclarations,Instructions)}.
deklaracje(X)--> [],
				{X=[]}
			; 
				deklaracja(H),
				deklaracje(T),
				{X=[H|T]}.

deklaracja(H)-->deklarator(H)
			;
				procedura(X),{H=proc(X)}.

deklarator(X)-->[tokLocal],	
				zmienne(X).

zmienne([H|T])-->zmienna(H),
					([tokComma],!, 
					zmienne(T)
					;
					[],{T=[]}
					).

zmienna(Var)-->[tokId(Name)],
				{Var=var(Name)}.

procedura(X)-->[tokProcedure],
				nazwa_procedury(Name),
				[tokLParen],
				argumenty_formalne(List),
				[tokRParen],
				blok(Rest),
				{X=procedureTree(Name,List,Rest)}.

nazwa_procedury(Name)-->[tokId(Name)].

argumenty_formalne(Exit)--> [],{Exit=[]}
			;
				argument_formalny(H),
				argumenty_formalne(T),
				{Exit=[H|T]}.
argument_formalny(X)--> zmienna(X)
			;
				[tokValue], 
				zmienna(X).

instrukcja_zlozona(X)--> 								
				instrukcja(Xs),
				([tokSColon],!,
				instrukcja_zlozona(T),
				{X=[Xs|T]}
				;[],
				{X=[Xs]}).



instrukcja(Ins)-->zmienna(X),
				[tokAssgn],
				wyrazenie_arytmetyczne(Wyr),
				{Ins=assgn(X,Wyr)}
			;
				[tokIf],
				wyrazenie_logiczne(Bool),
				[tokThen],
				instrukcja_zlozona(List),
				(
				[tokFi],!,
				{Ins=if(Bool,List)}
			;
				[tokElse],
				instrukcja_zlozona(List2),
				[tokFi],
				{Ins=ifElse(Bool,List,List2)}
				)
			;
				[tokWhile],
				wyrazenie_logiczne(Bool),
				[tokDo],
				instrukcja_zlozona(List),
				[tokDone],
				{Ins=while(Bool,List)}
			;
				[tokCall],
				wywolanie_procedury(A),
				{Ins=call(A)}
			;
				[tokReturn],
				wyrazenie_arytmetyczne(A),
				{Ins=ret(A)}
			;
				[tokRead],
				zmienna(A),
				{Ins=read(A)}
			;
				[tokWrite],
				wyrazenie_arytmetyczne(A),
				{Ins=ioWrite(A)}.

wyrazenie_arytmetyczne(Wyr) -->
    			skladnik(A), 
    			wyrazenie_arytmetyczne(A,Wyr).

wyrazenie_arytmetyczne(Acc, Wyr)-->
   				operator_addytywny(Op),
   				!,
   				skladnik(B),
   				{Acc1 = [Acc,B,Op]},
   				wyrazenie_arytmetyczne(Acc1, Wyr).

wyrazenie_arytmetyczne(Acc, Acc1)-->[],{flatten(Acc,Acc1)}.	
			 
operator_addytywny(Op)-->[tokPlus],
				{Op=plus}
			;
				[tokMinus],
				{Op=minus}.

skladnik(Exit) -->
    czynnik(A), skladnik(A,Exit).

skladnik(Acc, Exit)-->
   operator_multiplikatywny(A),!,czynnik(B),
   {Acc1 = [Acc,B,A]},
   skladnik(Acc1, Exit).

skladnik(Acc, Acc)-->[].

operator_multiplikatywny(Op)-->
				[tokMod],
				{Op=mod }
			;
				[tokDiv],
				{Op=div}
			;
				[tokTimes],
				{Op=mul}.

czynnik(Cz)-->[tokMinus],
				wyrazenie_proste(Cz1),
				{Cz=[Cz1,negat]};
			wyrazenie_proste(Cz).
				
wyrazenie_proste(W)-->				
				[tokLParen],
				wyrazenie_arytmetyczne(W),
				[tokRParen];
			wyrazenie_atomowe(W).

wyrazenie_atomowe(W)-->wywolanie_procedury(W)
			;
				zmienna(W)
			;
				liczba(W).
wywolanie_procedury(Wyw)-->zmienna(Name),
				[tokLParen],
				%argumenty_faktyczne(List),
				[tokRParen],
				{Wyw=callProc(Name)}.
/*argumenty_faktyczne(List)-->[],
				{List=[]}
			;
				argument_faktyczny(X),
				[tokComma], 
				argumenty_faktyczne(List2),
				{List=[X|List2]}.
argument_faktyczny(X)-->wyrazenie_arytmetyczne(X).*/
wyrazenie_logiczne(Bool)-->koniunkcja(K),
				wyrazenie_logiczne(K,Bool).
wyrazenie_logiczne(Acc, Exit)-->
  [tokOr],!,koniunkcja(A),
  {Acc1 = [Acc,A,or]},
  wyrazenie_logiczne(Acc1, Exit).
wyrazenie_logiczne(Acc, Acc1)-->[],{flatten(Acc,Acc1)}.


koniunkcja(Exit)-->
   warunek(A), koniunkcja(A, Exit).

koniunkcja(Acc, Exit)-->
  				[tokAnd],
  				!,
  				warunek(A),
  				{Acc1 = [Acc,A,and]},
  				koniunkcja(Acc1, Exit).

koniunkcja(Acc, Acc)-->[].  	

warunek(A)-->	[tokNot],!, 
				wyrazenie_relacyjne(B),
				{A=[B,not]}
				;
				wyrazenie_relacyjne(A).


wyrazenie_relacyjne(A)-->
				[tokLParen],
				wyrazenie_logiczne(W),
				[tokRParen],
				{A=W}
			;
				wyrazenie_arytmetyczne(W1),
				operator_relacyjny(Op),
				wyrazenie_arytmetyczne(W2),
				{A=[W1,W2,Op]}.

operator_relacyjny(Op)-->[tokEq],{Op=eq}
			;
				[tokNeq],
				{Op=neq}
			;
				[tokGeq],
				{Op=geq}
			;	
				[tokGt],
				{Op=gt}
			;	
				[tokLt],
				{Op=lt}
			;
				[tokLeq],
				{Op=leq}.
liczba(Exit)-->
  [tokNumber(A)],{Exit=num(A)}.


var_list(EnterL,List):-flatten(EnterL,List),!.


%głowny predykat zamieniający instrukcje na rozkazy, number to licznik etykiet, NumberBack to najwyższy numer etykiety.

instructions(X,Y,Z):-instructions(X,Y,1,Z).

instructions([H|Tree], Exit,Number,NumberBack):-
	%jeżeli while:  
	H=while(Bool,Instruction_list),!,
	%policz warunek:
	liczenie(Bool,Bool_List),
	Number2 is Number + 1,  
	%weź wynik ze stosu, jeżeli zero to skocz na konic
	After_Bool=[pop,swapd,const,where_jump(Number2),swapa,swapd,branchz],
	Number3 is Number2 + 1,
	%zamień instrukcje wewnątrz while'a na kod
	instructions(Instruction_list,Done_List,Number3,NumberBack3),
	After_ins=[const,where_jump(Number),jump],
	List2=[here_jump(Number),Bool_List,After_Bool,Done_List,After_ins,here_jump(Number2)],
	Number4 is NumberBack3 + 1, 
	%połącz wszystko i weź następną instrukcję
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
%if i ifElse działa podobnie jak while
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

liczenie(List,X):-
	licz(List,Acc),
	czysc(Acc,X).

%wrzuć zmienną na stos
licz([H|T],Acc):-H=var(X),!,
	Acc1=[const,var(X),swapa, load,push],
	append(Acc1,A,Acc),
	licz(T,A).

%wrzuć stałą na stos
licz([H|T],Acc):-H=num(X),!,
	Acc1=[const,num(X),push],
		append(Acc1,A,Acc),
		licz(T,A).
%zdejmij ze stosu argumenty operacji i wrzuć wynik na stos
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
	Acc=[pop,not,push].


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

%zamiana makr
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
	List=[swapa,const,where_jump(E1),swapa, sub,branchz,const,where_jump(End),swapd,const,num(0),swapd,jump,here_jump(E1),const,num(1),swapd,here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],Exit,Number):-
	H=not,!,
	E1 is Number +1,
	End is Number +2,
	List=[swapd,const,where_jump(E1),swapa,swapd,branchz,const,num(0),swapd,const,where_jump(End),jump,here_jump(E1),const, num(1),swapd,here_jump(End),swapd],
	podstaw(T,Exit2,End),
	append(List,Exit2,Exit).

podstaw([H|T],[H|Exit],Number):-
	podstaw(T,Exit,Number).

podstaw([],[],_).



make_fours([],[],X,X):-!.	
%robię pierwszą czwórkę, wyrzucam ile elementów zabrałem z listy, tworzę z czwórki osobną
%listę z numerem. 
make_fours(Lista,Exit,N,NumberBack):- 
	czworka(Lista,Exit3,X,4,End),
	drop(X,Lista,Lista2),
	L=[lin(N)|Exit3],
	N1 is N +1,
	sep(End,N1,NB,End2),
	make_fours(Lista2,Exit2,NB,NumberBack),
	append([L|End2],Exit2,Exit).
%tworzenie odSEParowanych list zwierających czwórki rozkazów
sep([H|List],N,NB,[[lin(N),H]|List2]):-
	N1 is N + 1,
	sep(List,N1,NB,List2),!.
sep([],N,N,[]):-!.

%poszczególne przypadki nopowania
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

make_adress(Plength,[H|List],[H2|List2]):-
	P2 is Plength+1,
	H=var(_),
	H2=[num(P2),H],
	make_adress(P2,List,List2).
make_adress(_,[],[]):-!.


slownik_etykiet([H|List],Exit):-
	H=[lin(X),here_jump(A)|T],!,
	get_jump(T,X,List2),
	H2=[num(X),here_jump(A)],
	slownik_etykiet(List,Dic),
	append([H2|List2],Dic,Exit).

slownik_etykiet([_|List],Dic):-
	slownik_etykiet(List,Dic),!.

slownik_etykiet([],[]):-!.

%gdy kilka etykiet odnosi się do tego samego adresu
get_jump([H|List],N,[H2|List2]):-
	H=here_jump(A),!,
	H2=[num(N),here_jump(A)],
	get_jump(List,N,List2).
get_jump([_|List],N,List2):-
	get_jump(List,N,List2).
get_jump([],_,[]).

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

na_numerki([H|T],[X2|Exit]):-
	H=[lin(_),num(X)],
	X<0,!,
	X2 is 32768+(32768+X), %liczbę ujemną trzeba "przekręcić"
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


printHex([],[]):-!.
printHex([H|T],[A|Exit]) :-
  format(atom(A),'~|~`0t~16r~4+', H),
  printHex(T,Exit).

%drop i take.
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



%inne, pomocnicze predykaty służące do wypisywania słów do pliku, nie są składowymi programu głównego.

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