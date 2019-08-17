defmodule NodesFun.GossipClient do
  def pass_value(server_name, msg) do
    pid = :global.whereis_name(server_name)
    GenServer.cast(pid, {:set_value, msg})
  end

  def get_value(server_name) do
    pid = :global.whereis_name(server_name)
    GenServer.call(pid, :get_value)
  end
end
