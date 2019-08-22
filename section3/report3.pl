% rep03: 第03回 演習課題レポート
% 2019年5月11日         by 学籍番号：29114116 名前：増田大輝
%


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



%演習3.11(教科書p.80)
%与えられたリストListを平滑化したリストFlatListを生成する関数flatを定義するプログラム

%二つのリストを連接させる関数concの定義
conc([], L, L).

conc([X|L1], L2, [X|L3]) :-
  conc(L1, L2, L3).

%再帰的定義を用いて,与えられたリストをHeadとTailに分けて,
%Headを平滑化したリストと
%Tailを平滑化したリストを生成し,
%concのバックトラックを利用して,元のリストを平滑化したリストを得る.
flat([Head|Tail], FlatList) :-
  flat(Head, FlatListH),
  flat(Tail, FlatListT),
  conc(FlatListH, FlatListT, FlatList).

%空リストの平滑化
flat([], []).

%要素数が1のリストの平滑化
flat(List, [List]).

/*
(実行例)
L = [a, b, c, d, e, f] .

[trace]  ?- flat([a,b,[c,d],[],[[[e]]],f],L).
   Call: (8) flat([a, b, [c, d], [], [[[e]]], f], _3018) ? creep
   Call: (9) flat(a, _3308) ? creep
   Exit: (9) flat(a, [a]) ? creep
   Call: (9) flat([b, [c, d], [], [[[e]]], f], _3314) ? creep
   Call: (10) flat(b, _3314) ? creep
   Exit: (10) flat(b, [b]) ? creep
   Call: (10) flat([[c, d], [], [[[e]]], f], _3320) ? creep
   Call: (11) flat([c, d], _3320) ? creep
   Call: (12) flat(c, _3320) ? creep
   Exit: (12) flat(c, [c]) ? creep
   Call: (12) flat([d], _3326) ? creep
   Call: (13) flat(d, _3326) ? creep
   Exit: (13) flat(d, [d]) ? creep
   Call: (13) flat([], _3332) ? creep
   Exit: (13) flat([], []) ? creep
   Call: (13) conc([d], [], _3334) ? creep
   Call: (14) conc([], [], _3318) ? creep
   Exit: (14) conc([], [], []) ? creep
   Exit: (13) conc([d], [], [d]) ? creep
   Exit: (12) flat([d], [d]) ? creep
   Call: (12) conc([c], [d], _3340) ? creep
   Call: (13) conc([], [d], _3324) ? creep
   Exit: (13) conc([], [d], [d]) ? creep
   Exit: (12) conc([c], [d], [c, d]) ? creep
   Exit: (11) flat([c, d], [c, d]) ? creep
   Call: (11) flat([[], [[[e]]], f], _3344) ? creep
   Call: (12) flat([], _3344) ? creep
   Exit: (12) flat([], []) ? creep
   Call: (12) flat([[[[e]]], f], _3344) ? creep
   Call: (13) flat([[[e]]], _3344) ? creep
   Call: (14) flat([[e]], _3344) ? creep
   Call: (15) flat([e], _3344) ? creep
   Call: (16) flat(e, _3344) ? creep
   Exit: (16) flat(e, [e]) ? creep
   Call: (16) flat([], _3350) ? creep
   Exit: (16) flat([], []) ? creep
   Call: (16) conc([e], [], _3352) ? creep
   Call: (17) conc([], [], _3336) ? creep
   Exit: (17) conc([], [], []) ? creep
   Exit: (16) conc([e], [], [e]) ? creep
   Exit: (15) flat([e], [e]) ? creep
   Call: (15) flat([], _3356) ? creep
   Exit: (15) flat([], []) ? creep
   Call: (15) conc([e], [], _3358) ? creep
   Call: (16) conc([], [], _3342) ? creep
   Exit: (16) conc([], [], []) ? creep
   Exit: (15) conc([e], [], [e]) ? creep
   Exit: (14) flat([[e]], [e]) ? creep
   Call: (14) flat([], _3362) ? creep
   Exit: (14) flat([], []) ? creep
   Call: (14) conc([e], [], _3364) ? creep
   Call: (15) conc([], [], _3348) ? creep
   Exit: (15) conc([], [], []) ? creep
   Exit: (14) conc([e], [], [e]) ? creep
   Exit: (13) flat([[[e]]], [e]) ? creep
   Call: (13) flat([f], _3368) ? creep
   Call: (14) flat(f, _3368) ? creep
   Exit: (14) flat(f, [f]) ? creep
   Call: (14) flat([], _3374) ? creep
   Exit: (14) flat([], []) ? creep
   Call: (14) conc([f], [], _3376) ? creep
   Call: (15) conc([], [], _3360) ? creep
   Exit: (15) conc([], [], []) ? creep
   Exit: (14) conc([f], [], [f]) ? creep
   Exit: (13) flat([f], [f]) ? creep
   Call: (13) conc([e], [f], _3382) ? creep
   Call: (14) conc([], [f], _3366) ? creep
   Exit: (14) conc([], [f], [f]) ? creep
   Exit: (13) conc([e], [f], [e, f]) ? creep
   Exit: (12) flat([[[[e]]], f], [e, f]) ? creep
   Call: (12) conc([], [e, f], _3388) ? creep
   Exit: (12) conc([], [e, f], [e, f]) ? creep
   Exit: (11) flat([[], [[[e]]], f], [e, f]) ? creep
   Call: (11) conc([c, d], [e, f], _3388) ? creep
   Call: (12) conc([d], [e, f], _3372) ? creep
   Call: (13) conc([], [e, f], _3378) ? creep
   Exit: (13) conc([], [e, f], [e, f]) ? creep
   Exit: (12) conc([d], [e, f], [d, e, f]) ? creep
   Exit: (11) conc([c, d], [e, f], [c, d, e, f]) ? creep
   Exit: (10) flat([[c, d], [], [[[e]]], f], [c, d, e, f]) ? creep
   Call: (10) conc([b], [c, d, e, f], _3400) ? creep
   Call: (11) conc([], [c, d, e, f], _3384) ? creep
   Exit: (11) conc([], [c, d, e, f], [c, d, e, f]) ? creep
   Exit: (10) conc([b], [c, d, e, f], [b, c, d, e, f]) ? creep
   Exit: (9) flat([b, [c, d], [], [[[e]]], f], [b, c, d, e, f]) ? creep
   Call: (9) conc([a], [b, c, d, e, f], _3018) ? creep
   Call: (10) conc([], [b, c, d, e, f], _3390) ? creep
   Exit: (10) conc([], [b, c, d, e, f], [b, c, d, e, f]) ? creep
   Exit: (9) conc([a], [b, c, d, e, f], [a, b, c, d, e, f]) ? creep
   Exit: (8) flat([a, b, [c, d], [], [[[e]]], f], [a, b, c, d, e, f]) ? creep
L = [a, b, c, d, e, f] .
*/


/*
(考察・感想)
今回定義した関数は,再帰的定義を使用することにやって,元のリストを二つに分割し,それぞれの平滑化リストを求めた後に,
concのバックトラックよって統合し,もとのリストの平滑化リストを得ている.
したがって,全ての要素は空リストもしくは要素一つのリストとなると,マッチングによってflatは具体化され,そこからバックトラックを利用して徐々に要素数を増やしながら平滑化リストが生成されていく.
*/



%演習3.12（教科書p.85）
%オペレータを定義して,その主関数と構造を示す

%優先度300, xfx型の中置オペレータplays
:- op(300, xfx, plays).

%優先度200, xfy型の中置オペレータand
:- op(200, xfy, and).


/*
(実行例)
?- Term3 = plays(daichi, and(soccer, ice_hockey)).
Term3 = daichi plays soccer and ice_hockey.

?- Term4 = plays(tobise, and(shooting, and(basketball, baseball))).
Term4 = tobise plays shooting and basketball and baseball.
*/

/*
(考察・感想)
今回のオペレータの定義では,playsの優先度が300,andの優先度が200であるのでplaysの方が優先度が大きく,
一番外の主関数子としてはplaysが正しい.
その上で,andはxfy型の中置オペレータであることから,自身の関数の中にandを入れることが可能である.
以上のようにしてTerm3,Term4のような構文が成立する.
*/



%演習3.21(教科書p.92)
%与えられた整数N1,N2に対して,制約N1≦X≦N2を満たすような整数Xをバックトラックによって求める関数betの定義

%制約N1≦N2を満たす時のみX=N1として具体化する
bet(N1, N2, N1) :-
  N1 =< N2.

%制約N1<N2を満たす場合はbet(N1+1,N2,X)として制約条件を強める
bet(N1, N2, X) :-
  N1 < N2,
  Y is N1 + 1,
  bet(Y, N2, X).

/*
(実行例)
?- bet(10, 20, X).     
X = 10 ;
X = 11 ;
X = 12 ;
X = 13 ;
X = 14 ;
X = 15 ;
X = 16 ;
X = 17 ;
X = 18 ;
X = 19 ;
X = 20 .


[trace]  ?- bet(10, 20, X).
   Call: (8) bet(10, 20, _2950) ? creep
   Call: (9) 10=<20 ? creep
   Exit: (9) 10=<20 ? creep
   Exit: (8) bet(10, 20, 10) ? creep
X = 10 .


?- bet(-5, 5, X).   
X = -5 ;
X = -4 ;
X = -3 ;
X = -2 ;
X = -1 ;
X = 0 ;
X = 1 ;
X = 2 ;
X = 3 ;
X = 4 ;
X = 5 .


[trace]  ?- bet(-5, 5, X). 
   Call: (8) bet(-5, 5, _2948) ? creep
   Call: (9) -5=<5 ? creep
   Exit: (9) -5=<5 ? creep
   Exit: (8) bet(-5, 5, -5) ? creep
X = -5 .
*/


/*
(考察・感想)
Prologでは算術演算も行うことができ,N1の値を1ずつ大きくすることで制約条件の範囲内を逐次的に調べた.
また,大小比較によって制約条件を設定し,再帰的定義のコントロールに活かした.
今回の課題では,これらの機能と再帰的定義を組み合わせることによって,バックトラックで制約条件を満たす整数を全て求めた.
*/



%演習3.9(別解)(教科書p.79・オリジナル)

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