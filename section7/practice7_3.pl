%演習7.3(教科書p.175)
%述語gnd(Term)を,具体化されていない変数がTermに含まれないなら真となるように定義する.

%具体化されていない変数がTermに含まれていない場合に真を返す述語gnd
gnd(Term) :-                  %Termがアトムの場合、真を返す
  atom(Term),!.

gnd(Term) :-                  %Termが構造を持つ時
  nonvar(Term),               %Termが変数でないことを保証
  Term =.. List,              %Termを分解してListに格納
  checkvar(List).             %Listの要素が具体化されているかチェック

%リストの先頭要素が具体化されているかチェックする述語checkvar
checkvar([]) :- !.            %リストが空の時の処理

checkvar([Head|List]) :-      %リストに要素が含まれる時
  gnd(Head),                  %先頭が具体化されているかチェック
  checkvar(List).             %尾部のリストについて再帰的に処理する


/*
(実行例)
?- gnd(f(a,b,c)).
true.

?- gnd(f(x,Y)).  
false.

?- gnd(a).     
true.

?- gnd(X).
false.


(トレース)
[trace]  ?- gnd(f(a,b,c)).
   Call: (8) gnd(f(a, b, c)) ? creep
   Call: (9) nonvar(f(a, b, c)) ? creep
   Exit: (9) nonvar(f(a, b, c)) ? creep
   Call: (9) f(a, b, c)=.._3038 ? creep
   Exit: (9) f(a, b, c)=..[f, a, b, c] ? creep
   Call: (9) checkvar([f, a, b, c]) ? creep
   Call: (10) gnd(f) ? creep
   Exit: (10) gnd(f) ? creep
   Call: (10) checkvar([a, b, c]) ? creep
   Call: (11) gnd(a) ? creep
   Exit: (11) gnd(a) ? creep
   Call: (11) checkvar([b, c]) ? creep
   Call: (12) gnd(b) ? creep
   Exit: (12) gnd(b) ? creep
   Call: (12) checkvar([c]) ? creep
   Call: (13) gnd(c) ? creep
   Exit: (13) gnd(c) ? creep
   Call: (13) checkvar([]) ? creep
   Exit: (13) checkvar([]) ? creep
   Exit: (12) checkvar([c]) ? creep
   Exit: (11) checkvar([b, c]) ? creep
   Exit: (10) checkvar([a, b, c]) ? creep
   Exit: (9) checkvar([f, a, b, c]) ? creep
   Exit: (8) gnd(f(a, b, c)) ? creep
true.

[trace]  ?- gnd(f(x,Y)).  
   Call: (8) gnd(f(x, _2844)) ? creep
   Call: (9) nonvar(f(x, _2844)) ? creep
   Exit: (9) nonvar(f(x, _2844)) ? creep
   Call: (9) f(x, _2844)=.._3072 ? creep
   Exit: (9) f(x, _2844)=..[f, x, _2844] ? creep
   Call: (9) checkvar([f, x, _2844]) ? creep
   Call: (10) gnd(f) ? creep
   Exit: (10) gnd(f) ? creep
   Call: (10) checkvar([x, _2844]) ? creep
   Call: (11) gnd(x) ? creep
   Exit: (11) gnd(x) ? creep
   Call: (11) checkvar([_2844]) ? creep
   Call: (12) gnd(_2844) ? creep
   Call: (13) nonvar(_2844) ? creep
   Fail: (13) nonvar(_2844) ? creep
   Fail: (12) gnd(_2844) ? creep
   Fail: (11) checkvar([_2844]) ? creep
   Fail: (10) checkvar([x, _2844]) ? creep
   Fail: (9) checkvar([f, x, _2844]) ? creep
   Fail: (8) gnd(f(x, _2844)) ? creep
false.

[trace]  ?- gnd(a).       
   Call: (8) gnd(a) ? creep
   Exit: (8) gnd(a) ? creep
true.

[trace]  ?- gnd(X).       
   Call: (8) gnd(_2842) ? creep
   Call: (9) nonvar(_2842) ? creep
   Fail: (9) nonvar(_2842) ? creep
   Fail: (8) gnd(_2842) ? creep
false.
*/


/*
(考察・感想)
今回の課題では,組み込み手続きatomとnonvarを用いて具体化されていない変数がTermに含まれていない場合に真となる関数gndを定義した.
組み込み述語では,利用価値が高く,複雑な処理をあらかじめ述語として定義してあるのでこれらを利用することで効率的にプログラムを構築できる.
また,自身でプログラムを作る必要もないため,基本的に誤りがなく,バグの要因にならない点が良いと感じた.
また,=..を利用することによって項の組み立てと分解を行うことができる機能は非常にユニークだと感じた.
*/
