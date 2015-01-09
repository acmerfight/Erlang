-module(rd_server).

-behaviour(gen_server).

-export([
        start_link/0,
        add_target_resource_type/1,
        add_local_resource/2,
        fetch_resources/1,
        trade_resources/0
    ]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {target_resource_types, local_resource_tuples, found_resource_tuples}).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

add_target_resource_type(Type) ->
    gen_server:cast(?SERVER, {add_target_resource_type, type})
