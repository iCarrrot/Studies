/* Funktory do budowania klauzul */

:- op(200, fx, ~).
:- op(500, xfy, v).

/* G³ówny program: main/1. Argumentem jest atom bedacy nazwa pliku
* z zadaniem. Przyk³ad uruchomienia:
* ?- main('zad125.txt').
* Plik z zadaniem powinien byc plikiem tekstowym, na którego
* poczatku znajduje sie lista klauzul zbudowanych za pomoca funktorów
* v/2 i ~/1 (szczegó³y znajduja sie w opisie zadania). Liste zapisujemy
* w notacji prologowej, tj. rozdzielajac elementy przecinkami
* i otaczajac liste nawiasami [ i ]. Za nawiasem ] nale»y postawic
* kropke. Wszelkie inne znaki umieszczone w pliku sa pomijane przez
* program (mo»na tam umiescic np. komentarz do zadania).
*/


main(FileName) :-
readClauses(FileName, Clauses),
prove(Clauses, Proof),
writeProof(Proof).
/* Silnik programu: predykat prove/2 do napisania w ramach zadania.
* Predykat umieszczony poni»ej nie rozwiazuje zadania. Najpierw
* wypisuje klauzule wczytane z pliku, a po nawrocie przyk³adowy dowód
* jednego z zadan. Dziewiec wierszy nastepujacych po tym komentarzu
* nale»y zastapic w³asnym rozwiazaniem. */
prove(Clauses, Proof) :-
maplist(addOrigin, Clauses, Proof).
prove(_, [(~p v q,axiom), (~p v ~r v s, axiom), (~q v r, axiom),
(p, axiom), (~s, axiom), (q, (1,4)), (r, (3,6)),
(~p v ~r, (2,5)), (~p, (7,8)), ([], (4,9))]).
addOrigin(Clause, (Clause, axiom)).
/* Pozosta³a czesc pliku zawiera definicje predykatów wczytujacych liste
* klauzul i wypisujacych rozwiazanie. Wykorzystane predykaty
* biblioteczne SWI-Prologu (wersja kompilatora: 6.6.6):
3
*
* close/1
* format/2
* length/2
* maplist/3
* max_list/2
* nl/0
* open/3
* read/2
* write_length/3
*
* Dokumentacje tych predykatów mo»na uzyskac wpisujac powy»sze napisy
* na koncu nastepujacego URL-a w przegladarce WWW:
* http://www.swi-prolog.org/pldoc/doc_for?object=
* np.
* http://www.swi-prolog.org/pldoc/doc_for?object=write_length/3
* lub jako argument predykatu help/1 w konsoli interpretera SWI
* Prologu, np.
* ?- help(write_length/3).
*/
readClauses(FileName, Clauses) :-
open(FileName, read, Fd),
read(Fd, Clauses),
close(Fd).
/* Wypisywanie dowodu */
writeProof(Proof) :-
maplist(clause_width, Proof, Sizes),
max_list(Sizes, ClauseWidth),
length(Proof, MaxNum),
write_length(MaxNum, NumWidth, []),
nl,
writeClauses(Proof, 1, NumWidth, ClauseWidth),
nl.
clause_width((Clause, _), Size) :-
write_length(Clause, Size, []).
writeClauses([], _, _, _).
writeClauses([(Clause,Origin) | Clauses], Num, NumWidth, ClauseWidth) :-
format('~t~d~*|. ~|~w~t~*+ (~w)~n',
[Num, NumWidth, Clause, ClauseWidth, Origin]),
Num1 is Num + 1,
writeClauses(Clauses, Num1, NumWidth, ClauseWidth).
/* twi 2016/03/13 vim: set filetype=prolog fileencoding=utf-8 : */
