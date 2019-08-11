defmodule NodesFun.App do
  use Application

  def start(_type, _args) do
    server_name = System.get_env("SERVER_NAME")
    registration_node = System.get_env("REG_NODE")

    children =
      if registration_node do
        Node.connect(:"one@MacBook-Pro-Artur")
        :global.sync
        NodesFun.Registration.add_own_node()
        [
          {NodesFun.GossipServer, server_name}
        ]
      else
        [
          NodesFun.Registration
        ]
      end

    opts = [strategy: :one_for_one, name: NodesFun.Supervisor]
    Supervisor.start_link(children, opts)
  end

  #  def handle_info(:ddd, state) do
  #    IO.puts("---- state #{inspect(state)} ---")
  #    {:noreply, state}
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
# ensure_started
