defmodule NodesFun.App do
  use Application

  def start(_type, _args) do
    node_name = System.get_env("NODE_NAME")

    children = [
      {NodesFun.GossipServer, node_name}
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    {:ok, pid} = Supervisor.start_link(children, opts)
    IO.puts("---- Started Node: #{inspect(node_name)} ---")
    {:ok, pid}
  end
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
