defmodule NodesFun.Runner do
  def call do
    value = NodesFun.GossipServer.get_value()
    names = NodesFun.Registration.get_names(2)
    Enum.each(names, &NodesFun.GossipClient.pass_value(&1, value))
  end

  def start(value) do
    NodesFun.GossipServer.set_value(value)
    call()
  end
end
