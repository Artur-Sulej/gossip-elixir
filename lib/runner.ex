defmodule NodesFun.Runner do
  @default_addressees 2

  def call(msg, addressees \\ @default_addressees)

  def call(%{metadata: %{steps: 0}}, _), do: nil

  def call(%{value: value, metadata: %{steps: steps}}, addressees) do
    names = NodesFun.Registration.get_names(addressees)
    new_msg = %{value: value, metadata: %{steps: steps - 1}}

    Enum.each(
      names,
      &NodesFun.GossipClient.pass_value(&1, new_msg)
    )
  end

  def get_all_values do
    names = NodesFun.Registration.get_all_names()
    Enum.map(names, &{&1, NodesFun.GossipClient.get_value(&1)})
  end
end

# NodesFun.Runner.call(%{value: :banan, metadata: %{steps: 2}})
# seq 20 | parallel --lb --jobs 20 'REG_NODE=one@MacBook-P-Artur elixir -S mix run --no-halt; {}'
# Runner zawiera logike, GossipServer/Client powinno być jak najczystsza abstrakcją gossipa
# Registration.get_names(addressees) -> topology
