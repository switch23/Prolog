parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

female(pam).
female(liz).
female(ann).
female(pat).
male(tom).
male(bob).
male(jim).

offspring(Y, X) :-
  parent(X, Y).

mother(X,Y) :-
  parent(X, Y),
  female(X).

grandparent(X, Z) :-
  parent(X, Y),
  parent(Y, Z).

different(X, Y) :-
  X\==Y.

sister(X, Y) :-
  parent(Z, X),
  parent(Z, Y),
  female(X),
  different(X, Y).

predecessor(X, Z) :-
  parent(X, Z).

predecessor(X, Z) :-
  parent(X, Y),
  predecessor(Y, Z).

predecessor2(X, Z) :-
  parent(X, Z).

predecessor2(X, Z) :-
  parent(Y, Z),
  predecessor2(X, Y).

aunt(X, Y) :-
 parent(Z, Y),
 sister(X, Z).

/*
?- predecessor2(pam, X).
X = bob ;
X = ann ;
X = pat ;
X = jim ;
false.
*/
