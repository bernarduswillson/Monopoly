%== Chance card =============================================================

%== 1. Get random card =====

chanceCard :-
    
    random(0, 5, Number),
    
    chanceCardMsg(Number),

    !.

%== 2. Tax card message =====

chanceCardMsg(0) :-

    write(''), nl,
    write('=============================================================='), nl,
    write('\tTax Card'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tOh tidak, Anda tekena pajak.'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    taxMsg,

    !.

%== 3. Gift card message =====

chanceCardMsg(1) :-

    turn(Player), cash(Player, Cash),

    random(3000, 5001, Gift),
    NewCash is Cash + Gift, retract(cash(Player,_)), asserta(cash(Player, NewCash)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tGift Card'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tAnda mendapatkan hadiah uang sebesar '), write(Gift), write('.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 4. Get out from jail card message =====

chanceCardMsg(2) :-

    turn(Player), card(Player, CardList),

    append(CardList, [ojC], NewCardList), retract(card(Player, _)), asserta(card(Player, NewCardList)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tGet Out From Jail Card'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tKartu ini dapat dipakai untuk keluar dari penjara.'),  nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 5. Get out from jail card message =====

chanceCardMsg(3) :-

    turn(Player),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tGo to Jail Card'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tAnda masuk penjara :('),  nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    retract(location(Player, _)), asserta((location(Player, jl))),
    retract(isJail(Player, _)), asserta((isJail(Player, 3))),
    %call jail

    !.

chanceCardMsg(4) :-

    turn(Player),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tGo to World Tour Card'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tAnda sekarang berada di World Tour'),  nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    retract(location(Player, _)), asserta((location(Player, wt))),
    retract(isWorldTour(Player, _)), asserta((isWorldTour(Player, 1))),
    %call jail

    !.