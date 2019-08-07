defmodule NodesFun.Registration do
  use Agent
  @agent_name {:global, __MODULE__}

  def start_link(_asd) do
    Agent.start_link(fn -> [] end, name: @agent_name)
  end

  def perform(reg_node) do
    connect_node(reg_node)
    nodes = get_nodes()
    add_own_node()
    Enum.each(nodes, &connect_node/1)
  end

  def add_own_node do
    own_node = Node.self()
    Agent.update(@agent_name, fn nodes -> [own_node | nodes] end)
  end

  def get_nodes2 do
    Agent.get(@agent_name, &build_nodes/1)
  end

  def get_nodes do
    Agent.get(@agent_name, __MODULE__, :build_nodes, [])
  end

  def clear do
    Agent.update(
      @agent_name,
      fn _nodes -> [] end
    )
  end

  defp connect_node(name) when is_binary(name) do
    connect_node(String.to_atom(name))
  end

  defp connect_node(name) when is_atom(name) do
    Node.connect(name)
  end

  def build_nodes(nodes) do
    nodes
  end
end
