% rep02: 第02回 演習課題レポート
% 2019年4月27日         by 学籍番号：29114116 名前：増田大輝
%

%演習3.1(テキスト72ページ)

%リストを連接するconc関数の定義

%空のリストとリストLを結合してリストLを生成
conc([],L,L).

%二つのリストL1とL2を結合してリストL3を生成
conc([X | L1],L2,[X | L3]) :-
  conc(L1,L2,L3).


/*
(実行例)

(a)の実行例
 ?- L = [a,b,c,d,e,f,g],
 |    conc(L1,[_,_,_],L).
 L = [a, b, c, d, e, f, g],
 L1 = [a, b, c, d] ;
 false.
 
 ?- L = [0,1,2,3,4,5,6,7,8,9],
 |    conc(L1,[_,_,_],L).
 L = [0, 1, 2, 3, 4, 5, 6, 7, 8|...],
 L1 = [0, 1, 2, 3, 4, 5, 6] ;
 false.
 
 ?- L = [0,1,1,2,3,5,8,13,21,33],
 |    conc(L1,[_,_,_],L).
 L = [0, 1, 1, 2, 3, 5, 8, 13, 21|...],
 L1 = [0, 1, 1, 2, 3, 5, 8] ;
 false.

 (a)のトレース

 [trace]  ?- L = [a,b,c,d,e,f,g],
|    conc(L1,[_,_,_],L).
   Call: (9) _3654=[a, b, c, d, e, f, g] ? creep
   Exit: (9) [a, b, c, d, e, f, g]=[a, b, c, d, e, f, g] ? creep
   Call: (9) conc(_3678, [_3660, _3666, _3672], [a, b, c, d, e, f, g]) ? creep
   Call: (10) conc(_4116, [_3660, _3666, _3672], [b, c, d, e, f, g]) ? creep
   Call: (11) conc(_4122, [_3660, _3666, _3672], [c, d, e, f, g]) ? creep
   Call: (12) conc(_4128, [_3660, _3666, _3672], [d, e, f, g]) ? creep
   Call: (13) conc(_4134, [_3660, _3666, _3672], [e, f, g]) ? creep
   Exit: (13) conc([], [e, f, g], [e, f, g]) ? creep
   Exit: (12) conc([d], [e, f, g], [d, e, f, g]) ? creep
   Exit: (11) conc([c, d], [e, f, g], [c, d, e, f, g]) ? creep
   Exit: (10) conc([b, c, d], [e, f, g], [b, c, d, e, f, g]) ? creep
   Exit: (9) conc([a, b, c, d], [e, f, g], [a, b, c, d, e, f, g]) ? creep
L = [a, b, c, d, e, f, g],
L1 = [a, b, c, d] .

 [trace]  ?- L = [0,1,2,3,4,5,6,7,8,9],
|    conc(L1,[_,_,_],L).
   Call: (9) _3482=[0, 1, 2, 3, 4, 5, 6, 7|...] ? creep
   Exit: (9) [0, 1, 2, 3, 4, 5, 6, 7|...]=[0, 1, 2, 3, 4, 5, 6, 7|...] ? creep
   Call: (9) conc(_3506, [_3488, _3494, _3500], [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Call: (10) conc(_3960, [_3488, _3494, _3500], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Call: (11) conc(_3966, [_3488, _3494, _3500], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (12) conc(_3972, [_3488, _3494, _3500], [3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (13) conc(_3978, [_3488, _3494, _3500], [4, 5, 6, 7, 8, 9]) ? creep
   Call: (14) conc(_3984, [_3488, _3494, _3500], [5, 6, 7, 8, 9]) ? creep
   Call: (15) conc(_3990, [_3488, _3494, _3500], [6, 7, 8, 9]) ? creep
   Call: (16) conc(_3996, [_3488, _3494, _3500], [7, 8, 9]) ? creep
   Exit: (16) conc([], [7, 8, 9], [7, 8, 9]) ? creep
   Exit: (15) conc([6], [7, 8, 9], [6, 7, 8, 9]) ? creep
   Exit: (14) conc([5, 6], [7, 8, 9], [5, 6, 7, 8, 9]) ? creep
   Exit: (13) conc([4, 5, 6], [7, 8, 9], [4, 5, 6, 7, 8, 9]) ? creep
   Exit: (12) conc([3, 4, 5, 6], [7, 8, 9], [3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (11) conc([2, 3, 4, 5, 6], [7, 8, 9], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (10) conc([1, 2, 3, 4, 5, 6], [7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Exit: (9) conc([0, 1, 2, 3, 4, 5, 6], [7, 8, 9], [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
L = [0, 1, 2, 3, 4, 5, 6, 7, 8|...],
L1 = [0, 1, 2, 3, 4, 5, 6] .

[trace]  ?- L = [0,1,2,3,4,5,6,7,8,9],
[trace]  ?-                           
[trace]  ?- L = [0,1,1,2,3,5,8,13,21,33],                                                
|    conc(L1,[_,_,_],L).
   Call: (9) _3484=[0, 1, 1, 2, 3, 5, 8, 13|...] ? creep
   Exit: (9) [0, 1, 1, 2, 3, 5, 8, 13|...]=[0, 1, 1, 2, 3, 5, 8, 13|...] ? creep
   Call: (9) conc(_3508, [_3490, _3496, _3502], [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Call: (10) conc(_3964, [_3490, _3496, _3502], [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Call: (11) conc(_3970, [_3490, _3496, _3502], [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (12) conc(_3976, [_3490, _3496, _3502], [2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (13) conc(_3982, [_3490, _3496, _3502], [3, 5, 8, 13, 21, 33]) ? creep
   Call: (14) conc(_3988, [_3490, _3496, _3502], [5, 8, 13, 21, 33]) ? creep
   Call: (15) conc(_3994, [_3490, _3496, _3502], [8, 13, 21, 33]) ? creep
   Call: (16) conc(_4000, [_3490, _3496, _3502], [13, 21, 33]) ? creep
   Exit: (16) conc([], [13, 21, 33], [13, 21, 33]) ? creep
   Exit: (15) conc([8], [13, 21, 33], [8, 13, 21, 33]) ? creep
   Exit: (14) conc([5, 8], [13, 21, 33], [5, 8, 13, 21, 33]) ? creep
   Exit: (13) conc([3, 5, 8], [13, 21, 33], [3, 5, 8, 13, 21, 33]) ? creep
   Exit: (12) conc([2, 3, 5, 8], [13, 21, 33], [2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (11) conc([1, 2, 3, 5, 8], [13, 21, 33], [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (10) conc([1, 1, 2, 3, 5, 8], [13, 21, 33], [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Exit: (9) conc([0, 1, 1, 2, 3, 5, 8], [13, 21, 33], [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
L = [0, 1, 1, 2, 3, 5, 8, 13, 21|...],
L1 = [0, 1, 1, 2, 3, 5, 8] .



 (b)の実行例
 ?- L = [a,b,c,d,e,f,g],
 |    conc(L1,[_,_,_],L),
 |    conc([_,_,_],L2,L1).
 L = [a, b, c, d, e, f, g],
 L1 = [a, b, c, d],
 L2 = [d] ;
 false.
 
 ?- L = [0,1,2,3,4,5,6,7,8,9],
 |    conc(L1,[_,_,_],L),
 |    conc([_,_,_],L2,L1).
 L = [0, 1, 2, 3, 4, 5, 6, 7, 8|...],
 L1 = [0, 1, 2, 3, 4, 5, 6],
 L2 = [3, 4, 5, 6] ;
 false.
 
 ?- L = [0,1,1,2,3,5,8,13,21,33],
 |    conc(L1,[_,_,_],L),
 |    conc([_,_,_],L2,L1).
 L = [0, 1, 1, 2, 3, 5, 8, 13, 21|...],
 L1 = [0, 1, 1, 2, 3, 5, 8],
 L2 = [2, 3, 5, 8] ;
 false.

 (b)のトレース 
[trace]  ?- L = [a,b,c,d,e,f,g],                                                         
|    conc(L1,[_,_,_],L),
|    conc([_,_,_],L2,L1).
   Call: (9) _3780=[a, b, c, d, e, f, g] ? creep
   Exit: (9) [a, b, c, d, e, f, g]=[a, b, c, d, e, f, g] ? creep
   Call: (9) conc(_3804, [_3786, _3792, _3798], [a, b, c, d, e, f, g]) ? creep
   Call: (10) conc(_4432, [_3786, _3792, _3798], [b, c, d, e, f, g]) ? creep
   Call: (11) conc(_4438, [_3786, _3792, _3798], [c, d, e, f, g]) ? creep
   Call: (12) conc(_4444, [_3786, _3792, _3798], [d, e, f, g]) ? creep
   Call: (13) conc(_4450, [_3786, _3792, _3798], [e, f, g]) ? creep
   Exit: (13) conc([], [e, f, g], [e, f, g]) ? creep
   Exit: (12) conc([d], [e, f, g], [d, e, f, g]) ? creep
   Exit: (11) conc([c, d], [e, f, g], [c, d, e, f, g]) ? creep
   Exit: (10) conc([b, c, d], [e, f, g], [b, c, d, e, f, g]) ? creep
   Exit: (9) conc([a, b, c, d], [e, f, g], [a, b, c, d, e, f, g]) ? creep
   Call: (9) conc([_3812, _3818, _3824], _3832, [a, b, c, d]) ? creep
   Call: (10) conc([_3818, _3824], _3832, [b, c, d]) ? creep
   Call: (11) conc([_3824], _3832, [c, d]) ? creep
   Call: (12) conc([], _3832, [d]) ? creep
   Exit: (12) conc([], [d], [d]) ? creep
   Exit: (11) conc([c], [d], [c, d]) ? creep
   Exit: (10) conc([b, c], [d], [b, c, d]) ? creep
   Exit: (9) conc([a, b, c], [d], [a, b, c, d]) ? creep
L = [a, b, c, d, e, f, g],
L1 = [a, b, c, d],
L2 = [d]  


 [trace]  ?- L = [0,1,2,3,4,5,6,7,8,9],
|    conc(L1,[_,_,_],L),
|    conc([_,_,_],L2,L1).
   Call: (9) _3800=[0, 1, 2, 3, 4, 5, 6, 7|...] ? creep
   Exit: (9) [0, 1, 2, 3, 4, 5, 6, 7|...]=[0, 1, 2, 3, 4, 5, 6, 7|...] ? creep
   Call: (9) conc(_3824, [_3806, _3812, _3818], [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Call: (10) conc(_4456, [_3806, _3812, _3818], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Call: (11) conc(_4462, [_3806, _3812, _3818], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (12) conc(_4468, [_3806, _3812, _3818], [3, 4, 5, 6, 7, 8, 9]) ? creep
   Call: (13) conc(_4474, [_3806, _3812, _3818], [4, 5, 6, 7, 8, 9]) ? creep
   Call: (14) conc(_4480, [_3806, _3812, _3818], [5, 6, 7, 8, 9]) ? creep
   Call: (15) conc(_4486, [_3806, _3812, _3818], [6, 7, 8, 9]) ? creep
   Call: (16) conc(_4492, [_3806, _3812, _3818], [7, 8, 9]) ? creep
   Exit: (16) conc([], [7, 8, 9], [7, 8, 9]) ? creep
   Exit: (15) conc([6], [7, 8, 9], [6, 7, 8, 9]) ? creep
   Exit: (14) conc([5, 6], [7, 8, 9], [5, 6, 7, 8, 9]) ? creep
   Exit: (13) conc([4, 5, 6], [7, 8, 9], [4, 5, 6, 7, 8, 9]) ? creep
   Exit: (12) conc([3, 4, 5, 6], [7, 8, 9], [3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (11) conc([2, 3, 4, 5, 6], [7, 8, 9], [2, 3, 4, 5, 6, 7, 8, 9]) ? creep
   Exit: (10) conc([1, 2, 3, 4, 5, 6], [7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8|...]) ? creep
   Exit: (9) conc([0, 1, 2, 3, 4, 5, 6], [7, 8, 9], [0, 1, 2, 3, 4, 5, 6, 7|...]) ? creep
   Call: (9) conc([_3832, _3838, _3844], _3852, [0, 1, 2, 3, 4, 5, 6]) ? creep
   Call: (10) conc([_3838, _3844], _3852, [1, 2, 3, 4, 5, 6]) ? creep
   Call: (11) conc([_3844], _3852, [2, 3, 4, 5, 6]) ? creep
   Call: (12) conc([], _3852, [3, 4, 5, 6]) ? creep
   Exit: (12) conc([], [3, 4, 5, 6], [3, 4, 5, 6]) ? creep
   Exit: (11) conc([2], [3, 4, 5, 6], [2, 3, 4, 5, 6]) ? creep
   Exit: (10) conc([1, 2], [3, 4, 5, 6], [1, 2, 3, 4, 5, 6]) ? creep
   Exit: (9) conc([0, 1, 2], [3, 4, 5, 6], [0, 1, 2, 3, 4, 5, 6]) ? creep
L = [0, 1, 2, 3, 4, 5, 6, 7, 8|...],
L1 = [0, 1, 2, 3, 4, 5, 6],
L2 = [3, 4, 5, 6] .

[trace]  ?- L = [0,1,1,2,3,5,8,13,21,33],
|    conc(L1,[_,_,_],L),
|    conc([_,_,_],L2,L1).
   Call: (9) _3800=[0, 1, 1, 2, 3, 5, 8, 13|...] ? creep
   Exit: (9) [0, 1, 1, 2, 3, 5, 8, 13|...]=[0, 1, 1, 2, 3, 5, 8, 13|...] ? creep
   Call: (9) conc(_3824, [_3806, _3812, _3818], [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Call: (10) conc(_4472, [_3806, _3812, _3818], [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Call: (11) conc(_4478, [_3806, _3812, _3818], [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (12) conc(_4484, [_3806, _3812, _3818], [2, 3, 5, 8, 13, 21, 33]) ? creep
   Call: (13) conc(_4490, [_3806, _3812, _3818], [3, 5, 8, 13, 21, 33]) ? creep
   Call: (14) conc(_4496, [_3806, _3812, _3818], [5, 8, 13, 21, 33]) ? creep
   Call: (15) conc(_4502, [_3806, _3812, _3818], [8, 13, 21, 33]) ? creep
   Call: (16) conc(_4508, [_3806, _3812, _3818], [13, 21, 33]) ? creep
   Exit: (16) conc([], [13, 21, 33], [13, 21, 33]) ? creep
   Exit: (15) conc([8], [13, 21, 33], [8, 13, 21, 33]) ? creep
   Exit: (14) conc([5, 8], [13, 21, 33], [5, 8, 13, 21, 33]) ? creep
   Exit: (13) conc([3, 5, 8], [13, 21, 33], [3, 5, 8, 13, 21, 33]) ? creep
   Exit: (12) conc([2, 3, 5, 8], [13, 21, 33], [2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (11) conc([1, 2, 3, 5, 8], [13, 21, 33], [1, 2, 3, 5, 8, 13, 21, 33]) ? creep
   Exit: (10) conc([1, 1, 2, 3, 5, 8], [13, 21, 33], [1, 1, 2, 3, 5, 8, 13, 21|...]) ? creep
   Exit: (9) conc([0, 1, 1, 2, 3, 5, 8], [13, 21, 33], [0, 1, 1, 2, 3, 5, 8, 13|...]) ? creep
   Call: (9) conc([_3832, _3838, _3844], _3852, [0, 1, 1, 2, 3, 5, 8]) ? creep
   Call: (10) conc([_3838, _3844], _3852, [1, 1, 2, 3, 5, 8]) ? creep
   Call: (11) conc([_3844], _3852, [1, 2, 3, 5, 8]) ? creep
   Call: (12) conc([], _3852, [2, 3, 5, 8]) ? creep
   Exit: (12) conc([], [2, 3, 5, 8], [2, 3, 5, 8]) ? creep
   Exit: (11) conc([1], [2, 3, 5, 8], [1, 2, 3, 5, 8]) ? creep
   Exit: (10) conc([1, 1], [2, 3, 5, 8], [1, 1, 2, 3, 5, 8]) ? creep
   Exit: (9) conc([0, 1, 1], [2, 3, 5, 8], [0, 1, 1, 2, 3, 5, 8]) ? creep
L = [0, 1, 1, 2, 3, 5, 8, 13, 21|...],
L1 = [0, 1, 1, 2, 3, 5, 8],
L2 = [2, 3, 5, 8] .
*/


/* 
 (考察・感想・評価)
 conc関数には,二つのリストL1,L2を連接して新たなリストL3を生成するという本来の機能がある一方で,
 リストL3を先に定義し,そのリストの要素に対して何らかの操作を指定し,条件に見合う要素のみを持つリストを具体化させることも可能である.
 今回の課題では,与えられたリストの先頭または最後尾の複数個の要素を削除したリストを生成した.
 Prologに置いて,条件という知識によって,与えられた情報から所望の要素を抽出できることを確かめることができた.
 また,(b)のように処理を多段化すると,複雑な条件を指定することも可能であり,柔軟性のある知識表現が可能となる.
 トレースからもわかるように,探索が進むにつれ,得たいリストの要素が一つずつ追加されていくのも特徴的であった.

*/



%演習3.2(テキスト73ページ)

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



%演習3.4(テキスト79ページ)

%空のリストがListとして入力された場合,終了する.
rev([],[]).

%入力されたリストをHeadとListに分割し,目標をrev(List,ReversedListEx)に置換する.
%ReversedListExと[Head]を結合し,要素が逆転したReversedListを表示する.
rev([Head|List],ReversedList) :-
  rev(List,ReversedListEx),
    conc(ReversedListEx,[Head],ReversedList).


    /*
    (実行例)
    ?- List = [a,b,c,d],
    |    rev(List,ReversedList).
    List = [a, b, c, d],
    ReversedList = [d, c, b, a].

    ?- List = [],
    |    rev(List,ReversedList).
    List = ReversedList, ReversedList = [].

    (トレース)
    [trace]  ?- List = [a,b,c,d],
    |    rev(List,ReversedList).
       Call: (9) _3270=[a, b, c, d] ? creep
       Exit: (9) [a, b, c, d]=[a, b, c, d] ? creep
       Call: (9) rev([a, b, c, d], _3278) ? creep
       Call: (10) rev([b, c, d], _3658) ? creep
       Call: (11) rev([c, d], _3658) ? creep
       Call: (12) rev([d], _3658) ? creep
       Call: (13) rev([], _3658) ? creep
       Exit: (13) rev([], []) ? creep
       Call: (13) conc([], [d], _3666) ? creep
       Exit: (13) conc([], [d], [d]) ? creep
       Exit: (12) rev([d], [d]) ? creep
       Call: (12) conc([d], [c], _3672) ? creep
       Call: (13) conc([], [c], _3656) ? creep
       Exit: (13) conc([], [c], [c]) ? creep
       Exit: (12) conc([d], [c], [d, c]) ? creep
       Exit: (11) rev([c, d], [d, c]) ? creep
       Call: (11) conc([d, c], [b], _3684) ? creep
       Call: (12) conc([c], [b], _3668) ? creep
       Call: (13) conc([], [b], _3674) ? creep
       Exit: (13) conc([], [b], [b]) ? creep
       Exit: (12) conc([c], [b], [c, b]) ? creep
       Exit: (11) conc([d, c], [b], [d, c, b]) ? creep
       Exit: (10) rev([b, c, d], [d, c, b]) ? creep
       Call: (10) conc([d, c, b], [a], _3278) ? creep
       Call: (11) conc([c, b], [a], _3686) ? creep
       Call: (12) conc([b], [a], _3692) ? creep
       Call: (13) conc([], [a], _3698) ? creep
       Exit: (13) conc([], [a], [a]) ? creep
       Exit: (12) conc([b], [a], [b, a]) ? creep
       Exit: (11) conc([c, b], [a], [c, b, a]) ? creep
       Exit: (10) conc([d, c, b], [a], [d, c, b, a]) ? creep
       Exit: (9) rev([a, b, c, d], [d, c, b, a]) ? creep
       List = [a, b, c, d],
       ReversedList = [d, c, b, a].

    [trace]  ?- List = [],
    |    rev(List,ReversedList).
       Call: (9) _3244=[] ? creep
       Exit: (9) []=[] ? creep
       Call: (9) rev([], _3252) ? creep
       Exit: (9) rev([], []) ? creep
       List = ReversedList, ReversedList = [].

    [trace]  ?- List = [0,1,2,3,4],
    |    rev(List,ReversedList).
       Call: (9) _3756=[0, 1, 2, 3, 4] ? creep
       Exit: (9) [0, 1, 2, 3, 4]=[0, 1, 2, 3, 4] ? creep
       Call: (9) rev([0, 1, 2, 3, 4], _3764) ? creep
       Call: (10) rev([1, 2, 3, 4], _4158) ? creep
       Call: (11) rev([2, 3, 4], _4158) ? creep
       Call: (12) rev([3, 4], _4158) ? creep
       Call: (13) rev([4], _4158) ? creep
       Call: (14) rev([], _4158) ? creep
       Exit: (14) rev([], []) ? creep
       Call: (14) conc([], [4], _4166) ? creep
       Exit: (14) conc([], [4], [4]) ? creep
       Exit: (13) rev([4], [4]) ? creep
       Call: (13) conc([4], [3], _4172) ? creep
       Call: (14) conc([], [3], _4156) ? creep
       Exit: (14) conc([], [3], [3]) ? creep
       Exit: (13) conc([4], [3], [4, 3]) ? creep
       Exit: (12) rev([3, 4], [4, 3]) ? creep
       Call: (12) conc([4, 3], [2], _4184) ? creep
       Call: (13) conc([3], [2], _4168) ? creep
       Call: (14) conc([], [2], _4174) ? creep
       Exit: (14) conc([], [2], [2]) ? creep
       Exit: (13) conc([3], [2], [3, 2]) ? creep
       Exit: (12) conc([4, 3], [2], [4, 3, 2]) ? creep
       Exit: (11) rev([2, 3, 4], [4, 3, 2]) ? creep
       Call: (11) conc([4, 3, 2], [1], _4202) ? creep
       Call: (12) conc([3, 2], [1], _4186) ? creep
       Call: (13) conc([2], [1], _4192) ? creep
       Call: (14) conc([], [1], _4198) ? creep
       Exit: (14) conc([], [1], [1]) ? creep
       Exit: (13) conc([2], [1], [2, 1]) ? creep
       Exit: (12) conc([3, 2], [1], [3, 2, 1]) ? creep
       Exit: (11) conc([4, 3, 2], [1], [4, 3, 2, 1]) ? creep
       Exit: (10) rev([1, 2, 3, 4], [4, 3, 2, 1]) ? creep
       Call: (10) conc([4, 3, 2, 1], [0], _3764) ? creep
       Call: (11) conc([3, 2, 1], [0], _4210) ? creep
       Call: (12) conc([2, 1], [0], _4216) ? creep
       Call: (13) conc([1], [0], _4222) ? creep
       Call: (14) conc([], [0], _4228) ? creep
       Exit: (14) conc([], [0], [0]) ? creep
       Exit: (13) conc([1], [0], [1, 0]) ? creep
       Exit: (12) conc([2, 1], [0], [2, 1, 0]) ? creep
       Exit: (11) conc([3, 2, 1], [0], [3, 2, 1, 0]) ? creep     
       Exit: (10) conc([4, 3, 2, 1], [0], [4, 3, 2, 1, 0]) ? creep
       Exit: (9) rev([0, 1, 2, 3, 4], [4, 3, 2, 1, 0]) ? creep	
       List = [0, 1, 2, 3, 4],	
       ReversedList = [4, 3, 2, 1, 0]
*/



/*
       (考察・感想・評価)
       与えられたリストを逆転させる関数revを定義するにあたって,再帰的定義とconcの両方を用いているのが特徴的である.
       実際にトレースした結果からも,はじめは再帰的な関数呼び出しによって,rev([],[])が具体化される.
       次にconcによって新たなリストが生成され,リストと要素を逆転させたリストが生成されていく.
       この動作を繰り返すことで最終的には目的のリストが生成される.
*/




%演習3.9(テキスト79ページ)

%リストLを分割し,要素数がほぼ等しい二つのリストL1とL2に分ける関数dividelist関数

%空のリストLが入力された場合,L1,L2=[]として具体化し,終了する.
dividelist([],[],[]).

%要素数が一つだけのリストLが入力された場合,同じリストと空のリストを返す.
dividelist([X],[X],[]).

%リストLが入力されたとき,Lの先頭の二つの要素をそれぞれ先頭として持つ二つのリストを具体化する.
%また,目標をdividelist(List,List1,List2)に置き換える.
dividelist([X,Y|List],[X|List1],[Y|List2]) :-
  dividelist(List,List1,List2).


  /*
  (実行例)
  ?- L = [],
  |    dividelist(L,L1,L2).
  L = L1, L1 = L2, L2 = [].

  ?- L = [a,b,c,d,e,f,g],
  |    dividelist(L,L1,L2).
  L = [a, b, c, d, e, f, g],
  L1 = [a, c, e, g],
  L2 = [b, d, f] .

  ?- L = [0,1,2,3],
  |    dividelist(L,L1,L2).
  L = [0, 1, 2, 3],
  L1 = [0, 2],
  L2 = [1, 3].


  [trace]  ?- L = [],
  |    dividelist(L,L1,L2).
     Call: (9) _3266=[] ? creep
     Exit: (9) []=[] ? creep
     Call: (9) dividelist([], _3274, _3276) ? creep
     Exit: (9) dividelist([], [], []) ? creep
     L = L1, L1 = L2, L2 = [].

  [trace]  ?- L = [a,b,c,d,e,f,g],
  |    dividelist(L,L1,L2).
     Call: (9) _3312=[a, b, c, d, e, f, g] ? creep
     Exit: (9) [a, b, c, d, e, f, g]=[a, b, c, d, e, f, g] ? creep
     Call: (9) dividelist([a, b, c, d, e, f, g], _3320, _3322) ? creep
     Call: (10) dividelist([c, d, e, f, g], _3750, _3756) ? creep
     Call: (11) dividelist([e, f, g], _3762, _3768) ? creep
     Call: (12) dividelist([g], _3774, _3780) ? creep
     Exit: (12) dividelist([g], [g], []) ? creep
     Exit: (11) dividelist([e, f, g], [e, g], [f]) ? creep
     Exit: (10) dividelist([c, d, e, f, g], [c, e, g], [d, f]) ? creep
     Exit: (9) dividelist([a, b, c, d, e, f, g], [a, c, e, g], [b, d, f]) ? creep
     L = [a, b, c, d, e, f, g],
     L1 = [a, c, e, g],
     L2 = [b, d, f] .

  [trace]  ?- L = [0,1,2,3],
  |    dividelist(L,L1,L2).
     Call: (9) _3292=[0, 1, 2, 3] ? creep
     Exit: (9) [0, 1, 2, 3]=[0, 1, 2, 3] ? creep
     Call: (9) dividelist([0, 1, 2, 3], _3300, _3302) ? creep
     Call: (10) dividelist([2, 3], _3714, _3720) ? creep
     Call: (11) dividelist([], _3726, _3732) ? creep
     Exit: (11) dividelist([], [], []) ? creep
     Exit: (10) dividelist([2, 3], [2], [3]) ? creep
     Exit: (9) dividelist([0, 1, 2, 3], [0, 2], [1, 3]) ? creep
     L = [0, 1, 2, 3],
     L1 = [0, 2],
     L2 = [1, 3].
*/


/*
 (考察・感想・評価)
 再帰的定義を用いて,与えられたリストの先頭か順に二つのリストL1とL2に振り分ける.
 また,元のリストの要素数の偶奇を考える必要があり,
 空のリストが入力された場合,要素数が1つのリストが入力された場合のふた通りの具体化を考える必要がある.
 したがって,トレースからもわかるように,最初に連続してCallが行われ,一度具体化が行われると,
 そこから連続してExitが行われる.
*/
