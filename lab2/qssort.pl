read_input(Filename, N, L) :-

    open(Filename, read, Stream),

    read_line(Stream, [N]),

    read_line(Stream, L).



read_line(Stream, L) :-

    read_line_to_codes(Stream, Line),

    atom_codes(Atom, Line),

    atomic_list_concat(Atoms, ' ', Atom),

    maplist(atom_number, Atoms, L).



initial_stack([]).



% move(CurrentStateQueue, CurrentStateStack, Move, NextStateQueue, NextStateStack)



% move from queue to stack (Q)

move([H|T], L, q, T, [H|L]).



% move from stack to queue (S)

move([H1|T1], [H2|T2], s, [H1|T], T2) :-

    \+ H1 = H2,

    append(T1, [H2], T).



move([], [H|T], s, [H], T).



solve(Init, StateQueue, _, _, _, []) :-

    sort(0, @=<, Init, StateQueue).



solve(Init, StateQueue, StateStack, Count1, Len, [Move|Moves]) :-

    move(StateQueue, StateStack, Move, NextStateQueue, NextStateStack),

    (   Move = 'q' -> Count2 is Count1 + 1

    ;   Count2 is Count1),

    (   Count2 > Len / 2 -> false

    ;   true),

    solve(Init, NextStateQueue, NextStateStack, Count2, Len, Moves).



solve_all(Init, StateQueue, Moves) :-

    initial_stack(StateStack),

    length(Moves, Len),

    (

        Len mod 2 =:= 0 -> Count1 is 0, solve(Init, StateQueue, StateStack, Count1, Len, Moves)

        ; false

    ).



char_to_upper(Lower, Upper) :-

    char_type(Lower, to_lower(Upper)).



char_to_upper_list([], []).



char_to_upper_list([Head1|Tail1], [Head2|Tail2]) :-

    char_to_upper(Head1, Head2),

    char_to_upper_list(Tail1, Tail2).



qssort(Filename, Answer) :-

    read_input(Filename, _, L),

    Mylist = L,

    solve_all(Mylist, L, Moves), ! ,

    length(Moves, N),

    (

        N =:= 0 -> Temp = [e, m, p, t, y]

    ;   char_to_upper_list(Moves, Temp)

    ),

    atomic_list_concat(Temp, Answer).
