%演習3.8(教科書p.79)
%与えられた集合Setに対して,可能な部分集合を生成するプログラム

%Setが空のリスト（空集合）だった場合は,その部分集合は空集合のみ
subs([],[]).

%バックトラックを利用した再帰的定義により,部分集合の先頭を保存する
subs([X|Set],[X|Subset]) :-
  subs(Set,Subset).

%与えられたリストの先頭を順次取り除いていく
subs([_|Set],Subset) :-
  subs(Set,Subset).


/*
(実行例)

?- subs([a,b,c],S).  
S = [a, b, c] ;
S = [a, b] ;
S = [a, c] ;
S = [a] ;
S = [b, c] ;
S = [b] ;
S = [c] ;
S = [].

?- trace.
true.

[trace]  ?- subs([a,b,c],S).
   Call: (8) subs([a, b, c], _2966) ? creep
   Call: (9) subs([b, c], _3190) ? creep
   Call: (10) subs([c], _3196) ? creep
   Call: (11) subs([], _3202) ? creep
   Exit: (11) subs([], []) ? creep
   Exit: (10) subs([c], [c]) ? creep
   Exit: (9) subs([b, c], [b, c]) ? creep
   Exit: (8) subs([a, b, c], [a, b, c]) ? creep
S = [a, b, c] .





?- subs([0,1,2,3],S).
S = [0, 1, 2, 3] ;
S = [0, 1, 2] ;
S = [0, 1, 3] ;
S = [0, 1] ;
S = [0, 2, 3] ;
S = [0, 2] ;
S = [0, 3] ;
S = [0] ;
S = [1, 2, 3] ;
S = [1, 2] ;
S = [1, 3] ;
S = [1] ;
S = [2, 3] ;
S = [2] ;
S = [3] ;
S = [].

?- trace.
true.

[trace]  ?- subs([0,1,2,3],S).
   Call: (8) subs([0, 1, 2, 3], _4120) ? creep
   Call: (9) subs([1, 2, 3], _4350) ? creep
   Call: (10) subs([2, 3], _4356) ? creep
   Call: (11) subs([3], _4362) ? creep
   Call: (12) subs([], _4368) ? creep
   Exit: (12) subs([], []) ? creep
   Exit: (11) subs([3], [3]) ? creep
   Exit: (10) subs([2, 3], [2, 3]) ? creep
   Exit: (9) subs([1, 2, 3], [1, 2, 3]) ? creep
   Exit: (8) subs([0, 1, 2, 3], [0, 1, 2, 3]) ? creep
S = [0, 1, 2, 3] .


*/

/*
(考察・感想)
今回の課題では,再帰的定義を用いることによって,関数subs(Set, Subset)を作成した.
まず,subs([],[])によって,具体化されるように設定し,subs([X|Set], Subset) :- subs(Set, Subset)によって空集合が生み出されるのに対応する.
次に,subs([X|Set], [X|Subset]) :- subs(Set, Subset)によって要素数が一つ多い部分集合をバックトラックの利用によって生成する.
最後に,subs([X|Set], Subset) :- subs(Set, Subset)では,与えられた集合よりも要素数の少ない部分集合を生成する定義となっている.
以上のようにして,与えられた集合に対して,要素数を変化させたsubs(Set,Subset)の具体化を得ながら,部分集合を生成していく.

*/
