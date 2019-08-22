%演習3.9(別解)(教科書p.79・オリジナル)

conc([], L, L).

conc([X|L1], L2, [X|L3]) :-
  conc(L1, L2, L3).


%与えられたリストLの長さNの関係を表す関数len(L,N)の定義
len([], 0).

len([_|Tail], N) :-
  len(Tail, N1),
  N is 1 + N1.


%与えられたリストの先頭二つを分割リストに分配する
dividelist2([X,Y|L], [X|L1], [Y|L2]) :-
  dividelist2(L, L1, L2).

%分割の終了条件
%リストL1,L2の長さN1,N2の差の絶対値が1以下となり
%L1とL2を結合するとLとなるように定義
dividelist2(L, L1, L2) :-
  conc(L1, L2, L),
  len(L1, N1),
  len(L2, N2),
  N is N1 - N2,
  N =< 1,
  N >= -1.


/*
(実行例)
?- dividelist2([a,b,c,d,e,f,g], L1, L2).
L1 = [a, c, e],
L2 = [b, d, f, g] ;
L1 = [a, c, e, g],
L2 = [b, d, f] ;
L1 = [a, c, e],
L2 = [b, d, f, g] ;
L1 = [a, c, e, f],
L2 = [b, d, g] ;
L1 = [a, c, d],
L2 = [b, e, f, g] ;
L1 = [a, c, d, e],
L2 = [b, f, g] ;
L1 = [a, b, c],
L2 = [d, e, f, g] ;
L1 = [a, b, c, d],
L2 = [e, f, g] .

?- dividelist2([0,1,2,3,4,5,6,7,8,9], L1, L2).
L1 = [0, 2, 4, 6, 8],
L2 = [1, 3, 5, 7, 9] ;
L1 = [0, 2, 4, 6, 8],
L2 = [1, 3, 5, 7, 9] ;
L1 = [0, 2, 4, 6, 7],
L2 = [1, 3, 5, 8, 9] ;
L1 = [0, 2, 4, 5, 6],
L2 = [1, 3, 7, 8, 9] ;
L1 = [0, 2, 3, 4, 5],
L2 = [1, 6, 7, 8, 9] ;
L1 = [0, 1, 2, 3, 4],
L2 = [5, 6, 7, 8, 9] .

[trace]  ?- dividelist2([a,b,c,d,e,f,g], L1, L2).
   Call: (8) dividelist2([a, b, c, d, e, f, g], _3546, _3548) ? creep
   Call: (9) dividelist2([c, d, e, f, g], _3838, _3844) ? creep
   Call: (10) dividelist2([e, f, g], _3850, _3856) ? creep
   Call: (11) dividelist2([g], _3862, _3868) ? creep
   Call: (12) conc(_3862, _3868, [g]) ? creep
   Exit: (12) conc([], [g], [g]) ? creep
   Call: (12) len([], _3888) ? creep
   Exit: (12) len([], 0) ? creep
   Call: (12) len([g], _3888) ? creep
   Call: (13) len([], _3888) ? creep
   Exit: (13) len([], 0) ? creep
   Call: (13) _3892 is 1+0 ? creep
   Exit: (13) 1 is 1+0 ? creep
   Exit: (12) len([g], 1) ? creep
   Call: (12) _3898 is 0-1 ? creep
   Exit: (12) -1 is 0-1 ? creep
   Call: (12) -1=<1 ? creep
   Exit: (12) -1=<1 ? creep
   Call: (12) -1>= -1 ? creep
   Exit: (12) -1>= -1 ? creep
   Exit: (11) dividelist2([g], [], [g]) ? creep
   Exit: (10) dividelist2([e, f, g], [e], [f, g]) ? creep
   Exit: (9) dividelist2([c, d, e, f, g], [c, e], [d, f, g]) ? creep
   Exit: (8) dividelist2([a, b, c, d, e, f, g], [a, c, e], [b, d, f, g]) ? creep
L1 = [a, c, e],
L2 = [b, d, f, g] .


[trace]  ?- dividelist2([0,1,2,3,4,5,6,7,8,9], L1, L2).
   Call: (8) dividelist2([0, 1, 2, 3, 4, 5, 6, 7|...], _3014, _3016) ? creep
   Call: (9) dividelist2([2, 3, 4, 5, 6, 7, 8, 9], _3326, _3332) ? creep
   Call: (10) dividelist2([4, 5, 6, 7, 8, 9], _3338, _3344) ? creep
   Call: (11) dividelist2([6, 7, 8, 9], _3350, _3356) ? creep
   Call: (12) dividelist2([8, 9], _3362, _3368) ? creep
   Call: (13) dividelist2([], _3374, _3380) ? creep
   Call: (14) conc(_3374, _3380, []) ? creep
   Exit: (14) conc([], [], []) ? creep
   Call: (14) len([], _3400) ? creep
   Exit: (14) len([], 0) ? creep
   Call: (14) len([], _3400) ? creep
   Exit: (14) len([], 0) ? creep
   Call: (14) _3404 is 0-0 ? creep
   Exit: (14) 0 is 0-0 ? creep
   Call: (14) 0=<1 ? creep
   Exit: (14) 0=<1 ? creep
   Call: (14) 0>= -1 ? creep
   Exit: (14) 0>= -1 ? creep
   Exit: (13) dividelist2([], [], []) ? creep
   Exit: (12) dividelist2([8, 9], [8], [9]) ? creep
   Exit: (11) dividelist2([6, 7, 8, 9], [6, 8], [7, 9]) ? creep
   Exit: (10) dividelist2([4, 5, 6, 7, 8, 9], [4, 6, 8], [5, 7, 9]) ? creep
   Exit: (9) dividelist2([2, 3, 4, 5, 6, 7, 8, 9], [2, 4, 6, 8], [3, 5, 7, 9]) ? creep
   Exit: (8) dividelist2([0, 1, 2, 3, 4, 5, 6, 7|...], [0, 2, 4, 6, 8], [1, 3, 5, 7, 9]) ? creep
L1 = [0, 2, 4, 6, 8],
L2 = [1, 3, 5, 7, 9] .


*/

/*
(考察・感想)
この課題では,教科書3.9でdividelistのみを利用した定義とは異なり,
concのバックトラックとlenによってリストの長さを判定する働きを利用することで終了条件を判定した.
算術演算と大小関係によって,定義式の意味がわかりやすくなるメリットを感じた.


*/
