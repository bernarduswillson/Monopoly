%== Functions ===============================================================

%== 1. Display player property =====

displayPlayerSellProperty(Player) :- prop(Player, LocList),
    displaySellProperty(1, LocList).

displaySellProperty(_, []) :- !.

displaySellProperty(Num, [LocH | LocT]) :-
    locField(_, LocH, LocCodeName, _, _), propPrice(LocH, LocPrice), propType(LocH, PropH),
    propTypeField(PropH, PropTypeName),
    write('\t   '), write(Num), write('. '), write(LocCodeName), write(' - '), write(PropTypeName), write(' : '), write(LocPrice), nl,
    Num2 is Num + 1,
    displaySellProperty(Num2, LocT).

%== Sell property to pay rent ===============================================

%== 1. Sell property message =====

sellMsgRent :-

    turn(Player),
    
    retract(isSellingProperty(Player,_)), asserta(isSellingProperty(Player, 1)),
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tJual Properti'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tDaftar properti Anda:'), nl,
    displayPlayerSellProperty(Player),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    sellPropSelectRent,

    !.

%== 1.1 Ask for selection =====

sellPropSelectRent :-
    
    write('Pilih properti yang akan dijual: '),
    read_token(user_input, UserInput),
    
    sellPropSelectRent(UserInput),

    !.

%== 1.2 Invalid selection =====

sellPropSelectRent(UserInput) :-

    UserInput =< 0, 

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    sellPropSelectRent, !.

sellPropSelectRent(UserInput) :-

    turn(Player), prop(Player, PropList), length(PropList, PropLength),
    PropLength < UserInput,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    sellPropSelectRent, !.

%== 1.3 Valid selection =====

sellPropSelectRent(UserInput) :-

    turn(Player), prop(Player, PropList), length(PropList, PropLength),
    UserInput > 0, PropLength >= UserInput,

    nth(UserInput, PropList, SoldProp),
    cash(Player, CurrentCash),
    propValue(Player, CurrentPropValue),
    propPrice(SoldProp, SoldPropPrice),
    propAcqui(SoldProp, NewPropPrice, _, _, _, _),
    
    NewCash is CurrentCash + SoldPropPrice, retract(cash(Player,_)), asserta(cash(Player, NewCash)),
    NewPropValue is CurrentPropValue - SoldPropPrice, retract(propValue(Player,_)), asserta(propValue(Player, NewPropValue)),
    
    retract(isSellingProperty(Player,_)), asserta(isSellingProperty(Player, 0)),

    delete(PropList, SoldProp, NewPropList),
    retract(prop(Player,_)), asserta(prop(Player, NewPropList)),

    retract(propOwner(SoldProp,_)), asserta(propOwner(SoldProp, null)),
    retract(propType(SoldProp,_)), asserta(propType(SoldProp, -1)),
    retract(propPrice(SoldProp,_)), asserta(propPrice(SoldProp, NewPropPrice)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tJual Properti'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty berhasil dijual!\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payRent,
    
    !.

%== Sell property to pay tax ================================================

%== 1. Sell property message =====

sellMsgTax :-

    turn(Player),
    
    retract(isSellingProperty(Player,_)), asserta(isSellingProperty(Player, 1)),
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tJual Properti'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tDaftar properti Anda:'), nl,
    displayPlayerSellProperty(Player),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    sellPropSelectTax,

    !.

%== 1.1 Ask for selection =====

sellPropSelectTax :-
    
    write('Pilih properti yang akan dijual: '),
    read_token(user_input, UserInput), nl,
    
    sellPropSelectTax(UserInput),

    !.

%== 1.2 Invalid selection =====

sellPropSelectTax(UserInput) :-

    UserInput =< 0,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    sellPropSelectTax, !.

sellPropSelectTax(UserInput) :-

    turn(Player), prop(Player, PropList), length(PropList, PropLength),
    PropLength < UserInput,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    sellPropSelectTax, !.

%== 1.3 Valid selection =====

sellPropSelectTax(UserInput) :-

    turn(Player), prop(Player, PropList), length(PropList, PropLength),
    UserInput > 0, PropLength >= UserInput,

    nth(UserInput, PropList, SoldProp),
    cash(Player, CurrentCash),
    propValue(Player, CurrentPropValue),
    propPrice(SoldProp, SoldPropPrice),
    propAcqui(SoldProp, NewPropPrice, _, _, _, _),
    
    NewCash is CurrentCash + SoldPropPrice, retract(cash(Player,_)), asserta(cash(Player, NewCash)),
    NewPropValue is CurrentPropValue - SoldPropPrice, retract(propValue(Player,_)), asserta(propValue(Player, NewPropValue)),
    
    retract(isSellingProperty(Player,_)), asserta(isSellingProperty(Player, 0)),

    delete(PropList, SoldProp, NewPropList),
    retract(prop(Player,_)), asserta(prop(Player, NewPropList)),

    retract(propOwner(SoldProp,_)), asserta(propOwner(SoldProp, null)),
    retract(propType(SoldProp,_)), asserta(propType(SoldProp, -1)),
    retract(propPrice(SoldProp,_)), asserta(propPrice(SoldProp, NewPropPrice)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tJual Properti'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty berhasil dijual!\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payTax,
    
    !.