defmodule NodesMonitoring do
  def enable do
    spawn_link(fn ->
      :net_kernel.monitor_nodes(true)
      monitor_nodes()
    end)
  end

  defp monitor_nodes do
    receive do
      {:nodeup, node_name} ->
        IO.puts("Node-Up #{inspect(node_name)} ---")

      {:nodedown, node_name} ->
        IO.puts("Node-Down #{inspect(node_name)} ---")
        Gossip.Registration.unregister_node(node_name)
    end

    monitor_nodes()
  end
end
