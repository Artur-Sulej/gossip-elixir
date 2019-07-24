defmodule AcceptorBehaviour do
  @callback promise(String.t) :: {:ok, term} | {:error, String.t}
  @callback accepted(String.t) :: {:ok, term} | {:error, String.t}
end
