-module(tr_server).

-behaviour(gen_server).

%% API
-export([]).

%% gen_server callbacks
-export([init/1, handle/3, handle_cast/2, handle_info/2,
            terminate/2, code_change/3]).

-define(SERVER, ?module).
-define(DEFAULT_PORT, 1055).

-record(state, {port, lsock, request_count = 0}).
