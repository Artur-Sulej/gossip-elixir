defmodule NodesFun.GossipServer do
  use GenServer

  @name __MODULE__

  ### External API

  def start_link(server_name) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: @name)
    :global.register_name(server_name, pid)

#    send(__MODULE__, :eee)
#    GenServer.call(pid, {:set_value, 4448})
    {:ok, pid}
  end

#  @impl true
#  def init(state) do
#    IO.puts("---- init #{inspect(state)} ---")
##    a = NodesFun.Registration.get_nodes()
##        IO.puts("---- a #{inspect(a)} ---")
#        send(__MODULE__, :eee)
#
#    {:ok, NodesFun.Registration.get_nodes()}
#  end

  def get_value do
    send(__MODULE__, :eee)

    GenServer.call(__MODULE__, :get_value)
  end

  def handle_info(msg, state) do

    IO.puts("---- msg #{inspect(msg)} ---")
#    IO.puts("---- state eee #{inspect(state)} ---")
#    IO.puts("---- NodesFun.Registration.get_nodes() #{inspect(NodesFun.Registration.get_nodes())} ---")
    {:noreply, state}
  end

  ### GenServer implementation

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_cast({:set_value, new_val}, _from, _current_val) do
    {:noreply, new_val}
  end

  def handle_call({:set_value, new_val}, _from, current_val) do
    a = NodesFun.Registration.get_nodes()
        IO.puts("---- a #{inspect(a)} ---")

    {:reply, current_val, new_val}
  end

  def handle_call(:get_value, _, current_val) do
    {:reply, current_val, current_val}
  end
end
