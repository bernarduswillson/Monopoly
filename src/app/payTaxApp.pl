
taxMsg :-
    
    turn(Player), netWorth(Player, Net),
    Tax is round(Net/10),
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tAnda terkena pajak!'), nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tAnda harus membayar pajak sebesar '), write(Tax), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payTax,
    
    !.

%== Pay Tax ================================================================

%== 1. Player has enough cash to pay tax =====

payTax :-
    turn(Player), netWorth(Player, Net), cash(Player, Cash),
    Tax is round(Net/10),
    Cash >= Tax,
    NewCash is Cash - Tax,
    retract(cash(Player, Cash)),
    asserta(cash(Player, NewCash)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tBerhasil membayar pajak!'),nl,
    write('=============================================================='), nl,
    write(''), nl, 
    
    !.

%== 2. Player has to sell property to pay tax =====

payTax :-
    
    turn(Player), netWorth(Player, Net), cash(Player, Cash),
    Tax is round(Net/10),
    Cash < Tax,
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tUang Anda tidak cukup!'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tAnda harus menjual properti untuk membayar pajak.'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    payTaxConfirm,

    !.

%== 2.1 Ask for confirmation =====

payTaxConfirm :-

    write('Apakah Anda ingin melanjutkan? (yes/no): '),
    read_token(user_input, UserInput),
    
    payTaxConfirm(UserInput),

    !.

%== 2.2 Invalid input =====

payTaxConfirm(UserInput) :-
    
    UserInput \= 'yes', UserInput \= 'no',

    nl,
    write('=============================================================='), nl,
    write(''), nl,
    write('\tMasukan tidak tersedia!\n'),
    write(''), nl,
    write('=============================================================='), nl,
    nl,

    payTaxConfirm,

    !.

%== 2.3 Refuses to sell =====

payTaxConfirm('no') :-

    bankrupt,

    !.

%== 2.4 Confirms to sell =====

payTaxConfirm('yes') :-

    sellMsgTax,

    !.
