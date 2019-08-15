defmodule NodesFun.GossipClient do
  def pass_value(server_name, params) do
    pid = :global.whereis_name(server_name)
    GenServer.cast(pid, {:set_value, params})
  end

  def get_value(node_name) do
    pid = :global.whereis_name(node_name)
    GenServer.call(pid, :get_value)
  end
end
