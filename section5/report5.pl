% rep05: 第05回 演習課題レポート
% 2019年5月23日         by 学籍番号：29114116 名前：増田大輝
%



%演習5.2(教科書p.133)
%与えられた数を整数,零,負数に分類するプログラム

%与えられた数Numberを正数,零,負数に分類する関数class
class(Number, positive) :- Number > 0, !.    %Numberが正数のとき,positiveに分類
class(0, zero)          :- !.                %Numberが零のとき,zeroに分類
class(_, negative).                          %Numberが負数のとき,negativeに分類


/*
(実行例)
?- class(-2,Class).
Class = negative.

?- class(0,Class). 
Class = zero.

?- class(1000, Class).
Class = positive.


(トレース)
[trace]  ?- class(-2,Class).   
   Call: (8) class(-2, _2948) ? creep
   Call: (9) -2>0 ? creep
   Fail: (9) -2>0 ? creep
   Redo: (8) class(-2, _2948) ? creep
   Exit: (8) class(-2, negative) ? creep
Class = negative.

[trace]  ?- class(0,Class).    
   Call: (8) class(0, _2948) ? creep
   Call: (9) 0>0 ? creep
   Fail: (9) 0>0 ? creep
   Redo: (8) class(0, _2948) ? creep
   Exit: (8) class(0, zero) ? creep
Class = zero.

[trace]  ?- class(1000, Class).
   Call: (8) class(1000, _2948) ? creep
   Call: (9) 1000>0 ? creep
   Exit: (9) 1000>0 ? creep
   Exit: (8) class(1000, positive) ? creep
Class = positive.
*/


/*
(考察・感想)
今回の課題では,カットを用いることによって,条件分岐プログラムの簡潔化を行った.
カットを用いると,「!」が現れる以前の解が凍結され,バックトラックが制限される.
カット以前で条件を満たしている場合,その値でマッチングが成立し,具体化がなされる.
条件を満たさない場合には,カット以前の条件範囲の解が排除されると考えられる.
このように,カットを利用して条件を徐々に絞ることで,他の言語におけるelse_ifの要領で分岐を実現できる.
カットを活用することでプログラムが簡潔になり,可読性も改善し,軽量な実行が可能となる.
一方で,今回作成したプログラムはレッドカットとなっており,カットによって条件範囲が絞られることに,プログラム上の保証は無い.
そのため,プログラマは論理的に正しいことを確認し,レッドカットを使用する責任がある.
*/



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



%演習5.6(教科書p.137)
%与えられたリストList1の要素の中から,Termとマッチするものを要素とするList2を作成するプログラム

%否定を返す関数naf
naf(P) :- P,!,fail.
  naf(_).

%与えられたリストList1の要素の中からTermに合致する要素のみを抽出し,List2を作成する関数canunify
canunify([], _, []).                                      %空リストが与えられた場合の具体化

canunify([Head | List1], Term, List2) :-                  %HeadとTermがマッチしない場合
  naf(Head = Term), !,                                    %Head=Termのときにはnafは失敗し,具体化は破棄される
  canunify(List1, Term, List2).                           %そうでない場合は,List2にHeadを追加しない

canunify([Head | List1], Term, [Head | List2]) :-         %HeadとTermがマッチする場合
  canunify(List1, Term, List2).                           %HeadをList2に加える


/*
(実行例)
?- canunify([X,b,t(Y)], t(a), List).                        
List = [X, t(Y)].

?- canunify([a,b,[c],d,[[e]],f], [Item], List).
List = [[c], [[e]]].


(トレース)
[trace]  ?- canunify([X,b,t(Y)], t(a), List).           
   Call: (8) canunify([_2950, b, t(_2962)], t(a), _2980) ? creep
   Call: (9) naf(_2950=t(a)) ? creep
   Call: (10) _2950=t(a) ? creep
   Exit: (10) t(a)=t(a) ? creep
   Call: (10) fail ? creep
   Fail: (10) fail ? creep
   Fail: (9) naf(_2950=t(a)) ? creep
   Redo: (8) canunify([_2950, b, t(_2962)], t(a), _2980) ? creep
   Call: (9) canunify([b, t(_2962)], t(a), _3290) ? creep
   Call: (10) naf(b=t(a)) ? creep
   Call: (11) b=t(a) ? creep
   Fail: (11) b=t(a) ? creep
   Redo: (10) naf(b=t(a)) ? creep
   Exit: (10) naf(b=t(a)) ? creep
   Call: (10) canunify([t(_2962)], t(a), _3290) ? creep
   Call: (11) naf(t(_2962)=t(a)) ? creep
   Call: (12) t(_2962)=t(a) ? creep
   Exit: (12) t(a)=t(a) ? creep
   Call: (12) fail ? creep
   Fail: (12) fail ? creep
   Fail: (11) naf(t(_2962)=t(a)) ? creep
   Redo: (10) canunify([t(_2962)], t(a), _3290) ? creep
   Call: (11) canunify([], t(a), _3302) ? creep
   Exit: (11) canunify([], t(a), []) ? creep
   Exit: (10) canunify([t(_2962)], t(a), [t(_2962)]) ? creep
   Exit: (9) canunify([b, t(_2962)], t(a), [t(_2962)]) ? creep
   Exit: (8) canunify([_2950, b, t(_2962)], t(a), [_2950, t(_2962)]) ? creep
List = [X, t(Y)].

[trace]  ?- canunify([a,b,[c],d,[[e]],f], [Item], List). 
   Call: (8) canunify([a, b, [c], d, [[e]], f], [_3006], _3016) ? creep
   Call: (9) naf(a=[_3006]) ? creep
   Call: (10) a=[_3006] ? creep
   Fail: (10) a=[_3006] ? creep
   Redo: (9) naf(a=[_3006]) ? creep
   Exit: (9) naf(a=[_3006]) ? creep
   Call: (9) canunify([b, [c], d, [[e]], f], [_3006], _3016) ? creep
   Call: (10) naf(b=[_3006]) ? creep
   Call: (11) b=[_3006] ? creep
   Fail: (11) b=[_3006] ? creep
   Redo: (10) naf(b=[_3006]) ? creep
   Exit: (10) naf(b=[_3006]) ? creep
   Call: (10) canunify([[c], d, [[e]], f], [_3006], _3016) ? creep
   Call: (11) naf([c]=[_3006]) ? creep
   Call: (12) [c]=[_3006] ? creep
   Exit: (12) [c]=[c] ? creep
   Call: (12) fail ? creep
   Fail: (12) fail ? creep
   Fail: (11) naf([c]=[_3006]) ? creep
   Redo: (10) canunify([[c], d, [[e]], f], [_3006], _3016) ? creep
   Call: (11) canunify([d, [[e]], f], [_3006], _3346) ? creep
   Call: (12) naf(d=[_3006]) ? creep
   Call: (13) d=[_3006] ? creep
   Fail: (13) d=[_3006] ? creep
   Redo: (12) naf(d=[_3006]) ? creep
   Exit: (12) naf(d=[_3006]) ? creep
   Call: (12) canunify([[[e]], f], [_3006], _3346) ? creep
   Call: (13) naf([[e]]=[_3006]) ? creep
   Call: (14) [[e]]=[_3006] ? creep
   Exit: (14) [[e]]=[[e]] ? creep
   Call: (14) fail ? creep
   Fail: (14) fail ? creep
   Fail: (13) naf([[e]]=[_3006]) ? creep
   Redo: (12) canunify([[[e]], f], [_3006], _3346) ? creep
   Call: (13) canunify([f], [_3006], _3358) ? creep
   Call: (14) naf(f=[_3006]) ? creep
   Call: (15) f=[_3006] ? creep
   Fail: (15) f=[_3006] ? creep
   Redo: (14) naf(f=[_3006]) ? creep
   Exit: (14) naf(f=[_3006]) ? creep
   Call: (14) canunify([], [_3006], _3358) ? creep
   Exit: (14) canunify([], [_3006], []) ? creep
   Exit: (13) canunify([f], [_3006], []) ? creep
   Exit: (12) canunify([[[e]], f], [_3006], [[[e]]]) ? creep
   Exit: (11) canunify([d, [[e]], f], [_3006], [[[e]]]) ? creep
   Exit: (10) canunify([[c], d, [[e]], f], [_3006], [[c], [[e]]]) ? creep
   Exit: (9) canunify([b, [c], d, [[e]], f], [_3006], [[c], [[e]]]) ? creep
   Exit: (8) canunify([a, b, [c], d, [[e]], f], [_3006], [[c], [[e]]]) ? creep
List = [[c], [[e]]].
*/



/*
(考察・感想)
今回の課題ではnafの特性を生かし,生じた具体化を破棄させることで変数は元の変数の状態を保持させてList2に入れることが可能である.
また,nafを使う都合上,先にHeadとTermが同じである場合を排除するという考え方で処理を記述する必要がある.
したがって,nafによりHeadとTermが異なるものだけがカットの先のマッチングに到達する.
その後,排除されたものは自動的にHeadとTermが同じものとなり,排他的な場合分けが実装される.
以上のようなレッドカットを用いることによって条件分岐を作成した.
*/