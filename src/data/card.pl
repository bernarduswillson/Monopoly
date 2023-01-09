%== Dynamic clause management ===============================================

:- dynamic(newCard/2).

%== Facts ===================================================================

cardField(0, txC, 'Tax Card').
cardField(1, gfC, 'Gift Card').
cardField(2, ojC, 'Get Out From Jail Card').
cardField(3, ijC, 'Go To Jail Card').

%== States ==================================================================

newCard(null, null).