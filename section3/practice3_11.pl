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
