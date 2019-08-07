defmodule NodesFun.GossipClient do
  def pass_value(node_name, value) do
    pid = :global.whereis_name(node_name)
    IO.puts("---- pass_value #{inspect(value)} ---")
    GenServer.call(pid, {:set_value, value})
  end
end
