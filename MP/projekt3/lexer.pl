% SWI-Prolog

:- module(lexer, [parse/2]).


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

/*
:- op(990, xfy, ';;').
:- op(900, xfy, :=).
:- op(820, xfy, and).
:- op(840, xfy, or).
:- op(700, xfy, <=).
:- op(700, xfy, <>).*/
%:- op(990, xfy, ';;').


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




parse(CharCodeList, Absynt) :-
   phrase(lexer(TokList), CharCodeList),
   %write(TokList),
   phrase(program(Absynt), TokList).
   %write(Absynt).
 %phrase(program(X),[tokProgram,tokId(Suma),tokLocal,tokId(x),tokComma,tokId(s),tokBegin,tokId(s),tokAssgn,tokNumber(0),tokSColon,tokRead,tokId(x),tokSColon,tokWhile,tokId(x),tokNeq,tokNumber(0),tokDo,tokId(s),tokAssgn,tokId(s),tokPlus,tokId(x),tokSColon,tokRead,tokId(x),tokDone,tokSColon,tokWrite,tokId(s),tokEnd]).
% TWI, Mar 15, 2009 && MRCHW Apr 30,2016.
