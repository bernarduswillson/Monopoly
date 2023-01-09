checkPropertyDetail(X):-
    atom_length(X, Len),
    Len == 2,
    atom_chars(X, [Y,Z]),
    name(Y, [X1]),
    name(Z, [Y1]),
    X1>=97,X1=<103,Y1=<51,Y1>=49,
    propDetail(X),!.

checkPropertyDetail(X):-
    atom_length(X, Len),
    Len == 2,
    atom_chars(X, [Y,Z]),
    name(Y, [X1]),
    name(Z, [Y1]),
    X1==104,Y1>=49,Y1=<50,
    propDetail(X),!.

checkPropertyDetail(X):-
    atom_length(X,_),
    write('Invalid input. Please enter a valid property code.'),nl,!.

propDetail(X):-
    propAcqui(X,T,B1,B2,B3,L),
    propRent(X,Tr,B1r,B2r,B3r,Lr),
    locField(_,X,_,Name,Desc),
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,
    write('--------------------------------------------------------------'), nl,
    nl,
    write('\tBuy:'), nl,
    write('\t   Price Land: '), write(T), nl,
    write('\t   Price House 1: '), write(B1), nl,
    write('\t   Price House 2: '), write(B2), nl,
    write('\t   Price House 3: '), write(B3), nl,
    write('\t   Price Landmark: '), write(L), nl,
    nl,
    write('--------------------------------------------------------------'), nl, nl,
    write('\tRent:'), nl,
    write('\t   Rent Land: '), write(Tr), nl,
    write('\t   Rent House 1: '), write(B1r), nl,
    write('\t   Rent House 2: '), write(B2r), nl,
    write('\t   Rent House 3: '), write(B3r), nl,
    write('\t   Rent Landmark: '), write(Lr), nl, nl,
    write('=============================================================='),
    nl,!.
