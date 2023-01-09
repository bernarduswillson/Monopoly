%== Dynamic clause management ===============================================

:- dynamic(cash/2).
:- dynamic(propValue/2).
:- dynamic(netWorth/2).
:- dynamic(location/2).
:- dynamic(prop/2).
:- dynamic(card/2).
:- dynamic(isJail/2).
:- dynamic(isDouble/2).
:- dynamic(nDouble/2).
:- dynamic(isWorldTour/2).
:- dynamic(isDebt/2).
:- dynamic(isPayingRent/2).
:- dynamic(isSellingProperty/2).
:- dynamic(isBoughtProperty/2).

%== Facts ===================================================================

availablePlayer(v).
availablePlayer(w).

playerField(v, 1, 'V').
playerField(w, 2, 'W').

%== States ==================================================================

cash(v, 0).
cash(w, 0).

propValue(v, 0).
propValue(w, 0).

netWorth(Player, NetWorth) :-
    cash(Player, Cash),
    propValue(Player, PropValue),
    NetWorth is Cash + PropValue.

location(v, go).
location(w, go).

locationid(v, 0).
locationid(w, 0).

prop(v, []).
prop(w, []).

card(v, []).
card(w, []).

isJail(v, 0).
isJail(w, 0).

isGoOutJail(v, 0).
isGoOutJail(w, 0).

isDouble(v, 0).
isDouble(w, 0).

nDouble(v, 0).
nDouble(w, 0).

isWorldTour(v, 0).
isWorldTour(w, 0).

isPayingRent(v, 0).
isPayingRent(w, 0).

isSellingProperty(v, 0).
isSellingProperty(w, 0).

isBoughtProperty(v, 0).
isBoughtProperty(w, 0).