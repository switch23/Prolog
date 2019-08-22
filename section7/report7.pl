% rep07: 第07回 演習課題レポート
% 2019年6月8日         by 学籍番号：29114116 名前：増田大輝
%


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



%演習7.5(教科書p.175)
%Term1がTerm2よりも一般的である,または等しい関係subsumeを定義する.


%述語subsumeはTerm1がTerm2よりも一般的または等しい関係

%Term1が変数の場合
subsume(Term1, _) :-
  var(Term1),!.

%Term1がアトムでTerm2が変数の場合
subsume(Term1, Term2) :-
  atomic(Term1),
  var(Term2),!,fail.

%Term1とTerm2が同一アトムの場合
subsume(Term1, Term2) :-
  atomic(Term1),
  atomic(Term2),
  not(not(Term1 = Term2)),!.

%Term1とTerm2が構造の場合
subsume(Term1, Term2) :- 
  Term1 =.. [Head1|List1],
  Term2 =.. [Head2|List2],
  Head1 = Head2,
  checklist(List1, List2).

%述語checklistはリスト内においてHead1がHead2よりも一般的または等しい関係

%List1が空の時の処理
checklist([],_) :- !.

%List2が空の時の処理
checklist(_,[]) :- !.

%Head1とHead2がアトムの場合
checklist([Head1|List1],[Head2|List2]) :-
  atomic(Head1),
  atomic(Head2),
  Head1=Head2,
  checklist(List1, List2),!.

%Head1がアトムでHead2が変数の場合
checklist([Head1|_],[Head2|_]) :-
  atomic(Head1),
  var(Head2),!,fail.

%Head1が変数でHead2がアトムでも変数でもない場合
checklist([Head1|_], [Head2|_]) :-
  var(Head1),
  not(atomic(Head2)),
  nonvar(Head2),!.

%変数Head1をHead2で具体化して次の要素を処理する
checklist([Head1|List1], [Head2|List2]) :-
  var(Head1),
  Head1 = Head2,
  checklist(List1,List2),!.

%Head1とHead2が共にアトムではない場合
checklist([Head1|List1], [Head2|List2]) :-
  not(atomic(Head1)),
  not(atomic(Head2)),
  subsume(Head1, Head2),
  checklist(List1, List2),!.


/*
(実行例)
?- subsume(X,c).
true.

?- subsume(g(X),g(t(Y))).
true.

?- subsume(f(X,X), f(a,b)).
false.

?- subsume(g(g(g(a))),g(g(g(X)))).
false.


(トレース)
[trace]  ?- subsume(X,c).                  
   Call: (8) subsume(_2842, c) ? creep
   Call: (9) var(_2842) ? creep
   Exit: (9) var(_2842) ? creep
   Exit: (8) subsume(_2842, c) ? creep
true.

[trace]  ?- subsume(g(X),g(t(Y))).         
   Call: (8) subsume(g(_2844), g(t(_2848))) ? creep
   Call: (9) var(g(_2844)) ? creep
   Fail: (9) var(g(_2844)) ? creep
   Redo: (8) subsume(g(_2844), g(t(_2848))) ? creep
   Call: (9) g(_2844)=..[_3112|_3114] ? creep
   Exit: (9) g(_2844)=..[g, _2844] ? creep
   Call: (9) g(t(_2848))=..[_3124|_3126] ? creep
   Exit: (9) g(t(_2848))=..[g, t(_2848)] ? creep
   Call: (9) g=g ? creep
   Exit: (9) g=g ? creep
   Call: (9) checklist([_2844], [t(_2848)]) ? creep
   Call: (10) var(_2844) ? creep
   Exit: (10) var(_2844) ? creep
^  Call: (10) not(atomic(t(_2848))) ? creep
^  Exit: (10) not(user:atomic(t(_2848))) ? creep
   Call: (10) nonvar(t(_2848)) ? creep
   Exit: (10) nonvar(t(_2848)) ? creep
   Exit: (9) checklist([_2844], [t(_2848)]) ? creep
   Exit: (8) subsume(g(_2844), g(t(_2848))) ? creep
true.

[trace]  ?- subsume(f(X,X), f(a,b)).       
   Call: (8) subsume(f(_2846, _2846), f(a, b)) ? creep
   Call: (9) var(f(_2846, _2846)) ? creep
   Fail: (9) var(f(_2846, _2846)) ? creep
   Redo: (8) subsume(f(_2846, _2846), f(a, b)) ? creep
   Call: (9) f(_2846, _2846)=..[_3082|_3084] ? creep
   Exit: (9) f(_2846, _2846)=..[f, _2846, _2846] ? creep
   Call: (9) f(a, b)=..[_3100|_3102] ? creep
   Exit: (9) f(a, b)=..[f, a, b] ? creep
   Call: (9) f=f ? creep
   Exit: (9) f=f ? creep
   Call: (9) checklist([_2846, _2846], [a, b]) ? creep
   Call: (10) var(_2846) ? creep
   Exit: (10) var(_2846) ? creep
^  Call: (10) not(atomic(a)) ? creep
^  Fail: (10) not(user:atomic(a)) ? creep
   Redo: (9) checklist([_2846, _2846], [a, b]) ? creep
   Call: (10) var(_2846) ? creep
   Exit: (10) var(_2846) ? creep
   Call: (10) _2846=a ? creep
   Exit: (10) a=a ? creep
   Call: (10) checklist([a], [b]) ? creep
   Call: (11) a=b ? creep
   Fail: (11) a=b ? creep
   Redo: (10) checklist([a], [b]) ? creep
   Call: (11) var(b) ? creep
   Fail: (11) var(b) ? creep
   Redo: (10) checklist([a], [b]) ? creep
   Call: (11) var(a) ? creep
   Fail: (11) var(a) ? creep
   Redo: (10) checklist([a], [b]) ? creep
   Call: (11) var(a) ? creep
   Fail: (11) var(a) ? creep
   Redo: (10) checklist([a], [b]) ? creep
^  Call: (11) not(atomic(a)) ? creep
^  Fail: (11) not(user:atomic(a)) ? creep
   Fail: (10) checklist([a], [b]) ? creep
   Redo: (9) checklist([_2846, _2846], [a, b]) ? creep
^  Call: (10) not(atomic(_2846)) ? creep
^  Exit: (10) not(user:atomic(_2846)) ? creep
^  Call: (10) not(atomic(a)) ? creep
^  Fail: (10) not(user:atomic(a)) ? creep
   Fail: (9) checklist([_2846, _2846], [a, b]) ? creep
   Fail: (8) subsume(f(_2846, _2846), f(a, b)) ? creep
false.

[trace]  ?- subsume(g(g(g(a))),g(g(g(X)))).
   Call: (8) subsume(g(g(g(a))), g(g(g(_2860)))) ? creep
   Call: (9) var(g(g(g(a)))) ? creep
   Fail: (9) var(g(g(g(a)))) ? creep
   Redo: (8) subsume(g(g(g(a))), g(g(g(_2860)))) ? creep
   Call: (9) g(g(g(a)))=..[_3110|_3112] ? creep
   Exit: (9) g(g(g(a)))=..[g, g(g(a))] ? creep
   Call: (9) g(g(g(_2860)))=..[_3122|_3124] ? creep
   Exit: (9) g(g(g(_2860)))=..[g, g(g(_2860))] ? creep
   Call: (9) g=g ? creep
   Exit: (9) g=g ? creep
   Call: (9) checklist([g(g(a))], [g(g(_2860))]) ? creep
   Call: (10) var(g(g(a))) ? creep
   Fail: (10) var(g(g(a))) ? creep
   Redo: (9) checklist([g(g(a))], [g(g(_2860))]) ? creep
   Call: (10) var(g(g(a))) ? creep
   Fail: (10) var(g(g(a))) ? creep
   Redo: (9) checklist([g(g(a))], [g(g(_2860))]) ? creep
^  Call: (10) not(atomic(g(g(a)))) ? creep
^  Exit: (10) not(user:atomic(g(g(a)))) ? creep
^  Call: (10) not(atomic(g(g(_2860)))) ? creep
^  Exit: (10) not(user:atomic(g(g(_2860)))) ? creep
   Call: (10) subsume(g(g(a)), g(g(_2860))) ? creep
   Call: (11) var(g(g(a))) ? creep
   Fail: (11) var(g(g(a))) ? creep
   Redo: (10) subsume(g(g(a)), g(g(_2860))) ? creep
   Call: (11) g(g(a))=..[_3154|_3156] ? creep
   Exit: (11) g(g(a))=..[g, g(a)] ? creep
   Call: (11) g(g(_2860))=..[_3166|_3168] ? creep
   Exit: (11) g(g(_2860))=..[g, g(_2860)] ? creep
   Call: (11) g=g ? creep
   Exit: (11) g=g ? creep
   Call: (11) checklist([g(a)], [g(_2860)]) ? creep
   Call: (12) var(g(a)) ? creep
   Fail: (12) var(g(a)) ? creep
   Redo: (11) checklist([g(a)], [g(_2860)]) ? creep
   Call: (12) var(g(a)) ? creep
   Fail: (12) var(g(a)) ? creep
   Redo: (11) checklist([g(a)], [g(_2860)]) ? creep
^  Call: (12) not(atomic(g(a))) ? creep
^  Exit: (12) not(user:atomic(g(a))) ? creep
^  Call: (12) not(atomic(g(_2860))) ? creep
^  Exit: (12) not(user:atomic(g(_2860))) ? creep
   Call: (12) subsume(g(a), g(_2860)) ? creep
   Call: (13) var(g(a)) ? creep
   Fail: (13) var(g(a)) ? creep
   Redo: (12) subsume(g(a), g(_2860)) ? creep
   Call: (13) g(a)=..[_3198|_3200] ? creep
   Exit: (13) g(a)=..[g, a] ? creep
   Call: (13) g(_2860)=..[_3210|_3212] ? creep
   Exit: (13) g(_2860)=..[g, _2860] ? creep
   Call: (13) g=g ? creep
   Exit: (13) g=g ? creep
   Call: (13) checklist([a], [_2860]) ? creep
   Call: (14) var(_2860) ? creep
   Exit: (14) var(_2860) ? creep
   Call: (14) fail ? creep
   Fail: (14) fail ? creep
   Fail: (13) checklist([a], [_2860]) ? creep
   Fail: (12) subsume(g(a), g(_2860)) ? creep
   Fail: (11) checklist([g(a)], [g(_2860)]) ? creep
   Fail: (10) subsume(g(g(a)), g(g(_2860))) ? creep
   Fail: (9) checklist([g(g(a))], [g(g(_2860))]) ? creep
   Fail: (8) subsume(g(g(g(a))), g(g(g(_2860)))) ? creep
false.
*/


/*
(考察・感想)
今回の課題では,HB(Term1)がHB(Term2)を内包するか否かを判別するプログラムを構築した.
特に,エルブラン領域が一般的に無限になることから,あらゆるケースに対応できるようにプログラムを組み立てた.
そのため,手続きの分岐や手数が非常に多くなり,多くの時間を要した.
しかし,2年後期の「知識表現と推論」の講義と,本演習で学んだPrologの集大成の設問としてかなりやりごたえのある課題であった.
*/



%演習7.8(教科書p.185)
%与えられた集合全ての部分集合の集合を求める関係powersetを組み込み述語bagofを用いて定義する.
%ただし,課題3.8で作成した関数subsを用いて定義する

%与えられた集合の部分集合を求める関係subsを定義

%Setが空のリスト（空集合）だった場合は,その部分集合は空集合のみ
subs([],[]) :- !.

%バックトラックを利用した再帰的定義により,部分集合の先頭を保存する
subs([X|Set],[X|Subset]) :-
  subs(Set,Subset).

%与えられたリストの先頭を順次取り除いていく
subs([_|Set],Subset) :-
  subs(Set,Subset).

%与えられた集合の全ての部分集合の集合を求める関係powersetの定義
powerset(Set,Subset) :-
  bagof(Subs,subs(Set,Subs),Subset).   %与えられた集合Subsからルールsubsによって得られる集合Subset


/*
(実行例)
?- powerset([a,b,c],Subset).
Subset = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []].

?- powerset([0,1,[2]], Subset).        
Subset = [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[2]], []].

?- powerset([[],[[]]], Subset).
Subset = [[[], [[]]], [[]], [[[]]], []].


(トレース)
[trace]  ?- powerset([a,b,c],Subset).           
   Call: (8) powerset([a, b, c], _2866) ? creep
^  Call: (9) bagof(_3092, subs([a, b, c], _3092), _2866) ? creep
   Call: (15) subs([a, b, c], _3092) ? creep
   Call: (16) subs([b, c], _3144) ? creep
   Call: (17) subs([c], _3150) ? creep
   Call: (18) subs([], _3156) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [b, c]) ? creep
   Exit: (15) subs([a, b, c], [a, b, c]) ? creep
   Redo: (17) subs([c], _3150) ? creep
   Call: (18) subs([], _3150) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], [b]) ? creep
   Exit: (15) subs([a, b, c], [a, b]) ? creep
   Redo: (16) subs([b, c], _3144) ? creep
   Call: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3150) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [c]) ? creep
   Exit: (15) subs([a, b, c], [a, c]) ? creep
   Redo: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3144) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], []) ? creep
   Exit: (15) subs([a, b, c], [a]) ? creep
   Redo: (15) subs([a, b, c], _3092) ? creep
   Call: (16) subs([b, c], _3092) ? creep
   Call: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3150) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [b, c]) ? creep
   Exit: (15) subs([a, b, c], [b, c]) ? creep
   Redo: (17) subs([c], _3144) ? creep
   Call: (18) subs([], _3144) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], [b]) ? creep
   Exit: (15) subs([a, b, c], [b]) ? creep
   Redo: (16) subs([b, c], _3092) ? creep
   Call: (17) subs([c], _3092) ? creep
   Call: (18) subs([], _3144) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], [c]) ? creep
   Exit: (16) subs([b, c], [c]) ? creep
   Exit: (15) subs([a, b, c], [c]) ? creep
   Redo: (17) subs([c], _3092) ? creep
   Call: (18) subs([], _3092) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([c], []) ? creep
   Exit: (16) subs([b, c], []) ? creep
   Exit: (15) subs([a, b, c], []) ? creep
^  Call: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (9) bagof(_3092, user:subs([a, b, c], _3092), [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []]) ? creep
   Exit: (8) powerset([a, b, c], [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []]) ? creep
Subset = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []].

[trace]  ?- powerset([0,1,[2]], Subset).
   Call: (8) powerset([0, 1, [2]], _2872) ? creep
^  Call: (9) bagof(_3110, subs([0, 1, [2]], _3110), _2872) ? creep
   Call: (15) subs([0, 1, [2]], _3110) ? creep
   Call: (16) subs([1, [2]], _3162) ? creep
   Call: (17) subs([[2]], _3168) ? creep
   Call: (18) subs([], _3174) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [1, [2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [0, 1, [2]]) ? creep
   Redo: (17) subs([[2]], _3168) ? creep
   Call: (18) subs([], _3168) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], [1]) ? creep
   Exit: (15) subs([0, 1, [2]], [0, 1]) ? creep
   Redo: (16) subs([1, [2]], _3162) ? creep
   Call: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3168) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [[2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [0, [2]]) ? creep
   Redo: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3162) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], []) ? creep
   Exit: (15) subs([0, 1, [2]], [0]) ? creep
   Redo: (15) subs([0, 1, [2]], _3110) ? creep
   Call: (16) subs([1, [2]], _3110) ? creep
   Call: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3168) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [1, [2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [1, [2]]) ? creep
   Redo: (17) subs([[2]], _3162) ? creep
   Call: (18) subs([], _3162) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], [1]) ? creep
   Exit: (15) subs([0, 1, [2]], [1]) ? creep
   Redo: (16) subs([1, [2]], _3110) ? creep
   Call: (17) subs([[2]], _3110) ? creep
   Call: (18) subs([], _3162) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], [[2]]) ? creep
   Exit: (16) subs([1, [2]], [[2]]) ? creep
   Exit: (15) subs([0, 1, [2]], [[2]]) ? creep
   Redo: (17) subs([[2]], _3110) ? creep
   Call: (18) subs([], _3110) ? creep
   Exit: (18) subs([], []) ? creep
   Exit: (17) subs([[2]], []) ? creep
   Exit: (16) subs([1, [2]], []) ? creep
   Exit: (15) subs([0, 1, [2]], []) ? creep
^  Call: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (9) bagof(_3110, user:subs([0, 1, [2]], _3110), [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[...]], []]) ? creep
   Exit: (8) powerset([0, 1, [2]], [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[...]], []]) ? creep
Subset = [[0, 1, [2]], [0, 1], [0, [2]], [0], [1, [2]], [1], [[2]], []].

[trace]  ?- powerset([[],[[]]], Subset).
   Call: (8) powerset([[], [[]]], _2866) ? creep
^  Call: (9) bagof(_3098, subs([[], [[]]], _3098), _2866) ? creep
   Call: (15) subs([[], [[]]], _3098) ? creep
   Call: (16) subs([[[]]], _3150) ? creep
   Call: (17) subs([], _3156) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], [[[]]]) ? creep
   Exit: (15) subs([[], [[]]], [[], [[]]]) ? creep
   Redo: (16) subs([[[]]], _3150) ? creep
   Call: (17) subs([], _3150) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], []) ? creep
   Exit: (15) subs([[], [[]]], [[]]) ? creep
   Redo: (15) subs([[], [[]]], _3098) ? creep
   Call: (16) subs([[[]]], _3098) ? creep
   Call: (17) subs([], _3150) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], [[[]]]) ? creep
   Exit: (15) subs([[], [[]]], [[[]]]) ? creep
   Redo: (16) subs([[[]]], _3098) ? creep
   Call: (17) subs([], _3098) ? creep
   Exit: (17) subs([], []) ? creep
   Exit: (16) subs([[[]]], []) ? creep
   Exit: (15) subs([[], [[]]], []) ? creep
^  Call: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (15) call('$bags':'$destroy_findall_bag') ? creep
^  Exit: (9) bagof(_3098, user:subs([[], [[]]], _3098), [[[], [[]]], [[]], [[[]]], []]) ? creep
   Exit: (8) powerset([[], [[]]], [[[], [[]]], [[]], [[[]]], []]) ? creep
Subset = [[[], [[]]], [[]], [[[]]], []].
*/


/*
(考察・感想)
本課題では,「Lが条件Pを満たす全てのXのリストである」という組み込み述語bagof(X,P,L)を用いて答える設問であった.
組み込み述語には,このように条件に合うものだけを抽出する便利な機能を持つものもあることを知り,自分で実装する手間がないことを考えると,その恩恵は計り知れないと感じた.
組み込み述語を効率的に用いると早い上に正確なプログラムを作れることを体感した課題でもあった.
同様に,多言語においてもパッケージやライブラリといった概念が存在するため,これらを有効に活用できるようになりたいと感じた.
*/