%== Functions ===============================================================

%== 1. Get accumulated price =====

accPrice(Loc, 1, AccPrice) :-

    propAcqui(Loc, LandPrice, _, _, _, _),
    AccPrice is LandPrice,

    !.

accPrice(Loc, 2, AccPrice) :-

    propAcqui(Loc, LandPrice, B1Price, _, _, _),
    AccPrice is LandPrice + B1Price,

    !.

accPrice(Loc, 3, AccPrice) :-

    propAcqui(Loc, LandPrice, B1Price, B2Price, _, _),
    AccPrice is LandPrice + B1Price + B2Price,

    !.

accPrice(Loc, 4, AccPrice) :-

    propAcqui(Loc, LandPrice, B1Price, B2Price, B3Price, _),
    AccPrice is LandPrice + B1Price + B2Price + B3Price,

    !.

accPrice(Loc, 5, AccPrice) :-

    propAcqui(Loc, LandPrice, B1Price, B2Price, B3Price, LandmarkPrice),
    AccPrice is LandPrice + B1Price + B2Price + B3Price + LandmarkPrice,

    !.

%== 1. Get rent =====

getRent(Loc, 0, Rent) :-

    propRent(Loc, LandRent, _, _, _, _),
    Rent is LandRent,

    !.

getRent(Loc, 1, Rent) :-

    propRent(Loc, _, B1Rent, _, _, _),
    Rent is B1Rent,

    !.

getRent(Loc, 2, Rent) :-

    propRent(Loc, _, _, B2Rent, _, _),
    Rent is B2Rent,

    !.

getRent(Loc, 3, Rent) :-

    propRent(Loc, _, _, _, B3Rent, _),
    Rent is B3Rent,

    !.

getRent(Loc, 4, Rent) :-

    propRent(Loc, _, _, _, _, LandmarkRent),
    Rent is LandmarkRent,

    !.

%== Property not available ==================================================

%== 1. Game has not been started =====

buy :-

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

%== 2. Already bought property =====

buy :-

    turn(Player), isBoughtProperty(Player, 1),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tTidak dapat membeli properti!'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tAnda sudah membeli properti pada giliran ini.'),nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    
    !.

%== 3. Property is not available =====

buy :-

    turn(Player), location(Player, CurLoc),
    \+propAcqui(CurLoc, _, _, _, _, _),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tTidak dapat membeli properti!'),nl,
    write('--------------------------------------------------------------'), nl,
    write('\t'), nl,
    write('\tProperty tidak tersedia di lokasi Anda.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== Is property is for sale, selfowned, or owned ============================

%== 1. Property is for sale =====

buy :-

    turn(Player), location(Player, CurLoc),
    propOwner(CurLoc, null),

    buyPropertySaleMsg,

    !.

%== 2. Property is selfowned =====

buy :-

    turn(Player), location(Player, CurLoc),
    propOwner(CurLoc, Player),

    upgradePropertyMsg,

    !.

%== 3. Property is owned =====

buy :- 

    turn(Player), location(Player, CurLoc),
    propOwner(CurLoc, Owner), Owner \= Player,

    acquirePropertyMsg,

    !.

%== Property is for sale ============================

%== 1. Buy property message =====

buyPropertySaleMsg :-

    turn(Player), location(Player, CurLoc),

    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propAcqui(CurLoc, LandPrice, B1Price, B2Price, B3Price, _),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Property '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\t     1. Tanah      : '), write(LandPrice), nl,
    write('\t     2. Bangunan 1 : '), write(B1Price), nl,
    write('\t     3. Bangunan 2 : '), write(B2Price), nl,
    write('\t     4. Bangunan 3 : '), write(B3Price), nl,
    write('\t     5. Landmark   : Beli bangunan 3 untuk membangun Landmark'), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    buyPropertySaleSelect,

    !.

%== 1. Select property to buy =====

buyPropertySaleSelect :-

    write('Pilih properti yang akan dibeli: '),
    read_token(user_input, UserInput),
    
    buyPropertySaleSelect(UserInput),

    !.

%== 2. Buy land =====

buyPropertySaleSelect(1) :-

    turn(Player), location(Player, CurLoc),

    cash(Player, Cash), propValue(Player, PropValue), prop(Player, PropList),
    propAcqui(CurLoc, LandPrice, _, _, _, _), propRent(CurLoc, LandRent, _, _, _, _),
    locField(_, CurLoc, CurLocCode, CurLocName, _),

    Cash >= LandPrice,

    NewCash is Cash - LandPrice, retract(cash(Player, _)), asserta(cash(Player, NewCash)),
    NewPropValue is PropValue + LandPrice, retract(propValue(Player, _)), asserta(propValue(Player, NewPropValue)),
    append(PropList, [CurLoc], NewPropList), retract(prop(Player, _)), asserta(prop(Player, NewPropList)),

    retract(propOwner(CurLoc, _)), asserta(propOwner(CurLoc, Player)),
    retract(propType(CurLoc, _)), asserta(propType(CurLoc, 0)),
    retract(propPrice(CurLoc, _)), asserta(propPrice(CurLoc, LandPrice)),
    retract(propRent(CurLoc, _)), asserta(propRent(CurLoc, LandRent)),

    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti berhasil dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tTanah '), write(CurLocCode), write(' - '), write(CurLocName), nl,
    write('\tberhasil dibeli.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    
    !.

%== 3. Buy building 1 =====

buyPropertySaleSelect(2) :-

    turn(Player), location(Player, CurLoc),

    cash(Player, Cash), propValue(Player, PropValue), prop(Player, PropList),
    propAcqui(CurLoc, LandPrice, B1Price, _, _, _), propRent(CurLoc, LandRent, B1Rent, _, _, _),
    locField(_, CurLoc, CurLocCode, CurLocName, _),

    TotalPrice is LandPrice + B1Price, TotalRent is LandRent + B1Rent,

    Cash >= TotalPrice,

    NewCash is Cash - TotalPrice, retract(cash(Player, _)), asserta(cash(Player, NewCash)),
    NewPropValue is PropValue + TotalPrice, retract(propValue(Player, _)), asserta(propValue(Player, NewPropValue)),
    append(PropList, [CurLoc], NewPropList), retract(prop(Player, _)), asserta(prop(Player, NewPropList)),

    retract(propOwner(CurLoc, _)), asserta(propOwner(CurLoc, Player)),
    retract(propType(CurLoc, _)), asserta(propType(CurLoc, 1)),
    retract(propPrice(CurLoc, _)), asserta(propPrice(CurLoc, TotalPrice)),
    retract(propRent(CurLoc, _)), asserta(propRent(CurLoc, TotalRent)),

    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti berhasil dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tBangunan 1 '), write(CurLocCode), write(' - '), write(CurLocName), nl,
    write('\tberhasil dibeli.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    
    !.

%== 4 Buy building 2 =====

buyPropertySaleSelect(3) :-

    turn(Player), location(Player, CurLoc),

    cash(Player, Cash), propValue(Player, PropValue), prop(Player, PropList),
    propAcqui(CurLoc, LandPrice, B1Price, B2Price, _, _), propRent(CurLoc, LandRent, B1Rent, B2Rent, _, _),
    locField(_, CurLoc, CurLocCode, CurLocName, _),

    TotalPrice is LandPrice + B1Price + B2Price, TotalRent is LandRent + B1Rent + B2Rent,

    Cash >= TotalPrice,

    NewCash is Cash - TotalPrice, retract(cash(Player, _)), asserta(cash(Player, NewCash)),
    NewPropValue is PropValue + TotalPrice, retract(propValue(Player, _)), asserta(propValue(Player, NewPropValue)),
    append(PropList, [CurLoc], NewPropList), retract(prop(Player, _)), asserta(prop(Player, NewPropList)),

    retract(propOwner(CurLoc, _)), asserta(propOwner(CurLoc, Player)),
    retract(propType(CurLoc, _)), asserta(propType(CurLoc, 2)),
    retract(propPrice(CurLoc, _)), asserta(propPrice(CurLoc, TotalPrice)),
    retract(propRent(CurLoc, _)), asserta(propRent(CurLoc, TotalRent)),

    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti berhasil dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tBangunan 2 '), write(CurLocCode), write(' - '), write(CurLocName), nl,
    write('\tberhasil dibeli.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    
    !.

%== 5. Buy building 3 =====

buyPropertySaleSelect(4) :-

    turn(Player), location(Player, CurLoc),

    cash(Player, Cash), propValue(Player, PropValue), prop(Player, PropList),
    propAcqui(CurLoc, LandPrice, B1Price, B2Price, B3Price, _), propRent(CurLoc, LandRent, B1Rent, B2Rent, B3Rent, _),
    locField(_, CurLoc, CurLocCode, CurLocName, _),

    TotalPrice is LandPrice + B1Price + B2Price + B3Price, TotalRent is LandRent + B1Rent + B2Rent + B3Rent,

    Cash >= TotalPrice,

    NewCash is Cash - TotalPrice, retract(cash(Player, _)), asserta(cash(Player, NewCash)),
    NewPropValue is PropValue + TotalPrice, retract(propValue(Player, _)), asserta(propValue(Player, NewPropValue)),
    append(PropList, [CurLoc], NewPropList), retract(prop(Player, _)), asserta(prop(Player, NewPropList)),

    retract(propOwner(CurLoc, _)), asserta(propOwner(CurLoc, Player)),
    retract(propType(CurLoc, _)), asserta(propType(CurLoc, 3)),
    retract(propPrice(CurLoc, _)), asserta(propPrice(CurLoc, TotalPrice)),
    retract(propRent(CurLoc, _)), asserta(propRent(CurLoc, TotalRent)),

    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti berhasil dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tBangunan 3 '), write(CurLocCode), write(' - '), write(CurLocName), nl,
    write('\tberhasil dibeli.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,
    
    !.

%== 6. Buy landmark =====

buyPropertySaleSelect(5) :-

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti gagal dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tBeli bangunan 3 terlebih dahulu untuk membangun'), nl,
    write('\tlandmark.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 7. Not enough cash =====

buyPropertySaleSelect(UserInput) :-

    UserInput > 0, UserInput =< 4,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti gagal dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tUang Anda tidak cukup untuk membeli properti ini!\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.


%== 1.1 Invalid selection =====

buyPropertySaleSelect(UserInput) :-
    
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

    !.

buyPropertySaleSelect(UserInput) :-
    
    UserInput > 4,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== Property is self owned ==========================

%== 1. Upgrade property message =====

%== 1.1 Player has land =====

upgradePropertyMsg :-

    turn(Player), location(Player, CurLoc),

    propType(CurLoc, 0),
    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propAcqui(CurLoc, _, B1Price, B2Price, B3Price, _),


    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\t     1. Tanah      : Sudah dibeli'), nl,
    write('\t     2. Bangunan 1 : '), write(B1Price), nl,
    write('\t     3. Bangunan 2 : '), write(B2Price), nl,
    write('\t     4. Bangunan 3 : '), write(B3Price), nl,
    write('\t     5. Landmark   : Beli bangunan 3 untuk membangun Landmark'), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    upgradePropertySelect,

    !.

%== 1.2 Player has B1 =====

upgradePropertyMsg :-

    turn(Player), location(Player, CurLoc),

    propType(CurLoc, 1),
    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propAcqui(CurLoc, _, _, B2Price, B3Price, _),


    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\t     1. Tanah      : Sudah dibeli'), nl,
    write('\t     2. Bangunan 1 : Sudah dibeli'), nl,
    write('\t     3. Bangunan 2 : '), write(B2Price), nl,
    write('\t     4. Bangunan 3 : '), write(B3Price), nl,
    write('\t     5. Landmark   : Beli bangunan 3 untuk membangun Landmark'), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    upgradePropertySelect,

    !.

%== 1.3 Player has B2 =====

upgradePropertyMsg :-

    turn(Player), location(Player, CurLoc),

    propType(CurLoc, 2),
    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propAcqui(CurLoc, _, _, _, B3Price, _),


    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\t     1. Tanah      : Sudah dibeli'), nl,
    write('\t     2. Bangunan 1 : Sudah dibeli'), nl,
    write('\t     3. Bangunan 2 : Sudah dibeli'), nl,
    write('\t     4. Bangunan 3 : '), write(B3Price), nl,
    write('\t     5. Landmark   : Beli bangunan 3 untuk membangun Landmark'), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    upgradePropertySelect,

    !.

%== 1.4 Player has B3 =====

upgradePropertyMsg :-

    turn(Player), location(Player, CurLoc),

    propType(CurLoc, 3),
    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propAcqui(CurLoc, _, _, _, _, LandmarkPrice),


    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\t     1. Tanah      : Sudah dibeli'), nl,
    write('\t     2. Bangunan 1 : Sudah dibeli'), nl,
    write('\t     3. Bangunan 2 : Sudah dibeli'), nl,
    write('\t     4. Bangunan 3 : Sudah dibeli'), nl,
    write('\t     5. Landmark   : '), write(LandmarkPrice), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    upgradePropertySelect,

    !.

%== 1.4 Player has Landmark =====

upgradePropertyMsg :-

    turn(Player), location(Player, CurLoc),

    propType(CurLoc, 4),
    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propAcqui(CurLoc, _, _, _, _, _),


    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\t     1. Tanah      : Sudah dibeli'), nl,
    write('\t     2. Bangunan 1 : Sudah dibeli'), nl,
    write('\t     3. Bangunan 2 : Sudah dibeli'), nl,
    write('\t     4. Bangunan 3 : Sudah dibeli'), nl,
    write('\t     5. Landmark   : Sudah dibeli'), nl,
    write(''), nl,
    write('\tSemua properti sudah Anda beli.'), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    !.

%== 2. Select property to upgrade =====

upgradePropertySelect :-

    write('Pilih properti yang akan dibeli: '),
    read_token(user_input, UserInput),
    
    upgradePropertySelection(UserInput),

    !.

%== 2.1 Selection is invalid =====

upgradePropertySelection(UserInput) :-

    UserInput < 1,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    upgradePropertySelect, 
    
    !.

upgradePropertySelection(UserInput) :-

    UserInput > 5,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tPilihan tidak tersedia!\n'),
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tPilihan yang Anda masukkan tidak tersedia.\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    upgradePropertySelect, 
    
    !.

%== 3. Upgrade to landmark =====

upgradePropertySelection(5) :-

    turn(Player), location(Player, CurLoc), propType(CurLoc, PropType),

    PropType \= 3,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti gagal dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tBeli bangunan 3 terlebih dahulu untuk membangun'), nl,
    write('\tlandmark.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 3. Upgrade property =====

upgradePropertySelection(UserInput) :-

    turn(Player), location(Player, CurLoc), propType(CurLoc, PropType),
    locField(_, CurLoc, CurLocCode, CurLocName, _),
    NewProp is UserInput - 1, NewProp > PropType,
    propTypeField(NewProp, PropTypeName),
    Np is NewProp + 1,
    accPrice(CurLoc, UserInput, Price), accPrice(CurLoc, Np, LastPrice),
    TotalPrice is Price - LastPrice,
    cash(Player, Cash), propValue(Player, PropValue),
    Cash >= TotalPrice,
    NewCash is Cash - TotalPrice, retract(cash(Player, _)), asserta(cash(Player, NewCash)),
    NewPropValue is PropValue + TotalPrice, retract(propValue(Player, _)), asserta(propValue(Player, NewPropValue)),
    NewPropType is UserInput - 1, retract(propType(CurLoc, _)), asserta(propType(CurLoc, NewPropType)),
    retract(propPrice(CurLoc, _)), asserta(propPrice(CurLoc, Price)),
    getRent(CurLoc, NewPropType, Rent), retract(propRent(CurLoc, _)), asserta(propRent(CurLoc, Rent)),
    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti berhasil dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\t'), write(PropTypeName), write(' '), write(CurLocCode), write(' - '), write(CurLocName), nl,
    write('\tberhasil dibeli.'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 4. Player does not have enough cash =====

upgradePropertySelection(UserInput) :-

    turn(Player), location(Player, CurLoc), propType(CurLoc, PropType),
    NewProp is UserInput - 1, NewProp >= PropType,

    accPrice(CurLoc, UserInput, Price), accPrice(CurLoc, PropType, LastPrice),
    TotalPrice is Price - LastPrice,

    cash(Player, Cash),
    
    TotalPrice > Cash,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti gagal dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tUang Anda tidak cukup untuk membeli properti ini!'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== 2.2. Player has already bought property =====

upgradePropertySelection(UserInput) :-

    turn(Player), location(Player, CurLoc), propType(CurLoc, PropType),
    NewProp is UserInput - 1, NewProp =< PropType,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti gagal dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tAnda sudah membeli properti ini!\n'),
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

%== Property is owned ===============================

acquirePropertyMsg :-

    turn(Player), location(Player, CurLoc), propOwner(CurLoc, Owner), propType(CurLoc, PropType),
    PropType \= 4,

    locField(_, CurLoc, CurLocCode, CurLocName, _),
    propPrice(CurLoc, PropPrice), NewPropPrice is PropPrice * 2,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\tProperti ini dimiliki Player '), write(Owner), write('.'), nl,
    write('\tHarga properti ini menjadi '), nl,
    write('\t     '), write(PropPrice), write(' x 2 = '), write(NewPropPrice), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    acquirePropertySelect,

    !.

acquirePropertyMsg :-

    turn(Player), location(Player, CurLoc), propOwner(CurLoc, Owner), propType(CurLoc, PropType),
    PropType = 4,

    locField(_, CurLoc, CurLocCode, CurLocName, _),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti '), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tProperty '), write(CurLocCode), write(' - '), write(CurLocName), write(':'), nl,
    write(''), nl,
    write('\tProperti ini dimiliki Player '), write(Owner), write('.'), nl,
    write('\tTidak dapat mengakuisisi, properti memiliki landmark'), nl,
    write(''), nl,
    write('=============================================================='), nl, 
    write(''), nl,

    !.

acquirePropertySelect :-

    write('Apakah Anda yakin? (yes/no): '),
    read_token(user_input, UserInput),
    
    acquirePropertySelect(UserInput),

    !.

acquirePropertySelect(UserInput) :-

    UserInput = 'yes',

    turn(Player), cash(Player, Cash), propValue(Player, PropValue), prop(Player, PropList),
    location(Player, CurLoc), propPrice(CurLoc, PropPrice),

    propOwner(CurLoc, OPlayer), propValue(OPlayer, OPropValue), prop(OPlayer, OPropList),

    NewPropPrice is PropPrice * 2,

    NewPropPrice =< Cash,

    NewCash is Cash - NewPropPrice, retract(cash(Player, _)), asserta(cash(Player, NewCash)),
    NewPropValue is PropValue + PropPrice, retract(propValue(Player, _)), asserta(propValue(Player, NewPropValue)),
    append(PropList, [CurLoc], NewPropList), retract(prop(Player, _)), asserta(prop(Player, NewPropList)),
    delete(OPropList, CurLoc, ONewPropList), retract(prop(OPlayer, _)), asserta(prop(OPlayer, ONewPropList)),
    ONewPropValue is OPropValue - PropPrice, retract(propValue(OPlayer, _)), asserta(propValue(OPlayer, ONewPropValue)),

    retract(propOwner(CurLoc, _)), asserta(propOwner(CurLoc, Player)),

    retract(isBoughtProperty(Player, _)), asserta(isBoughtProperty(Player, 1)),

    write(''), nl,
    write('=============================================================='), nl,
    write('\tBeli Properti'), nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,   
    write('\tProperty berhasil diakuisisi!'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

acquirePropertySelect(UserInput) :-

    UserInput = 'yes',

    turn(Player), cash(Player, Cash),
    location(Player, CurLoc), propPrice(CurLoc, PropPrice),

    NewPropPrice is PropPrice * 2,

    NewPropPrice > Cash,

    write(''), nl,
    write('=============================================================='), nl,
    write('\tProperti gagal dibeli!'),nl,
    write('--------------------------------------------------------------'), nl,
    write(''), nl,
    write('\tUang Anda tidak cukup untuk membeli properti ini!'), nl,
    write(''), nl,
    write('=============================================================='), nl,
    write(''), nl,

    !.

acquirePropertySelect(UserInput) :-

    UserInput = 'no',

    !.

acquirePropertySelect(UserInput) :-

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

    acquirePropertySelect,

    !.