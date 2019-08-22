% rep00:第00回 演習課題レポート
% 2019年4月10日         by 学籍番号：29114116 名前：増田大輝
%
% 練習0.0 Prologテスト
% [術後の説明]
% parent(X, Y): XはYの親である
% father(X, Y): XはYの父親である
% male(X): Xは男性である
% ancestor(X, Y): XはYの祖先である
% /* 以下Prologプログラム */

parent(pam, bob) :- true .
parent(tom, bob) :- true .
parent(tom, liz) .
parent(bob, ann) .
male(tom) .
male(bob) .
father(X, Y) :- parent(X, Y), male(X) .
ancestor(X, Y) :- parent(X, Y) .
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y) .


/*
 (実行例)
?- [report1].
true.

?- parent(X, bob).
X = pam ;
X = tom.

?- male(tom).
true.

?- father(X, ann).
X = bob.

?- ancestor(X, ann).
X = bob ;
X = pam ;
X = tom ;
false.
*/

/*
 [説明,考察,評価]
Prologの実行テストプログラム。親子関係を解くプログラムになっている>。

*/

