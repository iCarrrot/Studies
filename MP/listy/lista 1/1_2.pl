happy/1.
smok/1.
mieszka/1.
mily/1.
czlowiek/1.
styka/2.
zwierze/1.
not_happy/1.
odwiedza/1.


not_happy(X):-not(happy(X)).
not_happy(X):-mieszka(X),smok(X).
happy(X):-styka(X,Y),zwierze(X),mily(Y),czlowiek(Y).
mily(X):-czlowiek(X),odwiedza(X).
styka(X,Y):-zwierze(X),czlowiek(Y),mieszka(X),odwiedza(Y).
zwierze(X):-smok(X).

czlowiek(a).
czlowiek(b).
smok(d).
smok(c).
odwiedza(a).
mieszka(e).
zwierze(e).

