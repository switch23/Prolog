%演習7.8(教科書p.185)
%与えられた集合全ての部分集合の集合を求める関係powersetを組み込み述語bagofを用いて定義する.
%ただし,課題3.8で作成した関数subsを用いて定義する

%与えられた集合の部分集合を求める関係subsを定義

%Setが空のリスト（空集合）だった場合は,その部分集合は空集合のみ
subs([],[]) :- !.

%バックトラックを利用した再帰的定義により,部分集合の先頭を保存する
subs([X|Set],[X|Subset]) :-
  subs(Set,Subset).

%与えられたリストの先頭を順次取り除いていく
subs([_|Set],Subset) :-
  subs(Set,Subset).

%与えられた集合の全ての部分集合の集合を求める関係powersetの定義
powerset(Set,Subset) :-
  bagof(Subs,subs(Set,Subs),Subset).   %与えられた集合Subsからルールsubsによって得られる集合Subset


/*
(実行例)
?- powerset([a,b,c],Subset).
Subset = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []].

?- powerset([0,1,[2]], Subset).        
Subset = [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[2]], []].

?- powerset([[],[[]]], Subset).
Subset = [[[], [[]]], [[]], [[[]]], []].


(トレース)
[trace]  ?- powerset([a,b,c],Subset).           
   Call: (8) powerset([a, b, c], _2866) ? creep
^  Call: (9) bagof(_3092, subs([a, b, c], _3092), _2866) ? creep
   Call: (15) subs([a, b, c], _3092) ? creep
   Call: (16) subs([b, c], _3144) ? creep
   Call: (17) subs([c], _3150) ? creep
   Call: (18) subs([], _3156) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [b, c]) ? creep
   Exit: (15) subs([a, b, c], [a, b, c]) ? creep
   Redo: (17) subs([c], _3150) ? creep
   Call: (18) subs([], _3150) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], [b]) ? creep
   Exit: (15) subs([a, b, c], [a, b]) ? creep
   Redo: (16) subs([b, c], _3144) ? creep
   Call: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3150) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [c]) ? creep
   Exit: (15) subs([a, b, c], [a, c]) ? creep
   Redo: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3144) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], []) ? creep
   Exit: (15) subs([a, b, c], [a]) ? creep
   Redo: (15) subs([a, b, c], _3092) ? creep
   Call: (16) subs([b, c], _3092) ? creep
   Call: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3150) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [b, c]) ? creep
   Exit: (15) subs([a, b, c], [b, c]) ? creep
   Redo: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3144) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], [b]) ? creep
   Exit: (15) subs([a, b, c], [b]) ? creep
   Redo: (16) subs([b, c], _3092) ? creep
   Call: (17) subs([c], _3092) ? creep
   Call: (18) subs([], _3144) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [c]) ? creep
   Exit: (15) subs([a, b, c], [c]) ? creep
   Redo: (17) subs([c], _3092) ? creep
   Call: (18) subs([], _3092) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], []) ? creep
   Exit: (15) subs([a, b, c], []) ? creep
^  Call: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (9) bagof(_3092, user:subs([a, b, c], _3092), [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []]) ? creep
   Exit: (8) powerset([a, b, c], [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []]) ? creep
Subset = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []].

[trace]  ?- powerset([0,1,[2]], Subset).
   Call: (8) powerset([0, 1, [2]], _2872) ? creep
^  Call: (9) bagof(_3110, subs([0, 1, [2]], _3110), _2872) ? creep
   Call: (15) subs([0, 1, [2]], _3110) ? creep
   Call: (16) subs([1, [2]], _3162) ? creep
   Call: (17) subs([[2]], _3168) ? creep
   Call: (18) subs([], _3174) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [1, [2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [0, 1, [2]]) ? creep
   Redo: (17) subs([[2]], _3168) ? creep
   Call: (18) subs([], _3168) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], [1]) ? creep
   Exit: (15) subs([0, 1, [2]], [0, 1]) ? creep
   Redo: (16) subs([1, [2]], _3162) ? creep
   Call: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3168) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [[2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [0, [2]]) ? creep
   Redo: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3162) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], []) ? creep
   Exit: (15) subs([0, 1, [2]], [0]) ? creep
   Redo: (15) subs([0, 1, [2]], _3110) ? creep
   Call: (16) subs([1, [2]], _3110) ? creep
   Call: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3168) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [1, [2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [1, [2]]) ? creep
   Redo: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3162) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], [1]) ? creep
   Exit: (15) subs([0, 1, [2]], [1]) ? creep
   Redo: (16) subs([1, [2]], _3110) ? creep
   Call: (17) subs([[2]], _3110) ? creep
   Call: (18) subs([], _3162) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [[2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [[2]]) ? creep
   Redo: (17) subs([[2]], _3110) ? creep
   Call: (18) subs([], _3110) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], []) ? creep
   Exit: (15) subs([0, 1, [2]], []) ? creep
^  Call: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (9) bagof(_3110, user:subs([0, 1, [2]], _3110), [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[...]], []]) ? creep
   Exit: (8) powerset([0, 1, [2]], [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[...]], []]) ? creep
Subset = [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[2]], []].

[trace]  ?- powerset([[],[[]]], Subset).
   Call: (8) powerset([[], [[]]], _2866) ? creep
^  Call: (9) bagof(_3098, subs([[], [[]]], _3098), _2866) ? creep
   Call: (15) subs([[], [[]]], _3098) ? creep
   Call: (16) subs([[[]]], _3150) ? creep
   Call: (17) subs([], _3156) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], [[[]]]) ? creep
   Exit: (15) subs([[], [[]]], [[], [[]]]) ? creep
   Redo: (16) subs([[[]]], _3150) ? creep
   Call: (17) subs([], _3150) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], []) ? creep
   Exit: (15) subs([[], [[]]], [[]]) ? creep
   Redo: (15) subs([[], [[]]], _3098) ? creep
   Call: (16) subs([[[]]], _3098) ? creep
   Call: (17) subs([], _3150) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], [[[]]]) ? creep
   Exit: (15) subs([[], [[]]], [[[]]]) ? creep
   Redo: (16) subs([[[]]], _3098) ? creep
   Call: (17) subs([], _3098) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], []) ? creep
   Exit: (15) subs([[], [[]]], []) ? creep
^  Call: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (9) bagof(_3098, user:subs([[], [[]]], _3098), [[[], [[]]], [[]], [[[]]], []]) ? creep
   Exit: (8) powerset([[], [[]]], [[[], [[]]], [[]], [[[]]], []]) ? creep
Subset = [[[], [[]]], [[]], [[[]]], []].
*/


/*
(考察・感想)
本課題では,「Lが条件Pを満たす全てのXのリストである」という組み込み述語bagof(X,P,L)を用いて答える設問であった.
組み込み述語には,このように条件に合うものだけを抽出する便利な機能を持つものもあることを知り,自分で実装する手間がないことを考えると,その恩恵は計り知れないと感じた.
組み込み述語を効率的に用いると早い上に正確なプログラムを作れることを体感した課題でもあった.
同様に,多言語においてもパッケージやライブラリといった概念が存在するため,これらを有効に活用できるようになりたいと感じた.
*/
