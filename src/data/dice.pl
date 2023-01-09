%== Dynamic clause management ===============================================

:- dynamic(playerDice/2).
:- dynamic(currentDice1/1).
:- dynamic(currentDice2/1).
:- dynamic(canRoll/2).

%== States ==================================================================

canRoll(w, 1).
canRoll(v, 1).
playerDice(w, 0).
playerDice(v, 0).

roll:-
    isOngoing(X), X=\=1 -> 
    
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

roll:-
    turn(Player),
    canRoll(Player, 1),
    isWorldTour(Player,1),
    write(''), nl,
    write('=============================================================='), nl,
    write('\tAnda berada di World Tour!'), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tAnda bisa pergi kemana saja!'), nl,
    write(''), nl,
    write('=============================================================='), nl,nl,
    retract(isWorldTour(Player,1)),
    asserta(isWorldTour(Player,0)),
    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 0)),
    wtMsg,!.


roll :-     turn(Player), isJail(Player, 0), canRoll(Player, 1),
            write('Sekarang adalah giliran pemain '), playerField(Player, _, X), write(X), nl,
            retractall(currentDice1(_)), random(1,7,D1), asserta(currentDice1(D1)), displayDice(D1), nl,
            retractall(currentDice2(_)), random(1,7,D2), asserta(currentDice2(D2)), displayDice(D2), nl, isDoubleDice(D1, D2, Player), nDoubleDice,
            write('Anda maju sebanyak '), retractall(playerDice(Player, _)), D is D1+D2, asserta(playerDice(Player, D)), write(D), write(' langkah.'),
            location(Player, Loc), locField(CurrentLocID, Loc, _, _, _), isOneRound(Player, CurrentLocID, D), CurrentLoc is (CurrentLocID + D) mod 32, locField(CurrentLoc, NewLoc, _, _, _), retract(location(Player, _)), asserta(location(Player, NewLoc)), nl,
            isGotoJail(Player), location(Player,CurLoc), isOn(CurLoc), retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 0)), !.

roll :-     turn(Player), isJail(Player, M), M \= 0, canRoll(Player, 1),
            write('Sekarang adalah giliran pemain '),
            playerField(Player, _, X), write(X), nl, write('ANDA SEDANG DI PENJARA'), nl,
            goOutJailInput, !.

roll :-     turn(Player), canRoll(Player, 0), 
            write(''), nl,
            write('=============================================================='), nl, nl,
            write('\tMaaf, kesempatan roll dadu sudah habis!'),nl,
            write(''), nl,
            write('=============================================================='), nl, !.


isOneRound(Player, CurrentLocID, D) :- CurrentLocID + D >= 32, nl, write('Anda telah menyelesaikan satu putaran!'), nl, cash(Player, Money), retractall(cash(Player, _)), NewMoney is Money + 2000, asserta(cash(Player, NewMoney)), write('Anda mendapatkan uang tambahan sebesar 2000!'), nl, !. 

isOneRound(_, CurrentLocID, D) :- CurrentLocID + D < 32, !. 


% validate if dice double
isDoubleDice(D1, D2, Player) :- D1 =:= D2, retract(isDouble(Player, _)), asserta(isDouble(Player, 1)).


isDoubleDice(D1, D2, Player) :- D1 =\= D2, retract(canRoll(Player, _)), asserta(canRoll(Player, 0)).

isDoubleJail(D1, D2, Player) :- D1 =:= D2, retract(canRoll(Player, _)), asserta(canRoll(Player, 0)),
                                retract(isJail(Player, _)), asserta(isJail(Player, 0)),
                                write('Anda maju sebanyak '), retractall(playerDice(Player, _)), D is D1+D2, asserta(playerDice(Player, D)), write(D), write(' langkah.'),
                                location(Player, Loc), locField(CurrentLocID, Loc, _, _, _), CurrentLoc is (CurrentLocID + D) mod 32, locField(CurrentLoc, NewLoc, _, _, _), 
                                retract(location(Player, _)), asserta(location(Player, NewLoc)), nl, !.

isDoubleJail(D1, D2, Player) :- D1 =\= D2, retract(canRoll(Player, _)), asserta(canRoll(Player, 0)), isJail(Player, M), MS is M-1,
                                retract(isJail(Player, _)), asserta(isJail(Player, MS)) ,!.                     

% count double dice
nDoubleDice :-  isDouble(Player, 1), nDouble(Player, Count), Counts is Count + 1, 
                retract(nDouble(Player, _)), asserta(nDouble(Player, Counts)), 
                retract(isDouble(Player, _)), asserta(isDouble(Player, 0)).

nDoubleDice :- isDouble(_, 0).

endTurn:-
    isOngoing(X), X=\=1 -> 
    
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



endTurn :-  canRoll(_, 0), turn(v),
            write(''), nl,
            write('=============================================================='), nl, nl,
            write('\tGiliran V sudah selesai, sekarang giliran W!'),nl,
            write(''), nl,
            write('=============================================================='), nl,
            retract(turn(_)), asserta(turn(w)), 
            retract(canRoll(v, _)), asserta(canRoll(v, 1)), 
            retract(nDouble(_, _)), asserta(nDouble(_r, 0)),
            
            retract(isBoughtProperty(v, _)), asserta(isBoughtProperty(v, 1)),
             !.

endTurn :-  canRoll(_, 0), turn(w),
            write(''), nl,
            write('=============================================================='), nl, nl,
            write('\tGiliran W sudah selesai, sekarang giliran V!'),nl,
            write(''), nl,
            write('=============================================================='), nl,
            retract(turn(_)), asserta(turn(v)), 
            retract(canRoll(w, _)), asserta(canRoll(w, 1)),
            retract(nDouble(_, _)), asserta(nDouble(_, 0)), 
            
            retract(isBoughtProperty(w, _)), asserta(isBoughtProperty(w, 1)),
            !.

endTurn :-  canRoll(_, 1),
            write(''), nl,
            write('=============================================================='), nl, nl,
            write('\tAnda masih punya kesempatan roll dice!'),nl,
            write(''), nl,
            write('=============================================================='), nl, !.


isGotoJail(Player) :-   nDouble(Player, 3), retract(location(Player, _)), asserta(location(Player, jl)), write('Anda masuk penjara.'), nl, 
                        retract(nDouble(Player, _)), asserta(nDouble(Player, 0)), 
                        retract(canRoll(Player, _)), asserta(canRoll(Player, 0)), 
                        retract(isJail(Player, _)), asserta(isJail(Player, 3)), !.

isGotoJail(Player) :-   nDouble(Player, _), !.

payJail(Player) :- 
    isJail(Player,M),M\=0, 
    cash(Player,Cash), 
    Cash>=2500,
    NewCash is Cash - 2500,
    retract(cash(Player,Cash)),
    asserta(cash(Player,NewCash)),
    retract(isJail(Player, _)),
    asserta(isJail(Player, 0)),
    roll, !.

payJail(Player) :-
    isJail(Player,M),M\=0,
    cash(Player,Cash),
    Cash<2500,
    write('Uang anda tidak cukup untuk membayar penjara'),nl,
    goOutJailInput,!.

goOutJailInput :-
    turn(Player),
    isJail(Player, M), M \= 0,
    write('Pilih cara anda keluar dari penjara(kartu, roll, bayar)'), nl,
    read_token(user_input, Input),
    goOutJail(Input), !.

goOutJail(Input):- 
    turn(Player),
    Input==kartu,
    outJailKartu(Player), !.

goOutJail(Input):-
    turn(Player),
    Input==roll,
    retractall(currentDice1(_)), random(1,7,D1), asserta(currentDice1(D1)), displayDice(D1), nl,
    retractall(currentDice2(_)), random(1,7,D2), asserta(currentDice2(D2)), displayDice(D2), nl,
    isDoubleJail(D1,D2,Player), !.

goOutJail(Input):-
    turn(Player),
    Input==bayar,
    payJail(Player), !.

outJailKartu(Player):-
    isJail(Player, M), M \= 0,
    card(Player, Card),
    member(ojC, Card),
    delete(Card, ojC, NewCard),
    retract(card(Player,_)),
    asserta(card(Player, NewCard)),
    retract(isJail(Player, _)),
    asserta(isJail(Player, 0)),
    roll,!.

outJailKartu(Player):-
    isJail(Player, M), M \= 0,
    write('Anda tidak memiliki kartu keluar dari penjara!'),nl,
    goOutJailInput,!.


isOn(Loc) :- 
    Loc == cc1,
    chanceCard, !.

isOn(Loc) :- 
    Loc == cc2,
    chanceCard, !.

isOn(Loc) :- 
    Loc == cc3,
    chanceCard, !.

isOn(Loc) :- 
    Loc == tx,
    taxMsg, !.

isOn(Loc) :- 
    Loc == wt,
    turn(Player),
    retract(isWorldTour(Player, _)),
    asserta(isWorldTour(Player, 1)),!.

isOn(Loc) :-    Loc == bg, 
                write('Selamat Datang di BONUS GAME!'), nl,
                write('BONUS GAME kali ini adalah FLIP COIN, anda harus menebak HEAD atau TAIL.'), nl,
                write('Setiap tebakan benar akan diberi hadiah sebesar 1000, maks jawaban benar adalah 3x.'), nl,
                flipCoin, !.

isOn(Loc) :- Loc == fp, !.

isOn(Loc) :- Loc == jl, !.

isOn(Loc) :- 
    propOwner(Loc, X),
    X == null,
    locField(_, Loc, LOC, _, _),
    write('Anda berada di properti kosong ('),write(LOC),write(')'), !.

isOn(Loc) :- 
    propOwner(Loc, X),
    turn(Player),
    X==Player,
    locField(_, Loc, LOC, _, _),
    write('Anda berada di properti anda sendiri ('),write(LOC),write(')'), nl, !.

isOn(Loc) :-
    propOwner(Loc, X),
    turn(Player),
    X\=Player,
    rentMsg, !.

displayDice(D) :-   D == 1,
                    write(' _______ '), nl,
                    write('|       |'), nl,
                    write('|       |'), nl,
                    write('|   o   |'), nl,
                    write('|       |'), nl,
                    write('|_______|'), nl, !.

displayDice(D) :-   D == 2,
                    write(' _______ '), nl,
                    write('|       |'), nl,
                    write('|       |'), nl,
                    write('| o   o |'), nl,
                    write('|       |'), nl,
                    write('|_______|'), nl, !.

displayDice(D) :-   D == 3,
                    write(' _______ '), nl,
                    write('|       |'), nl,
                    write('|       |'), nl,
                    write('| o o o |'), nl,
                    write('|       |'), nl,
                    write('|_______|'), nl, !.

displayDice(D) :-   D == 4,
                    write(' _______ '), nl,
                    write('|       |'), nl,
                    write('| o   o |'), nl,
                    write('|       |'), nl,
                    write('| o   o |'), nl,
                    write('|_______|'), nl, !. 

displayDice(D) :-   D == 5,
                    write(' _______ '), nl,
                    write('|       |'), nl,
                    write('| o   o |'), nl,
                    write('|   o   |'), nl,
                    write('| o   o |'), nl,
                    write('|_______|'), nl, !.   

displayDice(D) :-   D == 6,
                    write(' _______ '), nl,
                    write('|       |'), nl,
                    write('| o   o |'), nl,
                    write('| o   o |'), nl,
                    write('| o   o |'), nl,
                    write('|_______|'), nl, !.                                               