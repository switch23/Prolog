%演習3.2

%二つのリストを結合するconc関数の定義

conc([],L,L).

conc([X | L1],L2,[X | L3]) :-
  conc(L1,L2,L3).

%リストListの末尾の要素がItemとなる関数last

%(a)concを用いてlastを定義するlasa
%任意のリストとItemからのみなるリストを結合するとListとなることから,ListからItemを求める.
lasa(Item,List) :-
  conc(_,[Item],List).

%(b)concを用いずlastを定義するlasb
%Itemからのみなるリストが現れた場合に終了する.
lasb(Item,[Item]).
%二つ以上の要素からなるリストが現れた場合,HeadとTailに分割し,目標をlasb(Item,Tail)に置換する.
lasb(Item,[Head|Tail]) :-
  lasb(Item,Tail).


/*
(実行例)
 (a)
 ?- lasa(Item,[a,b,c,d,e,f,g]).         
 Item = g .
 
 ?- lasa(Item,[0,1,2,3,4,5,6,7,8,9]).   
 Item = 9 .
 
 ?- lasa(Item,[0,1,1,2,3,5,8,13,21,33]).
 Item = 33 .
 
(a)のトレース
[trace]  ?- lasa(Item,[a,b,c,d,e,f,g]).
   Call: (8) lasa(_3332, [a, b, c, d, e, f, g]) ? creep
   Call: (9) conc(_3602, [_3332], [a, b, c, d, e, f, g]) ? creep
   Call: (10) conc(_3590, [_3332], [b, c, d, e, f, g]) ? creep
   Call: (11) conc(_3596, [_3332], [c, d, e, f, g]) ? creep
   Call: (12) conc(_3602, [_3332], [d, e, f, g]) ? creep
   Call: (13) conc(_3608, [_3332], [e, f, g]) ? creep
   Call: (14) conc(_3614, [_3332], [f, g]) ? creep
   Call: (15) conc(_3620, [_3332], [g]) ? creep
   Exit: (15) conc([], [g], [g]) ? creep
   Exit: (14) conc([f], [g], [f, g]) ? creep
   Exit: (13) conc([e, f], [g], [e, f, g]) ? creep
   Exit: (12) conc([d, e, f], [g], [d, e, f, g]) ? creep
   Exit: (11) conc([c, d, e, f], [g], [c, d, e, f, g]) ? creep
   Exit: (10) conc([b, c, d, e, f], [g], [b, c, d, e, f, g]) ? creep
   Exit: (9) conc([a, b, c, d, e, f], [g], [a, b, c, d, e, f, g]) ? creep
   Exit: (8) lasa(g, [a, b, c, d, e, f, g]) ? creep
Item = g .

[trace]  ?- lasa(Item,[0,1,2,3,4,5,6,7,8,9]).
   Call: (8) lasa(_3352, [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Call: (9) conc(_3648, [_3352], [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Call: (10) conc(_3636, [_3352], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Call: (11) conc(_3642, [_3352], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (12) conc(_3648, [_3352], [3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (13) conc(_3654, [_3352], [4, 5, 6, 7, 8, 9]) ? creep
   Call: (14) conc(_3660, [_3352], [5, 6, 7, 8, 9]) ? creep
   Call: (15) conc(_3666, [_3352], [6, 7, 8, 9]) ? creep
   Call: (16) conc(_3672, [_3352], [7, 8, 9]) ? creep
   Call: (17) conc(_3678, [_3352], [8, 9]) ? creep
   Call: (18) conc(_3684, [_3352], [9]) ? creep
   Exit: (18) conc([], [9], [9]) ? creep
   Exit: (17) conc([8], [9], [8, 9]) ? creep
   Exit: (16) conc([7, 8], [9], [7, 8, 9]) ? creep
   Exit: (15) conc([6, 7, 8], [9], [6, 7, 8, 9]) ? creep
   Exit: (14) conc([5, 6, 7, 8], [9], [5, 6, 7, 8, 9]) ? creep
   Exit: (13) conc([4, 5, 6, 7, 8], [9], [4, 5, 6, 7, 8, 9]) ? creep
   Exit: (12) conc([3, 4, 5, 6, 7, 8], [9], [3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (11) conc([2, 3, 4, 5, 6, 7, 8], [9], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (10) conc([1, 2, 3, 4, 5, 6, 7, 8], [9], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Exit: (9) conc([0, 1, 2, 3, 4, 5, 6, 7|...], [9], [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Exit: (8) lasa(9, [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
Item = 9 .

[trace]  ?- lasa(Item,[0,1,1,2,3,5,8,13,21,33]).
   Call: (8) lasa(_3352, [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Call: (9) conc(_3650, [_3352], [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Call: (10) conc(_3638, [_3352], [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Call: (11) conc(_3644, [_3352], [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (12) conc(_3650, [_3352], [2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (13) conc(_3656, [_3352], [3, 5, 8, 13, 21, 33]) ? creep
   Call: (14) conc(_3662, [_3352], [5, 8, 13, 21, 33]) ? creep
   Call: (15) conc(_3668, [_3352], [8, 13, 21, 33]) ? creep
   Call: (16) conc(_3674, [_3352], [13, 21, 33]) ? creep
   Call: (17) conc(_3680, [_3352], [21, 33]) ? creep
   Call: (18) conc(_3686, [_3352], [33]) ? creep
   Exit: (18) conc([], [33], [33]) ? creep
   Exit: (17) conc([21], [33], [21, 33]) ? creep
   Exit: (16) conc([13, 21], [33], [13, 21, 33]) ? creep
   Exit: (15) conc([8, 13, 21], [33], [8, 13, 21, 33]) ? creep
   Exit: (14) conc([5, 8, 13, 21], [33], [5, 8, 13, 21, 33]) ? creep
   Exit: (13) conc([3, 5, 8, 13, 21], [33], [3, 5, 8, 13, 21, 33]) ? creep
   Exit: (12) conc([2, 3, 5, 8, 13, 21], [33], [2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (11) conc([1, 2, 3, 5, 8, 13, 21], [33], [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (10) conc([1, 1, 2, 3, 5, 8, 13, 21], [33], [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Exit: (9) conc([0, 1, 1, 2, 3, 5, 8, 13|...], [33], [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Exit: (8) lasa(33, [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
Item = 33 .



(b)
 ?- lasb(Item,[a,b,c,d,e,f,g]).         
 Item = g .
 
 ?- lasb(Item,[0,1,2,3,4,5,6,7,8,9]).   
 Item = 9 .
 
 ?- lasb(Item,[0,1,1,2,3,5,8,13,21,33]).
 Item = 33 .


(b)のトレース
[trace]  ?- lasb(Item,[a,b,c,d,e,f,g]).         
   Call: (8) lasb(_2990, [a, b, c, d, e, f, g]) ? creep
   Call: (9) lasb(_2990, [b, c, d, e, f, g]) ? creep
   Call: (10) lasb(_2990, [c, d, e, f, g]) ? creep
   Call: (11) lasb(_2990, [d, e, f, g]) ? creep
   Call: (12) lasb(_2990, [e, f, g]) ? creep
   Call: (13) lasb(_2990, [f, g]) ? creep
   Call: (14) lasb(_2990, [g]) ? creep
   Exit: (14) lasb(g, [g]) ? creep
   Exit: (13) lasb(g, [f, g]) ? creep
   Exit: (12) lasb(g, [e, f, g]) ? creep
   Exit: (11) lasb(g, [d, e, f, g]) ? creep
   Exit: (10) lasb(g, [c, d, e, f, g]) ? creep
   Exit: (9) lasb(g, [b, c, d, e, f, g]) ? creep
   Exit: (8) lasb(g, [a, b, c, d, e, f, g]) ? creep
Item = g .

[trace]  ?- lasb(Item,[0,1,2,3,4,5,6,7,8,9]).   
   Call: (8) lasb(_3010, [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Call: (9) lasb(_3010, [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Call: (10) lasb(_3010, [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (11) lasb(_3010, [3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (12) lasb(_3010, [4, 5, 6, 7, 8, 9]) ? creep
   Call: (13) lasb(_3010, [5, 6, 7, 8, 9]) ? creep
   Call: (14) lasb(_3010, [6, 7, 8, 9]) ? creep
   Call: (15) lasb(_3010, [7, 8, 9]) ? creep
   Call: (16) lasb(_3010, [8, 9]) ? creep
   Call: (17) lasb(_3010, [9]) ? creep
   Exit: (17) lasb(9, [9]) ? creep
   Exit: (16) lasb(9, [8, 9]) ? creep
   Exit: (15) lasb(9, [7, 8, 9]) ? creep
   Exit: (14) lasb(9, [6, 7, 8, 9]) ? creep
   Exit: (13) lasb(9, [5, 6, 7, 8, 9]) ? creep
   Exit: (12) lasb(9, [4, 5, 6, 7, 8, 9]) ? creep
   Exit: (11) lasb(9, [3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (10) lasb(9, [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (9) lasb(9, [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Exit: (8) lasb(9, [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
Item = 9 .

[trace]  ?- lasb(Item,[0,1,1,2,3,5,8,13,21,33]).
   Call: (8) lasb(_3010, [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Call: (9) lasb(_3010, [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Call: (10) lasb(_3010, [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (11) lasb(_3010, [2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (12) lasb(_3010, [3, 5, 8, 13, 21, 33]) ? creep
   Call: (13) lasb(_3010, [5, 8, 13, 21, 33]) ? creep
   Call: (14) lasb(_3010, [8, 13, 21, 33]) ? creep
   Call: (15) lasb(_3010, [13, 21, 33]) ? creep
   Call: (16) lasb(_3010, [21, 33]) ? creep
   Call: (17) lasb(_3010, [33]) ? creep
   Exit: (17) lasb(33, [33]) ? creep
   Exit: (16) lasb(33, [21, 33]) ? creep
   Exit: (15) lasb(33, [13, 21, 33]) ? creep
   Exit: (14) lasb(33, [8, 13, 21, 33]) ? creep
   Exit: (13) lasb(33, [5, 8, 13, 21, 33]) ? creep
   Exit: (12) lasb(33, [3, 5, 8, 13, 21, 33]) ? creep
   Exit: (11) lasb(33, [2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (10) lasb(33, [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (9) lasb(33, [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Exit: (8) lasb(33, [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
Item = 33 .
*/


/*
 (実行例)
 (a)のconc関数を利用する場合は,本来のリストを連接させる働きを利用して,最後の一要素を発見するため,
 Listの最後の要素Itemを見つけるまでに余分な操作も必要となる.
 また,一番最後にItemがわかる仕組みとなっている.
 対して,(b)の場合は,再帰的にListの最後のItemを導き出すので,探索の半分あたりでItemが明らかになっているのが特徴的である.
 全ての実行例で3回ほど再帰的定義を用いたほうが探索回数が少なくなる.
 これは,concを用いると,発見されたItemと残りの要素が連接して,元のListと一致するかの処理が行われることに起因し,
 conc本来の機能が働いているためであると考えられる.


*/
