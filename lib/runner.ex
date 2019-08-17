defmodule Gossip.Runner do
  @addressees_count 2

  def call(%{value: value, metadata: %{steps: steps}}) do
    names = Gossip.Registration.get_names(@addressees_count)
    new_msg = %{value: value, metadata: %{steps: steps - 1}}

    Enum.each(
      names,
      &Gossip.Client.pass_value(&1, new_msg)
    )
  end

  def get_all_values do
    names = Gossip.Registration.get_all_names()
    Enum.map(names, &{&1, Gossip.Client.get_value(&1)})
  end
end

# Gossip.Runner.call(%{value: :banan, metadata: %{steps: 2}})
# seq 20 | parallel --lb --jobs 20 'REG_NODE=one@MacBook-P-Artur elixir -S mix run --no-halt; {}'
# Runner zawiera logike, Gossip.Server/Client powinno być jak najczystsza abstrakcją gossipa
# Registration.get_names(addressees) -> topology
