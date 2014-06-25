-module(lib_misc).
-export([filter/2]).
-export([odds_and_evens_acc/3]).
-export([odds_and_evens/1]).
-export([map/2]).
-export([qsort/1]).
-export([pythag/1]).
-export([perms/1]).
-export([all/2]).
-export([any/2]).
-export([append/1]).
-export([priority_receive/0]).
-export([delete/2]).


delete(Item, [Item|Rest]) -> Rest;
delete(Item, [H|Rest]) ->
    [H|delete(Item, Rest)];
delete(_, []) -> [].

priority_receive() ->
    receive
        {alarm, X} ->
            {alarm, X}
    after 0 ->
        receive
            Any ->
                Any
        end
    end.


filter(P, [H|T]) -> 
    case P(H) of 
        true -> [H|filter(P, T)];
        false -> filter(P, T)
    end;
filter(_, []) -> 
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


map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

qsort([]) -> [];
qsort([Pivot|T]) ->
    qsort([X || X <- T, X < Pivot])
    ++ [Pivot] ++
    qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
    [{A, B, C} || 
        A <- lists:seq(1, N),
        B <- lists:seq(1, N),
        C <- lists:seq(1, N),
        A + B + C =< N,
        A*A + B*B =:= C*C
    ].


perms([]) ->[[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

all(P, [H|T]) ->
    case P(H) of
        true -> all(P, T);
        false -> false
    end;
all(P, []) when is_function(P, 1) -> true.


any(P, [H|T]) ->
    case P(H) of
        true -> true;
        false -> any(P, T)
    end;
any(P, []) when is_function(P, 1) -> false.

append([E]) -> E;
append([H|T]) -> H ++ append(T);
append([]) -> [].
