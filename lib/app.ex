defmodule NodesFun.App do
  use Application

  def start(_type, _args) do
    server_name = System.get_env("SERVER_NAME")
    registration_node = System.get_env("REG_NODE")
    Node.connect(:"one@MacBook-Pro-Artur")
    IO.puts("---- Node.self #{inspect(Node.self())} ---")

    #    IO.puts("---- :global.whereis #{inspect(:global.whereis_name(NodesFun.Registration))} ---")

    #    n = Agent.get({:global, NodesFun.Registration}, fn x -> x end)
    #    IO.puts("---- n #{inspect(n)} ---")

    #    spawn(fn ->
    IO.puts("---- registration_node #{inspect(registration_node)} ---")
#    send(__MODULE__, :ddd)
    send(NodesFun.GossipServer, :eee)

    if registration_node do
      #        a = NodesFun.Registration.perform(registration_node)
      #        IO.puts("---- reg #{inspect(a)} ---")
    else
      a = NodesFun.Registration.start_link()
      IO.puts("---- start #{inspect(a)} ---")
    end

    #    end)

    IO.puts("---- Node.list #{inspect(Node.list())} ---")

    children = [
      #      {Task,
      #       fn ->
      #         a = NodesFun.Registration.perform(registration_node)
      #         IO.puts("---- reg #{inspect(a)} ---")
      #       end},
      {NodesFun.GossipServer, server_name}
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    {:ok, pid} = Supervisor.start_link(children, opts)
    IO.puts("---- Started Node: #{inspect(server_name)} ---")
    {:ok, pid}
  end

  def handle_info(:ddd, state) do
    IO.puts("---- state #{inspect(state)} ---")
    {:noreply, state}
  end

  #  def start_phase(:finish, _type, _args) do
  #    registration_node = System.get_env("REG_NODE")
  #    n = Agent.get({:global, NodesFun.Registration}, fn x -> x end)
  #    IO.puts("---- n #{inspect(n)} ---")
  #  end
end

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
