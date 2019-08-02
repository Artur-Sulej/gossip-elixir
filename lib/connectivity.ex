defmodule NodesFun.Connectivity do
  def connect_node(name) when is_binary(name) do
    connect_node(String.to_atom(name))
  end

  def connect_node(name) when is_atom(name) do
    Node.connect(name)
  end
end
