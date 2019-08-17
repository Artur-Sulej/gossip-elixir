defmodule Gossip.Registration do
  use Agent
  @agent_name {:global, __MODULE__}

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: @agent_name)
  end

  def add_own_name(name) do
    own_node = Node.self()
    Agent.update(@agent_name, fn names -> [{name, own_node} | names] end)
  end

  def get_names(count) do
    Agent.get(@agent_name, fn names ->
      names
      |> Enum.take_random(count)
      |> Enum.map(fn {name, _node} -> name end)
    end)
  end

  def get_all_names do
    Agent.get(@agent_name, fn names ->
      names
      |> Enum.map(fn {name, _node} -> name end)
    end)
  end

  def unregister_node(node_name) do
    Agent.update(@agent_name, &reject_node(&1, node_name))
  end

  def clear_all do
    Agent.update(@agent_name, fn _names -> [] end)
  end

  defp reject_node(names, given_node_name) do
    Enum.reject(names, fn {_name, node_name} -> node_name == given_node_name end)
  end
end
