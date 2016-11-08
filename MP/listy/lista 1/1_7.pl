dom/6.
%dom(numer,kolor,cz³owiek,zwierze,pipierosy,napoj)
sasiaduje/2.
sasiaduje(X,Y):- (X=1,Y=2);
                 (X=2,X=3);
		 (X=3,X=4);
		 (X=4,X=5);
		 (Y=1,X=2);
                 (Y=2,X=3);
		 (Y=3,X=4);
		 (Y=4,X=5).
sasiaduje(X,Y):- dom(X,zielony,_,_,_,_), dom(Y,bialy,_,_,_,_).
sasiaduje(X,Y):-dom(Y,_,_,lis,_,_), dom(X,_,_,_,chesterfieldy,_).
sasiaduje(X,Y):-dom(Y,_,_,kon,_,_), dom(X,_,_,_,koole,_).
sasiaduje(X,Y):-dom(Y,niebieski,_,_,_,_), dom(X,_,norweg,_,_,_).


dom(_,czerwony,anglik,_,_,_).
dom(_,_,hiszpan,pies,_,_).
dom(_,zielony,_,_,_,kawa).
dom(_,_,ukrainiec,_,_,herbata).
dom(_,_,_,waz,winstony,_).
dom(_,zolty,_,_,koole,_).
dom(3,_,_,_,_,mleko).
dom(1,_,norweg,_,_,_).
dom(_,_,_,_,lucky_strike,sok).
dom(_,_,japonczyk,_,kenty,_).
dom(_,_,_,slon,_,_).
dom(_,_,_,_,_,wodka).
