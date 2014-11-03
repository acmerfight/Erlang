-module(my_module).

-export([print/1]).
-export([either_or_both/2]).
-export([area/1]).
-export([sum/1]).
-export([do_sum/1]).
-export([do_sum/2]).


print(Term) ->
    io:format("The value is: ~p.~n", [Term]).

either_or_both(A, B) ->
    case {A, B} of
        {true, B} when is_boolean(B) ->
            true;
        {A, true} when is_boolean(A) ->
            true;
        {false, false} ->
            false
    end.


area(Shape) -> 
    case Shape of
        {circle, Radius} ->
            Radius * Radius * math:pi();
        {square, Side} ->
            Side * Side;
        {rec, Height, Width} ->
            Height * Width
    end.

sum(0) -> 0;
sum(N) -> sum(N - 1) + N.



do_sum(N) -> do_sum(N, 0).

do_sum(0, Total) -> Total;
do_sum(N, Total) -> do_sum(N - 1, Total + N).