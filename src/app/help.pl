%== Help ====================================================================

%== 1. Show available commands while game is ongoing =====

help:-  isOngoing(1),
        write('=============================================================='), nl,
        write('\tCommands'),nl,
        write('--------------------------------------------------------------'), nl,
        write('\t'), nl,
        write('\t1. map. -- Show map'),nl,
        write('\t2. help. -- Show available commands'),nl,
        write('\t3. checkPlayerDetail(Player). -- Show player detail'),nl,
        write('\t3. checkLocationDetail(Location). -- Show location detail'),nl,
        write('\t3. checkPropertyDetail(Property). -- Show property detail'),nl,
        write('\t4. buy. -- Buy or upgrade property'),nl,
        write('\t5. roll. -- Roll the dice'),nl,
        write('\t6. endTurn. -- End the turn'),nl,
        write('\t7. checkTurn. -- Show turn'), nl,
        write(''), nl,
        write('=============================================================='), nl, !.

%== 2. Show available commands while game has not been started =====

help:-  isOngoing(X), X=\=1 ->
        write('=============================================================='), nl,
        write('\tCommands'),nl,
        write('--------------------------------------------------------------'), nl,
        write('\t'), nl,
        write('\t1. start. -- start the game'),nl,
        write(''), nl,
        write('=============================================================='), nl, 
        
        !.
