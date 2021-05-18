personne(k,f,85,tunis).
personne(c,m,63,nabeul).
personne(d,f,60,nabeul).
personne(e,m,35,tunis).
personne(g,f,27,sousse).
personne(h,f,39,nabeul).
personne(i,m,40,nabeul).
personne(j,m,17,sousse).
personne(1,f,9,sousse).
personne(m,f,19,tunis).
personne(n,m,1,tunis).



individu(X):- personne(X,_,_,_).
masculin(X):-personne(X,m,_,_).
feminin(X):-personne(X,f,_,_).
est_age_de(X,Y):-personne(X,_,Y,_).
habite_a(X,Y):-personne(X,_,_,Y).
majeur(X):-est_age_de(X,Y),Y>18.
mineur(X):-est_age_de(X,Y),Y<18.
meme_age(X,Y):-est_age_de(X,Z),est_age_de(Y,Z).
habite_la_meme_ville(X,Y):-habite_a(X,Z),habite_a(Y,Z).
epoux_possible(X,Y):-masculin(X),feminin(Y),majeur(X),majeur(Y),est_age_de(X,Z),est_age_de(Y,W),Z-W <20.

travaille(k,medecin,2000).
travaille(c,chanteur,800).
travaille(d,medecin,1800).
travaille(e,ingenieur,800).
travaille(g,chanteur,800).
travaille(h,ingenieur,1800).
travaille(i,acteur,1000).
travaille(j,acteur,2000).
travaille(l,acteur,7000).
travaille(m,peintre,900).
travaille(n,acteur,800).


meme_profession(X,Y):-travaille(X,Z,_),travaille(Y,Z,_).
gagne_plus(X,Y):-travaille(X,_,Z),travaille(Y,_,W),Z>W.
meme_ordre(X,Y):-travaille(X,_,Z),travaille(Y,_,W),Z-W =< 0.2*W .










