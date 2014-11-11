-module(tr_server).

-behaviour(gen_server).

%% API
-export([
    start_link/1,
    start_link/0,
    get_count/0,
    stop/0
    ]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
            terminate/2, code_change/3]).

-define(SERVER, ?MODULE).
-define(DEFAULT_PORT, 1055).

-record(state, {port, lsock, request_count = 0}).

start_link(Port) ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [Port], []).

start_link() ->
    start_link(?DEFAULT_PORT).

get_count() ->
    gen_server:call(?SERVER, get_count).

stop() ->
    gen_server:cast(?SERVER, stop).

%%%================================================================
%%% gen_server callbacks
%%%================================================================

init([Port]) ->
    {ok, Lsock} = gen_tcp:listen(Port, [{active, true}]),
    {ok, #state{port = Port, lsock = Lsock}, 0}.

handle_call(get_count, _FROM, State) ->
    {reply, {ok, State#state.request_count}, State}.

handle_cast(stop, State) ->
    {stop, normal, State}.
