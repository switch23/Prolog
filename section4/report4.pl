% rep04: 第04回 演習課題レポート
% 2019年5月18日         by 学籍番号：29114116 名前：増田大輝
%



%演習4.2(教科書p.98)
%家族データベースで双子を見つける関数twinsを定義する


%fox家の家族データベース
family(
  person(tom, fox, date(7, may, 1950), works(bbc, 15200)),
  person(ann, fox, date(9, may, 1951), unemployed),
  [ person(pat, fox, date(5, may, 1973), unemployed),
    person(jim, fox, date(5, may, 1973), unemployed) ]).

%増田家の家族データベース
family(
  person(yasuhiro, masuda, date(8, april, 1970), works(tokaisumiden, 5000000)),
  person(yuko, masuda, date(5, march, 1972), works(ykkap, 1000000)),
  [ person(hiroki, masuda, date(4, jun, 1998), unemployed),
    person(ami, masuda, date(15, december, 1999), works(bene, 1250000)) ]).

%armstrong家の家族データベース
family(
  person(kevin, armstrong, date(27, december, 1952), works(nitech, 10000000)),
  person(alice, armstrong, date(29, jun, 1953), unemployed),
  [ person(jhon, armstrong, date(15, july, 1980), unemployed),
    person(becky, armstrong, date(15, july, 1980), unemployed) ]).

%fox家の家族データベース
family(
  person(alex, fox, date(7, november, 1930), works(bbc, 17000)),
  person(annie, fox, date(9, january, 1931), unemployed),
  [ person(tom, fox, date(7, may, 1950), works(bbc, 15200)),
    person(alice, armstrong, date(29, jun, 1953), unemployed) ]).

%家族のリストListとその一員Xの関係を表す関数member(X,List)の定義
member(X, [X|_]).

member(X, [_|L]) :-
  member(X, L).

%個人Pとその誕生日Dateを表す関係dateofbirth(P, Date)
dateofbirth(person(_, _, Date, _), Date).

%XとYが別人である関係を表す関数different(X, Y)
different(X, Y) :-
  X\==Y.

%個人Pとラストネームを表す関係lastname(P, Last)
lastname(person(_, Last, _, _), Last).

%双子の関係を表す関数twins(Child1, Child2)
%ある家族の子供の一員として,Child1とChild2が含まれている必要があり,
%なおかつ,Child1とChild2は別人でなければならない.
%また,Child1とChild2の誕生日とラストネームが一致する必要があり,
%以上の条件を満たす場合にChild1とChild2は双子の関係にあると言える.
twins(Child1, Child2) :-
  family(_, _, Children),
  member(Child1, Children),
  member(Child2, Children),
  different(Child1, Child2),
  dateofbirth(Child1, Date),
  dateofbirth(Child2, Date),
  lastname(Child1, Last),
  lastname(Child2, Last).

%いとこの関係を表す関数cousin(P1, P2)
%まず,P1とP2の両親を見つける
%次に,P1とP2の両親が別人である必要がある
%そして,ある家族がP1とP2の親を子として持つかを探す
%以上のようにして,いとこ関係は定義される.
cousin(P1, P2) :-
  family(Father1, Mother1, Children1),
  member(P1, Children1),
  family(Father2, Mother2, Children2),
  member(P2, Children2),
  different(Father1, Father2),
  different(Mother1, Mother2),
  family(_, _, Children3),
  (
  (member(Father1, Children3), member(Father2, Children3));
  (member(Father1, Children3), member(Mother2, Children3));
  (member(Father2, Children3), member(Mother1, Children3));
  (member(Mother1, Children3), member(Father2, Children3));
  (member(Mother1, Children3), member(Mother2, Children3))
  ).


/*

(実行例)

?- twins(person(pat, fox, date(5, may, 1973), unemployed), Child2).
Child2 = person(jim, fox, date(5, may, 1973), unemployed) .


?- twins(person(hiroki, masuda, date(4, jun, 1998), unemployed), Child2).
false.



(トレース)
[trace]  ?- twins(person(pat, fox, date(5, may, 1973), unemployed), Child2).
   Call: (8) twins(person(pat, fox, date(5, may, 1973), unemployed), _2978) ? creep
   Call: (9) family(_3226, _3228, _3230) ? creep
   Exit: (9) family(person(tom, fox, date(7, may, 1950), works(bbc, 15200)), person(ann, fox, date(9, may, 1951), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (9) member(person(pat, fox, date(5, may, 1973), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Exit: (9) member(person(pat, fox, date(5, may, 1973), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (9) member(_2978, [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Exit: (9) member(person(pat, fox, date(5, may, 1973), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (9) different(person(pat, fox, date(5, may, 1973), unemployed), person(pat, fox, date(5, may, 1973), unemployed)) ? creep
   Call: (10) person(pat, fox, date(5, may, 1973), unemployed)\==person(pat, fox, date(5, may, 1973), unemployed) ? creep
   Fail: (10) person(pat, fox, date(5, may, 1973), unemployed)\==person(pat, fox, date(5, may, 1973), unemployed) ? creep
   Fail: (9) different(person(pat, fox, date(5, may, 1973), unemployed), person(pat, fox, date(5, may, 1973), unemployed)) ? creep
   Redo: (9) member(_2978, [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (10) member(_2978, [person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Exit: (10) member(person(jim, fox, date(5, may, 1973), unemployed), [person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Exit: (9) member(person(jim, fox, date(5, may, 1973), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (9) different(person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)) ? creep
   Call: (10) person(pat, fox, date(5, may, 1973), unemployed)\==person(jim, fox, date(5, may, 1973), unemployed) ? creep
   Exit: (10) person(pat, fox, date(5, may, 1973), unemployed)\==person(jim, fox, date(5, may, 1973), unemployed) ? creep
   Exit: (9) different(person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)) ? creep
   Call: (9) dateofbirth(person(pat, fox, date(5, may, 1973), unemployed), _3318) ? creep
   Exit: (9) dateofbirth(person(pat, fox, date(5, may, 1973), unemployed), date(5, may, 1973)) ? creep
   Call: (9) dateofbirth(person(jim, fox, date(5, may, 1973), unemployed), date(5, may, 1973)) ? creep
   Exit: (9) dateofbirth(person(jim, fox, date(5, may, 1973), unemployed), date(5, may, 1973)) ? creep
   Call: (9) lastname(person(pat, fox, date(5, may, 1973), unemployed), _3318) ? creep
   Exit: (9) lastname(person(pat, fox, date(5, may, 1973), unemployed), fox) ? creep
   Call: (9) lastname(person(jim, fox, date(5, may, 1973), unemployed), fox) ? creep
   Exit: (9) lastname(person(jim, fox, date(5, may, 1973), unemployed), fox) ? creep
   Exit: (8) twins(person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)) ? creep
Child2 = person(jim, fox, date(5, may, 1973), unemployed) .<Paste>



[trace]  ?- twins(person(hiroki, masuda, date(4, jun, 1998), unemployed), Child2).
   Call: (8) twins(person(hiroki, masuda, date(4, jun, 1998), unemployed), _4134) ? creep
   Call: (9) family(_4382, _4384, _4386) ? creep
   Exit: (9) family(person(tom, fox, date(7, may, 1950), works(bbc, 15200)), person(ann, fox, date(9, may, 1951), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Call: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Fail: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(pat, fox, date(5, may, 1973), unemployed), person(jim, fox, date(5, may, 1973), unemployed)]) ? creep
   Redo: (9) family(_4382, _4384, _4386) ? creep
   Exit: (9) family(person(yasuhiro, masuda, date(8, april, 1970), works(tokaisumiden, 5000000)), person(yuko, masuda, date(5, march, 1972), works(ykkap, 1000000)), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Exit: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (9) member(_4134, [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Exit: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (9) different(person(hiroki, masuda, date(4, jun, 1998), unemployed), person(hiroki, masuda, date(4, jun, 1998), unemployed)) ? creep
   Call: (10) person(hiroki, masuda, date(4, jun, 1998), unemployed)\==person(hiroki, masuda, date(4, jun, 1998), unemployed) ? creep
   Fail: (10) person(hiroki, masuda, date(4, jun, 1998), unemployed)\==person(hiroki, masuda, date(4, jun, 1998), unemployed) ? creep
   Fail: (9) different(person(hiroki, masuda, date(4, jun, 1998), unemployed), person(hiroki, masuda, date(4, jun, 1998), unemployed)) ? creep
   Redo: (9) member(_4134, [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (10) member(_4134, [person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Exit: (10) member(person(ami, masuda, date(15, december, 1999), works(bene, 1250000)), [person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Exit: (9) member(person(ami, masuda, date(15, december, 1999), works(bene, 1250000)), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (9) different(person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))) ? creep
   Call: (10) person(hiroki, masuda, date(4, jun, 1998), unemployed)\==person(ami, masuda, date(15, december, 1999), works(bene, 1250000)) ? creep
   Exit: (10) person(hiroki, masuda, date(4, jun, 1998), unemployed)\==person(ami, masuda, date(15, december, 1999), works(bene, 1250000)) ? creep
   Exit: (9) different(person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))) ? creep
   Call: (9) dateofbirth(person(hiroki, masuda, date(4, jun, 1998), unemployed), _4486) ? creep
   Exit: (9) dateofbirth(person(hiroki, masuda, date(4, jun, 1998), unemployed), date(4, jun, 1998)) ? creep
   Call: (9) dateofbirth(person(ami, masuda, date(15, december, 1999), works(bene, 1250000)), date(4, jun, 1998)) ? creep
   Fail: (9) dateofbirth(person(ami, masuda, date(15, december, 1999), works(bene, 1250000)), date(4, jun, 1998)) ? creep
   Redo: (10) member(_4134, [person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (11) member(_4134, []) ? creep
   Fail: (11) member(_4134, []) ? creep
   Fail: (10) member(_4134, [person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Fail: (9) member(_4134, [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Redo: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Call: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Fail: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(hiroki, masuda, date(4, jun, 1998), unemployed), person(ami, masuda, date(15, december, 1999), works(bene, 1250000))]) ? creep
   Redo: (9) family(_4382, _4384, _4386) ? creep
   Exit: (9) family(person(kevin, armstrong, date(27, december, 1952), works(nitech, 10000000)), person(alice, armstrong, date(29, jun, 1953), unemployed), [person(jhon, armstrong, date(15, july, 1980), unemployed), person(becky, armstrong, date(15, july, 1980), unemployed)]) ? creep
   Call: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(jhon, armstrong, date(15, july, 1980), unemployed), person(becky, armstrong, date(15, july, 1980), unemployed)]) ? creep
   Call: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(becky, armstrong, date(15, july, 1980), unemployed)]) ? creep
   Call: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(becky, armstrong, date(15, july, 1980), unemployed)]) ? creep
   Fail: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(jhon, armstrong, date(15, july, 1980), unemployed), person(becky, armstrong, date(15, july, 1980), unemployed)]) ? creep
   Redo: (9) family(_4382, _4384, _4386) ? creep
   Exit: (9) family(person(alex, fox, date(7, november, 1930), works(bbc, 17000)), person(annie, fox, date(9, january, 1931), unemployed), [person(tom, fox, date(7, may, 1950), works(bbc, 15200)), person(alice, armstrong, date(29, jun, 1953), unemployed)]) ? creep
   Call: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(tom, fox, date(7, may, 1950), works(bbc, 15200)), person(alice, armstrong, date(29, jun, 1953), unemployed)]) ? creep
   Call: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(alice, armstrong, date(29, jun, 1953), unemployed)]) ? creep
   Call: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (11) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), []) ? creep
   Fail: (10) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(alice, armstrong, date(29, jun, 1953), unemployed)]) ? creep
   Fail: (9) member(person(hiroki, masuda, date(4, jun, 1998), unemployed), [person(tom, fox, date(7, may, 1950), works(bbc, 15200)), person(alice, armstrong, date(29, jun, 1953), unemployed)]) ? creep
   Fail: (8) twins(person(hiroki, masuda, date(4, jun, 1998), unemployed), _4134) ? creep
false.
*/


/*
(考察・感想)
今回の課題では,双子といとこの関係について条件を複数に分割し,それら全ての条件を満たすものとして定義した.
また,それぞれ個々の条件を関数として定義した(例：member, different).
さらに,twinsとcousinの両方で利用できる関数もあったため,非常に利便性も高かった.
応用的なプログラムを書くにあたって,問題を適切な大きさに分割し,独立した関数に解決を担当させることは,
可読性が上がるだけでなく,再利用性や問題の具体化といった面でも有用な方法であると再確認できた.
*/



%演習4.5(教科書p.105)
%非決定性オートマトンに最大操作数を設けた関数acceptsを定義する

%受理状態を定義
final(s3).

%状態遷移を定義
trans(s1, a, s1).
trans(s1, a, s2).
trans(s1, b, s1).
trans(s2, b, s3).
trans(s3, b, s4).

%無言遷移を定義
silent(s2, s4).
silent(s3, s1).

%最大操作数以内で状態Sから入力Stringによって受理状態に到達するかの関係を表す関数accepts(S, String, MaxMoves)
%入力が空リストの場合, その時の状態が受理状態にあれば受理する.
accepts(S, [], _) :-
  final(S).

%操作数の制限下において,現段階での状態と遷移が状態遷移の定義にあれば適応する.
%ただし,最大操作数を一つ減らす.
accepts(S, [X|Rest], MaxMoves) :-
  MaxMoves > 0,
  trans(S, X, S1),
  MaxMovesEx is MaxMoves - 1,
  accepts(S1, Rest, MaxMovesEx).

%操作数の制限下において,現段階での状態からの無言遷移が定義にあれば適応する.
%ただし,最大操作数を一つ減らす.
accepts(S, String, MaxMoves) :-
  MaxMoves > 0,
  silent(S, S1),
  MaxMovesEx is MaxMoves - 1,
  accepts(S1, String, MaxMovesEx).


/*

(実行例)

tring = [a, a, a, a, b] ;
String = [a, a, a, b] ;
String = [a, a, b, a, b] ;
String = [a, a, b] ;
String = [a, b, a, a, b] ;
String = [a, b, a, b] ;
String = [a, b, b, a, b] ;
String = [a, b] ;
String = [a, b, a, b] ;
String = [b, a, a, a, b] ;
String = [b, a, a, b] ;
String = [b, a, b, a, b] ;
String = [b, a, b] ;
String = [b, b, a, a, b] ;
String = [b, b, a, b] ;
String = [b, b, b, a, b] ;
false.

?- accepts(s3, String, 3).
String = [] ;
String = [a, b] ;
false.



(トレース)

[trace]  ?- accepts(s1, String, 5).
   Call: (8) accepts(s1, _2950, 5) ? creep
   Call: (9) final(s1) ? creep
   Fail: (9) final(s1) ? creep
   Redo: (8) accepts(s1, _2950, 5) ? creep
   Call: (9) 5>0 ? creep
   Exit: (9) 5>0 ? creep
   Call: (9) trans(s1, _3158, _3182) ? creep
   Exit: (9) trans(s1, a, s1) ? creep
   Call: (9) _3184 is 5+ -1 ? creep
   Exit: (9) 4 is 5+ -1 ? creep
   Call: (9) accepts(s1, _3160, 4) ? creep
   Call: (10) final(s1) ? creep
   Fail: (10) final(s1) ? creep
   Redo: (9) accepts(s1, _3160, 4) ? creep
   Call: (10) 4>0 ? creep
   Exit: (10) 4>0 ? creep
   Call: (10) trans(s1, _3170, _3194) ? creep
   Exit: (10) trans(s1, a, s1) ? creep
   Call: (10) _3196 is 4+ -1 ? creep
   Exit: (10) 3 is 4+ -1 ? creep
   Call: (10) accepts(s1, _3172, 3) ? creep
   Call: (11) final(s1) ? creep
   Fail: (11) final(s1) ? creep
   Redo: (10) accepts(s1, _3172, 3) ? creep
   Call: (11) 3>0 ? creep
   Exit: (11) 3>0 ? creep
   Call: (11) trans(s1, _3182, _3206) ? creep
   Exit: (11) trans(s1, a, s1) ? creep
   Call: (11) _3208 is 3+ -1 ? creep
   Exit: (11) 2 is 3+ -1 ? creep
   Call: (11) accepts(s1, _3184, 2) ? creep
   Call: (12) final(s1) ? creep
   Fail: (12) final(s1) ? creep
   Redo: (11) accepts(s1, _3184, 2) ? creep
   Call: (12) 2>0 ? creep
   Exit: (12) 2>0 ? creep
   Call: (12) trans(s1, _3194, _3218) ? creep
   Exit: (12) trans(s1, a, s1) ? creep
   Call: (12) _3220 is 2+ -1 ? creep
   Exit: (12) 1 is 2+ -1 ? creep
   Call: (12) accepts(s1, _3196, 1) ? creep
   Call: (13) final(s1) ? creep
   Fail: (13) final(s1) ? creep
   Redo: (12) accepts(s1, _3196, 1) ? creep
   Call: (13) 1>0 ? creep
   Exit: (13) 1>0 ? creep
   Call: (13) trans(s1, _3206, _3230) ? creep
   Exit: (13) trans(s1, a, s1) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) final(s1) ? creep
   Fail: (14) final(s1) ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Fail: (13) accepts(s1, _3208, 0) ? creep
   Redo: (13) trans(s1, _3206, _3230) ? creep
   Exit: (13) trans(s1, a, s2) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s2, _3208, 0) ? creep
   Call: (14) final(s2) ? creep
   Fail: (14) final(s2) ? creep
   Redo: (13) accepts(s2, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Redo: (13) accepts(s2, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Fail: (13) accepts(s2, _3208, 0) ? creep
   Redo: (13) trans(s1, _3206, _3230) ? creep
   Exit: (13) trans(s1, b, s1) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) final(s1) ? creep
   Fail: (14) final(s1) ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Redo: (13) accepts(s1, _3208, 0) ? creep
   Call: (14) 0>0 ? creep
   Fail: (14) 0>0 ? creep
   Fail: (13) accepts(s1, _3208, 0) ? creep
   Redo: (12) accepts(s1, _3196, 1) ? creep
   Call: (13) 1>0 ? creep
   Exit: (13) 1>0 ? creep
   Call: (13) silent(s1, _3222) ? creep
   Fail: (13) silent(s1, _3222) ? creep
   Fail: (12) accepts(s1, _3196, 1) ? creep
   Redo: (12) trans(s1, _3194, _3218) ? creep
   Exit: (12) trans(s1, a, s2) ? creep
   Call: (12) _3220 is 2+ -1 ? creep
   Exit: (12) 1 is 2+ -1 ? creep
   Call: (12) accepts(s2, _3196, 1) ? creep
   Call: (13) final(s2) ? creep
   Fail: (13) final(s2) ? creep
   Redo: (12) accepts(s2, _3196, 1) ? creep
   Call: (13) 1>0 ? creep
   Exit: (13) 1>0 ? creep
   Call: (13) trans(s2, _3206, _3230) ? creep
   Exit: (13) trans(s2, b, s3) ? creep
   Call: (13) _3232 is 1+ -1 ? creep
   Exit: (13) 0 is 1+ -1 ? creep
   Call: (13) accepts(s3, _3208, 0) ? creep
   Call: (14) final(s3) ? creep
   Exit: (14) final(s3) ? creep
   Exit: (13) accepts(s3, [], 0) ? creep
   Exit: (12) accepts(s2, [b], 1) ? creep
   Exit: (11) accepts(s1, [a, b], 2) ? creep
   Exit: (10) accepts(s1, [a, a, b], 3) ? creep
   Exit: (9) accepts(s1, [a, a, a, b], 4) ? creep
   Exit: (8) accepts(s1, [a, a, a, a, b], 5) ? creep
String = [a, a, a, a, b] .

[trace]  ?- accepts(s3, String, 3).
   Call: (8) accepts(s3, _2950, 3) ? creep
   Call: (9) final(s3) ? creep
   Exit: (9) final(s3) ? creep
   Exit: (8) accepts(s3, [], 3) ? creep
String = [] .
*/


/*
(考察・感想)
今回の課題では,受理状態,状態遷移,無言遷移を定義し,最大操作数の制限付き非決定性オートマトンを実装した.
算術演算子を用いて,最大操作数を逐次減らしていくことにより,動作回数をカウントすることと同値としている.
また,比較演算子によって,操作回数による終了条件を設けている.
実行例では,初期状態と最大操作数を設定した上で,終了状態に到達するまでに許される入力系列を列挙する形式になっている.
*/