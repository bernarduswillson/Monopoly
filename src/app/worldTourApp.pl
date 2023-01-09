worldTour:-
    turn(Player),
    cash(Player, Cash),
    Cash>=1000,
    NewCash is Cash-1000,
    retract(cash(Player,_)),
    asserta(cash(Player, NewCash)),
    map,
    write('Please choose where you wanna go!!(no capital): '),
    read_token(user_input, Input),nl,
    worldTourSelect(Input),!.

worldTour:-
    write('You do not have enough money to travel to another location'), nl,
    write('Please choose another action'), nl,!.


worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1>=98,X1=<103,Y1=<51,Y1>=49,
    travel(Player, Input),!.

worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==97,Y1>=49,Y1=<50,
    travel(Player, Input),!.

worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==98,Y1==103,
    travel(Player, Input),!.

worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==104,Y1>=49,Y1=<50,
    travel(Player, Input),!.

worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==103,Y1>=111,
    travel(Player, Input),!.

worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==102,Y1==112,
    travel(Player, Input),!.

worldTourSelect(Input):-
    turn(Player),
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==106,Y1==108,
    travel(Player, Input),!.

worldTourSelect(Input):-
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==99,Y1==99,
    selectCC,!.

worldTourSelect(Input):-
    atom_length(Input, Len),
    Len == 2,
    atom_chars(Input, [X,Y]),
    name(X, [X1]),
    name(Y, [Y1]),
    X1==116,Y1==120,
    selectTX,!.


worldTourSelect(Input):-
    write(Input),write(' is not a valid location'),nl,
    write('Please enter a valid location'),nl,
    worldTour,!.


travel(Player,Place):-
    locField(Id,Place,_,_,_),
    Id<24,
    cash(Player, Cash),
    NewCash is Cash+2000,
    retract(cash(Player,_)),
    asserta(cash(Player, NewCash)),
    retract(location(Player, _)),
    asserta(location(Player, Place)),
    write('You are now in '), write(Place), nl,!.

travel(Player,Place):-
    retract(location(Player, _)),
    asserta(location(Player, Place)),
    write('You are now in '), write(Place), nl,!.


selectCC:-
    write('Please choose a chance card spot!' ),nl,
    write('4 (cc bottom)'),nl,
    write('20 (cc top)'),nl,
    write('29 (cc right)'),nl,nl,
    write('Please choose the number:' ),
    read_token(user_input, Input),nl,
    selectCCid(Input),!.

selectTX:-
    write('Please choose a tax spot!' ),nl,
    write('12 (tx left)'),nl,
    write('28 (tx right)'),nl,nl,
    write('Please choose the number:' ),
    read_token(user_input, Input),
    selectTXid(Input),!.

travelbyid(Player,Place):-
    locField(Place,Loc,_,_,_),
    retract(location(Player, _)),
    asserta(location(Player, Loc)),
    isOn(Loc),
    write('You are now in '), write(Loc), nl,!.


wtMsg:-
    write('Apakah anda ingin melakukan World Tour? (y/n):'),
    read_token(user_input, Input),
    wtMsgSelect(Input),!.

wtMsgSelect(X):-
    turn(Player),
    X == y,
    retract(canRoll(Player,_)),
    asserta(canRoll(Player,0)),
    worldTour,!.

wtMsgSelect(X):-
    X == n,
    roll,!.

wtMsgSelect(X):-
    X \= y, X \= n,
    write('Input yang anda masukkan tidak valid'),nl,
    wtMsg,!.

selectCCid(X):-
    X==4,
    turn(Player),
    cash(Player, Cash),
    NewCash is Cash+2000,
    retract(cash(Player,_)),
    asserta(cash(Player, NewCash)),
    locField(X,Loc,_,_,_),
    retract(location(Player, _)),
    asserta(location(Player, Loc)),
    locField(_, Loc, LOC, _, _),
    write('You are now in '), write(LOC), chanceCard, nl,nl, !.

selectCCid(X):-
    X==20,
    turn(Player),
    cash(Player, Cash),
    NewCash is Cash+2000,
    retract(cash(Player,_)),
    asserta(cash(Player, NewCash)),
    locField(X,Loc,_,_,_),
    retract(location(Player, _)),
    asserta(location(Player, Loc)),
    locField(_, Loc, LOC, _, _),
    write('You are now in '), write(LOC), chanceCard, nl,nl,!.

selectCCid(X):-
    X==29,
    turn(Player),
    locField(X,Loc,_,_,_),
    retract(location(Player, _)),
    asserta(location(Player, Loc)),
    locField(_, Loc, LOC, _, _),
    write('You are now in '), write(LOC), chanceCard, nl,nl,!.

selectCCid(X):-
    locField(X,_,_,_,_),
    write('Please enter a valid number'),nl,nl,
    selectCC,!.

selectTXid(X):-
    X==12,
    turn(Player),
    cash(Player, Cash),
    NewCash is Cash+2000,
    retract(cash(Player,_)),
    asserta(cash(Player, NewCash)),
    locField(X,Loc,_,_,_),
    retract(location(Player, _)),
    asserta(location(Player, Loc)),
    write('You are now in '), write(Loc), nl,!.

selectTXid(X):-
    X==28,
    turn(Player),
    locField(X,Loc,_,_,_),
    retract(location(Player, _)),
    asserta(location(Player, Loc)),
    write('You are now in '), write(Loc), nl,nl,!.

selectTXid(X):-
    locField(X,_,_,_,_),
    write('Please enter a valid number'),nl,nl,
    selectTX,!.
