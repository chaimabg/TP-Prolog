lire(X):-write('donner un entier'),nl,read(X),nl,write('votre entier est'),write(X),nl,nl.

calcul_carre(X,Y):-Y is X*X.

ecrire_resultat(X,Y):-write('le carré de '),write(X),write(' est '),write(Y),nl,nl.

aller:-lire(X),calcul_carre(X,Y),ecrire_resultat(X,Y)
.
carre:-write('donner un entier'),nl,read(X),nl,write('votre entier est'),write(X),nl,nl,Y is X*X,write('le carré de '),write(X),write(' est '),write(Y),nl,nl.

boucle:-write('donner un entier'),nl,read(X),(X>0 -> write('votre entier est'),write(X),nl,Y is X*X,write('le carré de '),write(X),write(' est '),write(Y),nl,nl,boucle;write('l entier doit etre non nul')).
factorille(0,1).
factorielle(X,Y):-X>0,A is X-1,factorielle(A,Z),Y is X*Z.

