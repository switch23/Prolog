% rep01: 第01回 演習課題レポート
% 2019年4月21日         by 学籍番号：29114116 名前：増田大輝
%
% 練習1.2 親子関係を解くプログラム  （テキスト6ページ）
% [術後の説明]
% parent(X, Y): XはYの親である
% male(X): Xは男性である
% female(X):Xは女性である
% offspring(Y,X):XはYの親である
% mother(X,Y):XはYの母親である
% grandparent(X,Z):XはZの祖父母である
% different(X,Y):XとYは別人である
% sister(X,Y):XはYの姉妹である
% predecessor(X, Y): XはYの祖先である
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

/*
（実行例）
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

/*
 [説明, 考察, 評価]
 Prologでは,変数を用いることで知りたい知識を質問することが可能であることが理解できた.
 また,該当する解が複数個ある場合には,「;」を入力することによって全ての解を表示することができる.
 該当する解がなくなった場合は,falseを返す.
*/


% 練習1.5 叔母関係を解くプログラム （テキスト12ページ）
% [述語の説明]
% aunt(X,Y):XはYの叔母である
% /* 以下Prologプログラム */
aunt(X, Y) :-
 parent(Z, Y),
 sister(X, Z).

/*
（実行例）
 ?- aunt(X,jim).
 X = ann ;
 false.
*/

/* 
 [説明, 考察, 評価]
 Prologでは,定義した他の関数を用いることで,新たな関数を定義できることが理解できた.
 この機能によって,複雑な関係をより単純な複数の関係の組み合わせによって表現することができる.
*/


% 練習1.6 祖先関係を解くプログラム （テキスト18ページ）
% [述語の説明]
% predecessor2(X,Z):XはZの祖先である
% /* 以下Prologプログラム */
predecessor2(X, Z) :-
  parent(X, Z).

predecessor2(X, Z) :-
  parent(Y, Z),
  predecessor2(X, Y).


/*
（実行例）
 ?- predecessor2(pam, X).
 X = bob ;
 X = ann ;
 X = pat ;
 X = jim ;
 false.
*/

/*
 [説明, 考察, 評価]
 Prologでは,再帰的に関数の定義することによって長大かつ複雑な関係を簡潔に表現することが可能となる.
*/


% 練習2.1 構文的に正しいPrologオブジェクトとその種類を判別する
% [述語の説明]
% goes(_, _):構造を表す一例
% black(_):構造を表す一例
% three(black(_)):構造を表す一例
% /* 以下Prologプログラム */
goes(_, _) :-
  true.

black(_).

three(black(_)).

+(_,_).

/*
（解答）
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

（実行例）
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

/*
 [説明, 考察, 評価]
 Prologでは全てのデータオブジェクトは構文的には項として表せる.
 また,関数は木構造として表され,その根に当たる関数子は項の主関数子である.
 構文的に正しくないものはSyntax errorとしてエラーが発生する.
*/


% 練習2.3 マッチング操作の成功の可否と得られた変数の具体化を確かめる
% [述語の説明]
% point(_,_):二次元平面上の任意の点を表す
% point(_,_,_):3次元空間上の任意の点を表す
% triangle(point(_,_),point(_,_),point(_,_)):平面上の三角形を表す
% /* 以下Prologプログラム */
point(_, _).
point(_, _, _).
triangle(point(_, _), point(_, _), point(_, _)).

/*
（実行例）
 (a)成功する
 (b)失敗する
 (c)失敗する
 (d)成功する
 (e)成功する

 結果として具体化された三角形は,二点(1,0),(-1,0)と任意の点(0,Y)からなる,二等辺三角形のクラスを定義する.

 (a)
 ?- point(A, B) = point(1, 2).
 A = 1,
 B = 2.
 
 (b)
 ?- point(A, B) = point(X, Y, Z).
 false.
 
 (c)
 ?- plus(2, 2) = 4.
 false.
 
 (d)
 ?- +(2, D) = +(E, 2).
 D = E, E = 2.
 
 (e)
 ?- triangle(point(-1,0),P2,P3) = triangle(P1,point(1,0),point(0,Y)).
 P2 = point(1, 0),
 P3 = point(0, Y),
 P1 = point(-1, 0).
*/

/*
 [説明, 考察, 評価]
 Prologでは,二つの項が与えられた時にマッチング操作,すなわち変数の最汎単一化が行われる.
 マッチするとは,二つの項が同一であるか最汎単一化による具体化が可能な場合のことを指す.
*/


% 練習2.5 水平と垂直な辺を持つ矩形である場合に真を返す関係
% [述語の説明]
% rectangle(P1,P2,P3,P4):順序付けられた頂点P1,P2,P3,P4によって定義された矩形
% regular(R):Rが水平と垂直な辺を持つ矩形である場合に真を返す
% /* 以下Prologプログラム */
rectangle(point(_,_),point(_,_),point(_,_),point(_,_)).
regular(rectangle(point(X1,Y1),point(X2,Y1),point(X2,Y2),point(X1,Y2))).

/*
（実行例）
 成功例：
 ?- regular(rectangle(point(0,2),point(4,2),point(4,0),point(0,0))).
 true.
 
 失敗例：
 ?- regular(rectangle(point(0,2),point(4,1),point(4,0),point(0,1))).
 false.
 
 ?- regular(rectangle(point(0,2),point(4,2),point(5,0),point(1,0))).
 false.
*/

/*
 [説明, 考察, 評価]
 Prologにおけるマッチング機能では,関数の木構造をたどり変数を具体化し,真偽を判定する.
*/

