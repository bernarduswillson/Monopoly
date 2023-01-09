%== Functions ===============================================================

%== 1. Display player property =====

displayPlayerProperty(Player) :- 
    prop(Player, LocList),
    displayProperty(1, LocList).

displayProperty(_, []) :- !.

displayProperty(Num, [LocH | LocT]) :-
    locField(_, LocH, LocCodeName, _, _), propType(LocH, PropType),
    propTypeField(PropType, PropTypeName),
    write('\t   '), write(Num), write('. '), write(LocCodeName), write(' - '), write(PropTypeName), nl,
    Num2 is Num + 1,
    displayProperty(Num2, LocT).

%== 2. Display player card =====

displayPlayerCard(Player) :-
    
    card(Player, CardList),
    displayCard(1, CardList).

displayCard(_, []) :- !.

displayCard(Num, [H | T]) :-
    cardField(_, H, CardName),
    write('\t   '), write(Num), write('. '), write(CardName), nl,
    Num2 is Num + 1,
    displayCard(Num2, T).

%== Check Player Detail =====================================================

%== 1. Check player detail is not available =====

checkPlayerDetail(_) :- 

    isOngoing(0),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPermainan belum dimulai!'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tMasukan "start." untuk memulai permainan.'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 2. Invalid player =====

checkPlayerDetail(Player) :-

    \+availablePlayer(Player),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPemain tidak terseida!'), nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tOops, pemain '), write(Player), write(' tidak ditemukan.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 3. Check player detail =====

checkPlayerDetail(Player) :-

    playerField(Player, _, PlayerName),
    location(Player, CurrentLocationCode), locField(_, CurrentLocationCode, CurrentLocationCodeName, _, _),
    cash(Player, CashNominal), propValue(Player, PropNominal), netWorth(Player, NetNominal),
    
    write(''), nl,
    write('=============================================================='), nl,
    write('\tInformasi Player '), write(PlayerName), nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tLokasi                      : '), write(CurrentLocationCodeName), nl,
    write('\tTotal Uang                  : '), write(CashNominal), nl,
    write('\tTotal Nilai Properti        : '), write(PropNominal), nl,
    write('\tTotal Aset                  : '), write(NetNominal), nl,
    write(''), nl,
    write('\tDaftar Kepemilikan Properti :'), nl,
    displayPlayerProperty(Player), 
    write(''), nl,
    write('\tDaftar Kepemilikan Card     :'), nl,
    displayPlayerCard(Player),
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,
    
    !.