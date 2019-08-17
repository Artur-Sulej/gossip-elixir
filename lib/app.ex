defmodule Gossip.App do
  use Application

  def start(_type, _args) do
    registration_node = System.get_env("REG_NODE")

    children =
      if registration_node do
        server_name = generate_server_name()
        register_name(registration_node, server_name)

        [
          {Gossip.Server, server_name}
        ]
      else
        NodesMonitoring.enable()

        [
          Gossip.Registration
        ]
      end

    opts = [strategy: :one_for_one, name: Gossip.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp register_name(registration_node, server_name) do
    Node.start(String.to_atom(server_name), :shortnames)
    Node.connect(String.to_atom(registration_node))
    :global.sync()
    Gossip.Registration.add_own_name(server_name)
  end

  defp generate_server_name do
    System.get_env("SERVER_NAME") || :crypto.strong_rand_bytes(15) |> Base.url_encode64()
  end
end
