defmodule NodesFun.Runner do
  def call(value) do
    names = NodesFun.Registration.get_names(2)
    Enum.each(names, &NodesFun.GossipClient.pass_value(&1, value))
  end

  def start(value) do
    NodesFun.GossipServer.set_value(value)
    call(value)
  end
end

