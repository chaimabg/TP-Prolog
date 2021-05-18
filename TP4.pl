%Exercice 1 :

% 1.
:-dynamic rocher/2.
:-dynamic arbre/2.

% 2.
:-dynamic vache/4.

% 3.
:-dynamic dimitri/2.

% 4.
largeur(5).
hauteur(5).

% 5.
nombre_rochers(1).
nombre_arbres(1).
nombre_vaches(brune,3).
nombre_vaches(simmental,3).
nombre_vaches(alpine_herens,3).


%Exercice 2:

% 1.
occupe(X,Y):-arbre(X,Y).
occupe(X,Y):-rocher(X,Y).
occupe(X,Y):-vache(X,Y,_,_).
occupe(X,Y):-dimitri(X,Y).

% 2.

libre(X,Y):-repeat,X is random(5),Y is random(5), not(occupe(X,Y)),!.

% 3.

placer_rochers(0).
placer_rochers(N):- N>0,libre(X,Y),assert(rocher(X,Y)),M is N-1, placer_rochers(M).

placer_arbres(0).
placer_arbres(N):-N>0,libre(X,Y),assert(arbre(X,Y)),M is N-1, placer_arbres(M).

placer_vaches(_,0).
placer_vaches(R,N):-N>0,libre(X,Y),assert(vache(X,Y,R,vivante)),M is N-1, placer_vaches(R,M).

placer_dimitri:- libre(X,Y),assert(dimitri(X,Y)).

% 4.

vaches(L):-findall([X,Y],vache(X,Y,_,vivante),L).

% 5.

creer_zombie:- vaches([[X,Y]|_]),vache(X,Y,Z,vivante),assert(vache(X,Y,Z,zombie)),retract(vache(X,Y,Z,vivante)).

%EXERCICE3

%1.

question(R):-print('Choisir la direction de Dimitri reste ou nord ou sud  ou est ou ouest: '),read(R).

%2.

vache_voisine((X,Y),(X1,Y1)):-vache(X,Y,_,_), A is X1+1, B is X1-1, C is Y1-1, D is Y1+1,((X=A,Y=Y1); (X=B,Y=Y1);(X = X1,Y=D);(X=X1,Y=C)).

vaches_voisines(X,Y,L):- findall(((A,B)),vache_voisine((A,B),(X,Y)),L).

transformer_en_zombie([]).
transformer_en_zombie(L):- L=[(X,Y)|L1],retract(vache(X,Y,R,_)),assert(vache(X,Y,R,zombie)), transformer_en_zombie(L1).

zombification:- vache(X,Y,_,zombie),vaches_voisines(X,Y,L),transformer_en_zombie(L).

%3.

random_list([], _).
random_list(L, X) :-length(L, S),I is random(S),nth0(I, L, X).

deplacement_vache(_, _, D):- D = reste,!.
deplacement_vache(X, Y, D):- D = nord, Y>0, Y1 is Y-1,not(occupe(X,Y1)),retract(vache(X,Y,R,E)),assert(vache(X,Y1,R,E)),!.
deplacement_vache(X, Y, D):- D = sud,hauteur(N),N1 is N-1, Y<N1, Y1 is Y+1,not(occupe(X,Y1)),retract(vache(X,Y,R,E)),assert(vache(X,Y1,R,E)),!.
deplacement_vache(X, Y, D):- D = est,largeur(N), N1 is N-1, X<N1, X1 is X+1,not(occupe(X1,Y)), retract(vache(X,Y,R,E)),assert(vache(X1,Y,R,E)),!.
deplacement_vache(X, Y, D):- D = ouest, X>0, X1 is X-1,not(occupe(X1,Y)),retract(vache(X,Y,R,E)),assert(vache(X1,Y,R,E)),!.
deplacement_vache(_, _,_):- !.

deplacement_vaches:- vache(X,Y,_,zombie),random_list([est, ouest, nord, sud],Dir),deplacement_vache(X,Y,Dir).


%4.

deplacement_joueur(D):- D = reste,!.
deplacement_joueur(D):- D = nord, dimitri(X,Y), Y>0, Y1 is Y-1,not(occupe(X,Y1)), retract(dimitri(X,Y)),assert(dimitri(X,Y1)),!.
deplacement_joueur(D):- D = sud, dimitri(X,Y),hauteur(N),N1 is N-1, Y<N1, Y1 is Y+1,not(occupe(X,Y1)),retract(dimitri(X,Y)),assert(dimitri(X,Y1)),!.
deplacement_joueur(D):- D = est, dimitri(X,Y),largeur(N), N1 is N-1, X<N1, X1 is X+1,not(occupe(X1,Y)),retract(dimitri(X,Y)),assert(dimitri(X1,Y)),!.
deplacement_joueur(D):- D = ouest, dimitri(X,Y), X>0, X1 is X-1,not(occupe(X1,Y)), retract(dimitri(X,Y)),assert(dimitri(X1,Y)),!.
deplacement_joueur(_):- !.


%5.

liste_zombie([]):- fail.
liste_zombie([(X,Y)]):- vache(X,Y,_,zombie).
liste_zombie(L):- L=[(X,Y)|_],vache(X,Y,_,zombie),!.
liste_zombie(L):- L=[(X,Y)|L1],not(vache(X,Y,_,zombie)),liste_zombie(L1).

verification:- dimitri(X,Y),vaches_voisines(X,Y,L),liste_zombie(L).


% le reste est le code prédéfini du jeu

initialisation :-
  placer_dimitri,
  nombre_rochers(NR),
  placer_rochers(NR),
  nombre_arbres(NA),
  placer_arbres(NA),
  nombre_vaches(brune, NVB),
  placer_vaches(brune, NVB),
  nombre_vaches(simmental, NVS),
  placer_vaches(simmental, NVS),
  nombre_vaches(alpine_herens, NVH),
  placer_vaches(alpine_herens, NVH),
  creer_zombie,
  !.

affichage(L, _) :-
  largeur(L),
  nl.

affichage(L, H) :-
  rocher(L, H),
  print('O'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  arbre(L, H),
  print('T'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  dimitri(L, H),
  print('D'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  vache(L, H, brune, vivante),
  print('B'),
  L_ is L + 1,
  affichage(L_, H).
affichage(L, H) :-
  vache(L, H, brune, zombie),
  print('b'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  vache(L, H, simmental, vivante),
  print('S'),
  L_ is L + 1,
  affichage(L_, H).
affichage(L, H) :-
  vache(L, H, simmental, zombie),
  print('s'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  vache(L, H, alpine_herens, vivante),
  print('H'),
  L_ is L + 1,
  affichage(L_, H).
affichage(L, H) :-
  vache(L, H, alpine_herens, zombie),
  print('h'),
  L_ is L + 1,
  affichage(L_, H).

affichage(L, H) :-
  \+ occupe(L, H),
  print('.'),
  L_ is L + 1,
  affichage(L_, H).

affichage(H) :-
  hauteur(H).

affichage(H) :-
  hauteur(HMax),
  H < HMax,
  affichage(0, H),
  H_ is H + 1,
  affichage(H_).

affichage :-
  affichage(0),!.

jouer :-
  initialisation,
  tour(0).

tour_(_) :- verification, write('Dimitri s\'est fait mordre'),!.

tour_(N) :-
  not(verification),
  M is N + 1,
  tour(M).

tour(N) :-
  affichage,
  question(R),
  deplacement_joueur(R),
  deplacement_vaches,
  zombification,
  tour_(N).
