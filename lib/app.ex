defmodule NodesFun.App do
  use Application

  def start(_type, _args) do
    registration_node = System.get_env("REG_NODE")

    children =
      if registration_node do
        server_name = generate_server_name()
        register_name(registration_node, server_name)

        [
          {NodesFun.GossipServer, server_name}
        ]
      else
        NodesMonitoring.enable()

        [
          NodesFun.Registration
        ]
      end

    opts = [strategy: :one_for_one, name: NodesFun.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp register_name(registration_node, server_name) do
    Node.start(String.to_atom(server_name), :shortnames)
    Node.connect(String.to_atom(registration_node))
    :global.sync()
    NodesFun.Registration.add_own_name(server_name)
  end

  defp generate_server_name do
    :crypto.strong_rand_bytes(15) |> Base.url_encode64()
  end
end

# :net_kernel.monitor_nodes(true)
# NodesFun.Runner.call(%{value: :pawian, steps: 2})
# SERVER_NAME=banan REG_NODE=one@MacBook-Pro-Artur iex --sname four -S mix
# z wygaszaniem (max liczba kroków)
# proces global_name_server ??
# https://learnyousomeerlang.com/distributed-otp-applications#making-the-application-distributed
# mix run --no-halt
# iex --sname two -S mix
# jak nazwać node (bez iex)
# distributed GenServer
# https://www.freecodecamp.org/news/how-to-build-a-distributed-game-of-life-in-elixir-9152588100cd/
# GenServer.call({name, node}, arg)
# pid=:global.whereis_name("kalafior")
# GenServer.call pid, :next_number
# Node.connect(:"one@MacBook-Pro-Artur")
# elixir --sname hello -S mix run --no-halt
# handle_info vs receive
# send pid, :next_number
# NodesFun.GossipClient.pass_value("pawian", "2eiugh2ghuue")
# neighbours = String.split(System.get_env("NEIGHBOURS"), ",")
# Enum.each(neighbours, fn name -> Node.connect(String.to_atom(name)) end)
# Node.list
# SERVER_NAME=one SERVER_NAMES=one,two,three,four NODE_NAMES=one@MacBook-Pro-Artur,two@MacBook-Pro-Artur,three@MacBook-Pro-Artur,four@MacBook-Pro-Artur iex --sname two -S mix
# Node pobiera listę zarejestrowanych nodeow / laczy sie z nimi / sam sie rejestruje
# ensure_started
# (distributed) (D)ETS
# singletonowy agent
# distributed registry
# Application.ensure_all_started(:nodes_fun)
