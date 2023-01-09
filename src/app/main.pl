%== Import Facts and States =================================================

:- include('../data/player.pl').
:- include('../data/location.pl').
:- include('../data/card.pl').
:- include('../data/dice.pl').

%== Import App ==============================================================

:- include('mapApp.pl').
:- include('help.pl').
:- include('playerdetailApp.pl').
:- include('payRentApp.pl').
:- include('buyProperty.pl').
:- include('payTaxApp.pl').
:- include('sellPropertyApp.pl').
:- include('chanceCardApp.pl').
:- include('bankruptApp.pl').
:- include('worldTourApp.pl').
:- include('locDetailApp.pl').
:- include('propDetail.pl').
:- include('bonusGameApp.pl').

%== Main program ============================================================

:- dynamic(isOngoing/1).
:- dynamic(turn/1).
:- dynamic(winner/1).

%== Global States ===========================================================

isOngoing(0).
turn(v).
winner(null).

%== Start ===================================================================

%== 1. Start game =====

start:- isOngoing(0),
        retractall(isOngoing(_)), asserta(isOngoing(1)),
        
        retractall(turn(_)), asserta(turn(v)),
        
        retract(cash(v,_)), asserta(cash(v, 20000)),
        retract(cash(w,_)), asserta(cash(w, 20000)),

        write('          .  .      J5YYYYYYJY~             ~JPGG5?:    ^?5PP5?^   J@@P        ?@@G !5YYYYYYJJ?     '),nl,
        write('    .5BG.~#BB#^:BB5.B@@@&&&&&&JJBGB?      :G@@@@@@@@Y  Y@@@@@@@@5. J@@@Y      !@@@G Y@@@&&&&&&G     '),nl,
        write('     G@@JY@@@@JY@@5 B@@5    .. P@@@Y     .B@@@J^7BGY7.5@@@Y^~G@@@P Y@@@@7    ~&@@@P Y@@#.   ..      '),nl,
        write('     7@@&&@@@@&&@@~ #@@P~!7~   5@@@?     !@@@J       :&@@P   :&@@@~Y@@@@&~  ^#@@@@P 5@@#~~!!        '),nl,
        write('     .#@@@@@@@@@@B .#@@@@@@P   Y@@@7     ?@@@~       ~@@@?    Y@@&~5@@@@@#:.B@@@@@5 5@@@@@@&.       '),nl,
        write('      Y@@@@@@@@@@J :#@@B?JY7   ?@@@7     !@@@!       :&@@Y    7@@P 5@@@&@@GG@@@&@@5 P@@&JJYJ        '),nl,
        write('      @@@@GB@@@@^ :&@@G  .... 7@@@      G@@B:  J7: Y@@&  ^#@@! P@@@?5@@@@@Y5@@Y G@@&:  ....         '),nl,
        write('       B@@@~7@@@G  :@@@@#&&&&&?7@@@BGGGGGJ.P@@&GB@@#~ .5@@@BB@@&?  5&&&? G@@@B.?&&J B@@@&#&&&&G     '),nl,
        write('       ?#BP .GB#7  :B###&&&&&@J~BGGBBGGGGJ  ~JPGG5!.    ^JPGGP?:   ..... .!!7^ .... P####&&&&&G     '),nl,
        write('                    .........:.                                                     ...........     '),nl,
        write('                                                                                                    '),nl,
        write('                                                                                                    '),nl,
        write('                                                                                                    '),nl,
        write('                                                                                                    '),nl,
        write('              :^^^^^^^:                    ^!!.                ^^^^^:::::.^~~~~~^^:                 '),nl,
        write('              G@@@@@@@&B5^ !777^          ^&@@?   .~JG?   :Y?^:&@@@@@@@@@7B@@@@@@@@BY:              '),nl,
        write('              B@@G???YB@@&~B@@@?         .B@@@#:  ~#@@@? 7&@@J:&@@5777777:B@@&?7?JG@@B:             '),nl,
        write('             .#@@Y    J@@@JG@@@!         Y@@@@@Y   :5@@@B@@@J ^&@@7       B@@#.   ^&@@~             '),nl,
        write('             :&@@&###&@@@B:P@@@~        !@@@&@@&^    !#@@@@?  ^@@@#B#&7   G@@@&&#G#@@Y              '),nl,
        write('             :&@@@&&&#BP7. 5@@@~       :#@@@?B@@5     J@@@J   ~@@@&##@?   P@@@&&@@@#^               '),nl,
        write('             ^@@@B:...     Y@@@^       P@@@@@@@@&^    7@@@~   ~@@@J  .    5@@B::Y@@@Y               '),nl,
        write('             ~@@@B         Y@@@?!!!!!:?@@@&P5YP@@5    ^@@@^   !@@@BJJYYYY^5@@5   7&@@J              '),nl,
        write('             !@@@B         J@@@@@@@@@G&@@@!   .#@@~    .7?7.   !@@@@@@@@@@7^??^    ^5J~              '),nl,
        write('             .~!7!         :~~~~~^^^^~7JPJ     ~?!:           :7777777???^                          '),nl,!.

%== 2. Game is ongoing =====

start:- 

        isOngoing(X), X =\= 0 -> 
        
        turn(Player),

        write(''), nl,
        write('=============================================================='), nl,
        write('\tPermainan sedang berjalan!'), nl,
        write('--------------------------------------------------------------'), nl,
        write('\t'), nl,
        write('\tPermainan masih berlangsung. Sekarang giliran'), nl,
        write('\tpemain '), write(Player), write(.), nl,
        write(''), nl,
        write('=============================================================='), nl,
        write(''), nl,

        !.

%== 3. Check turn =====

checkTurn :-

        isOngoing(1),
        turn(Player),
        playerField(Player, _, PLAYER),
        write(''), nl,
        write('=============================================================='), nl,
        write('\tCek giliran pemain'), nl,
        write('--------------------------------------------------------------'), nl,
        write('\t'), nl,
        write('\tSekarang giliran pemain '), write(PLAYER), nl,
        write(''), nl,
        write('=============================================================='), nl,
        write(''), nl,
        !.

checkTurn :-

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