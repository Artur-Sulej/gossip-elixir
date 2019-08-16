defmodule NodesFun.GossipServer do
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

  def handle_cast({:set_value, params = %{value: new_val}}, _current_val) do
    IO.puts("---- #{inspect({Node.self(), params.value, params.steps})} ---")
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
