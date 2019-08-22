% 練習1.2 Prologテスト
% [術後の説明]
% parent(X, Y): XはYの親である
% father(X, Y): XはYの父親である
% male(X): Xは男性である
% ancestor(X, Y): XはYの祖先である
% /* 以下Prologプログラム */
  
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

/*
(1)
?- parent(X, pat).
X = bob.

(2)
?- parent(liz, X).
false.

(3)
?- grandparent(X, pat).
X = pam ;
X = tom ;
false.

*/
