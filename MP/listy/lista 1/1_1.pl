ptak/1.
dzdzownica/1.
ryba/1.
przyjaciele/2.
kot/1.
lubi/2.
jada/2.

ptak(_):- fail.
dzdzownica(_):-fail.
ryba(_) :- fail.
kot(my_cat).
przyjaciele(me, my_cat).

lubi(X,Y):-ptak(X),dzdzownica(Y).
lubi(X,Y):-kot(X),ryba(Y).
lubi(X,Y):-przyjaciele(X,Y).
lubi(X,Y):-przyjaciele(Y,X).
jada(my_cat,Y):-lubi(my_cat,Y).

%jada(my_cat,me).
