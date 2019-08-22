%演習5.3(教科書p.133)
%与えられたリストに含まれる整数を正数と負数のリストに分割するプログラム

%与えられたリストNumbersを正数のリストPositivesと負数のリストNegativesに分割する関数split

%カット使用：splitA

splitA([], [], []).                                       %Numbersが空リストのとき,PositivesもNegativesも空リストとして具体化

splitA([X | Numbers], [X | Positives], Negatives) :-      %Numbersの先頭が正数だった場合はPositivesに追加する
  X >= 0,!,                                               %負数の場合はカットする
  splitA(Numbers, Positives, Negatives).

splitA([X | Numbers], Positives, [X | Negatives]) :-      %上の条件に合致しなかった場合,排他的にNumbersの先頭はNegativesに追加される
  splitA(Numbers, Positives, Negatives).



%カット不使用：splitB

splitB([], [], []).                                       %Numbersが空リストのとき,PositivesもNegativesも空リストとして具体化

splitB([X | Numbers], [X | Positives], Negatives) :-      %Numbersの先頭が正数だった場合はPositivesに追加する
  X >= 0,
  splitB(Numbers, Positives, Negatives).

splitB([X | Numbers], Positives, [X | Negatives]) :-      %Numbersの先頭が負数だった場合はNegativesに追加する
  X < 0,
  splitB(Numbers, Positives, Negatives).

/*
(実行例)
?- splitA([-2,-1,0,1,2], Positives, Negatives).
Positives = [0, 1, 2],
Negatives = [-2, -1].

?- splitB([-2,-1,0,1,2], Positives, Negatives).
Positives = [0, 1, 2],
Negatives = [-2, -1] ;
false.

?- splitA([100,-5,-83,77,-19,53,-31], Positives, Negatives).
Positives = [100, 77, 53],
Negatives = [-5, -83, -19, -31].

?- splitB([100,-5,-83,77,-19,53,-31], Positives, Negatives).
Positives = [100, 77, 53],
Negatives = [-5, -83, -19, -31] ;
false.


(トレース)

[trace]  ?- splitA([-2,-1,0,1,2], Positives, Negatives).             
   Call: (8) splitA([-2, -1, 0, 1, 2], _2984, _2986) ? creep
   Call: (9) -2>=0 ? creep
   Fail: (9) -2>=0 ? creep
   Redo: (8) splitA([-2, -1, 0, 1, 2], _2984, _2986) ? creep
   Call: (9) splitA([-1, 0, 1, 2], _2984, _3266) ? creep
   Call: (10) -1>=0 ? creep
   Fail: (10) -1>=0 ? creep
   Redo: (9) splitA([-1, 0, 1, 2], _2984, _3266) ? creep
   Call: (10) splitA([0, 1, 2], _2984, _3272) ? creep
   Call: (11) 0>=0 ? creep
   Exit: (11) 0>=0 ? creep
   Call: (11) splitA([1, 2], _3278, _3272) ? creep
   Call: (12) 1>=0 ? creep
   Exit: (12) 1>=0 ? creep
   Call: (12) splitA([2], _3284, _3272) ? creep
   Call: (13) 2>=0 ? creep
   Exit: (13) 2>=0 ? creep
   Call: (13) splitA([], _3290, _3272) ? creep
   Exit: (13) splitA([], [], []) ? creep
   Exit: (12) splitA([2], [2], []) ? creep
   Exit: (11) splitA([1, 2], [1, 2], []) ? creep
   Exit: (10) splitA([0, 1, 2], [0, 1, 2], []) ? creep
   Exit: (9) splitA([-1, 0, 1, 2], [0, 1, 2], [-1]) ? creep
   Exit: (8) splitA([-2, -1, 0, 1, 2], [0, 1, 2], [-2, -1]) ? creep
Positives = [0, 1, 2],
Negatives = [-2, -1].

[trace]  ?- splitB([-2,-1,0,1,2], Positives, Negatives).             
   Call: (8) splitB([-2, -1, 0, 1, 2], _2984, _2986) ? creep
   Call: (9) -2>=0 ? creep
   Fail: (9) -2>=0 ? creep
   Redo: (8) splitB([-2, -1, 0, 1, 2], _2984, _2986) ? creep
   Call: (9) -2<0 ? creep
   Exit: (9) -2<0 ? creep
   Call: (9) splitB([-1, 0, 1, 2], _2984, _3276) ? creep
   Call: (10) -1>=0 ? creep
   Fail: (10) -1>=0 ? creep
   Redo: (9) splitB([-1, 0, 1, 2], _2984, _3276) ? creep
   Call: (10) -1<0 ? creep
   Exit: (10) -1<0 ? creep
   Call: (10) splitB([0, 1, 2], _2984, _3282) ? creep
   Call: (11) 0>=0 ? creep
   Exit: (11) 0>=0 ? creep
   Call: (11) splitB([1, 2], _3288, _3282) ? creep
   Call: (12) 1>=0 ? creep
   Exit: (12) 1>=0 ? creep
   Call: (12) splitB([2], _3294, _3282) ? creep
   Call: (13) 2>=0 ? creep
   Exit: (13) 2>=0 ? creep
   Call: (13) splitB([], _3300, _3282) ? creep
   Exit: (13) splitB([], [], []) ? creep
   Exit: (12) splitB([2], [2], []) ? creep
   Exit: (11) splitB([1, 2], [1, 2], []) ? creep
   Exit: (10) splitB([0, 1, 2], [0, 1, 2], []) ? creep
   Exit: (9) splitB([-1, 0, 1, 2], [0, 1, 2], [-1]) ? creep
   Exit: (8) splitB([-2, -1, 0, 1, 2], [0, 1, 2], [-2, -1]) ? creep
Positives = [0, 1, 2],
Negatives = [-2, -1] .

[trace]  ?- splitA([100,-5,-83,77,-19,53,-31], Positives, Negatives).
   Call: (8) splitA([100, -5, -83, 77, -19, 53, -31], _3000, _3002) ? creep
   Call: (9) 100>=0 ? creep
   Exit: (9) 100>=0 ? creep
   Call: (9) splitA([-5, -83, 77, -19, 53, -31], _3308, _3002) ? creep
   Call: (10) -5>=0 ? creep
   Fail: (10) -5>=0 ? creep
   Redo: (9) splitA([-5, -83, 77, -19, 53, -31], _3308, _3002) ? creep
   Call: (10) splitA([-83, 77, -19, 53, -31], _3308, _3314) ? creep
   Call: (11) -83>=0 ? creep
   Fail: (11) -83>=0 ? creep
   Redo: (10) splitA([-83, 77, -19, 53, -31], _3308, _3314) ? creep
   Call: (11) splitA([77, -19, 53, -31], _3308, _3320) ? creep
   Call: (12) 77>=0 ? creep
   Exit: (12) 77>=0 ? creep
   Call: (12) splitA([-19, 53, -31], _3326, _3320) ? creep
   Call: (13) -19>=0 ? creep
   Fail: (13) -19>=0 ? creep
   Redo: (12) splitA([-19, 53, -31], _3326, _3320) ? creep
   Call: (13) splitA([53, -31], _3326, _3332) ? creep
   Call: (14) 53>=0 ? creep
   Exit: (14) 53>=0 ? creep
   Call: (14) splitA([-31], _3338, _3332) ? creep
   Call: (15) -31>=0 ? creep
   Fail: (15) -31>=0 ? creep
   Redo: (14) splitA([-31], _3338, _3332) ? creep
   Call: (15) splitA([], _3338, _3344) ? creep
   Exit: (15) splitA([], [], []) ? creep
   Exit: (14) splitA([-31], [], [-31]) ? creep
   Exit: (13) splitA([53, -31], [53], [-31]) ? creep
   Exit: (12) splitA([-19, 53, -31], [53], [-19, -31]) ? creep
   Exit: (11) splitA([77, -19, 53, -31], [77, 53], [-19, -31]) ? creep
   Exit: (10) splitA([-83, 77, -19, 53, -31], [77, 53], [-83, -19, -31]) ? creep
   Exit: (9) splitA([-5, -83, 77, -19, 53, -31], [77, 53], [-5, -83, -19, -31]) ? creep
   Exit: (8) splitA([100, -5, -83, 77, -19, 53, -31], [100, 77, 53], [-5, -83, -19, -31]) ? creep
Positives = [100, 77, 53],
Negatives = [-5, -83, -19, -31].

[trace]  ?- splitB([100,-5,-83,77,-19,53,-31], Positives, Negatives).
   Call: (8) splitB([100, -5, -83, 77, -19, 53, -31], _3000, _3002) ? creep
   Call: (9) 100>=0 ? creep
   Exit: (9) 100>=0 ? creep
   Call: (9) splitB([-5, -83, 77, -19, 53, -31], _3312, _3002) ? creep
   Call: (10) -5>=0 ? creep
   Fail: (10) -5>=0 ? creep
   Redo: (9) splitB([-5, -83, 77, -19, 53, -31], _3312, _3002) ? creep
   Call: (10) -5<0 ? creep
   Exit: (10) -5<0 ? creep
   Call: (10) splitB([-83, 77, -19, 53, -31], _3312, _3318) ? creep
   Call: (11) -83>=0 ? creep
   Fail: (11) -83>=0 ? creep
   Redo: (10) splitB([-83, 77, -19, 53, -31], _3312, _3318) ? creep
   Call: (11) -83<0 ? creep
   Exit: (11) -83<0 ? creep
   Call: (11) splitB([77, -19, 53, -31], _3312, _3324) ? creep
   Call: (12) 77>=0 ? creep
   Exit: (12) 77>=0 ? creep
   Call: (12) splitB([-19, 53, -31], _3330, _3324) ? creep
   Call: (13) -19>=0 ? creep
   Fail: (13) -19>=0 ? creep
   Redo: (12) splitB([-19, 53, -31], _3330, _3324) ? creep
   Call: (13) -19<0 ? creep
   Exit: (13) -19<0 ? creep
   Call: (13) splitB([53, -31], _3330, _3336) ? creep
   Call: (14) 53>=0 ? creep
   Exit: (14) 53>=0 ? creep
   Call: (14) splitB([-31], _3342, _3336) ? creep
   Call: (15) -31>=0 ? creep
   Fail: (15) -31>=0 ? creep
   Redo: (14) splitB([-31], _3342, _3336) ? creep
   Call: (15) -31<0 ? creep
   Exit: (15) -31<0 ? creep
   Call: (15) splitB([], _3342, _3348) ? creep
   Exit: (15) splitB([], [], []) ? creep
   Exit: (14) splitB([-31], [], [-31]) ? creep
   Exit: (13) splitB([53, -31], [53], [-31]) ? creep
   Exit: (12) splitB([-19, 53, -31], [53], [-19, -31]) ? creep
   Exit: (11) splitB([77, -19, 53, -31], [77, 53], [-19, -31]) ? creep
   Exit: (10) splitB([-83, 77, -19, 53, -31], [77, 53], [-83, -19, -31]) ? creep
   Exit: (9) splitB([-5, -83, 77, -19, 53, -31], [77, 53], [-5, -83, -19, -31]) ? creep
   Exit: (8) splitB([100, -5, -83, 77, -19, 53, -31], [100, 77, 53], [-5, -83, -19, -31]) ? creep
Positives = [100, 77, 53],
Negatives = [-5, -83, -19, -31] .
*/



/*
(考察・感想)
今回の課題では,カットを使用する場合としない場合でのプログラムの動作の違いを確かめることができた.
トレースからも読み取れるように,カットを使用したsplitAでは,負数がNumbersの先頭として取り出された場合には,0と比較後Failし,次にはsplitA([X | Numbers], Positives, [X | Negatives]) :- splitA(Numbers, Positives, Negatives)にマッチングされている.一方,plitBでは負数がNumbersの先頭として取り出された場合には,0との比較後Failすると,次に0未満であることが比較によって確認されるので,splitAよりも処理が増える.
これは,splitAにおいてカットを用いて,0以上の範囲に解が存在しないことを確認していることにより,排他的に0未満であることを指定しているためで,レッドカットの効果であることが確認できる.
*/
