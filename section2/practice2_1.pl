arent(pam, bob).
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

goes(_, _) :-
  true.

black(_).

three(black(_)).

+(_,_).

/*
(a)変数
(b)アトム
(c)アトム
(d)変数
(e)アトム
(f)構造
(g)数
(h)構造ではない
(i)構造
(J)構造

(a)
?- parent(Diana, bob).
Diana = tom.

(b)
?- parent(X, diana).
false.

(c)
?- parent('Diana', bob).
false.

(d)
?- parent(_diana, bob).
_diana = tom.

(e)
?- parent('Diana goes south', bob).
false.

(f)
?- goes(diana, south).
true.

(g)
?- X is 45.
X = 45.

(h)
?- 5(X, Y).
ERROR: Syntax error: Operator expected
ERROR: 
ERROR: ** here **
ERROR: 5(X, Y) . 

(i)
?- +(north,west).  
true.

(j)
?- three(black(Cats)).
true.


*/
