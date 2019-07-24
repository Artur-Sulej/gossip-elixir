defmodule NodesFun.App do
  use Application

  def start(_type, _args) do
    IO.puts("---- start ---")
    children = [
      {NodesFun.Server, 123},
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
# mix run --no-halt
