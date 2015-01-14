-module(pmap).
-export([pmap/2]).
-export([pmap1/2]).
-export([map/2]).


map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

pmap(F, L) ->
    S = self(),
    Ref = erlang:make_ref(),
    Pids = map(fun(I) ->
                spawn(fun() -> do_f(S, Ref, F, I) end)
               end, L),
    gather(Pids, Ref).
    do_f(Parent, Ref, F, I) ->
        Parent ! {self(), Ref, (catch F(I))}.
    gather([Pid|T], Ref) ->
        receive
            {Pid, Ref, Ret} -> [Ret|gather(T, Ref)]
        end;
gather([], _) ->
    [].

pmap1(F, L) ->
    S = self(),
    Ref = erlang:make_ref(),
    foreach(fun(I) ->
                spawn(fun() -> do_f1(S, Ref, F, I) end)
            end, L),
    gather1(length(L), Ref, []).

do_f1(Parent, Ref, F, I) ->
    Parent ! {Ref, (catch F(I))}.

gather1(0, _, L) -> L;
gather1(N, Ref, L) ->
    receive
        {Ref, Ret} -> gather1(N-1, Ref, [Ret|L])
    end.

