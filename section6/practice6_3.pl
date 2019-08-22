%演習6.3(教科書p.155)
%端末から入力された英文について,単語間の空白を1つに調整した上で,','の前の単語との間には空白なし,後の単語との間には空白を一つ開けることで自然な英文への整形を行う処理を行うプログラム.


%否定を返す関数naf
naf(P) :- P,!,fail.
  naf(_).

%端末から入力された英文について,単語間の空白を1つに調整した上で,','の前の単語との間には空白なし,後の単語との間には空白を一つ開けることで自然な英文への整形を行う処理を行う手続きsqueeze.
squeeze :-
  get0(C),                       %次の文字Cを読み込む
  C \= 32, !,                    %Cが空白ではない場合のみ次の行の処理に移る
  put(C),                        %文字Cを端末に出力する
  dorest(C).                     %Cの文字コードによって処理を分岐

squeeze :-                       %相互排他的に空白文字の場合の処理を行う
  dorest(32).                    %空白文字用の処理に移る

%文字コードによって適切な処理を行う関数dorest
dorest(46) :- !.                 %ピリオドを読み取った際,処理を終了する.

dorest(44) :- !,                 %カンマを読み取った際の処理
  put(32),                       %カンマの後の空白を出力する
  get(C),                        %次の印字可能な文字Cを読み取る
  put(C),                        %Cを出力する
  dorest(C).                     %Cの文字コードによって処理を分岐

dorest(32) :-                    %空白を読み取った際の処理
  get(C),                        %次の印字可能な文字Cを読み取る
  C \= 44, !,                    %Cがカンマでない場合のみ次の行の処理に移る
  put(32),                       %空白を出力する
  put(C),                        %Cを出力する
  dorest(C).                     %Cの文字コードによって処理を分岐

dorest(32) :- !,                 %相互排他的に次の文字がカンマであった場合の処理を行う
  put(44),                       %カンマを出力する
  dorest(44).                    %カンマを読み取った際の処理を行う

dorest(Letter) :-                %上記のいずれにもマッチしない文字コードの処理
  squeeze.                       %再び手続きsqueezeを行う


/*
(実行例)
?- squeeze.
|: I     like   curry_and_rice     and       soba    ,okonomiyaki,    sushi.
I like curry_and_rice and soba, okonomiyaki, sushi.
true.

?- squeeze.
|: He   like    baseball   and  soccer      ,       swimming.
He like baseball and soccer, swimming.
true.


(トレース)
[trace]  ?- squeeze.        
   Call: (8) squeeze ? creep
   Call: (9) get0(_3114) ? creep
|: A

   Exit: (9) get0(65) ? creep
   Call: (9) 65\=32 ? creep
   Exit: (9) 65\=32 ? creep
   Call: (9) put(65) ? creep
A
   Exit: (9) put(65) ? creep
   Call: (9) dorest(65) ? creep
   Call: (10) squeeze ? creep
   Call: (11) get0(_3114) ? creep
|: ,

   Exit: (11) get0(44) ? creep
   Call: (11) 44\=32 ? creep
   Exit: (11) 44\=32 ? creep
   Call: (11) put(44) ? creep
,
   Exit: (11) put(44) ? creep
   Call: (11) dorest(44) ? creep
   Call: (12) put(32) ? creep
 
   Exit: (12) put(32) ? creep
   Call: (12) get(_3114) ? creep
|:  
|: 
|: F

   Exit: (12) get(70) ? creep
   Call: (12) put(70) ? creep
F
   Exit: (12) put(70) ? creep
   Call: (12) dorest(70) ? creep
   Call: (13) squeeze ? creep
   Call: (14) get0(_3114) ? creep
|: .

   Exit: (14) get0(46) ? creep
   Call: (14) 46\=32 ? creep
   Exit: (14) 46\=32 ? creep
   Call: (14) put(46) ? creep
.
   Exit: (14) put(46) ? creep
   Call: (14) dorest(46) ? creep
   Exit: (14) dorest(46) ? creep
   Exit: (13) squeeze ? creep
   Exit: (12) dorest(70) ? creep
   Exit: (11) dorest(44) ? creep
   Exit: (10) squeeze ? creep
   Exit: (9) dorest(65) ? creep
   Exit: (8) squeeze ? creep
true.
*/


/*
(考察・感想)
考える必要のある条件分岐が多く,個人的にかなり苦戦した.
教科書にあったsqueezeを改良したが,完成後に言語処理という観点からオートマトンを構成する方法もあるのではないかという案も浮かんだ.
しかし,そもそもdorest()の頭部が状態を表し,dorest()の本体とsqueezeが遷移条件ならびに遷移に対応することに気づいた.
最終的には,オートマトンを構成するよりもシンプルで直感的なプログラムになったと考えている.
*/

