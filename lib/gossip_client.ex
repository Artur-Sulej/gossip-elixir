defmodule NodesFun.GossipClient do
  def pass_value(node_name, value) do
    pid = :global.whereis_name(node_name)
    GenServer.cast(pid, {:set_value, value})
  end
end
