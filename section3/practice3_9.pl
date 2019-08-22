%演習3.9

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
