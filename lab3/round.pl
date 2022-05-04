ead_input(File, N, K, L) :-
  open(File,read,Stream),
  read_line(Stream, [N,K]),
  read_line(Stream, L).

read_line(Stream, L) :-
  read_line_to_codes(Stream, Line),
  atom_codes(Atom, Line),
  atomic_list_concat(Atoms, ' ', Atom),
  maplist(atom_number, Atoms, L).



modify([],[],T,_,T).
modify([],[H2|T2],I,Freq,T) :-
  H2 = Freq, NewI is I + 1,
  (NewI < T -> modify([],T2,NewI,0,T)
  ; NewI =:= T , T2 = [], modify([],[],NewI,0,T)
  ).

modify([H1|T1],[H2|T2],I,Freq,T) :-                       % I represents current town,Freq is for cars in a town
  (H1 =\= I ->  H2 is Freq, NewFreq is 0, NewI is I + 1, modify([H1|T1],T2,NewI,NewFreq,T)
  ; H1 =:= I, NewFreq is Freq + 1, modify(T1, [H2|T2],I,NewFreq,T)
  ).


valid(Sum,Max) :- Sum - Max + 1 >= Max.

increment_max(Max,T,Res) :-
  Aux is Max + 1,
  ( Aux >= T ->  Res is Aux - T
  ; Aux < T  ->  Res is Aux
  ).

find_diff(Main,Max,T,Res) :-
  Aux is Main - Max,
  (Aux < 0 -> Res is Aux + T
  ;Aux > 0, Res is Aux
  ).

initSum([],_,Res,Res).
initSum([H1|T1],T,I,Res) :-
  (H1 =:= 0 -> initSum(T1,T,I,Res)
  ;H1 =\= 0, NewI is T - H1 + I,
  initSum(T1,T,NewI,Res)
  ).

sumArray([],_,_,_,_,[]).
sumArray([H1|T1],T,C,I,Sum,[H2|T2]) :-
   (I =:= 0 -> H2 = Sum
   ;I =\= 0, H2 is Sum + C - T * H1
   ),
   NewI is I + 1,
   sumArray(T1,T,C,NewI,H2,T2).

maxDist([H1|T1],Main,Max,T,Res) :-
  (Main =:= Max -> increment_max(Max,T,NewMax), maxDist(T1,Main,NewMax,T,Res)
  ; Main =\= Max ->
    (H1 =:= 0 -> increment_max(Max,T,NewMax), maxDist(T1,Main,NewMax,T,Res)
    ;H1 =\= 0 -> find_diff(Main,Max,T,Res)

    )
  ).

dist(_,_,T,T,[]).
dist([H1|T1],OldMax,I,T,[H3|T3]) :-
  (H1 =\= 0 -> NewI is I + 1, maxDist([H1|T1],I,I,T,H3),dist(T1,H3,NewI,T,T3)
  ;H1=:= 0 -> NewI is I + 1, increment_max(OldMax,T,H3),dist(T1,H3,NewI,T,T3)
  ).

check([],[],Min,Pos,_,Min,Pos).
check([H1|T1],[H2|T2],I,K,Count,Min,Pos) :-
  NewCount is Count + 1,
  (valid(H1,H2) -> NewI is min(I,H1),
    ( NewI =:= I -> check(T1,T2,NewI,K,NewCount,Min,Pos)
    ; NewI =:= H1 -> NewK is Count, check(T1,T2,NewI,NewK,NewCount,Min,Pos)

    )
  ;not(valid(H1,H2)),check(T1,T2,I,K,NewCount,Min,Pos)
  ).

round(Filename,Moves,City) :-
  read_input(Filename,T,C,List),
  initSum(List,T,0,InitSum),
  msort(List,NewList),
  modify(NewList,TownList,0,0,T),
  sumArray(TownList,T,C,0,InitSum,SumArray),
  append(TownList,TownList,DoubleList),
  dist(DoubleList,InitSum,0,T,MaxArray),
  check(SumArray,MaxArray,InitSum,0,0,Min,Pos),
  Moves = Min,
  City = Pos.
