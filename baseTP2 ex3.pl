
lire(1,X,0):-read(X).
lire(N,S,M) :- N>1, N1 is N-1,read(X), sumto(N1,S1,M1), S is S1+X,M is max(X,M1).
