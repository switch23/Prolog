%演習6.2(教科書p.153)
%ファイルから入力を行い,Termとマッチする全ての項を端末に表示するプログラム.


%否定を返す関数naf
naf(P) :- P,!,fail.
  naf(_).


%ファイルから入力を行い,Termとマッチする項を端末に表示する関数findallterms
findallterms(Term) :-
  see('rep06.txt'),                     %パス指定したテキストファイルからの読み込みを受け付ける
  read(Input),                          %テキストファイルから項を一つ読み込む
  process(Input, Term).


%入力された項Inputと与えられたTermのマッチを元に処理を行う関数process
process(end_of_file, Term) :- seen, !.  %読み込んだ項がend_of_fileとマッチする場合はテキストファイルからの読み込みを終了する.

process(Input, Term) :-                 %読み込んだ項がend_of_fileとマッチしない場合
  (naf(Input = Term), !;                %失敗としての否定nafを用いることによって，Termの具体化を破棄すると共に,カットによって排他的制御を実現
   write(Input),                        %入力された項とTermがマッチしない場合は項を出力
   nl),                                 %改行
  findallterms(Term).                   %マッチングの結果に関わらずfindalltermsを呼び出す


/*
%以下に,前回課題で作成した演習問題5.6を利用して本課題の実装を行ったものも掲載する.

%ファイルから入力を行い,Termとマッチする項を端末に表示する関数findallterms
findallterms(Term) :-
  see('rep06.txt'),                    %テキストファイルの読み込み
  process(List1),                      %読み込んだファイルから項のリストの生成
  canunify(List1, Term, List2),        %List1からTermに合致するものだけを抽出したList2を生成
  output(List2).                       %List2の要素を出力

%入力された項Inputと与えられたTermのマッチを元に処理を行う関数process
process([Input|List]) :-               %入力がend_of_fileではない場合の処理
  read(Input),                         %入力された項をリストに追加する.
  naf(Input = end_of_file), !,
  process(List).

process([end_of_file|List1]) :-        %入力がend_of_fileと合致する場合の処理
  seen, !.                             %ファイルを閉じて読み込み処理を終了する

%出力処理を行う関数output
output([]) :- !.                       %出力リストが空の場合の処理

output([Head|List]) :-                 %出力リストからコンソールに出力を行う処理
  write(Head),                         %リストの先頭を出力する
  nl,                                  %改行
  output(List).


%与えられたリストList1の要素の中からTermに合致する要素のみを抽出し,List2を作成する関数canunify
canunify([], _, []).                                      %空リストが与えられた場合の具体化

canunify([Head | List1], Term, List2) :-                  %HeadとTermがマッチしない場合
  naf(Head = Term), !,                                    %Head=Termのときにはnafは失敗し,具体化は破棄される
  canunify(List1, Term, List2).                           %そうでない場合は,List2にHeadを追加しない

canunify([Head | List1], Term, [Head | List2]) :-         %HeadとTermがマッチする場合
  canunify(List1, Term, List2).                           %HeadをList2に加える

*/


/*
(入力ファイル'/home/27115/clf14116/rep06.txt'の内容)
ok.
a.
like.
play.
hill(h).
p(a). atom. q(b(a)). r(A).
H is nn.
t(A) :- p.
*/


/*
(実行例)

-ユニファイ可能なもの

?- findallterms(A).
ok
a
like
play
hill(h)
p(a)
atom
q(b(a))
r(_2884)
_2888 is nn
t(_2894):-p
true.

?- findallterms(Nitech).
ok
a
like
play
hill(h)
p(a)
atom
q(b(a))
r(_2884)
_2888 is nn
t(_2894):-p
true.


-ユニファイ不可能なもの

?- findallterms(a).     
a
true.

?- findallterms(computer).
true.


(トレース)

-ユニファイ可能なもの

[trace]  ?- findallterms(A).       
   Call: (8) findallterms(_2946) ? creep
   Call: (9) see('rep06.txt') ? creep
   Exit: (9) see('rep06.txt') ? creep
   Call: (9) read(_3162) ? creep
   Exit: (9) read(ok) ? creep
   Call: (9) process(ok, _2946) ? creep
   Call: (10) naf(ok=_2946) ? creep
   Call: (11) ok=_2946 ? creep
   Exit: (11) ok=ok ? creep
   Call: (11) fail ? creep
   Fail: (11) fail ? creep
   Fail: (10) naf(ok=_2946) ? creep
   Redo: (9) process(ok, _2946) ? creep
   Call: (10) write(ok) ? creep
ok
   Exit: (10) write(ok) ? creep
   Call: (10) nl ? creep

   Exit: (10) nl ? creep
   Call: (10) findallterms(_2946) ? creep
   Call: (11) see('rep06.txt') ? creep
   Exit: (11) see('rep06.txt') ? creep
   Call: (11) read(_3162) ? creep
   Exit: (11) read(a) ? creep
   Call: (11) process(a, _2946) ? creep
   Call: (12) naf(a=_2946) ? creep
   Call: (13) a=_2946 ? creep
   Exit: (13) a=a ? creep
   Call: (13) fail ? creep
   Fail: (13) fail ? creep
   Fail: (12) naf(a=_2946) ? creep
   Redo: (11) process(a, _2946) ? creep
   Call: (12) write(a) ? creep
a
   Exit: (12) write(a) ? creep
   Call: (12) nl ? creep

   Exit: (12) nl ? creep
   Call: (12) findallterms(_2946) ? creep
   Call: (13) see('rep06.txt') ? creep
   Exit: (13) see('rep06.txt') ? creep
   Call: (13) read(_3162) ? creep
   Exit: (13) read(like) ? creep
   Call: (13) process(like, _2946) ? creep
   Call: (14) naf(like=_2946) ? creep
   Call: (15) like=_2946 ? creep
   Exit: (15) like=like ? creep
   Call: (15) fail ? creep
   Fail: (15) fail ? creep
   Fail: (14) naf(like=_2946) ? creep
   Redo: (13) process(like, _2946) ? creep
   Call: (14) write(like) ? creep
like
   Exit: (14) write(like) ? creep
   Call: (14) nl ? creep

   Exit: (14) nl ? creep
   Call: (14) findallterms(_2946) ? creep
   Call: (15) see('rep06.txt') ? creep
   Exit: (15) see('rep06.txt') ? creep
   Call: (15) read(_3162) ? creep
   Exit: (15) read(play) ? creep
   Call: (15) process(play, _2946) ? creep
   Call: (16) naf(play=_2946) ? creep
   Call: (17) play=_2946 ? creep
   Exit: (17) play=play ? creep
   Call: (17) fail ? creep
   Fail: (17) fail ? creep
   Fail: (16) naf(play=_2946) ? creep
   Redo: (15) process(play, _2946) ? creep
   Call: (16) write(play) ? creep
play
   Exit: (16) write(play) ? creep
   Call: (16) nl ? creep

   Exit: (16) nl ? creep
   Call: (16) findallterms(_2946) ? creep
   Call: (17) see('rep06.txt') ? creep
   Exit: (17) see('rep06.txt') ? creep
   Call: (17) read(_3162) ? creep
   Exit: (17) read(hill(h)) ? creep
   Call: (17) process(hill(h), _2946) ? creep
   Call: (18) naf(hill(h)=_2946) ? creep
   Call: (19) hill(h)=_2946 ? creep
   Exit: (19) hill(h)=hill(h) ? creep
   Call: (19) fail ? creep
   Fail: (19) fail ? creep
   Fail: (18) naf(hill(h)=_2946) ? creep
   Redo: (17) process(hill(h), _2946) ? creep
   Call: (18) write(hill(h)) ? creep
hill(h)
   Exit: (18) write(hill(h)) ? creep
   Call: (18) nl ? creep

   Exit: (18) nl ? creep
   Call: (18) findallterms(_2946) ? creep
   Call: (19) see('rep06.txt') ? creep
   Exit: (19) see('rep06.txt') ? creep
   Call: (19) read(_3166) ? creep
   Exit: (19) read(p(a)) ? creep
   Call: (19) process(p(a), _2946) ? creep
   Call: (20) naf(p(a)=_2946) ? creep
   Call: (21) p(a)=_2946 ? creep
   Exit: (21) p(a)=p(a) ? creep
   Call: (21) fail ? creep
   Fail: (21) fail ? creep
   Fail: (20) naf(p(a)=_2946) ? creep
   Redo: (19) process(p(a), _2946) ? creep
   Call: (20) write(p(a)) ? creep
p(a)
   Exit: (20) write(p(a)) ? creep
   Call: (20) nl ? creep

   Exit: (20) nl ? creep
   Call: (20) findallterms(_2946) ? creep
   Call: (21) see('rep06.txt') ? creep
   Exit: (21) see('rep06.txt') ? creep
   Call: (21) read(_3170) ? creep
   Exit: (21) read(atom) ? creep
   Call: (21) process(atom, _2946) ? creep
   Call: (22) naf(atom=_2946) ? creep
   Call: (23) atom=_2946 ? creep
   Exit: (23) atom=atom ? creep
   Call: (23) fail ? creep
   Fail: (23) fail ? creep
   Fail: (22) naf(atom=_2946) ? creep
   Redo: (21) process(atom, _2946) ? creep
   Call: (22) write(atom) ? creep
atom
   Exit: (22) write(atom) ? creep
   Call: (22) nl ? creep

   Exit: (22) nl ? creep
   Call: (22) findallterms(_2946) ? creep
   Call: (23) see('rep06.txt') ? creep
   Exit: (23) see('rep06.txt') ? creep
   Call: (23) read(_3170) ? creep
   Exit: (23) read(q(b(a))) ? creep
   Call: (23) process(q(b(a)), _2946) ? creep
   Call: (24) naf(q(b(a))=_2946) ? creep
   Call: (25) q(b(a))=_2946 ? creep
   Exit: (25) q(b(a))=q(b(a)) ? creep
   Call: (25) fail ? creep
   Fail: (25) fail ? creep
   Fail: (24) naf(q(b(a))=_2946) ? creep
   Redo: (23) process(q(b(a)), _2946) ? creep
   Call: (24) write(q(b(a))) ? creep
q(b(a))
   Exit: (24) write(q(b(a))) ? creep
   Call: (24) nl ? creep

   Exit: (24) nl ? creep
   Call: (24) findallterms(_2946) ? creep
   Call: (25) see('rep06.txt') ? creep
   Exit: (25) see('rep06.txt') ? creep
   Call: (25) read(_3178) ? creep
   Exit: (25) read(r(_3164)) ? creep
   Call: (25) process(r(_3164), _2946) ? creep
   Call: (26) naf(r(_3164)=_2946) ? creep
   Call: (27) r(_3164)=_2946 ? creep
   Exit: (27) r(_3164)=r(_3164) ? creep
   Call: (27) fail ? creep
   Fail: (27) fail ? creep
   Fail: (26) naf(r(_3164)=_2946) ? creep
   Redo: (25) process(r(_3164), _2946) ? creep
   Call: (26) write(r(_3164)) ? creep
r(_3164)
   Exit: (26) write(r(_3164)) ? creep
   Call: (26) nl ? creep

   Exit: (26) nl ? creep
   Call: (26) findallterms(_2946) ? creep
   Call: (27) see('rep06.txt') ? creep
   Exit: (27) see('rep06.txt') ? creep
   Call: (27) read(_3182) ? creep
   Exit: (27) read(_3168 is nn) ? creep
   Call: (27) process(_3168 is nn, _2946) ? creep
   Call: (28) naf((_3168 is nn)=_2946) ? creep
   Call: (29) (_3168 is nn)=_2946 ? creep
   Exit: (29) (_3168 is nn)=(_3168 is nn) ? creep
   Call: (29) fail ? creep
   Fail: (29) fail ? creep
   Fail: (28) naf((_3168 is nn)=_2946) ? creep
   Redo: (27) process(_3168 is nn, _2946) ? creep
   Call: (28) write(_3168 is nn) ? creep
_3168 is nn
   Exit: (28) write(_3168 is nn) ? creep
   Call: (28) nl ? creep

   Exit: (28) nl ? creep
   Call: (28) findallterms(_2946) ? creep
   Call: (29) see('rep06.txt') ? creep
   Exit: (29) see('rep06.txt') ? creep
   Call: (29) read(_3188) ? creep
   Exit: (29) read((t(_3174):-p)) ? creep
   Call: (29) process((t(_3174):-p), _2946) ? creep
   Call: (30) naf((t(_3174):-p)=_2946) ? creep
   Call: (31) (t(_3174):-p)=_2946 ? creep
   Exit: (31) (t(_3174):-p)=(t(_3174):-p) ? creep
   Call: (31) fail ? creep
   Fail: (31) fail ? creep
   Fail: (30) naf((t(_3174):-p)=_2946) ? creep
   Redo: (29) process((t(_3174):-p), _2946) ? creep
   Call: (30) write((t(_3174):-p)) ? creep
t(_3174):-p
   Exit: (30) write((t(_3174):-p)) ? creep
   Call: (30) nl ? creep

   Exit: (30) nl ? creep
   Call: (30) findallterms(_2946) ? creep
   Call: (31) see('rep06.txt') ? creep
   Exit: (31) see('rep06.txt') ? creep
   Call: (31) read(_3198) ? creep
   Exit: (31) read(end_of_file) ? creep
   Call: (31) process(end_of_file, _2946) ? creep
   Call: (32) seen ? creep
   Exit: (32) seen ? creep
   Exit: (31) process(end_of_file, _2946) ? creep
   Exit: (30) findallterms(_2946) ? creep
   Exit: (29) process((t(_3174):-p), _2946) ? creep
   Exit: (28) findallterms(_2946) ? creep
   Exit: (27) process(_3168 is nn, _2946) ? creep
   Exit: (26) findallterms(_2946) ? creep
   Exit: (25) process(r(_3164), _2946) ? creep
   Exit: (24) findallterms(_2946) ? creep
   Exit: (23) process(q(b(a)), _2946) ? creep
   Exit: (22) findallterms(_2946) ? creep
   Exit: (21) process(atom, _2946) ? creep
   Exit: (20) findallterms(_2946) ? creep
   Exit: (19) process(p(a), _2946) ? creep
   Exit: (18) findallterms(_2946) ? creep
   Exit: (17) process(hill(h), _2946) ? creep
   Exit: (16) findallterms(_2946) ? creep
   Exit: (15) process(play, _2946) ? creep
   Exit: (14) findallterms(_2946) ? creep
   Exit: (13) process(like, _2946) ? creep
   Exit: (12) findallterms(_2946) ? creep
   Exit: (11) process(a, _2946) ? creep
   Exit: (10) findallterms(_2946) ? creep
   Exit: (9) process(ok, _2946) ? creep
   Exit: (8) findallterms(_2946) ? creep
true.



-ユニファイ不可能なもの

[trace]  ?- findallterms(a).  
   Call: (8) findallterms(a) ? creep
   Call: (9) see('rep06.txt') ? creep
   Exit: (9) see('rep06.txt') ? creep
   Call: (9) read(_3130) ? creep
   Exit: (9) read(ok) ? creep
   Call: (9) process(ok, a) ? creep
   Call: (10) naf(ok=a) ? creep
   Call: (11) ok=a ? creep
   Fail: (11) ok=a ? creep
   Redo: (10) naf(ok=a) ? creep
   Exit: (10) naf(ok=a) ? creep
   Call: (10) findallterms(a) ? creep
   Call: (11) see('rep06.txt') ? creep
   Exit: (11) see('rep06.txt') ? creep
   Call: (11) read(_3136) ? creep
   Exit: (11) read(a) ? creep
   Call: (11) process(a, a) ? creep
   Call: (12) naf(a=a) ? creep
   Call: (13) a=a ? creep
   Exit: (13) a=a ? creep
   Call: (13) fail ? creep
   Fail: (13) fail ? creep
   Fail: (12) naf(a=a) ? creep
   Redo: (11) process(a, a) ? creep
   Call: (12) write(a) ? creep
a
   Exit: (12) write(a) ? creep
   Call: (12) nl ? creep

   Exit: (12) nl ? creep
   Call: (12) findallterms(a) ? creep
   Call: (13) see('rep06.txt') ? creep
   Exit: (13) see('rep06.txt') ? creep
   Call: (13) read(_3136) ? creep
   Exit: (13) read(like) ? creep
   Call: (13) process(like, a) ? creep
   Call: (14) naf(like=a) ? creep
   Call: (15) like=a ? creep
   Fail: (15) like=a ? creep
   Redo: (14) naf(like=a) ? creep
   Exit: (14) naf(like=a) ? creep
   Call: (14) findallterms(a) ? creep
   Call: (15) see('rep06.txt') ? creep
   Exit: (15) see('rep06.txt') ? creep
   Call: (15) read(_3142) ? creep
   Exit: (15) read(play) ? creep
   Call: (15) process(play, a) ? creep
   Call: (16) naf(play=a) ? creep
   Call: (17) play=a ? creep
   Fail: (17) play=a ? creep
   Redo: (16) naf(play=a) ? creep
   Exit: (16) naf(play=a) ? creep
   Call: (16) findallterms(a) ? creep
   Call: (17) see('rep06.txt') ? creep
   Exit: (17) see('rep06.txt') ? creep
   Call: (17) read(_3148) ? creep
   Exit: (17) read(hill(h)) ? creep
   Call: (17) process(hill(h), a) ? creep
   Call: (18) naf(hill(h)=a) ? creep
   Call: (19) hill(h)=a ? creep
   Fail: (19) hill(h)=a ? creep
   Redo: (18) naf(hill(h)=a) ? creep
   Exit: (18) naf(hill(h)=a) ? creep
   Call: (18) findallterms(a) ? creep
   Call: (19) see('rep06.txt') ? creep
   Exit: (19) see('rep06.txt') ? creep
   Call: (19) read(_3158) ? creep
   Exit: (19) read(p(a)) ? creep
   Call: (19) process(p(a), a) ? creep
   Call: (20) naf(p(a)=a) ? creep
   Call: (21) p(a)=a ? creep
   Fail: (21) p(a)=a ? creep
   Redo: (20) naf(p(a)=a) ? creep
   Exit: (20) naf(p(a)=a) ? creep
   Call: (20) findallterms(a) ? creep
   Call: (21) see('rep06.txt') ? creep
   Exit: (21) see('rep06.txt') ? creep
   Call: (21) read(_3168) ? creep
   Exit: (21) read(atom) ? creep
   Call: (21) process(atom, a) ? creep
   Call: (22) naf(atom=a) ? creep
   Call: (23) atom=a ? creep
   Fail: (23) atom=a ? creep
   Redo: (22) naf(atom=a) ? creep
   Exit: (22) naf(atom=a) ? creep
   Call: (22) findallterms(a) ? creep
   Call: (23) see('rep06.txt') ? creep
   Exit: (23) see('rep06.txt') ? creep
   Call: (23) read(_3174) ? creep
   Exit: (23) read(q(b(a))) ? creep
   Call: (23) process(q(b(a)), a) ? creep
   Call: (24) naf(q(b(a))=a) ? creep
   Call: (25) q(b(a))=a ? creep
   Fail: (25) q(b(a))=a ? creep
   Redo: (24) naf(q(b(a))=a) ? creep
   Exit: (24) naf(q(b(a))=a) ? creep
   Call: (24) findallterms(a) ? creep
   Call: (25) see('rep06.txt') ? creep
   Exit: (25) see('rep06.txt') ? creep
   Call: (25) read(_3188) ? creep
   Exit: (25) read(r(_3174)) ? creep
   Call: (25) process(r(_3174), a) ? creep
   Call: (26) naf(r(_3174)=a) ? creep
   Call: (27) r(_3174)=a ? creep
   Fail: (27) r(_3174)=a ? creep
   Redo: (26) naf(r(_3174)=a) ? creep
   Exit: (26) naf(r(_3174)=a) ? creep
   Call: (26) findallterms(a) ? creep
   Call: (27) see('rep06.txt') ? creep
   Exit: (27) see('rep06.txt') ? creep
   Call: (27) read(_3198) ? creep
   Exit: (27) read(_3184 is nn) ? creep
   Call: (27) process(_3184 is nn, a) ? creep
   Call: (28) naf((_3184 is nn)=a) ? creep
   Call: (29) (_3184 is nn)=a ? creep
   Fail: (29) (_3184 is nn)=a ? creep
   Redo: (28) naf((_3184 is nn)=a) ? creep
   Exit: (28) naf((_3184 is nn)=a) ? creep
   Call: (28) findallterms(a) ? creep
   Call: (29) see('rep06.txt') ? creep
   Exit: (29) see('rep06.txt') ? creep
   Call: (29) read(_3210) ? creep
   Exit: (29) read((t(_3196):-p)) ? creep
   Call: (29) process((t(_3196):-p), a) ? creep
   Call: (30) naf((t(_3196):-p)=a) ? creep
   Call: (31) (t(_3196):-p)=a ? creep
   Fail: (31) (t(_3196):-p)=a ? creep
   Redo: (30) naf((t(_3196):-p)=a) ? creep
   Exit: (30) naf((t(_3196):-p)=a) ? creep
   Call: (30) findallterms(a) ? creep
   Call: (31) see('rep06.txt') ? creep
   Exit: (31) see('rep06.txt') ? creep
   Call: (31) read(_3226) ? creep
   Exit: (31) read(end_of_file) ? creep
   Call: (31) process(end_of_file, a) ? creep
   Call: (32) seen ? creep
   Exit: (32) seen ? creep
   Exit: (31) process(end_of_file, a) ? creep
   Exit: (30) findallterms(a) ? creep
   Exit: (29) process((t(_3196):-p), a) ? creep
   Exit: (28) findallterms(a) ? creep
   Exit: (27) process(_3184 is nn, a) ? creep
   Exit: (26) findallterms(a) ? creep
   Exit: (25) process(r(_3174), a) ? creep
   Exit: (24) findallterms(a) ? creep
   Exit: (23) process(q(b(a)), a) ? creep
   Exit: (22) findallterms(a) ? creep
   Exit: (21) process(atom, a) ? creep
   Exit: (20) findallterms(a) ? creep
   Exit: (19) process(p(a), a) ? creep
   Exit: (18) findallterms(a) ? creep
   Exit: (17) process(hill(h), a) ? creep
   Exit: (16) findallterms(a) ? creep
   Exit: (15) process(play, a) ? creep
   Exit: (14) findallterms(a) ? creep
   Exit: (13) process(like, a) ? creep
   Exit: (12) findallterms(a) ? creep
   Exit: (11) process(a, a) ? creep
   Exit: (10) findallterms(a) ? creep
   Exit: (9) process(ok, a) ? creep
   Exit: (8) findallterms(a) ? creep
true.


(演習問題5.6を利用した本課題の実装の実行結果)
ユニファイ可能なものの実行結果を示す

?- findallterms(A).
ok
a
like
play
hill(h)
p(a)
atom
q(b(a))
r(_2986)
_3002 is nn
t(_3020):-p
end_of_file
true .


(演習問題5.6を利用した本課題の実装のトレース結果)
ユニファイ可能なもののトレース結果を示す

[trace]  ?- findallterms(A).
   Call: (8) findallterms(_2946) ? creep
   Call: (9) see('rep06.txt') ? creep
   Exit: (9) see('rep06.txt') ? creep
   Call: (9) process(_3162) ? creep
   Call: (10) read(_3148) ? creep
   Exit: (10) read(ok) ? creep
   Call: (10) naf(ok=end_of_file) ? creep
   Call: (11) ok=end_of_file ? creep
   Fail: (11) ok=end_of_file ? creep
   Redo: (10) naf(ok=end_of_file) ? creep
   Exit: (10) naf(ok=end_of_file) ? creep
   Call: (10) process(_3150) ? creep
   Call: (11) read(_3160) ? creep
   Exit: (11) read(a) ? creep
   Call: (11) naf(a=end_of_file) ? creep
   Call: (12) a=end_of_file ? creep
   Fail: (12) a=end_of_file ? creep
   Redo: (11) naf(a=end_of_file) ? creep
   Exit: (11) naf(a=end_of_file) ? creep
   Call: (11) process(_3162) ? creep
   Call: (12) read(_3172) ? creep
   Exit: (12) read(like) ? creep
   Call: (12) naf(like=end_of_file) ? creep
   Call: (13) like=end_of_file ? creep
   Fail: (13) like=end_of_file ? creep
   Redo: (12) naf(like=end_of_file) ? creep
   Exit: (12) naf(like=end_of_file) ? creep
   Call: (12) process(_3174) ? creep
   Call: (13) read(_3184) ? creep
   Exit: (13) read(play) ? creep
   Call: (13) naf(play=end_of_file) ? creep
   Call: (14) play=end_of_file ? creep
   Fail: (14) play=end_of_file ? creep
   Redo: (13) naf(play=end_of_file) ? creep
   Exit: (13) naf(play=end_of_file) ? creep
   Call: (13) process(_3186) ? creep
   Call: (14) read(_3196) ? creep
   Exit: (14) read(hill(h)) ? creep
   Call: (14) naf(hill(h)=end_of_file) ? creep
   Call: (15) hill(h)=end_of_file ? creep
   Fail: (15) hill(h)=end_of_file ? creep
   Redo: (14) naf(hill(h)=end_of_file) ? creep
   Exit: (14) naf(hill(h)=end_of_file) ? creep
   Call: (14) process(_3198) ? creep
   Call: (15) read(_3212) ? creep
   Exit: (15) read(p(a)) ? creep
   Call: (15) naf(p(a)=end_of_file) ? creep
   Call: (16) p(a)=end_of_file ? creep
   Fail: (16) p(a)=end_of_file ? creep
   Redo: (15) naf(p(a)=end_of_file) ? creep
   Exit: (15) naf(p(a)=end_of_file) ? creep
   Call: (15) process(_3214) ? creep
   Call: (16) read(_3228) ? creep
   Exit: (16) read(atom) ? creep
   Call: (16) naf(atom=end_of_file) ? creep
   Call: (17) atom=end_of_file ? creep
   Fail: (17) atom=end_of_file ? creep
   Redo: (16) naf(atom=end_of_file) ? creep
   Exit: (16) naf(atom=end_of_file) ? creep
   Call: (16) process(_3230) ? creep
   Call: (17) read(_3240) ? creep
   Exit: (17) read(q(b(a))) ? creep
   Call: (17) naf(q(b(a))=end_of_file) ? creep
   Call: (18) q(b(a))=end_of_file ? creep
   Fail: (18) q(b(a))=end_of_file ? creep
   Redo: (17) naf(q(b(a))=end_of_file) ? creep
   Exit: (17) naf(q(b(a))=end_of_file) ? creep
   Call: (17) process(_3242) ? creep
   Call: (18) read(_3260) ? creep
   Exit: (18) read(r(_3266)) ? creep
   Call: (18) naf(r(_3266)=end_of_file) ? creep
   Call: (19) r(_3266)=end_of_file ? creep
   Fail: (19) r(_3266)=end_of_file ? creep
   Redo: (18) naf(r(_3266)=end_of_file) ? creep
   Exit: (18) naf(r(_3266)=end_of_file) ? creep
   Call: (18) process(_3262) ? creep
   Call: (19) read(_3276) ? creep
   Exit: (19) read(_3282 is nn) ? creep
   Call: (19) naf((_3282 is nn)=end_of_file) ? creep
   Call: (20) (_3282 is nn)=end_of_file ? creep
   Fail: (20) (_3282 is nn)=end_of_file ? creep
   Redo: (19) naf((_3282 is nn)=end_of_file) ? creep
   Exit: (19) naf((_3282 is nn)=end_of_file) ? creep
   Call: (19) process(_3278) ? creep
   Call: (20) read(_3294) ? creep
   Exit: (20) read((t(_3300):-p)) ? creep
   Call: (20) naf((t(_3300):-p)=end_of_file) ? creep
   Call: (21) (t(_3300):-p)=end_of_file ? creep
   Fail: (21) (t(_3300):-p)=end_of_file ? creep
   Redo: (20) naf((t(_3300):-p)=end_of_file) ? creep
   Exit: (20) naf((t(_3300):-p)=end_of_file) ? creep
   Call: (20) process(_3296) ? creep
   Call: (21) read(_3316) ? creep
   Exit: (21) read(end_of_file) ? creep
   Call: (21) naf(end_of_file=end_of_file) ? creep
   Call: (22) end_of_file=end_of_file ? creep
   Exit: (22) end_of_file=end_of_file ? creep
   Call: (22) fail ? creep
   Fail: (22) fail ? creep
   Fail: (21) naf(end_of_file=end_of_file) ? creep
   Redo: (20) process(_3296) ? creep
   Call: (21) seen ? creep
   Exit: (21) seen ? creep
   Exit: (20) process([end_of_file|_3318]) ? creep
   Exit: (19) process([(t(_3300):-p), end_of_file|_3318]) ? creep
   Exit: (18) process([_3282 is nn,  (t(_3300):-p), end_of_file|_3318]) ? creep
   Exit: (17) process([r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318]) ? creep
   Exit: (16) process([q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318]) ? creep
   Exit: (15) process([atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318]) ? creep
   Exit: (14) process([p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318]) ? creep
   Exit: (13) process([hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file|...]) ? creep
   Exit: (12) process([play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...]) ? creep
   Exit: (11) process([like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...]) ? creep
   Exit: (10) process([a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...]) ? creep
   Exit: (9) process([ok, a, like, play, hill(h), p(a), atom, q(...)|...]) ? creep
   Call: (9) canunify([ok, a, like, play, hill(h), p(a), atom, q(...)|...], _2946, _3340) ? creep
   Call: (10) naf(ok=_2946) ? creep
   Call: (11) ok=_2946 ? creep
   Exit: (11) ok=ok ? creep
   Call: (11) fail ? creep
   Fail: (11) fail ? creep
   Fail: (10) naf(ok=_2946) ? creep
   Redo: (9) canunify([ok, a, like, play, hill(h), p(a), atom, q(...)|...], _2946, _3340) ? creep
   Call: (10) canunify([a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...], _2946, _3324) ? creep
   Call: (11) naf(a=_2946) ? creep
   Call: (12) a=_2946 ? creep
   Exit: (12) a=a ? creep
   Call: (12) fail ? creep
   Fail: (12) fail ? creep
   Fail: (11) naf(a=_2946) ? creep
   Redo: (10) canunify([a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...], _2946, _3324) ? creep
   Call: (11) canunify([like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...], _2946, _3330) ? creep
   Call: (12) naf(like=_2946) ? creep
   Call: (13) like=_2946 ? creep
   Exit: (13) like=like ? creep
   Call: (13) fail ? creep
   Fail: (13) fail ? creep
   Fail: (12) naf(like=_2946) ? creep
   Redo: (11) canunify([like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...], _2946, _3330) ? creep
   Call: (12) canunify([play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...], _2946, _3336) ? creep
   Call: (13) naf(play=_2946) ? creep
   Call: (14) play=_2946 ? creep
   Exit: (14) play=play ? creep
   Call: (14) fail ? creep
   Fail: (14) fail ? creep
   Fail: (13) naf(play=_2946) ? creep
   Redo: (12) canunify([play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...], _2946, _3336) ? creep
   Call: (13) canunify([hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file|...], _2946, _3342) ? creep
   Call: (14) naf(hill(h)=_2946) ? creep
   Call: (15) hill(h)=_2946 ? creep
   Exit: (15) hill(h)=hill(h) ? creep
   Call: (15) fail ? creep
   Fail: (15) fail ? creep
   Fail: (14) naf(hill(h)=_2946) ? creep
   Redo: (13) canunify([hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file|...], _2946, _3342) ? creep
   Call: (14) canunify([p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3348) ? creep
   Call: (15) naf(p(a)=_2946) ? creep
   Call: (16) p(a)=_2946 ? creep
   Exit: (16) p(a)=p(a) ? creep
   Call: (16) fail ? creep
   Fail: (16) fail ? creep
   Fail: (15) naf(p(a)=_2946) ? creep
   Redo: (14) canunify([p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3348) ? creep
   Call: (15) canunify([atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3354) ? creep
   Call: (16) naf(atom=_2946) ? creep
   Call: (17) atom=_2946 ? creep
   Exit: (17) atom=atom ? creep
   Call: (17) fail ? creep
   Fail: (17) fail ? creep
   Fail: (16) naf(atom=_2946) ? creep
   Redo: (15) canunify([atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3354) ? creep
   Call: (16) canunify([q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3360) ? creep
   Call: (17) naf(q(b(a))=_2946) ? creep
   Call: (18) q(b(a))=_2946 ? creep
   Exit: (18) q(b(a))=q(b(a)) ? creep
   Call: (18) fail ? creep
   Fail: (18) fail ? creep
   Fail: (17) naf(q(b(a))=_2946) ? creep
   Redo: (16) canunify([q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3360) ? creep
   Call: (17) canunify([r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3366) ? creep
   Call: (18) naf(r(_3266)=_2946) ? creep
   Call: (19) r(_3266)=_2946 ? creep
   Exit: (19) r(_3266)=r(_3266) ? creep
   Call: (19) fail ? creep
   Fail: (19) fail ? creep
   Fail: (18) naf(r(_3266)=_2946) ? creep
   Redo: (17) canunify([r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3366) ? creep
   Call: (18) canunify([_3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3372) ? creep
   Call: (19) naf((_3282 is nn)=_2946) ? creep
   Call: (20) (_3282 is nn)=_2946 ? creep
   Exit: (20) (_3282 is nn)=(_3282 is nn) ? creep
   Call: (20) fail ? creep
   Fail: (20) fail ? creep
   Fail: (19) naf((_3282 is nn)=_2946) ? creep
   Redo: (18) canunify([_3282 is nn,  (t(_3300):-p), end_of_file|_3318], _2946, _3372) ? creep
   Call: (19) canunify([(t(_3300):-p), end_of_file|_3318], _2946, _3378) ? creep
   Call: (20) naf((t(_3300):-p)=_2946) ? creep
   Call: (21) (t(_3300):-p)=_2946 ? creep
   Exit: (21) (t(_3300):-p)=(t(_3300):-p) ? creep
   Call: (21) fail ? creep
   Fail: (21) fail ? creep
   Fail: (20) naf((t(_3300):-p)=_2946) ? creep
   Redo: (19) canunify([(t(_3300):-p), end_of_file|_3318], _2946, _3378) ? creep
   Call: (20) canunify([end_of_file|_3318], _2946, _3384) ? creep
   Call: (21) naf(end_of_file=_2946) ? creep
   Call: (22) end_of_file=_2946 ? creep
   Exit: (22) end_of_file=end_of_file ? creep
   Call: (22) fail ? creep
   Fail: (22) fail ? creep
   Fail: (21) naf(end_of_file=_2946) ? creep
   Redo: (20) canunify([end_of_file|_3318], _2946, _3384) ? creep
   Call: (21) canunify(_3318, _2946, _3390) ? creep
   Exit: (21) canunify([], _2946, []) ? creep
   Exit: (20) canunify([end_of_file], _2946, [end_of_file]) ? creep
   Exit: (19) canunify([(t(_3300):-p), end_of_file], _2946, [(t(_3300):-p), end_of_file]) ? creep
   Exit: (18) canunify([_3282 is nn,  (t(_3300):-p), end_of_file], _2946, [_3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (17) canunify([r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file], _2946, [r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (16) canunify([q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file], _2946, [q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (15) canunify([atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file], _2946, [atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (14) canunify([p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file], _2946, [p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (13) canunify([hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file], _2946, [hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file]) ? creep
   Exit: (12) canunify([play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...], _2946, [play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...]) ? creep
   Exit: (11) canunify([like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...], _2946, [like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...]) ? creep
   Exit: (10) canunify([a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...], _2946, [a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...]) ? creep
   Exit: (9) canunify([ok, a, like, play, hill(h), p(a), atom, q(...)|...], _2946, [ok, a, like, play, hill(h), p(a), atom, q(...)|...]) ? creep
   Call: (9) output([ok, a, like, play, hill(h), p(a), atom, q(...)|...]) ? creep
   Call: (10) write(ok) ? creep
ok
   Exit: (10) write(ok) ? creep
   Call: (10) nl ? creep

   Exit: (10) nl ? creep
   Call: (10) output([a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...]) ? creep
   Call: (11) write(a) ? creep
a
   Exit: (11) write(a) ? creep
   Call: (11) nl ? creep

   Exit: (11) nl ? creep
   Call: (11) output([like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...]) ? creep
   Call: (12) write(like) ? creep
like
   Exit: (12) write(like) ? creep
   Call: (12) nl ? creep

   Exit: (12) nl ? creep
   Call: (12) output([play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...]) ? creep
   Call: (13) write(play) ? creep
play
   Exit: (13) write(play) ? creep
   Call: (13) nl ? creep

   Exit: (13) nl ? creep
   Call: (13) output([hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file]) ? creep
   Call: (14) write(hill(h)) ? creep
hill(h)
   Exit: (14) write(hill(h)) ? creep
   Call: (14) nl ? creep

   Exit: (14) nl ? creep
   Call: (14) output([p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Call: (15) write(p(a)) ? creep
p(a)
   Exit: (15) write(p(a)) ? creep
   Call: (15) nl ? creep

   Exit: (15) nl ? creep
   Call: (15) output([atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Call: (16) write(atom) ? creep
atom
   Exit: (16) write(atom) ? creep
   Call: (16) nl ? creep

   Exit: (16) nl ? creep
   Call: (16) output([q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Call: (17) write(q(b(a))) ? creep
q(b(a))
   Exit: (17) write(q(b(a))) ? creep
   Call: (17) nl ? creep

   Exit: (17) nl ? creep
   Call: (17) output([r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Call: (18) write(r(_3266)) ? creep
r(_3266)
   Exit: (18) write(r(_3266)) ? creep
   Call: (18) nl ? creep

   Exit: (18) nl ? creep
   Call: (18) output([_3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Call: (19) write(_3282 is nn) ? creep
_3282 is nn
   Exit: (19) write(_3282 is nn) ? creep
   Call: (19) nl ? creep

   Exit: (19) nl ? creep
   Call: (19) output([(t(_3300):-p), end_of_file]) ? creep
   Call: (20) write((t(_3300):-p)) ? creep
t(_3300):-p
   Exit: (20) write((t(_3300):-p)) ? creep
   Call: (20) nl ? creep

   Exit: (20) nl ? creep
   Call: (20) output([end_of_file]) ? creep
   Call: (21) write(end_of_file) ? creep
end_of_file
   Exit: (21) write(end_of_file) ? creep
   Call: (21) nl ? creep

   Exit: (21) nl ? creep
   Call: (21) output([]) ? creep
   Exit: (21) output([]) ? creep
   Exit: (20) output([end_of_file]) ? creep
   Exit: (19) output([(t(_3300):-p), end_of_file]) ? creep
   Exit: (18) output([_3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (17) output([r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (16) output([q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (15) output([atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (14) output([p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(_3300):-p), end_of_file]) ? creep
   Exit: (13) output([hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (t(...):-p), end_of_file]) ? creep
   Exit: (12) output([play, hill(h), p(a), atom, q(b(a)), r(_3266), _3282 is nn,  (... :- ...)|...]) ? creep
   Exit: (11) output([like, play, hill(h), p(a), atom, q(b(a)), r(_3266), ...is...|...]) ? creep
   Exit: (10) output([a, like, play, hill(h), p(a), atom, q(b(...)), r(...)|...]) ? creep
   Exit: (9) output([ok, a, like, play, hill(h), p(a), atom, q(...)|...]) ? creep
   Exit: (8) findallterms(_2946) ? creep
true .
*/


/*
(考察・感想)
まず,ファイル操作を行う上で,どの言語においても必要であるファイルのオープンとファイルのクローズ操作を処理に組み込まなければならないと考えた.
Prologの読み込み処理におけるこれらの操作は,組み込み述語see('file.txt')とseenによって行われる.
また,この課題に取り組んだ当初は,前回課題5.6を利用して実現が可能なのではないかと考えたため,上記のような一度入力された項を全てリストに格納し,その後canunifyによる抽出を行おうと試みた.
しかし,既存のプログラムを用いて実装を行うので,実装が容易になると考えていたが,リスト操作を取り入れる必要があったため,実際には処理に必要な手続きが多くなった.
今回採用した処理では,読み込んだ項に対して逐次的に処理を行うため,効率的であることがわかった.
*/