%演習1.3
happy(X) :-
 parent(X, Y).

hastwochildren(X) :-
 parent(X, Y),
 parent(X, Z),
 sister(Y, Z).
