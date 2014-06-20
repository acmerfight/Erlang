-module(lib).
-export([filter/2]).
-export([odds_and_evens_acc/3]).
-export([odds_and_evens/1]).


filter(P, [H|T]) -> 
    case P(H) of 
        true -> [H|filter(P, T)];
        false -> filter(P, T)
    end;
filter(P, []) -> 
    [].


odds_and_evens_acc([H|T], Odds, Evens) -> 
    case (H rem 2) of 
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;

odds_and_evens_acc([], Odds, Evens) -> 
    {Odds, Evens}.

odds_and_evens(L) -> 
    odds_and_evens_acc(L, [], []).


