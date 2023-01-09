displayProp(Loc) :-
        propOwner(Loc, Owner),
        Owner == 'null',
        write('  '), !.

displayProp(Loc) :-
        propOwner(Loc, Owner),
        Owner \= 'null', 
        playerField(Owner, _, OwnerName),
        propType(Loc, 4),
        write(OwnerName), write('L'),
        !.

displayProp(Loc) :-
        propOwner(Loc, Owner),
        Owner \= 'null', 
        playerField(Owner, _, OwnerName),
        propType(Loc, PropType),
        write(OwnerName), write(PropType),
        !.

%== MAP ==%
map:-   isOngoing(1),
        write(''), nl,
        write('\tMAP'), nl,
        write(''), nl,
        write('\t       '), 
        displayProp(e1), write('   '),
        displayProp(e2), write('   '),
        displayProp(e3), write('        '),
        displayProp(f1), write('   '),
        displayProp(f2), write('   '),
        displayProp(f3), write('   '), nl,
                                        write('\t----------------------------------------------\n'),
                                        write('\t| FP | E1 | E2 | E3 | CC | F1 | F2 | F3 | WT |\n'),
        write('     '), displayProp(d3), write(' | D3 |----------------------------------| G1 |'), write(' '), displayProp(g1), nl,
        write('     '), displayProp(d2), write(' | D2 |                                  | G2 |'), write(' '), displayProp(g2), nl,
        write('     '), displayProp(d1), write(' | D1 |                                  | G3 |'), write(' '), displayProp(g3), nl,
                                        write('\t| TX |          M O N O P O L Y         | TX |\n'),
        write('     '), displayProp(c3), write(' | C3 |                                  | CC |\n'),
        write('     '), displayProp(c2), write(' | C2 |                                  | H1 |'), write(' '), displayProp(h1), nl,
        write('     '), displayProp(c1), write(' | C1 |----------------------------------| H2 |'), write(' '), displayProp(h2), nl,
                                        write('\t| JL | B3 | B2 | B1 | CC | A2 | BG | A1 | GO |\n'),
                                        write('\t----------------------------------------------\n'),
        write('\t       '),
        displayProp(b3), write('   '),
        displayProp(b2), write('   '),
        displayProp(b1), write('        '),
        displayProp(a2), write('        '),
        displayProp(a1), write('   '), nl,
        write('\n'),
        write('\tPosisi pemain: \n'),
        write('\t     V = '), location(v,LocV), locField(_, LocV, LOCV, _, _), write(LOCV), nl,
        write('\t     W = '), location(w,LocW), locField(_, LocW, LOCW, _, _), write(LOCW), nl,
        write(''), !.

map:-   

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
