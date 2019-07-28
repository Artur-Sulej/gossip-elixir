defmodule NodesFun.App do
  use Application

  def start(_type, {node_name}) do
    children = [
      {NodesFun.Server, 123},
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
# mix run --no-halt
