defmodule Gossip.Runner do
  @addressees_count 2

  def call(%{value: value, metadata: %{type: :lapsing_pass, steps: steps}}, _current_value) do
    names = Gossip.Registration.get_names(@addressees_count)
    new_msg = %{value: value, metadata: %{steps: steps - 1}}

    Enum.each(
      names,
      &Gossip.Client.pass_value(&1, new_msg)
    )

    value
  end

  def call(params = %{metadata: %{type: :leader_election}}, current_value) do
    current_name = current_value || System.get_env("SERVER_NAME")
    name = Map.get(params, :value, nil)
    new_candidate = if current_name > name, do: current_name, else: name

    new_msg = %{value: new_candidate, metadata: %{type: :leader_election}}
    names = Gossip.Registration.get_names(@addressees_count)

    Enum.each(
      names,
      &Gossip.Client.pass_value(&1, new_msg)
    )

    new_candidate
  end

  def get_all_values do
    names = Gossip.Registration.get_all_names()
    Enum.map(names, &{&1, Gossip.Client.get_value(&1)})
  end
end

# Gossip.Runner.call(%{value: :banan, metadata: %{type: :lapsing_pass, steps: 2}})
# Gossip.Runner.call(%{metadata: %{type: :leader_election}})
# seq 20 | parallel --lb --jobs 20 'REG_NODE=one@MacBook-P-Artur elixir -S mix run --no-halt; {}'
# Runner zawiera logike, Gossip.Server/Client powinno być jak najczystsza abstrakcją gossipa
# Registration.get_names(addressees) -> topology
