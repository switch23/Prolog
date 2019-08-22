%演習3.4

conc([],L,L).

conc([X | L1],L2,[X | L3]) :-
  conc(L1,L2,L3).


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
ReversedList = [4, 3, 2, 1, 0].<Paste>
*/


/*
 (考察・感想・評価)
 与えられたリストを逆転させる関数revを定義するにあたって,再帰的定義とconcの両方を用いているのが特徴的である.
 実際にトレースした結果からも,はじめは再帰的な関数呼び出しによって,rev([],[])が具体化される.
 次にconcによって新たなリストが生成され,リストと要素を逆転させたリストが生成されていく.
 この動作を繰り返すことで最終的には目的のリストが生成される.

*/
