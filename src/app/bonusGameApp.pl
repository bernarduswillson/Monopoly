:- dynamic(isContinue/1).

isContinue(1).

flipCoin :- nl, isContinue(1),
            random(1, 3, Count1),
            write('Untuk koin pertama, apa tebakan anda (1 untuk HEAD, 2 untuk TAIL): '), read_token(user_input, Input1), 
            checkCoin1(Input1, Count1),
            question2,
            question3, !.


checkCoin1(Input, Count) :- isContinue(1), Input == Count, write('Selamat Anda berhasil menebak lemparan koin pertama! Lanjuttt...'), retract(isContinue(_)), asserta(isContinue(2)), nl, nl, !.

checkCoin1(Input, Count) :- isContinue(1), Input \= Count, write('Maaf, anda kurang beruntung! Anda tidak mendapatkan uang :('), nl, !.


checkCoin2(Input, Count) :- isContinue(2), Input == Count, write('Selamat Anda berhasil menebak lemparan koin kedua! Lanjuttt...'), retract(isContinue(_)), asserta(isContinue(3)), nl, nl, !.

checkCoin2(Input, Count) :- isContinue(2), turn(Player), Input \= Count, write('Maaf, anda kurang beruntung! Anda mendapat uang sebesar 1000.'), 
                            cash(Player, Cash), NewCash is Cash + 1000, retract(cash(Player, _)), asserta(cash(Player, NewCash)), nl, !.

checkCoin2(_, _) :- \+isContinue(2), !.


checkCoin3(Input, Count) :- isContinue(3), turn(Player), Input == Count, write('Selamat Anda berhasil menebak semua lemparan koin! Anda mendapat uang sebesar 3000!!!'), 
                            cash(Player, Cash), NewCash is Cash + 3000, retract(cash(Player, _)), asserta(cash(Player, NewCash)), nl, nl, !.

checkCoin3(Input, Count) :- isContinue(3), turn(Player), Input \= Count, write('Maaf, anda kurang beruntung! Anda mendapat uang sebesar 2000.'), 
                            cash(Player, Cash), NewCash is Cash + 2000, retract(cash(Player, _)), asserta(cash(Player, NewCash)), nl, !.

checkCoin3(_, _) :- \+isContinue(3), !.


question2 :- isContinue(2), random(1, 3, Count2), write('Untuk koin kedua, apa tebakan anda (1 untuk HEAD, 2 untuk TAIL): '), read_token(user_input, Input2), checkCoin2(Input2, Count2).

question2 :- \+isContinue(2), !.


question3 :- isContinue(3), random(1, 3, Count3), write('Untuk koin ketiga, apa tebakan anda (1 untuk HEAD, 2 untuk TAIL): '), read_token(user_input, Input3), checkCoin3(Input3, Count3).

question3 :- \+isContinue(3), !.