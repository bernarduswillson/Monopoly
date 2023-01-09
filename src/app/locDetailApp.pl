checkLocationDetail(X):-
    locField(_,X,_,_,_),
    isOngoing(0),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    write('\tGame belum dimulai!'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl, 
    !.


checkLocationDetail(X):-
    X == go,
    locField(_,X,_,Name,Desc),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc),write(''), nl,
    write('=============================================================='), nl,nl,nl,!.


checkLocationDetail(X):-
    X == cc,
    locField(_,X,_,Name,Desc),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,write(''), nl,
    write('=============================================================='), nl,nl,!.

checkLocationDetail(X):-
    X == tx,
    locField(_,X,_,Name,Desc),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,write(''), nl,
    write('=============================================================='), nl,nl,!.

checkLocationDetail(X):-
    X == jl,
    locField(_,X,_,Name,Desc),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,write(''), nl,
    write('=============================================================='), nl,nl,!.

checkLocationDetail(X):-
    X == fp,
    locField(_,X,_,Name,Desc),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,write(''), nl,
    write('=============================================================='), nl,nl,!.

checkLocationDetail(X):-
    X == wt,
    locField(_,X,_,Name,Desc),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,
    write(''), nl,
    write('=============================================================='), nl,nl,!.

checkLocationDetail(X):-
    atom_length(X, Len),
    Len == 2,
    atom_chars(X, [Y,Z]),
    name(Y, [X1]),
    name(Z, [Y1]),
    X1>=97,X1=<103,Y1=<51,Y1>=49,
    cityDetail(X),!.

checkLocationDetail(X):-
    atom_length(X, Len),
    Len == 2,
    atom_chars(X, [Y,Z]),
    name(Y, [X1]),
    name(Z, [Y1]),
    X1==104,Y1>=49,Y1=<50,
    cityDetail(X),!.

checkLocationDetail(X):-
    atom_length(X, _),
    write('Invalid location'),nl,!.

cityDetail(X):-
    propOwner(X,Owner),
    Owner==null,
    locField(_,X,_,Name,Desc),write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tThere is no property owner'),nl,
    write(''), nl,
    write('=============================================================='), nl,nl,!.

cityDetail(X):-
    locField(_,X,_,Name,Desc),
    propOwner(X,Owner),
    propRent(X,Rent),
    propType(X,Type),
    Type==4,
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,
    write('--------------------------------------------------------------'), nl,
    write('\tProperty Owner: '), write(Owner),nl,
    write('\tRent Price: '), write(Rent),nl,
    write('\tAcquisition Price: '), write('Can`t be acquired'),nl,
    write('\tProperty Type: '), write(Type),nl,
    write(''), nl,
    write('=============================================================='), nl,nl,!.

cityDetail(X):-
    locField(_,X,_,Name,Desc),
    propOwner(X,Owner),
    propRent(X,Rent),
    propPrice(X,Price),
    propType(X,Type),
    Type\=4,
    write(''), nl,
    write('=============================================================='), nl,
    write('\tName: '), write(Name), nl,
    write('\tdescription: '), write(Desc), nl,
    write('--------------------------------------------------------------'), nl,
    write('\tProperty Owner: '), write(Owner),nl,
    write('\tRent Price: '), write(Rent),nl,
    write('\tAcquisition Price: '), write(Price*2),nl,
    write('\tProperty Type: '), write(Type),nl,
    write(''), nl,
    write('=============================================================='), nl,nl,!.




