%演習5.2(教科書p.133)
%与えられた数を整数,零,負数に分類するプログラム

%与えられた数Numberを正数,零,負数に分類する関数class
class(Number, positive) :- Number > 0, !.    %Numberが正数のとき,positiveに分類
class(0, zero)          :- !.                %Numberが零のとき,zeroに分類
class(_, negative).                          %Numberが負数のとき,negativeに分類

/*
(実行例)
?- class(-2,Class).
lass = negative.

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


