defmodule NodesFun.Runner do
  @default_addressees 2

  def call(params, addressees \\ @default_addressees)

  def call(%{steps: 0}, _), do: nil

  def call(%{value: value, steps: steps}, addressees) do
    names = NodesFun.Registration.get_names(addressees)
    Enum.each(names, &NodesFun.GossipClient.pass_value(&1, %{value: value, steps: steps - 1}))
  end

  def get_all_values do
    names = NodesFun.Registration.get_all_names()
    Enum.map(names, &{&1, NodesFun.GossipClient.get_value(&1)})
  end
end

# NodesFun.Runner.call(%{value: :banan, steps: 3})
# seq 20 | parallel --lb --jobs 20 'REG_NODE=one@MacBook-P-Artur elixir -S mix run --no-halt; {}'
