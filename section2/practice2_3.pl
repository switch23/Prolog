%演習2.3
point(_, _).
point(_, _, _).
triangle(point(_, _), point(_, _), point(_, _)).


/*
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

