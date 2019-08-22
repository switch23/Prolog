%演習7.5(教科書p.175)



%Term1が変数の場合
subsume(Term1, Term2) :-
  var(Term1),!.

%Term1がアトムでTerm2が変数の場合
subsume(Term1, Term2) :-
  atomic(Term1),
  var(Term2),!,fail.

%Term1とTerm2が同一アトムの場合
subsume(Term1, Term2) :-
  atomic(Term1),
  atomic(Term2),
  Term1 = Term2,!.

%Term1とTerm2が構造の場合
subsume(Term1, Term2) :- 
  Term1 =.. [Head1|List1],
  Term2 =.. [Head2|List2],
  general(List1, List2).


/*
subsume(Term1, _) :- 
  var(Term1),!.

subsume(Term1, Term2) :-
  atomic(Term2),
  not(not(Term1=Term2)),!.

subsume(Term1, Term2) :-
    not( atomic(Term1) ),
    not( atomic(Term2) ),
    nonvar(Term1),
    nonvar(Term2),
    Term1 =.. [Head1|List1],
    Term2 =.. [Head2|List2],
    nonvar(Head1),
    nonvar(Head2),
    Head1 = Head2,
    general(List1, List2).
    %listcheck(List1,List2).
*/

general([],_) :- !.

/*
%general([Head1|List1], [Head2|List2]) :-
%  var(Head1),!.

general([Head1|List1], [Head2|List2]) :-
  atomic(Head1),
  var(Head2),fail,!.

general([Head1|List1], [Head2|List2]) :-
  atomic(Head1),
  atomic(Head2),
  Head1 = Head2,
  general(List1,List2).



general([Head1|List1], [Head2|List2]) :-
  var(Head1),
  not(not(Head1 = Head2)),
  general(List1,List2).

general([Head1|List1], [Head2|List2]) :-
  subsume(Head1,Head2),
  general(List1,List2).
*/

general([Head1|List1], [Head2|List2]) :-
  atomic(Term1),
  var(Term2),!,fail.

general([Head1|List1], [Head2|List2]) :-
  nonvar(Head1),
  nonvar(Head2),
  Head1 = Head2,
  listcheck(List1, List2).

general([Head1|List1], [Head2|List2]) :-
  atom(Head1),
  atom(Head2),
  Head1 = Head2,!.


listcheck([], _) :- !.

listcheck(_, []) :- !.
  

listcheck([Head1|List1], [Head2|List2]) :-
  nonvar(Head1),
  var(Head2),!,fail.

  
listcheck([Head1|List1], [Head2|List2]) :-
  atomic(Head1),
  atomic(Head2),
  (not(Head1 = Head2)),!,
  listcheck(List1, List2).


listcheck([Head1|List1], [Head2|List2]) :-
  atomic(Head1),
  atomic(Head2),!,fail.


listcheck([Head1|List1], [Head2|List2]) :-
  Head1 =.. Term1,
  Head2 =.. Term2,
  %general(Term1, Term2),
  subsume(Term1, Term2),
  listcheck(List1, List2).


listcheck([Head1|List1], [Head2|List2]) :-
  var(Head1),
  Head1 = Head2,
  listcheck(List1, List2).

/*
listcheck([Head1|List1], [Head2|List2]) :-
  Head1 =.. Term1,
  Head2 =.. Term2,
  listcheck(List1,List2),
  general(Term1, Term2).
*/
/*
listcheck([Head1|List1], [Head2|List2]) :-
  Head1 =.. Term1,
  Head2 =.. Term2,
  general(Term1, Term2),
  listcheck(List1, List2).
*/