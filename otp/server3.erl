-module(server3).
-export([start/2, rpc/2, swap_code/2]).

start(Name, Mod) ->
    register(Name,
            spawn(fun() -> loop(Name, Mod, Mod:init()) end)).

loop(Name, Mod, OldState) ->
    receive
        {From, {swap_code, NewCallBackMod}} ->
            From ! {Name, ack},
            loop(Name, NewCallBackMod, OldState);
        {From, Resquest} ->
            {Response, NewState} = Mod:handle(Resquest, OldState),
            From ! {Name, Response},
            loop(Name, Mod, NewState)
    end.

rpc(Name, Request) ->
    Name ! {self(), Request},
    receive
        {Name, Response} -> Response
    end.
