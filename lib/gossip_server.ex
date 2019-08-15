defmodule NodesFun.GossipServer do
  use GenServer

  ### External API

  def start_link(server_name) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    :global.register_name(server_name, pid)
    {:ok, pid}
  end

  def get_value do
    GenServer.call(__MODULE__, :get_value)
  end

  def set_value(value) do
    GenServer.call(__MODULE__, {:set_value, value})
  end

  ### GenServer implementation

  def init(args) do
    {:ok, args}
  end

  def handle_cast({:set_value, params = %{value: new_val}}, _current_val) do
    IO.puts("---- #{inspect(params)} ---")
    pass_value(params)
    {:noreply, new_val}
  end

  def handle_call(:get_value, _, current_val) do
    {:reply, current_val, current_val}
  end

  defp pass_value(params) do
    NodesFun.Runner.call(params)
  end
end
