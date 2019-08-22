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

