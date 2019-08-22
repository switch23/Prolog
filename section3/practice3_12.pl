%演習3.12（教科書p.85）
%オペレータを定義して,その主関数と構造を示す

%優先度300, xfx型の中置オペレータplays
:- op(300, xfx, plays).

%優先度200, xfy型の中置オペレータand
:- op(200, xfy, and).


/*
(実行例)
?- Term3 = plays(daichi, and(soccer, ice_hockey)).
Term3 = daichi plays soccer and ice_hockey.

?- Term4 = plays(tobise, and(shooting, and(basketball, baseball))).
Term4 = tobise plays shooting and basketball and baseball.

*/

/*
(考察・感想)
今回のオペレータの定義では,playsの優先度が300,andの優先度が200であるのでplaysの方が優先度が大きく,
一番外の主関数子としてはplaysが正しい.
その上で,andはxfy型の中置オペレータであることから,自身の関数の中にandを入れることが可能である.
以上のようにしてTerm3,Term4のような構文が成立する.

*/
