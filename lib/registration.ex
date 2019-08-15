defmodule NodesFun.Registration do
  use Agent
  @agent_name {:global, __MODULE__}

  def start_link(_asd) do
    Agent.start_link(fn -> [] end, name: @agent_name)
  end

  def add_own_name(name) do
    Agent.update(@agent_name, fn names -> [name | names] end)
  end

  def get_names(count) do
    Agent.get(@agent_name, fn names -> Enum.take_random(names, count) end)
  end

  def clear do
    Agent.update(@agent_name, fn _names -> [] end)
  end
end
