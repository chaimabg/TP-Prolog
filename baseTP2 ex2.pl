argent(jean).
argent(alain).
vacance(jean):-on_est(aout).
vacance(alain):-on_est(juillet).
on_est(juillet).
il_y_a(soleil):-on_est(aout).
reussit(jean,travail).
reussit(alain,travail).
reussit(alain,famille).

humeur(X):-argent(X),vacance(X),il_y_a(soleil).
humeur(X):-reussit(X,travail),reussit(X,famille).


