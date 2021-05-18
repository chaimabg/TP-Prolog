adjacent(a,b).
adjacent(a,c).
adjacent(a,d).
adjacent(d,c).
adjacent(d,e).
adjacent(e,c).
adjacent(e,b).
adjacent(b,c).

color(a,rouge,coloriage1).
color(e,rouge,coloriage1).
color(c,vert,coloriage1).
color(b,bleu,coloriage1).
color(d,bleu,coloriage1).

color(a,rouge,coloriage2).
color(b,rouge,coloriage2).
color(c,vert,coloriage2).
color(d,bleu,coloriage2).
color(e,bleu,coloriage2).

conflit(X,Y,Coloriage):-color(X,Z,Coloriage),color(Y,Z,Coloriage),adjacent(X,Y).
conflit(Coloriage):-conflit(_,_,Coloriage).
