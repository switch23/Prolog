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
