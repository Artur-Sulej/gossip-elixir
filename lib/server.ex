defmodule Gossip.Server do
  use GenServer

  ### External API

  def start_link(server_name) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    :global.register_name(server_name, pid)
    {:ok, pid}
  end

  ### GenServer implementation

  def init(args) do
    {:ok, args}
  end

  def handle_cast({:set_value, msg}, current_value) do
    IO.puts("---- #{inspect({Node.self(), msg.value, msg.metadata})} ---")
    new_value = perform(msg, current_value)
    {:noreply, new_value}
  end

  def handle_call(:get_value, _, current_val) do
    {:reply, current_val, current_val}
  end

  defp perform(msg, current_value) do
    Gossip.Runner.call(msg, current_value)
  end
end
