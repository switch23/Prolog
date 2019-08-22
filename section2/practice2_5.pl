%演習2.5
point(_, _).
rectangle(point(_,_),point(_,_),point(_,_),point(_,_)).
regular(rectangle(point(X1,Y1),point(X2,Y1),point(X2,Y2),point(X1,Y2))).

/*
成功例：
?- regular(rectangle(point(0,2),point(4,2),point(4,0),point(0,0))).
true.

失敗例：
?- regular(rectangle(point(0,2),point(4,1),point(4,0),point(0,1))).
false.

?- regular(rectangle(point(0,2),point(4,2),point(5,0),point(1,0))).
false.
*/
