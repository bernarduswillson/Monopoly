%== Rent message ============================================================

rentMsg :-
    
    turn(Player), location(Player, CurLoc),
    propOwner(CurLoc, Owner), playerField(Owner, _, OwnerName),
    locField(_, CurLoc, CurLocCode, CurLocName, _), propRent(CurLoc, RentValue),
    
    retract(isPayingRent(Player,_)), asserta(isPayingRent(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti ini dimiliki '), write(OwnerName), nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tAnda mendarat di '), write(CurLocCode), write('-'), write(CurLocName), write(' dan dikenakan biaya'), nl,
    write('\tsewa sebesar '), write(RentValue), write('.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payRent,
    
    !.

%== Pay Rent ================================================================

%== 1. Player has enough cash to pay rent =====

payRent :-
    
    turn(Player), cash(Player, Cash), location(Player, CurLoc), propRent(CurLoc, RentValue), 
    Cash > RentValue,

    propOwner(CurLoc, OPlayer), cash(OPlayer, OCash),

    NewCash is Cash - RentValue, retract(cash(Player,_)), asserta(cash(Player,NewCash)), 

    NewOCash is OCash + RentValue, retract(cash(OPlayer,_)), asserta(cash(OPlayer,NewOCash)),
    
    retract(isPayingRent(Player,_)), asserta(isPayingRent(Player,0)),

        write(''), nl,
    write('=============================================================='), nl,
    write('\tBayar Sewa'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tBerhasil membayar sewa!'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    
    !.

%== 2. Player has to sell property to pay rent =====

payRent :-
    
    turn(Player), cash(Player, Cash), netWorth(Player, Net), location(Player, CurLoc), propRent(CurLoc, RentValue), 
    Cash < RentValue, Net > RentValue,
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tUang Anda tidak cukup!'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tAnda harus menjual properti untuk membayar sewa.'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payRentConfirm,

    !.

payRent :-
    
    turn(Player), cash(Player, Cash), netWorth(Player, Net), location(Player, CurLoc), propRent(CurLoc, RentValue), 
    Cash < RentValue, Net < RentValue,
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tUang Anda tidak cukup!'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tAset Anda tidak cukup untuk membayar sewa!.'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    bankrupt,

    !.

%== 2.1 Ask for confirmation =====

payRentConfirm :-

    write('Apakah Anda ingin melanjutkan? (yes/no): '),
    read_token(user_input, UserInput),
    
    payRentConfirm(UserInput),

    !.

%== 2.2 Invalid input =====

payRentConfirm(UserInput) :-
    
    UserInput \= 'yes', UserInput \= 'no',

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payRentConfirm,

    !.

%== 2.3 Refuses to sell =====

payRentConfirm('no') :-

    bankrupt,

    !.

%== 2.4 Confirms to sell =====

payRentConfirm('yes') :-

    sellMsgRent,

    !.