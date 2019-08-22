%演習1.1

parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

/*

?- ['practice1_1'].
true.

?- parent(jim, X).
false.

?- parent(X, jim).
X = pat.

?- parent(pam, X), parent(X, pat).
X = bob.

?- parent(pam, X), parent(X, Y), parent(Y, jim).
X = bob,
Y = pat.

*/
