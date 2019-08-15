defmodule NodesFun.Runner do
  def call(%{steps: 0}), do: nil

  def call(%{value: value, steps: steps}) do
    names = NodesFun.Registration.get_names(2)
    Enum.each(names, &NodesFun.GossipClient.pass_value(&1, %{value: value, steps: steps - 1}))
  end
end
