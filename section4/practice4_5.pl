%演習4.5(教科書p.105)
%非決定性オートマトンに最大操作数を設けた関数acceptsを定義する

%受理状態を定義
final(s3).

%状態遷移を定義
trans(s1, a, s1).
trans(s1, a, s2).
trans(s1, b, s1).
trans(s2, b, s3).
trans(s3, b, s4).

%無言遷移を定義
silent(s2, s4).
silent(s3, s1).

%最大操作数以内で状態Sから入力Stringによって受理状態に到達するかの関係を表す関数accepts(S, String, MaxMoves)
%入力が空リストの場合, その時の状態が受理状態にあれば受理する.
accepts(S, [], _) :-
  final(S).

%操作数の制限下において,現段階での状態と遷移が状態遷移の定義にあれば適応する.
%ただし,最大操作数を一つ減らす.
accepts(S, [X|Rest], MaxMoves) :-
  MaxMoves > 0,
  trans(S, X, S1),
  MaxMovesEx is MaxMoves - 1,
  accepts(S1, Rest, MaxMovesEx).

%操作数の制限下において,現段階での状態からの無言遷移が定義にあれば適応する.
%ただし,最大操作数を一つ減らす.
accepts(S, String, MaxMoves) :-
  MaxMoves > 0,
  silent(S, S1),
  MaxMovesEx is MaxMoves - 1,
  accepts(S1, String, MaxMovesEx).


/*

(実行例)

tring = [a, a, a, a, b] ;
String = [a, a, a, b] ;
String = [a, a, b, a, b] ;
String = [a, a, b] ;
String = [a, b, a, a, b] ;
String = [a, b, a, b] ;
String = [a, b, b, a, b] ;
String = [a, b] ;
String = [a, b, a, b] ;
String = [b, a, a, a, b] ;
String = [b, a, a, b] ;
String = [b, a, b, a, b] ;
String = [b, a, b] ;
String = [b, b, a, a, b] ;
String = [b, b, a, b] ;
String = [b, b, b, a, b] ;
false.

?- accepts(s3, String, 3).
String = [] ;
String = [a, b] ;
false.



(トレース)

[trace]  ?- accepts(s1, String, 5).
   Call: (8) accepts(s1, _2950, 5) ? creep
   Call: (9) final(s1) ? creep
   Fail: (9) final(s1) ? creep
   Redo: (8) accepts(s1, _2950, 5) ? creep
   Call: (9) 5>0 ? creep
   Exit: (9) 5>0 ? creep
   Call: (9) trans(s1, _3158, _3182) ? creep
   Exit: (9) trans(s1, a, s1) ? creep
   Call: (9) _3184 is 5+ -1 ? creep
   Exit: (9) 4 is 5+ -1 ? creep
   Call: (9) accepts(s1, _3160, 4) ? creep
   Call: (10) final(s1) ? creep
   Fail: (10) final(s1) ? creep
   Redo: (9) accepts(s1, _3160, 4) ? creep
   Call: (10) 4>0 ? creep
   Exit: (10) 4>0 ? creep
   Call: (10) trans(s1, _3170, _3194) ? creep
   Exit: (10) trans(s1, a, s1) ? creep
   Call: (10) _3196 is 4+ -1 ? creep
   Exit: (10) 3 is 4+ -1 ? creep
   Call: (10) accepts(s1, _3172, 3) ? creep
   Call: (11) final(s1) ? creep
   Fail: (11) final(s1) ? creep
   Redo: (10) accepts(s1, _3172, 3) ? creep
   Call: (11) 3>0 ? creep
   Exit: (11) 3>0 ? creep
   Call: (11) trans(s1, _3182, _3206) ? creep
   Exit: (11) trans(s1, a, s1) ? creep
   Call: (11) _3208 is 3+ -1 ? creep
   Exit: (11) 2 is 3+ -1 ? creep
   Call: (11) accepts(s1, _3184, 2) ? creep
   Call: (12) final(s1) ? creep
   Fail: (12) final(s1) ? creep
   Redo: (11) accepts(s1, _3184, 2) ? creep
   Call: (12) 2>0 ? creep
   Exit: (12) 2>0 ? creep
   Call: (12) trans(s1, _3194, _3218) ? creep
   Exit: (12) trans(s1, a, s1) ? creep
   Call: (12) _3220 is 2+ -1 ? creep
   Exit: (12) 1 is 2+ -1 ? creep
   Call: (12) accepts(s1, _3196, 1) ? creep
   Call: (13) final(s1) ? creep
   Fail: (13) final(s1) ? creep
   Redo: (12) accepts(s1, _3196, 1) ? creep
   Call: (13) 1>0 ? creep
   Exit: (13) 1>0 ? creep
   Call: (13) trans(s1, _3206, _3230) ? creep
   Exit: (13) trans(s1, a, s1) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) final(s1) ? creep
   Fail: (14) final(s1) ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Fail: (13) accepts(s1, _3208, 0) ? creep
   Redo: (13) trans(s1, _3206, _3230) ? creep
   Exit: (13) trans(s1, a, s2) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s2, _3208, 0) ? creep
   Call: (14) final(s2) ? creep
   Fail: (14) final(s2) ? creep
   Redo: (13) accepts(s2, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Redo: (13) accepts(s2, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Fail: (13) accepts(s2, _3208, 0) ? creep
   Redo: (13) trans(s1, _3206, _3230) ? creep
   Exit: (13) trans(s1, b, s1) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) final(s1) ? creep
   Fail: (14) final(s1) ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Fail: (13) accepts(s1, _3208, 0) ? creep
   Redo: (12) accepts(s1, _3196, 1) ? creep
   Call: (13) 1>0 ? creep
   Exit: (13) 1>0 ? creep
   Call: (13) silent(s1, _3222) ? creep
   Fail: (13) silent(s1, _3222) ? creep
   Fail: (12) accepts(s1, _3196, 1) ? creep
   Redo: (12) trans(s1, _3194, _3218) ? creep
   Exit: (12) trans(s1, a, s2) ? creep
   Call: (12) _3220 is 2+ -1 ? creep
   Exit: (12) 1 is 2+ -1 ? creep
   Call: (12) accepts(s2, _3196, 1) ? creep
   Call: (13) final(s2) ? creep
   Fail: (13) final(s2) ? creep
   Redo: (12) accepts(s2, _3196, 1) ? creep
   Call: (13) 1>0 ? creep
   Exit: (13) 1>0 ? creep
   Call: (13) trans(s2, _3206, _3230) ? creep
   Exit: (13) trans(s2, b, s3) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s3, _3208, 0) ? creep
   Call: (14) final(s3) ? creep
   Exit: (14) final(s3) ? creep
   Exit: (13) accepts(s3, [], 0) ? creep
   Exit: (12) accepts(s2, [b], 1) ? creep
   Exit: (11) accepts(s1, [a, b], 2) ? creep
   Exit: (10) accepts(s1, [a, a, b], 3) ? creep
   Exit: (9) accepts(s1, [a, a, a, b], 4) ? creep
   Exit: (8) accepts(s1, [a, a, a, a, b], 5) ? creep
String = [a, a, a, a, b] .

[trace]  ?- accepts(s3, String, 3).
   Call: (8) accepts(s3, _2950, 3) ? creep
   Call: (9) final(s3) ? creep
   Exit: (9) final(s3) ? creep
   Exit: (8) accepts(s3, [], 3) ? creep
String = [] .
*/


/*
(考察・感想)
今回の課題では,受理状態,状態遷移,無言遷移を定義し,最大操作数の制限付き非決定性オートマトンを実装した.
算術演算子を用いて,最大操作数を逐次減らしていくことにより,動作回数をカウントすることと同値としている.
また,比較演算子によって,操作回数による終了条件を設けている.
実行例では,初期状態と最大操作数を設定した上で,終了状態に到達するまでに許される入力系列を列挙する形式になっている.
*/
