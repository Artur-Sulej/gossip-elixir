defmodule NodesFun.Registration do
  @agent_name {:global, __MODULE__}

  def start_link do
    Agent.start_link(fn -> [] end, name: @agent_name)

    #    x = :global.register_name(@agent_name, pid)
    #    {:ok, pid}
  end
#  NodesFun.Registration.get_nodes()

  def perform(reg_node) do
    connect_node(reg_node)
    IO.puts("---- Node.list #{inspect(Node.list())} ---")
    nodes = get_nodes()
    add_own_node()
    Enum.each(nodes, &connect_node/1)
  end

  defp add_own_node do
    own_node = Node.self()

    Agent.update(
      @agent_name,
      fn nodes -> [own_node | nodes] end
    )
  end

  def clear do
    Agent.update(
      @agent_name,
      fn nodes -> [] end
    )
  end

  def get_nodes do
    #    Agent.get(agent_pid(), & &1)
        Agent.get(@agent_name, &build_nodes/1)
#    Agent.get(@agent_name, fn x -> x end)
  end

  #  defp agent_pid do
  #    :global.whereis_name(@agent_name)
  #  end

  defp connect_node(name) when is_binary(name) do
    connect_node(String.to_atom(name))
  end

  defp connect_node(name) when is_atom(name) do
    IO.puts("---- name #{inspect(name)} ---")
    Node.connect(name)
  end

  defp build_nodes(nodes) do
    nodes
  end
end
