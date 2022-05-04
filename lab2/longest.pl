read_input(File, M, N, L) :-
  open(File,read,Stream),
  read_line(Stream, [M,N]),
  read_line(Stream, L).

read_line(Stream, L) :-
  read_line_to_codes(Stream, Line),
  atom_codes(Atom, Line),
  atomic_list_concat(Atoms, ' ', Atom),
  maplist(atom_number, Atoms, L).

modify([], _,[]).
modify([H1|T1],N, [H2|T2]) :-
  NewVal is -H1 - N,
  H2 = NewVal,
  modify(T1, N, T2).

prefix_sum([], [], _).
prefix_sum([H|T], [H1|T1], Hbuf) :-
  NewH is H + Hbuf,
  H1 = NewH,
  prefix_sum(T,T1,NewH).

minLeft([],[],_,_).
minLeft([H|T], [H1|T1], Hbuf, I) :-
  ( I =:= 0 -> Min is H
  ; I =\= 0,
  Min is min(Hbuf, H)
  ),
  H1 = Min,
  NewI is I + 1,
  minLeft(T, T1, Min, NewI).

maxRight([],[],_,_).                          % give the list reversed and reverse the result
maxRight([H|T], [H1|T1], Hbuf, I) :-
    ( I =:= 0 -> Max is H
    ; I =\= 0,
    Max is max(Hbuf, H)
    ),
    H1 = Max,
    NewI is I + 1,
    maxRight(T, T1, Max, NewI).


simpleCheck([],_,Count,Count).
simpleCheck([H|T],Counter,Ans,Count):-
  (H >= 0 -> NewCounter is Counter + 1 , NewAns is NewCounter, simpleCheck(T,NewCounter,NewAns,Count)
  ;H < 0, NewCounter is Counter + 1 ,simpleCheck(T,NewCounter,Ans,Count)
  ).

check([],[],_,_,Ans,Ans).
check([],_,_,_,Ans,Ans).
check(_,[],_,_,Ans,Ans).
check([H1|T1], [H2|T2], C1,C2, Counter,Ans) :-
  (H1 >= H2 -> NewC1 is C1 + 1,check(T1, [H2|T2], NewC1, C2,Counter,Ans)
  ; H1 < H2, NewC2 is C2 + 1, NewCounter is max(C2 - C1 , Counter),check([H1|T1], T2, C1, NewC2,NewCounter,Ans)
  ).

longest(Filename, Answer) :-
  read_input(Filename, _, N, L),
  modify(L, N, Aux1),
  prefix_sum(Aux1,Psum,0),
  minLeft(Psum,Mleft,0,0),
  reverse(Psum,RevPsum),
  maxRight(RevPsum,RevMright,0,0),
  reverse(RevMright,Mright),
  check(Mleft,Mright,0,0,0,Ans1),
  simpleCheck(Psum,0,0,Ans2),
  Answer is max(Ans1 ,Ans2).
